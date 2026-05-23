
%RT figure
% This script computes the correct and wrong prediction trials RT distribution.
% It reproduces Figure 4D.
load('path\to\AllC24.mat')
Params = setParams;
Params.animal = 1;
Params.session = 1;
Params.task = 3;
[~, ~, ~, ~, ~, ML, ~] = MentalLine(Params,DifT, AnsT);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, TEr] = InputOutput(Params,ErrorTrials,2);

PredEr = [];
PredictionEr = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredEr(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*ML;
    end
end
PredictionEr = mean(PredEr,2);
%%
[P_tot, T] = InputOutput(Params,CorrectTrials,2);
PredCor = [];
PredictionCor = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredCor(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*ML;
    end
end
PredictionCor = mean(PredCor,2);
%%
SDEr = sum(TEr.*repmat((1:size(TEr,1))',1,size(TEr,2)));
SDEr = -SDEr;
%%
SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
SD = -SD;
%%
temp = [];
for i=1:numel(CorrectTrials.condition)
    temp(i) = PredictionCor(i)*SD(i);
end

TP = find(temp>0);
FN = find(temp<0);
%%
temp = [];
for i=1:numel(ErrorTrials.condition)
    temp(i) = PredictionEr(i)*SDEr(i);
end

TN = find(temp<0);
FP = find(temp>0);
%%
EC = setEncodes();
Options.start = EC.TEST1_OFF;
Options.stop = EC.RT;%EC.TOUCH_PERIPHERICAL;
tStart = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.start);
tStop = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.stop);
rtCor = tStop-tStart;

tStart = getTriggerFromEventCode(ErrorTrials, Data.Events, Options.start);
tStop = getTriggerFromEventCode(ErrorTrials, Data.Events, Options.stop);
rtEr = tStop-tStart;
%%
rtTP = rtCor(TP);
rtFN = rtCor(FN);
rtTN = rtEr(TN);
rtFP = rtEr(FP);
%%
rtTPc24 = rtTP(rtTP>0);
rtFNc24 = rtFN(rtFN>0);
rtTNc24 = rtTN(rtTN>0);
rtFPc24 = rtFP(rtFP>0);
%%
load('path\to\AllC21.mat')
Params = setParams;
Params.animal = 1;
Params.session = 2;
Params.task = 3;
[~, ~, ~, ~, ~, ML, ~] = MentalLine(Params,DifT, AnsT);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, TEr] = InputOutput(Params,ErrorTrials,2);

PredEr = [];
PredictionEr = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredEr(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*ML;
    end
end
PredictionEr = mean(PredEr,2);
%%
[P_tot, T] = InputOutput(Params,CorrectTrials,2);
PredCor = [];
PredictionCor = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredCor(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*ML;
    end
end
PredictionCor = mean(PredCor,2);
%%
SDEr = sum(TEr.*repmat((1:size(TEr,1))',1,size(TEr,2)));
SDEr = -SDEr;
%%
SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
SD = -SD;
%%
temp = [];
for i=1:numel(CorrectTrials.condition)
    temp(i) = PredictionCor(i)*SD(i);
end

TP = find(temp>0);
FN = find(temp<0);
%%
temp = [];
for i=1:numel(ErrorTrials.condition)
    temp(i) = PredictionEr(i)*SDEr(i);
end

TN = find(temp<0);
FP = find(temp>0);
%%
EC = setEncodes();
Options.start = EC.TEST1_OFF;
Options.stop = EC.RT;%EC.TOUCH_PERIPHERICAL;
tStart = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.start);
tStop = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.stop);
rtCor = tStop-tStart;

tStart = getTriggerFromEventCode(ErrorTrials, Data.Events, Options.start);
tStop = getTriggerFromEventCode(ErrorTrials, Data.Events, Options.stop);
rtEr = tStop-tStart;
%%
rtTP = rtCor(TP);
rtFN = rtCor(FN);
rtTN = rtEr(TN);
rtFP = rtEr(FP);
%%
rtTPc21 = rtTP(rtTP>0);
rtFNc21 = rtFN(rtFN>0);
rtTNc21 = rtTN(rtTN>0);
rtFPc21 = rtFP(rtFP>0);
%%
load('path\to\AllP21.mat')
Params = setParams;
Params.animal = 2;
Params.session = 2;
Params.task = 3;
[~, ~, ~, ~, ~, ML, ~] = MentalLine(Params,DifT, AnsT);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, TEr] = InputOutput(Params,ErrorTrials,2);

PredEr = [];
PredictionEr = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredEr(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*ML;
    end
end
PredictionEr = mean(PredEr,2);
%%
[P_tot, T] = InputOutput(Params,CorrectTrials,2);
PredCor = [];
PredictionCor = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredCor(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*ML;
    end
end
PredictionCor = mean(PredCor,2);
%%
SDEr = sum(TEr.*repmat((1:size(TEr,1))',1,size(TEr,2)));
SDEr = -SDEr;
%%
SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
SD = -SD;
%%
temp = [];
for i=1:numel(CorrectTrials.condition)
    temp(i) = PredictionCor(i)*SD(i);
end

TP = find(temp>0);
FN = find(temp<0);
%%
temp = [];
for i=1:numel(ErrorTrials.condition)
    temp(i) = PredictionEr(i)*SDEr(i);
end

TN = find(temp<0);
FP = find(temp>0);
%%
EC = setEncodes();
Options.start = EC.TEST1_OFF;
Options.stop = EC.RT;%EC.TOUCH_PERIPHERICAL;
tStart = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.start);
tStop = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.stop);
rtCor = tStop-tStart;

tStart = getTriggerFromEventCode(ErrorTrials, Data.Events, Options.start);
tStop = getTriggerFromEventCode(ErrorTrials, Data.Events, Options.stop);
rtEr = tStop-tStart;
%%
rtTP = rtCor(TP);
rtFN = rtCor(FN);
rtTN = rtEr(TN);
rtFP = rtEr(FP);
%%
rtTPp21 = rtTP(rtTP>0);
rtFNp21 = rtFN(rtFN>0);
rtTNp21 = rtTN(rtTN>0);
rtFPp21 = rtFP(rtFP>0);
%%
load('path\to\AllP24.mat')
Params = setParams;
Params.animal = 2;
Params.session = 1;
Params.task = 3;
[~, ~, ~, ~, ~, ML, ~] = MentalLine(Params,DifT, AnsT);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, TEr] = InputOutput(Params,ErrorTrials,2);

PredEr = [];
PredictionEr = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredEr(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*ML;
    end
end
PredictionEr = mean(PredEr,2);
%%
[P_tot, T] = InputOutput(Params,CorrectTrials,2);
PredCor = [];
PredictionCor = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredCor(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*ML;
    end
end
PredictionCor = mean(PredCor,2);
%%
SDEr = sum(TEr.*repmat((1:size(TEr,1))',1,size(TEr,2)));
SDEr = -SDEr;
%%
SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
SD = -SD;
%%
temp = [];
for i=1:numel(CorrectTrials.condition)
    temp(i) = PredictionCor(i)*SD(i);
end

TP = find(temp>0);
FN = find(temp<0);
%%
temp = [];
for i=1:numel(ErrorTrials.condition)
    temp(i) = PredictionEr(i)*SDEr(i);
end

TN = find(temp<0);
FP = find(temp>0);
%%
EC = setEncodes();
Options.start = EC.TEST1_OFF;
Options.stop = EC.RT;%EC.TOUCH_PERIPHERICAL;
tStart = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.start);
tStop = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.stop);
rtCor = tStop-tStart;

tStart = getTriggerFromEventCode(ErrorTrials, Data.Events, Options.start);
tStop = getTriggerFromEventCode(ErrorTrials, Data.Events, Options.stop);
rtEr = tStop-tStart;
%%
rtTP = rtCor(TP);
rtFN = rtCor(FN);
rtTN = rtEr(TN);
rtFP = rtEr(FP);
%%
rtTPp24 = rtTP(rtTP>0);
rtFNp24 = rtFN(rtFN>0);
rtTNp24 = rtTN(rtTN>0);
rtFPp24 = rtFP(rtFP>0);
%%
figure
hold on
sym2 = [rtTPp24 rtTPp21 rtTPc24 rtTPc21 rtTNp24 rtTNp21 rtTNc24 rtTNc21];
sym1 = [rtFPp24 rtFPp21 rtFPc24 rtFPc21 rtFNp24 rtFNp21 rtFNc24 rtFNc21];
ValRange1 = [max(sym1) min(sym1)];
ValRange2 = [max(sym2) min(sym2)];
BIN_NUM = 50;
X1 = linspace(ValRange1(1), ValRange1(2), BIN_NUM);
X2 = linspace(ValRange2(1), ValRange2(2), BIN_NUM);
Y1 = ksdensity(sym1,X1);
Y2 = ksdensity(sym2,X2);
plot(X1,Y1, 'Linewidth', 2)
plot(X2,Y2, 'Linewidth', 2)