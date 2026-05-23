%% SD Mot Figure
% This script plots the performance in time for the different SDs of the motor action.
% It reproduces Figure S2B (you can also plot it loading SDMot.mat).
clear all;close all; clc;
%% use with Params.SD=1
Params=setParams();
Params.SD =1;
Params.TestedTimes = 0:0.05:0.2;
Params.TestedT = -0.5:0.05:1.5;
SelCh = AllCh(Params);
Params.output = 2;
Params.AllConditions = 4001:4012;
Params.animal =1;
Params.session=1;
[p, ~, A1c24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf1c24, Baseline] = FromPairOnAUCMot(Params,SelCh,A1c24);
Params.animal =1;
Params.session=2;
[~, ~, A1c21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf1c21, Baseline] = FromPairOnAUCMot(Params,SelCh,A1c21);
Params.animal =2;
Params.session=2;
[~, ~, A1p21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf1p21, Baseline] = FromPairOnAUCMot(Params,SelCh,A1p21);
Params.animal =2;
Params.session=1;
[~, ~, A1p24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf1p24, Baseline] = FromPairOnAUCMot(Params,SelCh,A1p24);
%%
Perf1 = [];
Perf1(:,:,:,1) = Perf1c24;
Perf1(:,:,:,2) = Perf1c21;
Perf1(:,:,:,3) = Perf1p21;
Perf1(:,:,:,4) = Perf1p24;
% Perf1 = mean(Perf1,4);
%%
Params.AllConditions = 4013:4022;
Params.animal =1;
Params.session=1;
[~, ~, A2c24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf2c24, ~] = FromPairOnAUCMot(Params,SelCh,A2c24);
Params.animal =1;
Params.session=2;
[~, ~, A2c21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf2c21, ~] = FromPairOnAUCMot(Params,SelCh,A2c21);
Params.animal =2;
Params.session=2;
[~, ~, A2p21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf2p21, ~] = FromPairOnAUCMot(Params,SelCh,A2p21);
Params.animal =2;
Params.session=1;
[~, ~, A2p24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf2p24, ~] = FromPairOnAUCMot(Params,SelCh,A2p24);
%%
Perf2 = [];
Perf2(:,:,:,1) = Perf2c24;
Perf2(:,:,:,2) = Perf2c21;
Perf2(:,:,:,3) = Perf2p21;
Perf2(:,:,:,4) = Perf2p24;
% Perf2 = mean(Perf2,4);
%%
Params.AllConditions = 4023:4030;
Params.animal =1;
Params.session=1;
[~, ~, A3c24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf3c24, ~] = FromPairOnAUCMot(Params,SelCh,A3c24);
Params.animal =1;
Params.session=2;
[~, ~, A3c21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf3c21, ~] = FromPairOnAUCMot(Params,SelCh,A3c21);
Params.animal =2;
Params.session=2;
[~, ~, A3p21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf3p21, ~] = FromPairOnAUCMot(Params,SelCh,A3p21);
Params.animal =2;
Params.session=1;
[~, ~, A3p24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf3p24, Baseline] = FromPairOnAUCMot(Params,SelCh,A3p24);
%%
Perf3 = [];
Perf3(:,:,:,1) = Perf3c24;
Perf3(:,:,:,2) = Perf3c21;
Perf3(:,:,:,3) = Perf3p21;
Perf3(:,:,:,4) = Perf3p24;
% Perf3 = mean(Perf3,4);
%%
Params.AllConditions = 4031:4036;
Params.animal =1;
Params.session=1;
[~, ~, A4c24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf4c24, ~] = FromPairOnAUCMot(Params,SelCh,A4c24);
Params.animal =1;
Params.session=2;
[~, ~, A4c21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf4c21, ~] = FromPairOnAUCMot(Params,SelCh,A4c21);
Params.animal =2;
Params.session=2;
[~, ~, A4p21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf4p21, ~] = FromPairOnAUCMot(Params,SelCh,A4p21);
Params.animal =2;
Params.session=1;
[~, ~, A4p24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf4p24, ~] = FromPairOnAUCMot(Params,SelCh,A4p24);
%%
Perf4 = [];
Perf4(:,:,:,1) = Perf4c24;
Perf4(:,:,:,2) = Perf4c21;
Perf4(:,:,:,3) = Perf4p21;
Perf4(:,:,:,4) = Perf4p24;
% Perf4 = mean(Perf4,4);
%%
Params.AllConditions = 4037:4040;
Params.animal =1;
Params.session=1;
[~, ~, A5c24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf5c24, ~] = FromPairOnAUCMot(Params,SelCh,A5c24);
Params.animal =1;
Params.session=2;
[~, ~, A5c21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf5c21, ~] = FromPairOnAUCMot(Params,SelCh,A5c21);
Params.animal =2;
Params.session=2;
[~, ~, A5p21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf5p21, ~] = FromPairOnAUCMot(Params,SelCh,A5p21);
Params.animal =2;
Params.session=1;
[~, ~, A5p24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf5p24, ~] = FromPairOnAUCMot(Params,SelCh,A5p24);
%%
Perf5 = [];
Perf5(:,:,:,1) = Perf5c24;
Perf5(:,:,:,2) = Perf5c21;
Perf5(:,:,:,3) = Perf5p21;
Perf5(:,:,:,4) = Perf5p24;
% Perf5 = mean(Perf5,4);
%%
Params.AllConditions = 4041:4042;
Params.animal =1;
Params.session=1;
[~, ~, A6c24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf6c24, ~] = FromPairOnAUCMot(Params,SelCh,A6c24);
Params.animal =1;
Params.session=2;
[~, ~, A6c21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf6c21, ~] = FromPairOnAUCMot(Params,SelCh,A6c21);
Params.animal =2;
Params.session=2;
[~, ~, A6p21, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf6p21, ~] = FromPairOnAUCMot(Params,SelCh,A6p21);
Params.animal =2;
Params.session=1;
[~, ~, A6p24, ~,~] = BestPerfAndChMot(Params, SelCh);
[Perf6p24, ~] = FromPairOnAUCMot(Params,SelCh,A6p24);
%%
Perf6 = [];
Perf6(:,:,:,1) = Perf6c24;
Perf6(:,:,:,2) = Perf6c21;
Perf6(:,:,:,3) = Perf6p21;
Perf6(:,:,:,4) = Perf6p24;
% Perf6 = mean(Perf6,4);

%%
% figure
% plot(Params.TestedT,mean(Perf1,3)','.-')
% hold on
% plot(Params.TestedT,mean(Perf2,3)','.-')
% plot(Params.TestedT,mean(Perf3,3)','.-')
% plot(Params.TestedT,mean(Perf4,3)','.-')
% plot(Params.TestedT,mean(Perf5,3)','.-')
% plot(Params.TestedT,mean(Perf6,3)','.-')
% % plot(Params.TestedT,mean(mean(Baselinea,3),2),'k.-')
% ylim([0 1])
% legend({'SD=1','SD=2','SD=3','SD=4','SD=5','SD=6'})
% ylabel('AUC of best channels')
% xlabel('Time from PairOn')