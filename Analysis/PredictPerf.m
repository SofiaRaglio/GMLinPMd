% Predict Performance
% This script predicts the performance of left/right decision predicted by the GML in correct and error trials.
% It reproduces Figure 4A and Table S2.
%%
load('path\to\AllC24.mat')
Params = setParams;
Params.animal = 1;
Params.session = 1;
Params.task = 2;
[~, ~, ~, ~, ~, MLC24C, ~] = MentalLine(Params,DifC, AnsC);
Params.task = 3;
[~, ~, ~, ~, ~, MLC24T, ~] = MentalLine(Params,DifT, AnsT);
[SDLineC24, stdLineC24, ~, sdxC24, sxdC24] = PredictLine(Params, MLC24T);
close all;
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, TEr] = InputOutput(Params,ErrorTrials,2);

PredEr = [];
PredictionEr = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredEr(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLC24T;
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
        PredCor(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLC24T;
    end
end
PredictionCor = mean(PredCor,2);
%%
SDEr = sum(TEr.*repmat((1:size(TEr,1))',1,size(TEr,2)));
%%
SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
SD = -SD;
%%
for i=1:numel(SD)
    dir(i) = PredictionCor(i)*SD(i);
end
perfC24 = numel(find(dir>0))/numel(dir);
statsC24 = permtest_singletrial_accuracy(PredictionCor, SD, 10000);
%%
for i=1:numel(SDEr)
    dirEr(i) = PredictionEr(i)*SDEr(i);
end
perfErC24 = numel(find(dirEr>0))/numel(dirEr);
statsErC24 = permtest_singletrial_accuracy(PredictionEr, SDEr, 10000);
%%
load('path\to\AllP24.mat')
Params = setParams;
Params.animal = 2;
Params.session = 1;
Params.task = 2;
[~, ~, ~, ~, ~, MLP24C, ~] = MentalLine(Params,DifC, AnsC);
Params.task = 3;
[~, ~, ~, ~, ~, MLP24T, ~] = MentalLine(Params,DifT, AnsT);
[SDLineP24, stdLineP24, ~, sdxP24, sxdP24] = PredictLine(Params, MLP24T);
close all;
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, TEr] = InputOutput(Params,ErrorTrials,2);

PredEr = [];
PredictionEr = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredEr(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLP24T;
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
        PredCor(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLP24T;
    end
end
PredictionCor = mean(PredCor,2);
%%
SDEr = sum(TEr.*repmat((1:size(TEr,1))',1,size(TEr,2)));
%%
SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
SD = -SD;
%%
for i=1:numel(SD)
    dir(i) = PredictionCor(i)*SD(i);
end
perfP24 = numel(find(dir>0))/numel(dir);
statsP24 = permtest_singletrial_accuracy(PredictionCor, SD, 10000);
%%
for i=1:numel(SDEr)
    dirEr(i) = PredictionEr(i)*SDEr(i);
end
perfErP24 = numel(find(dirEr>0))/numel(dirEr);
statsErP24 = permtest_singletrial_accuracy(PredictionEr, SDEr, 10000);
%%
load('path\to\AllP21.mat')
Params = setParams;
Params.animal = 2;
Params.session = 2;
Params.task = 2;
[~, ~, ~, ~, ~, MLP21C, ~] = MentalLine(Params,DifC, AnsC);
Params.task = 3;
[~, ~, ~, ~, ~, MLP21T, ~] = MentalLine(Params,DifT, AnsT);
[SDLineP21, stdLineP21, ~, sdxP21, sxdP21] = PredictLine(Params, MLP21T);
close all;
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, TEr] = InputOutput(Params,ErrorTrials,2);

PredEr = [];
PredictionEr = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredEr(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLP21T;
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
        PredCor(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLP21T;
    end
end
PredictionCor = mean(PredCor,2);
%%
SDEr = sum(TEr.*repmat((1:size(TEr,1))',1,size(TEr,2)));
%%
SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
SD = -SD;
%%
for i=1:numel(SD)
    dir(i) = PredictionCor(i)*SD(i);
end
perfP21 = numel(find(dir>0))/numel(dir);
statsP21= permtest_singletrial_accuracy(PredictionCor, SD, 10000);
%%
for i=1:numel(SDEr)
    dirEr(i) = PredictionEr(i)*SDEr(i);
end
perfErP21 = numel(find(dirEr>0))/numel(dirEr);
statsErP21 = permtest_singletrial_accuracy(PredictionEr, SDEr, 10000);
%%
load('path\to\AllC21.mat')
Params = setParams;
Params.animal = 1;
Params.session = 2;
Params.task = 2;
[~, ~, ~, ~, ~, MLC21C, ~] = MentalLine(Params,DifC, AnsC);
Params.task = 3;
[~, ~, ~, ~, ~, MLC21T, ~] = MentalLine(Params,DifT, AnsT);
[SDLineC21, stdLineC21, ~, sdxC21, sxdC21] = PredictLine(Params, MLC21T);
close all;
%%
[Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params);
[P_tot, TEr] = InputOutput(Params,ErrorTrials,2);

PredEr = [];
PredictionEr = [];
TestedTimes = Params.TestedTimes;
for nt = 1:numel(ErrorTrials.condition)
    for i=1:numel(TestedTimes)
        PredEr(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLC21T;
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
        PredCor(nt,i) = [P_tot(:,nt,i)' ones(1,1)]*MLC21T;
    end
end
PredictionCor = mean(PredCor,2);
%%
SDEr = sum(TEr.*repmat((1:size(TEr,1))',1,size(TEr,2)));
%%
SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
SD = -SD;
%%
for i=1:numel(SD)
    dir(i) = PredictionCor(i)*SD(i);
end
perfC21 = numel(find(dir>0))/numel(dir);
statsC21 = permtest_singletrial_accuracy(PredictionCor, SD, 10000);
%%
for i=1:numel(SDEr)
    dirEr(i) = PredictionEr(i)*SDEr(i);
end
perfErC21 = numel(find(dirEr>0))/numel(dirEr);
statsErC21 = permtest_singletrial_accuracy(PredictionEr, SDEr, 10000);
%%
perf = mean([perfC21 perfC24 perfP21 perfP24]);
errPerf = std([perfC21 perfC24 perfP21 perfP24]);

perfEr = mean([perfErC21 perfErC24 perfErP21 perfErP24]);
errPerfEr = std([perfErC21 perfErC24 perfErP21 perfErP24]);
%%
plotfig = [perf,perfEr];
ploter = [errPerf,errPerfEr];
figure
errorbar(plotfig,ploter,'.')
ylim([0 1])
xlim([0.5 2.5])
%%
function stats = permtest_singletrial_accuracy(Prediction, SD, nPerm)
% PERMTEST_SINGLETRIAL_ACCURACY
% Trial-level permutation test for binary choice prediction vs chance.
%
% Inputs
% ------
% Prediction : [nTrials x 1] vector
%     Continuous prediction variable (e.g. GML projection).
%
% SD : [nTrials x 1] vector
%     Ground-truth signed decision variable (e.g. signed symbolic distance).
%
% nPerm : scalar (optional, default = 10000)
%     Number of permutations.
%
% Output
% ------
% stats : struct with fields
%     .acc_obs   observed accuracy
%     .acc_null  null distribution of accuracies
%     .pval      one-sided permutation p-value (above chance)

    if nargin < 3
        nPerm = 10000;
    end

    % ensure column vectors
    Prediction = Prediction(:);
    SD = SD(:);

    assert(numel(Prediction) == numel(SD), ...
        'Prediction and SD must have the same length');

    % observed accuracy
    acc_obs = mean((Prediction .* SD) > 0);

    % permutation test
    n = numel(SD);
    acc_null = zeros(nPerm,1);

    for p = 1:nPerm
        flip = sign(randn(n,1));              % random ±1
        pred_perm = Prediction .* flip;       % flip prediction sign
        acc_null(p) = mean((pred_perm .* SD) > 0);
    end

    % one-sided p-value
    pval = (sum(acc_null >= acc_obs) + 1) / (nPerm + 1);

    % output
    stats.acc_obs  = acc_obs;
    stats.acc_null = acc_null;
    stats.pval     = pval;
end


