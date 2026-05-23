function [k, l] = BalancedReshuffling(f,t)

%
%   [k, l] = BalancedReshuffling(f,t)
%
%   This function rebalances classes for the decoding.
%
%   f = the indices corresponding to value 1 in the target matrix
%   t = the target matrix
%
%   k = the indices of the training set
%   l = the indices of the test set
%

fr = f(randperm(length(f)));
frt = fr(1:round(0.7*length(fr)));
rt = setdiff(fr,frt);
rest = setdiff(1:size(t,2),f);
restr = rest(randperm(length(rest)));
restrt = restr(1:length(frt));
estrt = setdiff(restr,restrt);
estr = estrt(randperm(length(estrt)));
if length(estr)>=length(rt)
    est = estr(1:length(rt));
else
    est = estr;
end
k = [frt restrt];
l = [rt est];
