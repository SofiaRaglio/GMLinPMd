function [Accuracy, SDEperf, SDErt,errSDErt, SPE, AllPairs,AnsPerc] = BehavioralPerf(Params)

%
%   [Accuracy, SDEperf, SDErt, SPE] = BehavioralPerf(Params)   
%   
%   This function computes behavioral performances of the animals performing TI task.
%
%   Params = decoding parameters
%
%   Accuracy = the accuracy of the animal in giving the correct response
%       (deprecated trials were not considered as errors) 
%   SDEperf = variation of performances depending on the symbolic distance (SD); 
%   SDErt = variation of the reaction times depending on SD,
%       considering both correct and error trials; 
%   SPE = variation of performances depending on the serial
%       position of the items, considering all possible SDs.
%

EC = setEncodes();
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
if Params.task==3
    AllConditions = 4001:4042;
else
    AllConditions = 4001:4012;
end

Trials = Data.Trials;

Accuracy = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
AnsPerc = (numel(CorrectTrials.condition)+numel(ErrorTrials.condition))/numel(Trials.condition);

if Params.task==3
    [~, T, ~] = InputOutput(Params,CorrectTrials,1);
    [~, Terr, ~] = InputOutput(Params,ErrorTrials,1);
    SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
    SDerr = sum(Terr.*repmat((1:size(Terr,1))',1,size(Terr,2)));
    corr = [];
    err = [];
    SDEperf = [];
    for k=1:6
        corr(k) = numel(find(abs(SD)==k));
        err(k) = numel(find(abs(SDerr)==k));
        SDEperf(k) = corr(k)/(corr(k)+err(k)); 
    end
    Options.start = EC.TEST1_OFF;
    Options.stop = EC.RT;
%     Options.stop = EC.TOUCH_PERIPHERICAL;
    tStart = getTriggerFromEventCode(Trials, Data.Events, Options.start);
    tStop = getTriggerFromEventCode(Trials, Data.Events, Options.stop);
    rts = tStop-tStart;
    ndx = [];
    SDErt = [];
    ind = find(rts>0);
    rts = rts(ind);
    Trials.condition = Trials.condition(ind);
    n=0;
    for k=1:6
        ad = (7-(k-1))*2;
        add =(7-k)*2;
        ndx = [];
        for cnd=1+n:n+add
            ndx = [ndx find(Trials.condition==4000+cnd)];
        end
        n=cnd;
        SDErt(k) = mean(rts(ndx));
        errSDErt(k) = std(rts(ndx))/sqrt(numel(rts(ndx)));
    end
    corr = [];
    err = [];
    SPE = [];
    for i=1:7
        corr(i) = numel(find(abs(T(i,:))==1));
        err(i) = numel(find(abs(Terr(i,:))==1));
        SPE(i) = corr(i)/(corr(i)+err(i));
    end 
    
    n=0;
    for k=1:2:42
        n=n+1;
        corrAll(n) = numel([find(CorrectTrials.condition==4000+k) find(CorrectTrials.condition==4001+k)]);
        errAll(n) = numel([find(ErrorTrials.condition==4000+k) find(ErrorTrials.condition==4001+k)]);
        AllPairs(n) = corrAll(n)/(corrAll(n)+errAll(n));
    end
    
    figure;plot(1:6,AllPairs(1:6),'.--')
    hold on;plot(7:11, AllPairs(7:11),'.--')
    hold on;plot(12:15, AllPairs(12:15),'.--')
    hold on;plot(16:18, AllPairs(16:18),'.--')
    hold on;plot(19:20, AllPairs(19:20),'.--')
    hold on;plot(21, AllPairs(21),'.--')
    ylim([0 1.1])
    
else
    SDEperf = [];
    SDErt = [];
    SPE = [];
    AllPairs = [];
    errSDErt = [];
end
