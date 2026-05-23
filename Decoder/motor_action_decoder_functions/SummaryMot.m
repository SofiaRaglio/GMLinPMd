%% Main file to compute the motor action decoder.
clear all;clc;
%%
%set the parameter to choose the decoder
Params = setParams;
Params.animal = 1;
Params.session=1;
Params.TestedTimes = 0:0.05:0.2%-0.2:0.05:0;  
%%
SelCh = AllCh(Params);
%%
%compute the Answer vector (Motor choice)
Params.output = 2;
[pa, ~, M, ~,tC24] = BestPerfAndChMot(Params, SelCh);
MotC24 = createVector(Params,SelCh, M);
%%
Params.animal=1;
Params.session=2;
[pa, ~, M, ~,tC21] = BestPerfAndChMot(Params, SelCh);
MotC21 = createVector(Params,SelCh, M);
%%
Params.animal=2;
Params.session=2;
[pa, ~, M, ~,tP21] = BestPerfAndChMot(Params, SelCh);
MotP21 = createVector(Params,SelCh, M);
%%
Params.animal=2;
Params.session=1;
[pa, ~, M, ~,tP24] = BestPerfAndChMot(Params, SelCh);
MotP24 = createVector(Params,SelCh, M);
%%
% save('MotVec.mat','MotC24','MotC21','MotP21','MotP24');

