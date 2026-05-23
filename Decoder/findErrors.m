function [zscoreErS, zscoreErD, zscoreS, zscoreD, predErD] = findErrors(Params,Line,SDx,SxD)

%
%   [zscoreErS, zscoreErD, zscoreS, zscoreD, predErD] = findErrors(Params,Line,SDx,SxD)
%
%   This function computes the zscores of each trial with respect to the
%   mean and std of the distribution of each symbolic distance. 
%
%   Params = decoding parameters
%   Line = mental line on which predictions are made
%   SDx = distribution of predictions on the right side of the mental line
%   SxD = distribution of predictions on the left side of the mental line
%   
%   zscoreErS = zscores of the error trials on the left side
%   zscoreErD = zscores of the error trials on the right side
%   zscoreS = zscores of the correct trials on the left side
%   zscoreD = zscores of the correct trials on the right side
%   predErD = predicted errors via zscore on the right side (?)
%

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, T] = InputOutput(Params,ErrorTrials,2);

if Params.output==1
    cond=7;
end

Pred = [];
Prediction = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        Pred(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*Line;
    end
end


Prediction = mean(Pred,2);

for i=1:numel(SDx)
    muS(i) = mean(SxD{i});
    muD(i) = mean(SDx{i});
    sigmaS(i) = std(SxD{i});
    sigmaD(i) = std(SDx{i});
end

SD={};
n = 0;
for k=1:6
    ad = (7-(k-1))*2;
    add =(7-k)*2;
    ind = [];
    for cnd=1+n:n+add
        ind = [ind find(ErrorTrials.condition==4000+cnd)];
    end
    n=cnd(end);
    SD{k} = ind;
end

zscoreErS = {};
zscoreErD = {};
predErD = {};
predErS ={};
for i=1:6
    ErS = [];
    ErD = [];
    for k=1:numel(SD{i})
        if rem(ErrorTrials.condition(SD{i}(k)),2)==0
            ErS(k) = SD{i}(k);
        else
            ErD(k) = SD{i}(k);
        end
    end
    if numel(ErS)>0
        zscoreErS{i} = (Prediction(ErS>0) - muS(i))/sigmaS(i);
        predErS{i} = Prediction(ErS>0);
    else
        zscoreErS{i} = 0;
        predErS{i} = 0;
    end
    
    if numel(ErD)>0
       zscoreErD{i} = (Prediction(ErD>0) - muD(i))/sigmaD(i);
       predErD{i} = Prediction(ErD>0);
    else
       zscoreErD{i} = 0;
       predErD{i} =0;
    end
end

zscoreS = {};
zscoreD = {};
for i=1:6
    zscoreS{i} = (SxD{i} - muS(i))/sigmaS(i);
    zscoreD{i} = (SDx{i} - muD(i))/sigmaD(i);
end




