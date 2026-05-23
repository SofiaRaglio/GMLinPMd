function [Prediction, Accuracy, MeanCondition, Rect] = PredictOutput(Params,Vec);

%
%   [Prediction, Accuracy, MeanCondition, Rect] = PredictOutput(Params,Vec)
%   
%   This function test the decoding vectors computing the performances of
%   the output they predict with respect to the ground truth.
%
%   Vec = the vector to test
%   
%   Prediction = the predicted value for each symbol (motor decision) in
%       each trial averaged across delay time.
%   Accuracy = the accuracy of the rectified prediction.
%   MeanCondition = the average prediction for each trial condition 
%       (all the trials with the same couples presented averaged together)
%   Rect = for the motor choice the predictions > 0 are set to one and < 0 
%       are set to -1. For the symbols the two max values (among 7) are set
%       to 1 and the others to 0.        
%

[Data,CorrectTrials,ErrorTrials] = computeMUAandEvents(Params);
[P_tot, T, tEC] = InputOutput(Params,CorrectTrials,1);
% [P_tot, T, tEC] = InputOutput(Params,ErrorTrials,1);

if Params.output==1
    cond=7;
    [val ndx]=sort(CorrectTrials.condition);
else
    cond=1;
    [val ndx]=sort(T);
    Threshold = find(val==1,1);
end

if Params.task==3
    maxCnd = 42;
else
    maxCnd = 12;
end

TestedTimes = Params.TestedTimes;
Target = [];
for Cnd = 1:cond
    Weights = Vec{Cnd};
    for nt = 1:numel(tEC)
        for i=(1:(numel(TestedTimes)-1))+numel(TestedTimes)
            Pred(Cnd,nt,i) = [P_tot(:,ndx(nt),i)' ones(1,1)]*Weights;
            Target(:,nt) = T(Cnd,ndx(nt));
        end
    end
end

Prediction = mean(Pred,3);

if Params.output==2
    figure
    imagesc(Prediction)
    xline(Threshold+0.5,'r-')
    
    for i=1:numel(tEC)
    if Prediction(:,i)>0
       rect(:,i)=1;
       else
            rect(:,i)=-1;
        end
    end
    
    Q= [];
    somma=[];
    Accuracy=[];
    for i=1:numel(tEC)
        for j=1:cond
            if rect(j,i) == Target(j,i)
                Q(j,i) = 1;
            else
                Q(j,i) = 0;
            end
        end
    end
    somma = sum(sum(Q));
    Accuracy = somma/(cond*numel(tEC));
    
    figure
    imagesc(rect)
    xline(Threshold+0.5,'r-')
    title(sprintf('Rectification of the output, total accuracy=%d',Accuracy));
    xlabel('Trials')
    
    Rect=rect;
    MeanCondition = [mean(Prediction(1:Threshold)) mean(Prediction(Threshold+1:end))];
else
    figure
    imagesc(Prediction)
    if Params.target==1
        for cnd = 1:maxCnd
            a = find(val==(cnd+4000));
            b(:,cnd) = mean(Prediction(:,a),2);
        end
        
        MeanCondition = b;
        
        for i=1:size(MeanCondition,2)
            M = max(MeanCondition(:,i));
            m = min(MeanCondition(:,i));
            for j=1:cond
                if MeanCondition(j,i)==M
                    rec(j,i)=1;
                elseif MeanCondition(j,i)==m
                    rec(j,i)=-1;
                else
                    rec(j,i)=0;
                end
            end
        end
    elseif Params.target==2
        k=0;
        for cnd = 1:2:maxCnd
            k=k+1;
            a = [find(val==(cnd+4000)) find(val==(cnd+4001))];
            b(:,k) = mean(Prediction(:,a),2);
        end
        
        MeanCondition = b;
        for i=1:size(MeanCondition,2)
            t = maxk(MeanCondition(:,i),2);
            for j=1:cond
                if MeanCondition(j,i)==t(1)
                    rec(j,i)=1;
                elseif MeanCondition(j,i)==t(2)
                    rec(j,i)=1;
                else
                    rec(j,i)=0;
                end
            end
        end
    else
        for cnd = 1:maxCnd
            a = find(val==(cnd+4000));
            b(:,cnd) = mean(Prediction(:,a),2);
        end
        
        MeanCondition = b;
        for i=1:size(MeanCondition,2)
            t = max(MeanCondition(:,i));
            for j=1:cond
                if MeanCondition(j,i)==t
                    rec(j,i)=1;
                else
                    rec(j,i)=0;
                end
            end
        end
    end
    Rect = rec;
        figure
        imagesc(MeanCondition)
        yticks([1:size(MeanCondition,1)])
        yticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
        if Params.task==3
            xticks([1:maxCnd])
            xticklabels({'AB','BC', 'CD', 'DE', 'EF', 'FG','AC','BD', 'CE', 'DF','EG','AD','BE', 'CF', 'DG','AE','BF', 'CG','AF','BG', 'AG'})
        else
            xticks([1:size(MeanCondition,2)])
            xticklabels({'AB','BC', 'CD', 'DE', 'EF', 'FG'})
        end
        
        figure
        if Params.target==1 || Params.target==2
            imagesc(rec)
        else
            imagesc(rec(:,1:2:end))
            figure
            imagesc(rec(:,2:2:end))
        end
        yticks([1:size(MeanCondition,1)])
        yticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
        if Params.task==3
            xticks([1:size(MeanCondition,2)])
            xticklabels({'AB','BC', 'CD', 'DE', 'EF', 'FG','AC','BD', 'CE', 'DF','EG','AD','BE', 'CF', 'DG','AE','BF', 'CG','AF','BG', 'AG'})
        else
            xticks([1:size(MeanCondition,2)])
            xticklabels({'AB','BC', 'CD', 'DE', 'EF', 'FG'})
        end
        
        Accuracy = NaN;
end


