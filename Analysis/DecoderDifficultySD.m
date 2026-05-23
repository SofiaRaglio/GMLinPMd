% Decoder Difficulty SD
% It reproduces Figure 5A, Figure S4B.

% clear all;close all;clc;
%% Performance consolidation C24
load('path\to\AllC24.mat')
Params = setParams;
Params.animal = 1;
Params.session = 1;
Params.output = 2;
Params.task = 2;
%%
SelCh = AllCh(Params);
[pc24c, ~, AnsC, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc24c, Baseline] = FromPairOnAUC(Params,SelCh,AnsC);
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_cons, T] = InputOutput(Params,CorrectTrials,2);
[P_consEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredCons = [];
PredictionCons = [];

PredConsEr = [];
PredictionConsEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredCons(nt,i) = [P_cons(:,nt,i)' ones(1,1)]*AnsC{1};
    end
end
PredictionCons = mean(PredCons,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredConsEr(nt,i) = [P_consEr(:,nt,i)' ones(1,1)]*AnsC{1};
    end
end
PredictionConsEr = mean(PredConsEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionCons(i)*T(i);
end
perfC24C = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionConsEr(i)*Ter(i);
end
perfC24CEr = numel(find(dirEr>0))/numel(dirEr);
pC24C = mean([perfC24C perfC24CEr]);
%% Performance Test SD>1, C24
Params.task = 3;
Params.SD = 1;
Params.AllConditions = 4013:4042;
[pc24tgt1, ~, AnsTgt1, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc24tgt1, Baseline] = FromPairOnAUC(Params,SelCh,AnsTgt1);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_Test, T] = InputOutput(Params,CorrectTrials,2);
[P_TestEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredTest = [];
PredictionTest = [];

PredTestEr = [];
PredictionTestEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredTest(nt,i) = [P_Test(:,nt,i)' ones(1,1)]*AnsTgt1{1};
    end
end
PredictionTest = mean(PredTest,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestEr(nt,i) = [P_TestEr(:,nt,i)' ones(1,1)]*AnsTgt1{1};
    end
end
PredictionTestEr = mean(PredTestEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionTest(i)*T(i);
end
perfC24T = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionTestEr(i)*Ter(i);
end
perfC24TEr = numel(find(dirEr>0))/numel(dirEr);
pC24T = mean([perfC24T perfC24TEr]);
%% Performance Test SD=1, C24
Params.AllConditions = 4001:4012;
[pc24tnn, ~, AnsNN, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc24tnn, Baseline] = FromPairOnAUC(Params,SelCh,AnsNN);

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_TestNN, T] = InputOutput(Params,CorrectTrials,2);
[P_TestNNEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredTestNN = [];
PredictionTestNN = [];

PredTestNNEr = [];
PredictionTestNNEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestNN(nt,i) = [P_TestNN(:,nt,i)' ones(1,1)]*AnsNN{1};
    end
end
PredictionTestNN = mean(PredTestNN,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestNNEr(nt,i) = [P_TestNNEr(:,nt,i)' ones(1,1)]*AnsNN{1};
    end
end
PredictionTestNNEr = mean(PredTestNNEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionTestNN(i)*T(i);
end
perfC24TNN = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionTestNNEr(i)*Ter(i);
end
perfC24TNNEr = numel(find(dirEr>0))/numel(dirEr);
pC24TNN = mean([perfC24TNN perfC24TNNEr]);

%% Performance consolidation C21
load('path\to\AllC21.mat')
Params = setParams;
Params.animal = 1;
Params.session = 2;
Params.output = 2;
Params.task = 2;
%%
SelCh = AllCh(Params);
[pc21c, ~, AnsC, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc21c, Baseline] = FromPairOnAUC(Params,SelCh,AnsC);

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_cons, T] = InputOutput(Params,CorrectTrials,2);
[P_consEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredCons = [];
PredictionCons = [];

PredConsEr = [];
PredictionConsEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredCons(nt,i) = [P_cons(:,nt,i)' ones(1,1)]*AnsC{1};
    end
end
PredictionCons = mean(PredCons,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredConsEr(nt,i) = [P_consEr(:,nt,i)' ones(1,1)]*AnsC{1};
    end
end
PredictionConsEr = mean(PredConsEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionCons(i)*T(i);
end
perfC21C = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionConsEr(i)*Ter(i);
end
perfC21CEr = numel(find(dirEr>0))/numel(dirEr);
pC21C = mean([perfC21C perfC21CEr]);
%% Performance Test SD>1, C21
Params.task = 3;
Params.SD = 1;
Params.AllConditions = 4013:4042;
[pc21tgt1, ~, AnsTgt1, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc21tgt1, Baseline] = FromPairOnAUC(Params,SelCh,AnsTgt1);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_Test, T] = InputOutput(Params,CorrectTrials,2);
[P_TestEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredTest = [];
PredictionTest = [];

PredTestEr = [];
PredictionTestEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredTest(nt,i) = [P_Test(:,nt,i)' ones(1,1)]*AnsTgt1{1};
    end
end
PredictionTest = mean(PredTest,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestEr(nt,i) = [P_TestEr(:,nt,i)' ones(1,1)]*AnsTgt1{1};
    end
end
PredictionTestEr = mean(PredTestEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionTest(i)*T(i);
end
perfC21T = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionTestEr(i)*Ter(i);
end
perfC21TEr = numel(find(dirEr>0))/numel(dirEr);
pC21T = mean([perfC21T perfC21TEr]);
%% Performance Test SD=1, C21
Params.AllConditions = 4001:4012;
[pc21tnn, ~, AnsNN, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc21tnn, Baseline] = FromPairOnAUC(Params,SelCh,AnsNN);

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_TestNN, T] = InputOutput(Params,CorrectTrials,2);
[P_TestNNEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredTestNN = [];
PredictionTestNN = [];

PredTestNNEr = [];
PredictionTestNNEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestNN(nt,i) = [P_TestNN(:,nt,i)' ones(1,1)]*AnsNN{1};
    end
end
PredictionTestNN = mean(PredTestNN,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestNNEr(nt,i) = [P_TestNNEr(:,nt,i)' ones(1,1)]*AnsNN{1};
    end
end
PredictionTestNNEr = mean(PredTestNNEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionTestNN(i)*T(i);
end
perfC21TNN = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionTestNNEr(i)*Ter(i);
end
perfC21TNNEr = numel(find(dirEr>0))/numel(dirEr);
pC21TNN = mean([perfC21TNN perfC21TNNEr]);

%% Performance consolidation P21
load('path\to\AllP21.mat')
Params = setParams;
Params.animal = 2;
Params.session = 2;
Params.output = 2;
Params.task = 2;
%%
SelCh = AllCh(Params);
[pp21c, ~, AnsC, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp21c, Baseline] = FromPairOnAUC(Params,SelCh,AnsC);
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_cons, T] = InputOutput(Params,CorrectTrials,2);
[P_consEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredCons = [];
PredictionCons = [];

PredConsEr = [];
PredictionConsEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredCons(nt,i) = [P_cons(:,nt,i)' ones(1,1)]*AnsC{1};
    end
end
PredictionCons = mean(PredCons,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredConsEr(nt,i) = [P_consEr(:,nt,i)' ones(1,1)]*AnsC{1};
    end
end
PredictionConsEr = mean(PredConsEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionCons(i)*T(i);
end
perfP21C = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionConsEr(i)*Ter(i);
end
perfP21CEr = numel(find(dirEr>0))/numel(dirEr);
pP21C = mean([perfP21C perfP21CEr]);
%% Performance Test SD>1, P21
Params.task = 3;
Params.SD = 1;
Params.AllConditions = 4013:4042;
[pp21tgt1, ~, AnsTgt1, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp21tgt1, Baseline] = FromPairOnAUC(Params,SelCh,AnsTgt1);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_Test, T] = InputOutput(Params,CorrectTrials,2);
[P_TestEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredTest = [];
PredictionTest = [];

PredTestEr = [];
PredictionTestEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredTest(nt,i) = [P_Test(:,nt,i)' ones(1,1)]*AnsTgt1{1};
    end
end
PredictionTest = mean(PredTest,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestEr(nt,i) = [P_TestEr(:,nt,i)' ones(1,1)]*AnsTgt1{1};
    end
end
PredictionTestEr = mean(PredTestEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionTest(i)*T(i);
end
perfP21T = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionTestEr(i)*Ter(i);
end
perfP21TEr = numel(find(dirEr>0))/numel(dirEr);
pP21T = mean([perfP21T perfP21TEr]);
%% Performance Test SD=1, P21
Params.AllConditions = 4001:4012;
[pp21tnn, ~, AnsNN, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp21tnn, Baseline] = FromPairOnAUC(Params,SelCh,AnsNN);

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_TestNN, T] = InputOutput(Params,CorrectTrials,2);
[P_TestNNEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredTestNN = [];
PredictionTestNN = [];

PredTestNNEr = [];
PredictionTestNNEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestNN(nt,i) = [P_TestNN(:,nt,i)' ones(1,1)]*AnsNN{1};
    end
end
PredictionTestNN = mean(PredTestNN,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestNNEr(nt,i) = [P_TestNNEr(:,nt,i)' ones(1,1)]*AnsNN{1};
    end
end
PredictionTestNNEr = mean(PredTestNNEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionTestNN(i)*T(i);
end
perfP21TNN = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionTestNNEr(i)*Ter(i);
end
perfP21TNNEr = numel(find(dirEr>0))/numel(dirEr);
pP21TNN = mean([perfP21TNN perfP21TNNEr]);

%% Performance consolidation P24
load('path\to\AllP24.mat')
Params = setParams;
Params.animal = 2;
Params.session = 1;
Params.output = 2;
Params.task = 2;
%%
SelCh = AllCh(Params);
[pp24c, ~, AnsC, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp24c, Baseline] = FromPairOnAUC(Params,SelCh,AnsC);
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_cons, T] = InputOutput(Params,CorrectTrials,2);
[P_consEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredCons = [];
PredictionCons = [];

PredConsEr = [];
PredictionConsEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredCons(nt,i) = [P_cons(:,nt,i)' ones(1,1)]*AnsC{1};
    end
end
PredictionCons = mean(PredCons,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredConsEr(nt,i) = [P_consEr(:,nt,i)' ones(1,1)]*AnsC{1};
    end
end
PredictionConsEr = mean(PredConsEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionCons(i)*T(i);
end
perfP24C = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionConsEr(i)*Ter(i);
end
perfP24CEr = numel(find(dirEr>0))/numel(dirEr);
pP24C = mean([perfP24C perfP24CEr]);
%% Performance Test SD>1, P24
Params.task = 3;
Params.SD = 1;
Params.AllConditions = 4013:4042;
[pp24tgt1, ~, AnsTgt1, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp24tgt1, Baseline] = FromPairOnAUC(Params,SelCh,AnsTgt1);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_Test, T] = InputOutput(Params,CorrectTrials,2);
[P_TestEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredTest = [];
PredictionTest = [];

PredTestEr = [];
PredictionTestEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredTest(nt,i) = [P_Test(:,nt,i)' ones(1,1)]*AnsTgt1{1};
    end
end
PredictionTest = mean(PredTest,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestEr(nt,i) = [P_TestEr(:,nt,i)' ones(1,1)]*AnsTgt1{1};
    end
end
PredictionTestEr = mean(PredTestEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionTest(i)*T(i);
end
perfP24T = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionTestEr(i)*Ter(i);
end
perfP24TEr = numel(find(dirEr>0))/numel(dirEr);
pP24T = mean([perfP24T perfP24TEr]);
%% Performance Test SD=1, P24
Params.AllConditions = 4001:4012;
[pp24tnn, ~, AnsNN, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp24tnn, Baseline] = FromPairOnAUC(Params,SelCh,AnsNN);

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_TestNN, T] = InputOutput(Params,CorrectTrials,2);
[P_TestNNEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

PredTestNN = [];
PredictionTestNN = [];

PredTestNNEr = [];
PredictionTestNNEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(CorrectTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestNN(nt,i) = [P_TestNN(:,nt,i)' ones(1,1)]*AnsNN{1};
    end
end
PredictionTestNN = mean(PredTestNN,2);

for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredTestNNEr(nt,i) = [P_TestNNEr(:,nt,i)' ones(1,1)]*AnsNN{1};
    end
end
PredictionTestNNEr = mean(PredTestNNEr,2);
%%
for i=1:numel(CorrectTrials.condition)
    dir(i) = PredictionTestNN(i)*T(i);
end
perfP24TNN = numel(find(dir>0))/numel(dir);

for i=1:numel(ErrorTrials.condition)
    dirEr(i) = PredictionTestNNEr(i)*Ter(i);
end
perfP24TNNEr = numel(find(dirEr>0))/numel(dirEr);
pP24TNN = mean([perfP24TNN perfP24TNNEr]);
%%
TestNN = [pC24TNN pC21TNN pP24TNN pP21TNN];
TestSDgt1 = [pC24T pC21T pP24T pP21T];
Cons = [pC24C pC21C pP24C pP21C];
%%
figure;
errorbar([mean(Cons) mean(TestNN) mean(TestSDgt1)],[std(Cons) std(TestNN) std(TestSDgt1)],'ko--', "LineWidth",2)
hold on
plot([mean(Cons) mean(TestNN) mean(TestSDgt1)], "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 3.5])
%%
figure
plot([pP24C pP24TNN pP24T])
%%
cons = [mean(mean(Perfc24c(13:end,:,:))) mean(mean(Perfc21c(13:end,:,:))) mean(mean(Perfp24c(13:end,:,:))) mean(mean(Perfp21c(13:end,:,:)))];
% tnn = [mean(mean(Perfc24tnn(13:end,:,:))) mean(mean(Perfc21tnn(13:end,:,:))) mean(mean(Perfp24tnn(13:end,:,:))) mean(mean(Perfp21tnn(13:end,:,:)))];
% tgt1 = [mean(mean(Perfc24tgt1(13:end,:,:))) mean(mean(Perfc21tgt1(13:end,:,:))) mean(mean(Perfp24tgt1(13:end,:,:))) mean(mean(Perfp21tgt1(13:end,:,:)))];
%%
load('SDAnsPerf.mat')
a = squeeze(mean(Perf1,3));
b = squeeze(mean(Perf2,3));
c = squeeze(mean(Perf3,3));
d = squeeze(mean(Perf4,3));
e = squeeze(mean(Perf5,3));
f = squeeze(mean(Perf6,3));
am = mean(a(13:end,:));
bm = mean(b(13:end,:));
cm = mean(c(13:end,:));
dm = mean(d(13:end,:));
em = mean(e(13:end,:));
fm = mean(f(13:end,:));
sdgt1 = mean([bm;cm;dm;em;fm]);
%%
figure;
errorbar([mean(cons) mean(am) mean(sdgt1)],[std(cons) std(am) std(sdgt1)],'ko--', "LineWidth",2)
hold on
plot([mean(cons) mean(am) mean(sdgt1)], "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 3.5])
%%
figure; hold on

X = [1 2 3];
Y = [cons; am; sdgt1];   % 3 × 4  (conditions × sessions)

colors = lines(4);
labels = {'C24','C21','P24','P21'};   % adjust if needed

for s = 1:4
    plot(X, Y(:,s), '-o', ...
        'Color', colors(s,:), ...
        'MarkerFaceColor', colors(s,:), ...
        'MarkerEdgeColor','k', ...
        'LineWidth',1.8, ...
        'MarkerSize',8);
end

xlim([0.5 3.5])
set(gca,'XTick',1:3,'XTickLabel',{'Cons','SD=1 (late)','SD>1'})
ylabel('Performance')
box on

legend(labels, 'Location','best')
