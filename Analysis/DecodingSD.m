% This script decodes SD from MUA (independently on the sign)
% This reproduces Table S3.
clear all;clc;
%%
%set the parameter to choose the decoder
Params = setParams;
Params.animal=1;
Params.session=2;
%%
[Data, CorrectTrials, ErrorTrials, TotTrials] = computeMUAandEvents(Params);
%%
[P_tot, T] = InputOutput(Params, CorrectTrials, 0);
%%
SD = sum(T.*flip(repmat((1:size(T,1))',1,size(T,2))));

%%
function w_feat_mean = multiclass_decoder(X, y)
% Runs multiclass decoding 10 times with random stratified splits
% Prints average performance and returns average decoding weights

nRuns = 10;

classes = unique(y);
classes = sort(classes(:))';  % 1 x K
K = numel(classes);

% storage
accTrain_all = zeros(nRuns,1);
accTest_all  = zeros(nRuns,1);
maeTest_all  = zeros(nRuns,1);
accPm1_all   = zeros(nRuns,1);

w_feat_all = zeros(size(X,2), nRuns);

for r = 1:nRuns

    % --------- stratified split 70/30 ---------
    trainFrac = 0.7;
    idxTr = [];
    idxTe = [];

    for c = classes
        idx = find(y == c);
        idx = idx(randperm(numel(idx)));
        ntr = max(1, round(trainFrac * numel(idx)));
        idxTr = [idxTr; idx(1:ntr)];
        idxTe = [idxTe; idx(ntr+1:end)];
    end

    idxTr = idxTr(randperm(numel(idxTr)));
    idxTe = idxTe(randperm(numel(idxTe)));

    Xtr = X(idxTr,:);
    Xte = X(idxTe,:);
    ytr = y(idxTr);
    yte = y(idxTe);

    % --------- z-score using train stats ---------
    mu  = mean(Xtr, 1);
    sig = std(Xtr, [], 1) + 1e-8;

    Xtrz = (Xtr - mu) ./ sig;
    Xtez = (Xte - mu) ./ sig;

    % add bias
    Xtrb = [Xtrz, ones(size(Xtrz,1),1)];
    Xteb = [Xtez, ones(size(Xtez,1),1)];

    % --------- fit regression ---------
    useRidge = false;
    lambda = 10;

    if useRidge
        D = size(Xtrb,2);
        I = eye(D); I(end,end) = 0;
        w = (Xtrb'*Xtrb + lambda*I) \ (Xtrb' * ytr);
    else
        w = Xtrb \ ytr;
    end

    % --------- predictions ---------
    yhatTr = Xtrb * w;
    yhatTe = Xteb * w;

    predTr = nearestClass(yhatTr, classes);
    predTe = nearestClass(yhatTe, classes);

    % --------- metrics ---------
    accTrain_all(r) = mean(predTr == ytr);
    accTest_all(r)  = mean(predTe == yte);
    maeTest_all(r)  = mean(abs(predTe - yte));
    accPm1_all(r)   = mean(abs(predTe - yte) <= 1);

    % --------- weights in original feature units ---------
    w_feat_z = w(1:end-1);
    bias_z   = w(end);

    w_feat = w_feat_z ./ sig(:);
    bias   = bias_z - sum(mu(:) .* w_feat); %#ok<NASGU>

    w_feat_all(:,r) = w_feat;
end

% --------- averages ---------
w_feat_mean = mean(w_feat_all, 2);

fprintf('\n==== %d-run decoding summary ====\n', nRuns);
fprintf('K=%d\n', K);
fprintf('Train acc: %.3f ± %.3f\n', mean(accTrain_all), std(accTrain_all));
fprintf('Test  acc: %.3f ± %.3f\n', mean(accTest_all),  std(accTest_all));
fprintf('MAE test : %.3f ± %.3f\n', mean(maeTest_all),  std(maeTest_all));
fprintf('Test acc(±1): %.3f ± %.3f\n\n', mean(accPm1_all), std(accPm1_all));

end

% ---------- helper ----------
function pred = nearestClass(yhat, classes)
    % yhat: Nx1, classes: 1xK
    % returns Nx1 predicted labels
    yhat = yhat(:);
    [~, idx] = min(abs(yhat - classes), [], 2); % implicit expansion
    pred = classes(idx)';
end


X = P_tot';        % N x F
y = abs(SD(:));         % N x 1
disp('Abs SD:')
w_mod_SD = multiclass_decoder(X,y);
