% SVD dimensionality in time analysis for each SD.
% This script reproduces Figure S2E.
clear all;
%%
SD_conditions = containers.Map( ...
    {1, 2, 3, 4, 5, 6}, ...
    {4001:4012, ...   % SD1
     4013:4022, ...   % SD2
     4023:4030, ...   % SD3
     4031:4036, ...   % SD4
     4037:4040, ...   % SD5
     4041:4042});     % SD6
%%
Params = setParams();
Params.animal  = 2;
Params.session = 1;
Params.task    = 3;
Params.TestedT = -0.5:0.005:2.5;

ThresholdEnergy = 0.9;

Dim_per_SD = struct();

for SD = 1:6
    
    Params.SD = SD;
    
    [Data, CorrectTrials, ErrorTrials, TotTrials] = computeMUAandEvents(Params);
    [P_tot, T, tEC] = InputOutput(Params, CorrectTrials, 1);
    
    %---- Build MUA matrix for this SD
    MUA = [];
    conds = SD_conditions(SD);

    for i = conds
        ndx = find(CorrectTrials.condition == i);
        MUA = [MUA squeeze(mean(P_tot(:, ndx, :), 2))];
    end



    %% ---- SVD
    X = MUA';
    [U, S, V] = svd(X, 'econ');
    
    %% ---- Instantaneous Effective Dimension
    nComp = size(S,1);
    mSV = S(1:nComp,1:nComp);
    mE  = (mSV * U(:,1:nComp)').^2;
    mE  = cumsum(mE);
    mE  = mE ./ repmat(mE(end,:), nComp, 1);
    
    IEDim = zeros(1, size(mE,2));
    for k = 1:numel(IEDim)
        IEDim(k) = find(mE(:,k) > ThresholdEnergy, 1, 'first');
    end
    
    %% ---- Average across conditions (as you were doing)
    nCond = numel(conds);
    Dim_per_SD(SD).IEDim = IEDim;
    Dim_per_SD(SD).Dim   = mean(reshape(IEDim, [1, 601, nCond]), 3);
end
%%
figure; hold on
for SD = 1:6
    plot(Params.TestedT,Dim_per_SD(SD).Dim, 'DisplayName', ['SD ' num2str(SD)])
end
xlabel('Time')
ylabel('Effective dimension')
legend
