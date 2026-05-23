% Predict Condition Figure
% This script reproduces Figure 3A and S3A,B.
Params = setParams();
%%
load('path\to\AllC24.mat')
Params.task = 2;
Params.animal =1;
Params.session=1;
[Prediction, Accuracy, MeanConditionC24,Rect] = PredictOutput(Params,PureC);
Params.task = 3;
[Prediction, Accuracy, MeanConditionC24test,Rect1] = PredictOutput(Params,PureT);
%%
load('path\to\AllC21.mat')
Params.task = 2;
Params.animal =1;
Params.session=2;
[Prediction, Accuracy, MeanConditionC21,Rect] = PredictOutput(Params,PureC);
Params.task = 3;
[Prediction, Accuracy, MeanConditionC21test,Rect] = PredictOutput(Params,PureT);
%%
load('path\to\AllP21.mat')
Params.task = 2;
Params.animal =2;
Params.session=2;
[Prediction, Accuracy, MeanConditionP21,Rect] = PredictOutput(Params,PureC);
Params.task = 3;
[Prediction, Accuracy, MeanConditionP21test,Rect] = PredictOutput(Params,PureT);
%%
load('path\to\AllP24.mat')
Params.task = 2;
Params.animal =2;
Params.session=1;
[Prediction, Accuracy, MeanConditionP24,Rect] = PredictOutput(Params,PureC);
Params.task = 3;
[Prediction, Accuracy, MeanConditionP24test,Rect2] = PredictOutput(Params,PureT);
%%
close all;
%%
MeanCondition = [];
MeanCondition(:,:,1) = MeanConditionC24;
MeanCondition(:,:,2) = MeanConditionC21;
MeanCondition(:,:,3) = MeanConditionP21;
MeanCondition(:,:,4) = MeanConditionP24;
MeanCondition = mean(MeanCondition,3);
%%
MeanConditiontest = [];
MeanConditiontest(:,:,1) = MeanConditionC24test;
MeanConditiontest(:,:,2) = MeanConditionC21test;
MeanConditiontest(:,:,3) = MeanConditionP21test;
MeanConditiontest(:,:,4) = MeanConditionP24test;
MeanConditiontest = mean(MeanConditiontest,3);
%%
figure
imagesc(MeanCondition)
yticks([1:size(MeanCondition,1)])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
xticks([1:size(MeanCondition,2)])
xticklabels({'AB','BC', 'CD', 'DE', 'EF', 'FG'})
caxis([0.2 0.28])
%% Prova per il plot di quanto codifico ogni lettera in consolidation
A = 0.28889;
B = mean([0.277543 0.270622]);
C = mean([0.27041 0.271447]);
D = mean([0.269883 0.276992]);
E = mean([0.274992 0.272129]);
F = mean([0.267738 0.277221]);
G = 0.286311;
figure
plot([A B C D E F G],'d--')
xlim([0.5 7.5])
ylim([0.25 0.3])
%%
MeanCond = [mean(MeanCondition(:,1:2),2) mean(MeanCondition(:,3:4),2) mean(MeanCondition(:,5:6),2) mean(MeanCondition(:,7:8),2) mean(MeanCondition(:,9:10),2) mean(MeanCondition(:,11:12),2)];
%%
% Histogram of the performance of each letter in the different conditions.
A = MeanCond(1,1);
B = mean([MeanCond(2,1) MeanCond(2,2)]);
C = mean([MeanCond(3,2) MeanCond(3,3)]);
D = mean([MeanCond(4,3) MeanCond(4,4)]);
R = mean([MeanCond(5,4) MeanCond(5,5)]);
F = mean([MeanCond(6,5) MeanCond(6,6)]);
G = MeanCond(7,6);
figure
plot([A B C D E F G],'d--')
xlim([0.5 7.5])
ylim([0.2 0.3])
xticklabels({'A','B','C','D','E','F','G'})
%%
figure
imagesc(MeanConditiontest)
yticks([1:size(MeanConditiontest,1)])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
xticks([1:21])
caxis([0.2 0.28])
xticklabels({'AB','BC', 'CD', 'DE', 'EF', 'FG','AC','BD', 'CE', 'DF','EG','AD','BE', 'CF', 'DG','AE','BF', 'CG','AF','BG', 'AG'})

%%
MeanCondT = [mean(MeanConditiontest(:,1:2),2) mean(MeanConditiontest(:,3:4),2) mean(MeanConditiontest(:,5:6),2) mean(MeanConditiontest(:,7:8),2) mean(MeanConditiontest(:,9:10),2) mean(MeanConditiontest(:,11:12),2) mean(MeanConditiontest(:,13:14),2) mean(MeanConditiontest(:,15:16),2) mean(MeanConditiontest(:,17:18),2) mean(MeanConditiontest(:,19:20),2) mean(MeanConditiontest(:,21:22),2) mean(MeanConditiontest(:,23:24),2) mean(MeanConditiontest(:,25:26),2) mean(MeanConditiontest(:,27:28),2) mean(MeanConditiontest(:,29:30),2) mean(MeanConditiontest(:,31:32),2) mean(MeanConditiontest(:,33:34),2) mean(MeanConditiontest(:,35:36),2) mean(MeanConditiontest(:,37:38),2) mean(MeanConditiontest(:,39:40),2) mean(MeanConditiontest(:,41:42),2)];
%%
MeanConditiontest = MeanCondT;
%% Histogram of the performance of each letter in the different conditions.
A = mean([MeanConditiontest(1,1) MeanConditiontest(1,7) MeanConditiontest(1,12) MeanConditiontest(1,16) MeanConditiontest(1,19) MeanConditiontest(1,21)]);
B = mean([MeanConditiontest(2,1) MeanConditiontest(2,2) MeanConditiontest(2,8) MeanConditiontest(2,13) MeanConditiontest(2,17) MeanConditiontest(2,20)]);
C = mean([MeanConditiontest(1,2) MeanConditiontest(1,3) MeanConditiontest(1,7) MeanConditiontest(1,9) MeanConditiontest(1,14) MeanConditiontest(1,18)]);
D = mean([MeanConditiontest(1,3) MeanConditiontest(1,4) MeanConditiontest(1,8) MeanConditiontest(1,10) MeanConditiontest(1,12) MeanConditiontest(1,15)]);
E = mean([MeanConditiontest(1,4) MeanConditiontest(1,5) MeanConditiontest(1,9) MeanConditiontest(1,11) MeanConditiontest(1,13) MeanConditiontest(1,16)]);
F = mean([MeanConditiontest(1,5) MeanConditiontest(1,6) MeanConditiontest(1,10) MeanConditiontest(1,14) MeanConditiontest(1,17) MeanConditiontest(1,19)]);
G = mean([MeanConditiontest(1,11) MeanConditiontest(1,6) MeanConditiontest(1,15) MeanConditiontest(1,18) MeanConditiontest(1,20) MeanConditiontest(1,21)]);

figure
plot([A B C D E F G],'d--')
xlim([0.5 7.5])
ylim([0.2 0.3])
xticklabels({'A','B','C','D','E','F','G'})