% Ans Line Plot
% This script reproduces gray line in Figure 3D, shadowed plot in Figure S4E.
load('path\to\AllC24.mat')
Params = setParams;
Params.animal = 1;
Params.session = 1;
Params.task = 3;
[SDLineC24, stdLineC24, ~, sdxc24, sxdc24] = PredictLine(Params, AnsT{1});
%%
load('path\to\AllC21.mat')
Params = setParams;
Params.animal = 1;
Params.session = 2;
Params.task = 3;
[SDLineC21, stdLineC21, ~, sdxc21, sxdc21] = PredictLine(Params, AnsT{1});
%%
load('path\to\AllP24.mat')
Params = setParams;
Params.animal = 2;
Params.session = 1;
Params.task = 3;
[SDLineP24, stdLineP24, ~, sdxp24, sxdp24] = PredictLine(Params, AnsT{1});
%%
load('path\to\AllP21.mat')
Params = setParams;
Params.animal = 2;
Params.session = 2;
Params.task = 3;
[SDLineP21, stdLineP21, ~, sdxp21, sxdp21] = PredictLine(Params, AnsT{1});
%%
% SDLine = [];
% SDLine(:,:,1) = SDLineC24;
% SDLine(:,:,2) = SDLineC21;
% SDLine(:,:,3) = SDLineP21;
% SDLine(:,:,4) = SDLineP24;
% SDLine = mean(SDLine,3);