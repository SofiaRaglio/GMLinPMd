% Behavior Difficulty Figure
% It reproduces Figure 5A, Figure S4B.

% clear all; close all;clc
%%
Params=setParams;
%%
Params.task = 3;
Params.animal = 1;
Params.session=1;
[Data CorrectTrials ErrorTrials,TotTrials] = computeMUAandEvents(Params);
a = find(TotTrials.response==5000);
b = find(TotTrials.response==5006);
n =round(numel(TotTrials.response)/2);
learningC24 = zeros(numel(TotTrials.response),1);
learningC24(a) = 1;
% y= cumsum(learningC24);
% x = 1:numel(Data.Trials.response);
% FC24 = griddedInterpolant(x, y);
C24pt1=sum(learningC24(1:n))/n;
C24pt2=sum(learningC24(n+1:end))/n;
C24Test = numel(CorrectTrials.condition)/numel(TotTrials.condition);
Params.SD=1;
Params.AllConditions = 4001:4012;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
C24TestNN = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
Params.AllConditions = 4013:4042;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
C24TestSDgt1 = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
Params.SD=2;
Params.task = 2;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
C24Cons = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
%%
Params.task = 3;
Params.animal = 1;
Params.session=2;
[Data CorrectTrials ErrorTrials,TotTrials] = computeMUAandEvents(Params);
a = find(TotTrials.response==5000);
b = find(TotTrials.response==5006);
n =round(numel(TotTrials.response)/2);
learningC21 = zeros(numel(TotTrials.response),1);
learningC21(a) = 1;
% y= cumsum(learningC21);
% x = 1:numel(Data.Trials.response);
% FC21 = griddedInterpolant(x, y);
n =round(numel(TotTrials.response)/2);
C21pt1=sum(learningC21(1:n))/n;
C21pt2=sum(learningC21(n+1:end))/n;
C21Test = numel(CorrectTrials.condition)/numel(TotTrials.condition);
Params.SD=1;
Params.AllConditions = 4001:4012;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
C21TestNN = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
Params.AllConditions = 4013:4042;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
C21TestSDgt1 = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
Params.SD=2;
Params.task = 2;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
C21Cons = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
%%
Params.task=3;
Params.animal = 2;
Params.session=1;
[Data CorrectTrials ErrorTrials,TotTrials] = computeMUAandEvents(Params);
a = find(TotTrials.response==5000);
b = find(TotTrials.response==5006);
n =round(numel(TotTrials.response)/2);
learningP24 = zeros(numel(TotTrials.response),1);
learningP24(a) = 1;
% y= cumsum(learningP24);
% x = 1:numel(Data.Trials.response);
% FP24 = griddedInterpolant(x, y);
n =round(numel(TotTrials.response)/2);
P24pt1=sum(learningP24(1:n))/n;
P24pt2=sum(learningP24(n+1:end))/n;
P24Test = numel(CorrectTrials.condition)/numel(TotTrials.condition);
Params.SD=1;
Params.AllConditions = 4001:4012;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
P24TestNN = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
Params.AllConditions = 4013:4042;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
P24TestSDgt1 = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
Params.SD=2;
Params.task = 2;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
P24Cons = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
%%
Params.task=3;
Params.animal = 2;
Params.session=2;
[Data CorrectTrials ErrorTrials,TotTrials] = computeMUAandEvents(Params);
a = find(TotTrials.response==5000);
b = find(TotTrials.response==5006);
n =round(numel(TotTrials.response)/2);
learningP21 = zeros(numel(TotTrials.response),1);
learningP21(a) = 1;
% y= cumsum(learningP21);
% x = 1:numel(Data.Trials.response);
% FP21 = griddedInterpolant(x, y);
n =round(numel(TotTrials.response)/2);
P21pt1=sum(learningP21(1:n))/n;
P21pt2=sum(learningP21(n+1:end))/n;
P21Test = numel(CorrectTrials.condition)/numel(TotTrials.condition);
Params.SD=1;
Params.AllConditions = 4001:4012;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
P21TestNN = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
Params.AllConditions = 4013:4042;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
P21TestSDgt1 = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
Params.SD=2;
Params.task = 2;
[Data, CorrectTrials, ErrorTrials] = computeMUAandEvents(Params);
P21Cons = numel(CorrectTrials.condition)/(numel(CorrectTrials.condition)+numel(ErrorTrials.condition));
%%
TestPt1 = [C24pt1 C21pt1 P24pt1 P21pt1];
TestPt2 = [C24pt2 C21pt2 P24pt2 P21pt2];
Test = [C24Test C21Test P24Test P21Test];
TestNN = [C24TestNN C21TestNN P24TestNN P21TestNN];
TestSDgt1 = [C24TestSDgt1 C21TestSDgt1 P24TestSDgt1 P21TestSDgt1];
Cons = [C24Cons C21Cons P24Cons P21Cons];
%%
figure;
errorbar([mean(Cons) mean(TestNN) mean(TestSDgt1)],[std(Cons) std(TestNN) std(TestSDgt1)],'ro--', "LineWidth",2)
hold on
plot([mean(Cons) mean(TestNN) mean(TestSDgt1)], "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 3.5])
%%
figure;
errorbar([mean(Cons) mean(TestPt1) mean(TestPt2)],[std(Cons) std(TestPt1) std(TestPt2)],'ko--', "LineWidth",2)
hold on
plot([mean(Cons) mean(TestPt1) mean(TestPt2)], "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 3.5])
%%
figure; hold on

X = [1 2 3];
Y = [Cons; TestNN; TestSDgt1];  % 3 × 4

plot(X, Y, '-o', ...
    'Color',[0.7 0.7 0.7], ...
    'MarkerFaceColor','r', ...
    'MarkerEdgeColor','k', ...
    'LineWidth',1.5, ...
    'MarkerSize',8)

xlim([0.5 3.5])
set(gca,'XTick',1:3,'XTickLabel',{'Cons','TestNN','Test SD>1'})
ylabel('Performance')
box on
%%
figure; hold on

X = [1 2 3];
Y = [Cons; TestNN; TestSDgt1];   % 3 × 4

colors = lines(4);   % 4 distinct colors
labels = {'C24','C21','P24','P21'};

for s = 1:4
    plot(X, Y(:,s), '-o', ...
        'Color', colors(s,:), ...
        'MarkerFaceColor', colors(s,:), ...
        'MarkerEdgeColor','k', ...
        'LineWidth',1.8, ...
        'MarkerSize',8);
end

xlim([0.5 3.5])
set(gca,'XTick',1:3,'XTickLabel',{'Cons','TestNN','Test SD>1'})
ylabel('Performance')
box on

legend(labels, 'Location','best')
%%
figure; hold on

X = [1 2 3];
Y = [Cons; TestPt1; TestPt2];

colors = lines(4);
labels = {'C24','C21','P24','P21'};

for s = 1:4
    plot(X, Y(:,s), '-o', ...
        'Color', colors(s,:), ...
        'MarkerFaceColor', colors(s,:), ...
        'MarkerEdgeColor','k', ...
        'LineWidth',1.8, ...
        'MarkerSize',8);
end

xlim([0.5 3.5])
set(gca,'XTick',1:3,'XTickLabel',{'Cons','Test1','Test2'})
ylabel('Performance')
box on

legend(labels, 'Location','best')
%%
