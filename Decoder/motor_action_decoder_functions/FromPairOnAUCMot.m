function [PerfInTime, Baseline] = FromPairOnAUC(Params,selch, weights);

%
%   [PerfInTime, Baseline] = FromPairOn(Params,selch, weights);
%
%   This function returns the AUC of the decoding in time.
%
%   Params = decoding parameters
%   selch = selected decoding channels
%   weights = decoding vectors
%
%   PerfInTime = AUC of (binary, not for Orig) classifier before and after Movement On (time interval given in Params.TestedT)
%   Baseline = AUC of random classifier
%

EC=setEncodes;
[Data] = computeMUAandEvents(Params);
cndTrials = selectTrialWithConditions(Data.Trials, Data.Events, Params.AllConditions); 
CorrectTrials = selectTrialWith2Events(cndTrials, Data.Events, EC.CORRECT_RESPONSE,EC.RT);
ErrorTrials = selectTrialWith2Events(cndTrials, Data.Events, EC.RESPONSE_WRONG,EC.RT);
[P_tot, T] = InputOutputMot(Params,CorrectTrials,1);

if Params.output==1
    cond=7;
else
    cond=1;
end


TestedTimes=Params.TestedT;
RsOfAllBC = [];
for a=1:50
    for i=1:cond
        R(i,:) = T(i,randperm(size(T,2)));
    end
    for Cnd =1:cond
        BestCh=selch{Cnd};
        Weights=weights{Cnd};
        RealTest = T(Cnd,:)';
        RandomTest = R(Cnd,:)';
        for nt=1:numel(TestedTimes)
            OutTest = [P_tot(BestCh,:,nt)' ones(size(P_tot,2),1)]*Weights;
            [X Y t AUC] = perfcurve(RealTest, OutTest, '1');
            PerfInTime(nt,Cnd,a) = AUC;
            [X Y t AUC] = perfcurve(RandomTest, OutTest, '1');
            Baseline(nt,a,Cnd) = AUC;
        end
    end
end


