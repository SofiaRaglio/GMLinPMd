function threshold = findThreshold(labels,real,pred)

%
%   threshold = findThreshold(labels,real,pred)
%
%   This function returns the optimal threshold for the classifier found
%   thanks to the ROC curve optimal point. The threshold is computed on the
%   training set and applied to the test set.
%
%   labels =  1 in the case of two classes and -1,1 in the case of three
%       classes (Orig vectors)
%   real = classifier target
%   pred = prediction ot the classifier
%
%   threshold = optimal threshold to compute accuracy
%

if numel(labels)>1
    for k=1:numel(labels)
        ind = find(real==labels(k));
        nd = find(real==0);
        tempReal = real([ind' nd'])*labels(k);
        tempPred = pred([ind' nd'])*labels(k);
        [X Y T AUC,opt] = perfcurve(tempReal, tempPred, 1);
        threshold(k) = T((X==opt(1))&(Y==opt(2)))*labels(k);
    end
else    
    [X Y T AUC,opt] = perfcurve(real, pred, 1);
    threshold = T((X==opt(1))&(Y==opt(2)));
end

