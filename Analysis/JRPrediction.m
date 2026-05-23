% JR Prediction from position-invariant derived GML.
% This script reproduces Figure 4B.
load('path\to\AllC24.mat')
Params = setParams;
Params.animal = 1;
Params.session = 1;
Params.task = 3;
[~, ~, ~, ~, ~, MLC24, ~] = MentalLine(Params,PureT, AnsT);
[Data, CorrectTrials,~] = computeMUAandEvents(Params);
[P_tot, T , tEC] = InputOutput(Params,CorrectTrials,2);
PredC24 = [];
PredictionC24=[];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(tEC)
    for i=1:numel(TestedTimes)
        PredC24(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLC24;
    end
end
PredictionC24 = mean(PredC24,2);
AnsC24 = AnsT;
%%
JRC24 = sum(abs(T).*flip(repmat((1:size(T,1))',1,size(T,2))));
n=0;
for i=3:13
    n=n+1;
    ind = find(JRC24==i);
    meanJR(n) = median(PredictionC24(ind));
    stdJR(n) = std(PredictionC24(ind))/sqrt(numel(PredictionC24(ind)));
end
c24 = corrcoef(JRC24,PredictionC24);
figure,plot(JRC24+randn(size(JRC24))*0.1,PredictionC24,'.')
hold on
errorbar(3:13, meanJR,stdJR, 'r.', 'MarkerSize',15)
title(sprintf('Correlation %d',c24(1,2)));
%%
load('path\to\AllC21.mat')
Params = setParams;
Params.animal = 1;
Params.session = 2;
Params.task = 3;
[~, ~, ~, ~, ~, MLC21, ~] = MentalLine(Params,PureT, AnsT);
[Data, CorrectTrials,~] = computeMUAandEvents(Params);
[P_tot, T , tEC] = InputOutput(Params,CorrectTrials,2);
PredC21 = [];
PredictionC21=[];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(tEC)
    for i=1:numel(TestedTimes)
        PredC21(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLC21;
    end
end
PredictionC21 = mean(PredC21,2);
AnsC21 = AnsT;
%%
JRC21 = sum(abs(T).*flip(repmat((1:size(T,1))',1,size(T,2))));
n=0;
for i=3:13
    n=n+1;
    ind = find(JRC21==i);
    meanJR(n) = median(PredictionC21(ind));
    stdJR(n) = std(PredictionC21(ind))/sqrt(numel(PredictionC21(ind)));
end
C21 = corrcoef(JRC21,PredictionC21);
figure,plot(JRC21+randn(size(JRC21))*0.1,PredictionC21,'.')
hold on
errorbar(3:13, meanJR,stdJR, 'r.', 'MarkerSize',15)
title(sprintf('Correlation %d',C21(1,2)));
%%
load('path\to\AllP24.mat')
Params = setParams;
Params.animal = 2;
Params.session = 1;
Params.task = 3;
[~, ~, ~, ~, ~, MLP24, ~] = MentalLine(Params,PureT, AnsT);
[Data, CorrectTrials,~] = computeMUAandEvents(Params);
[P_tot, T , tEC] = InputOutput(Params,CorrectTrials,2);
PredP24 = [];
PredictionP24=[];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(tEC)
    for i=1:numel(TestedTimes)
        PredP24(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLP24;
    end
end
PredictionP24 = mean(PredP24,2);
AnsP24 = AnsT;
%%
JRP24 = sum(abs(T).*flip(repmat((1:size(T,1))',1,size(T,2))));
n=0;
for i=3:13
    n=n+1;
    ind = find(JRP24==i);
    meanJR(n) = median(PredictionP24(ind));
    stdJR(n) = std(PredictionP24(ind))/sqrt(numel(PredictionP24(ind)));
end
P24 = corrcoef(JRP24,PredictionP24);
figure,plot(JRP24+randn(size(JRP24))*0.1,PredictionP24,'.')
hold on
errorbar(3:13, meanJR,stdJR, 'r.', 'MarkerSize',15)
title(sprintf('Correlation %d',P24(1,2)));
%%
load('path\to\AllP21.mat')
Params = setParams;
Params.animal = 2;
Params.session = 2;
Params.task = 3;
[~, ~, ~, ~, ~, MLP21, ~] = MentalLine(Params,PureT, AnsT);
[Data, CorrectTrials,~] = computeMUAandEvents(Params);
[P_tot, T , tEC] = InputOutput(Params,CorrectTrials,2);
PredP21 = [];
PredictionP21=[];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(tEC)
    for i=1:numel(TestedTimes)
        PredP21(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLP21;
    end
end
PredictionP21 = mean(PredP21,2);
AnsP21 = AnsT;
%%
JRP21 = sum(abs(T).*flip(repmat((1:size(T,1))',1,size(T,2))));
n=0;
for i=3:13
    n=n+1;
    ind = find(JRP21==i);
    meanJR(n) = median(PredictionP21(ind));
    stdJR(n) = std(PredictionP21(ind))/sqrt(numel(PredictionP21(ind)));
end
P21 = corrcoef(JRP21,PredictionP21);
figure,plot(JRP21+randn(size(JRP21))*0.1,PredictionP21,'.')
hold on
errorbar(3:13, meanJR,stdJR, 'r.', 'MarkerSize',15)
title(sprintf('Correlation %d',P21(1,2)));
%%
JR = [JRC24 JRC21 JRP24 JRP21];
Prediction = [PredictionC24' PredictionC21' PredictionP24' PredictionP21'];
% JR = [JRC24 JRP24 ];
% Prediction = [PredictionC24' PredictionP24' ];
n=0;
for i=3:13
    n=n+1;
    ind = find(JR==i);
    meanJR(n) = median(Prediction(ind));
    stdJR(n) = std(Prediction(ind))/sqrt(numel(Prediction(ind)));
end
cor = corrcoef(JR,Prediction);
figure,plot(JR+randn(size(JR))*0.1,Prediction,'.')
hold on
errorbar(3:13, meanJR,stdJR, 'r.', 'MarkerSize',15)
title(sprintf('Correlation %d',cor(1,2)));