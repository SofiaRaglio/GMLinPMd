function fltTrials = selectTrialWithConditions(Trials, Events, SelectingConditions)
%
%  fltTrials = selectTrialWithConditions(Trials, Events, SelectingConditions)
%

%ndxT = [];
%for n = 1:length(Trials.ndx)
%   if length(Trials.ndx{n}) > 0
%      if length(intersect(Trials.condition, SelectingConditions)) == length(SelectingConditions)
%         ndxT = [ndxT n];
%      end
%   end
%end

%[c,ndxT,ib] = intersect(Trials.condition, SelectingConditions);

ndxT = [];
for n = 1:length(Trials.condition)
   if ismember(Trials.condition(n),SelectingConditions)
      ndxT = [ndxT n];
   end
end

fltTrials.start = Trials.start(ndxT);
fltTrials.stop = Trials.stop(ndxT);
for k = 1:length(ndxT)
   fltTrials.ndx{k} = Trials.ndx{ndxT(k)};
end
fltTrials.number = Trials.number(ndxT);
fltTrials.condition = Trials.condition(ndxT);
fltTrials.response = Trials.response(ndxT);
