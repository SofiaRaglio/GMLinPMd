%% Plot Channels Activity LR
% This script plots the activity of two example channels in the left and right decision conditions.
% It reproduces Figure 2A 

Params = setParams;
Params.output=2;
Params.TestedT = -0.2:0.005:0.6;
[Data, CorrectTrials, ErrorTrials, TotTrials]=computeMUAandEvents(Params);
%%
[P_tot, T, tEC] = InputOutput(Params,CorrectTrials,1);
[val,ndx] = sort(T);
change = find(val==1,1);
%%
figure
plot(Params.TestedT,squeeze(mean(P_tot(20,ndx(1:190),:),2)))
hold on
plot(Params.TestedT,squeeze(mean(P_tot(20,ndx(191:end),:),2)))
ylim([0.05 0.25])
%%
figure
plot(Params.TestedT,squeeze(mean(P_tot(2,ndx(1:190),:),2)))
hold on
plot(Params.TestedT,squeeze(mean(P_tot(2,ndx(191:end),:),2)))
ylim([0.05 0.25])