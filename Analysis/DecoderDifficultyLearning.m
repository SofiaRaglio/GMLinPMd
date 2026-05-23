% Decoder Difficulty Learning
% It reproduces Figure 5A, Figure S4B.

% clear all; close all; clc;
%% First and second half C24
load('path\to\AllC24.mat')
Params = setParams;
Params.animal = 1;
Params.session = 1;
Params.output = 2;
Params.task = 3;
SelCh = AllCh(Params);
[Data, CorrectTrials,ErrorTrials,TotTrials] = computeMUAandEvents(Params);
k=numel(CorrectTrials.condition);
l = numel(ErrorTrials.condition);
Params.SlidingWindow = 1;
Params.NoT = 1:round(k/2);
[pc241h, ~, Ans1H, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc241h, Baseline] = FromPairOnAUC(Params,SelCh,Ans1H);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_1h, T] = InputOutput(Params,CorrectTrials,2);
Params.NoT = 1:round(l/2);
[P_1hEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

Pred1h = [];
Prediction1h = [];

Pred1hEr = [];
Prediction1hEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(1:round(k/2))
    for i=1:numel(TestedTimes)
        Pred1h(nt,i) = [P_1h(:,nt,i)' ones(1,1)]*Ans1H{1};
    end
end
Prediction1h = mean(Pred1h,2);

for nt = 1:numel(1:round(l/2))
    for i=1:numel(TestedTimes)
        Pred1hEr(nt,i) = [P_1hEr(:,nt,i)' ones(1,1)]*Ans1H{1};
    end
end
Prediction1hEr = mean(Pred1hEr,2);
%%
for i=1:numel(1:round(k/2))
    dir(i) = Prediction1h(i)*T(i);
end
perfc241h = numel(find(dir>0))/numel(dir);

for i=1:numel(1:round(l/2))
    dirEr(i) = Prediction1hEr(i)*Ter(i);
end
perfc241hEr = numel(find(dirEr>0))/numel(dirEr);
pc241h = mean([perfc241h perfc241hEr]);

%%
Params.SlidingWindow = 1;
Params.NoT = round(k/2)+1:k;
[pc242h, ~, Ans2H, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc242h, Baseline] = FromPairOnAUC(Params,SelCh,Ans2H);
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_2h, T] = InputOutput(Params,CorrectTrials,2);
Params.NoT = round(l/2)+1:l;
[P_2hEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

Pred2h = [];
Prediction2h = [];

Pred2hEr = [];
Prediction2hEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(round(k/2)+1:k)
    for i=1:numel(TestedTimes)
        Pred2h(nt,i) = [P_2h(:,nt,i)' ones(1,1)]*Ans2H{1};
    end
end
Prediction2h = mean(Pred2h,2);

for nt = 1:numel(round(l/2)+1:l)
    for i=1:numel(TestedTimes)
        Pred2hEr(nt,i) = [P_2hEr(:,nt,i)' ones(1,1)]*Ans2H{1};
    end
end
Prediction2hEr = mean(Pred2hEr,2);
%%
for i=1:numel(round(k/2)+1:k)
    dir(i) = Prediction2h(i)*T(i);
end
perfc242h = numel(find(dir>0))/numel(dir);

for i=1:numel(round(l/2)+1:l)
    dirEr(i) = Prediction2hEr(i)*Ter(i);
end
perfc242hEr = numel(find(dirEr>0))/numel(dirEr);
pc242h = mean([perfc242h perfc242hEr]);


%% c21
load('path\to\AllC21.mat')
Params = setParams;
Params.animal = 1;
Params.session = 2;
Params.output = 2;
Params.task = 3;
[Data, CorrectTrials,ErrorTrials,TotTrials] = computeMUAandEvents(Params);
k=numel(CorrectTrials.condition);
l=numel(ErrorTrials.condition);
Params.SlidingWindow = 1;
Params.NoT = 1:round(k/2);
[pc211h, ~, Ans1H, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc211h, Baseline] = FromPairOnAUC(Params,SelCh,Ans1H);

%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_1h, T] = InputOutput(Params,CorrectTrials,2);
Params.NoT = 1:round(l/2);
[P_1hEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

Pred1h = [];
Prediction1h = [];

Pred1hEr = [];
Prediction1hEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(1:round(k/2))
    for i=1:numel(TestedTimes)
        Pred1h(nt,i) = [P_1h(:,nt,i)' ones(1,1)]*Ans1H{1};
    end
end
Prediction1h = mean(Pred1h,2);

for nt = 1:numel(1:round(l/2))
    for i=1:numel(TestedTimes)
        Pred1hEr(nt,i) = [P_1hEr(:,nt,i)' ones(1,1)]*Ans1H{1};
    end
end
Prediction1hEr = mean(Pred1hEr,2);
%%
for i=1:numel(1:round(k/2))
    dir(i) = Prediction1h(i)*T(i);
end
perfc211h = numel(find(dir>0))/numel(dir);

for i=1:numel(1:round(l/2))
    dirEr(i) = Prediction1hEr(i)*Ter(i);
end
perfc211hEr = numel(find(dirEr>0))/numel(dirEr);
pc211h = mean([perfc211h perfc211hEr]);

%%
Params.SlidingWindow = 1;
Params.NoT = round(k/2)+1:k;
[pc212h, ~, Ans2H, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfc212h, Baseline] = FromPairOnAUC(Params,SelCh,Ans2H);

%%

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_2h, T] = InputOutput(Params,CorrectTrials,2);
Params.NoT = round(l/2)+1:l;
[P_2hEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

Pred2h = [];
Prediction2h = [];

Pred2hEr = [];
Prediction2hEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(round(k/2)+1:k)
    for i=1:numel(TestedTimes)
        Pred2h(nt,i) = [P_2h(:,nt,i)' ones(1,1)]*Ans2H{1};
    end
end
Prediction2h = mean(Pred2h,2);

for nt = 1:numel(round(l/2)+1:l)
    for i=1:numel(TestedTimes)
        Pred2hEr(nt,i) = [P_2hEr(:,nt,i)' ones(1,1)]*Ans2H{1};
    end
end
Prediction2hEr = mean(Pred2hEr,2);
%%
for i=1:numel(round(k/2)+1:k)
    dir(i) = Prediction2h(i)*T(i);
end
perfc212h = numel(find(dir>0))/numel(dir);

for i=1:numel(round(l/2)+1:l)
    dirEr(i) = Prediction2hEr(i)*Ter(i);
end
perfc212hEr = numel(find(dirEr>0))/numel(dirEr);
pc212h = mean([perfc212h perfc212hEr]);
%% p21
load('path\to\AllP21.mat')
Params = setParams;
Params.animal = 2;
Params.session = 2;
Params.output = 2;
Params.task = 3;
[Data, CorrectTrials,ErrorTrials,TotTrials] = computeMUAandEvents(Params);
k=numel(CorrectTrials.condition);
l=numel(ErrorTrials.condition);
Params.SlidingWindow = 1;
Params.NoT = 1:round(k/2);
[pp211h, ~, Ans1H, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp211h, Baseline] = FromPairOnAUC(Params,SelCh,Ans1H);

%%

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_1h, T] = InputOutput(Params,CorrectTrials,2);
Params.NoT = 1:round(l/2);
[P_1hEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

Pred1h = [];
Prediction1h = [];

Pred1hEr = [];
Prediction1hEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(1:round(k/2))
    for i=1:numel(TestedTimes)
        Pred1h(nt,i) = [P_1h(:,nt,i)' ones(1,1)]*Ans1H{1};
    end
end
Prediction1h = mean(Pred1h,2);

for nt = 1:numel(1:round(l/2))
    for i=1:numel(TestedTimes)
        Pred1hEr(nt,i) = [P_1hEr(:,nt,i)' ones(1,1)]*Ans1H{1};
    end
end
Prediction1hEr = mean(Pred1hEr,2);
%%
for i=1:numel(1:round(k/2))
    dir(i) = Prediction1h(i)*T(i);
end
perfp211h = numel(find(dir>0))/numel(dir);

for i=1:numel(1:round(l/2))
    dirEr(i) = Prediction1hEr(i)*Ter(i);
end
perfp211hEr = numel(find(dirEr>0))/numel(dirEr);
pp211h = mean([perfp211h perfp211hEr]);
%%
Params.SlidingWindow = 1;
Params.NoT = round(k/2)+1:k;
[pp212h, ~, Ans2H, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp212h, Baseline] = FromPairOnAUC(Params,SelCh,Ans2H);
%%

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_2h, T] = InputOutput(Params,CorrectTrials,2);
Params.NoT = 1+round(l/2):l;
[P_2hEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

Pred2h = [];
Prediction2h = [];

Pred2hEr = [];
Prediction2hEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(round(k/2)+1:k)
    for i=1:numel(TestedTimes)
        Pred2h(nt,i) = [P_2h(:,nt,i)' ones(1,1)]*Ans2H{1};
    end
end
Prediction2h = mean(Pred2h,2);

for nt = 1:numel(round(l/2)+1:l)
    for i=1:numel(TestedTimes)
        Pred2hEr(nt,i) = [P_2hEr(:,nt,i)' ones(1,1)]*Ans2H{1};
    end
end
Prediction2hEr = mean(Pred2hEr,2);
%%
for i=1:numel(round(k/2)+1:k)
    dir(i) = Prediction2h(i)*T(i);
end
perfp212h = numel(find(dir>0))/numel(dir);

for i=1:numel(round(l/2)+1:l)
    dirEr(i) = Prediction2hEr(i)*Ter(i);
end
perfp212hEr = numel(find(dirEr>0))/numel(dirEr);
pp212h = mean([perfp212h perfp212hEr]);
%% p24
load('path\to\AllP24.mat')
Params = setParams;
Params.animal = 2;
Params.session = 1;
Params.output = 2;
Params.task = 3;
[Data, CorrectTrials,ErrorTrials,TotTrials] = computeMUAandEvents(Params);
k=numel(CorrectTrials.condition);
l=numel(ErrorTrials.condition);
Params.SlidingWindow = 1;
Params.NoT = 1:round(k/2);
[pp241h, ~, Ans1H, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp241h, Baseline] = FromPairOnAUC(Params,SelCh,Ans1H);

%%

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_1h, T] = InputOutput(Params,CorrectTrials,2);
Params.NoT = 1:round(l/2);
[P_1hEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

Pred1h = [];
Prediction1h = [];

Pred1hEr = [];
Prediction1hEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(1:round(k/2))
    for i=1:numel(TestedTimes)
        Pred1h(nt,i) = [P_1h(:,nt,i)' ones(1,1)]*Ans1H{1};
    end
end
Prediction1h = mean(Pred1h,2);

for nt = 1:numel(1:round(l/2))
    for i=1:numel(TestedTimes)
        Pred1hEr(nt,i) = [P_1hEr(:,nt,i)' ones(1,1)]*Ans1H{1};
    end
end
Prediction1hEr = mean(Pred1hEr,2);
%%
for i=1:numel(1:round(k/2))
    dir(i) = Prediction1h(i)*T(i);
end
perfp241h = numel(find(dir>0))/numel(dir);

for i=1:numel(1:round(l/2))
    dirEr(i) = Prediction1hEr(i)*Ter(i);
end
perfp241hEr = numel(find(dirEr>0))/numel(dirEr);
pp241h = mean([perfp241h perfp241hEr]);
%%
Params.SlidingWindow = 1;
Params.NoT = round(k/2)+1:k;
[pp242h, ~, Ans2H, ~,~] = BestPerfAndCh(Params, SelCh);
[Perfp242h, Baseline] = FromPairOnAUC(Params,SelCh,Ans2H);

%%

[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_2h, T] = InputOutput(Params,CorrectTrials,2);
Params.NoT = 1+round(l/2):l;
[P_2hEr, Ter] = InputOutput(Params,ErrorTrials,2);
Ter = -Ter;

Pred2h = [];
Prediction2h = [];

Pred2hEr = [];
Prediction2hEr = [];

TestedTimes = Params.TestedTimes;
for nt = 1:numel(round(k/2)+1:k)
    for i=1:numel(TestedTimes)
        Pred2h(nt,i) = [P_2h(:,nt,i)' ones(1,1)]*Ans2H{1};
    end
end
Prediction2h = mean(Pred2h,2);

for nt = 1:numel(round(l/2)+1:l)
    for i=1:numel(TestedTimes)
        Pred2hEr(nt,i) = [P_2hEr(:,nt,i)' ones(1,1)]*Ans2H{1};
    end
end
Prediction2hEr = mean(Pred2hEr,2);
%%
for i=1:numel(round(k/2)+1:k)
    dir(i) = Prediction2h(i)*T(i);
end
perfp242h = numel(find(dir>0))/numel(dir);

for i=1:numel(round(l/2)+1:l)
    dirEr(i) = Prediction2hEr(i)*Ter(i);
end
perfp242hEr = numel(find(dirEr>0))/numel(dirEr);
pp242h = mean([perfp242h perfp242hEr]);
%%
% p1h = [mean(mean(Perfc241h(13:end,:,:))) mean(mean(Perfc211h(13:end,:,:))) mean(mean(Perfp241h(13:end,:,:))) mean(mean(Perfp211h(13:end,:,:)))];
% p2h = [mean(mean(Perfc242h(13:end,:,:))) mean(mean(Perfc212h(13:end,:,:))) mean(mean(Perfp242h(13:end,:,:))) mean(mean(Perfp212h(13:end,:,:)))];
p1h = [pc241h pc211h pp241h pp211h];
p2h = [pc242h pc212h pp242h pp212h ];
%%
figure;
errorbar([mean(cons) mean(p1h) mean(p2h)],[std(cons) std(p1h) std(p2h)],'ko--', "LineWidth",2)
hold on
plot([mean(cons) mean(p1h) mean(p2h)], "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 3.5])
%%
figure; hold on

X = [1 2 3];
Y = [cons; p1h; p2h];   % 3 × 4

colors = lines(4);
labels = {'C24','C21','P24','P21'};   % same ordering as vectors

for s = 1:4
    plot(X, Y(:,s), '-o', ...
        'Color', colors(s,:), ...
        'MarkerFaceColor', colors(s,:), ...
        'MarkerEdgeColor','k', ...
        'LineWidth',1.8, ...
        'MarkerSize',8);
end

xlim([0.5 3.5])
set(gca,'XTick',1:3,'XTickLabel',{'Cons','Half 1','Half 2'})
ylabel('Performance')
box on

legend(labels, 'Location','best')
