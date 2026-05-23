% Figures for Model Fit
% This script plots the model fit results and reproduces Figure 1E,f, Figure 3F, Figure S1A,B,C,E.

% clear all;close all;clc
%%
load('path\to\esn_results_gb~0.01_responseTH~0.7.mat')
%%
cmap  = [   1,1,1
              0.95,1.0,0.6
              0.7,1.0,0.6 
              0.5,0.8,1.0
              0.4,0.5,0.8
              0.3,0.4,0.9
              0.7,0.3 ,0.7
              0.7,0.2 ,0.6
              0.65,0.0 ,0.3
              0.5, 0, 0.2];
          
          
% Define the discrete colors
discreteColors = cmap; 
numEntries = 256;
continuousColors = interp1(linspace(0, 1, size(discreteColors, 1)), discreteColors, linspace(0, 1, numEntries));

figure; imagesc(snis,dnis,squeeze(cos_sim_mat(4,:,:)))
colormap(continuousColors)
caxis([0 1])
colorbar
%%
figure; imagesc(snis,dnis,squeeze(cos_rt_mat(1,:,:)))
colormap(continuousColors)
caxis([0 1])
%%
cos_sim_mat(isnan(cos_sim_mat))=0;
v = [0.5 0.5];
figure; 
contour(snis,flip(dnis),squeeze(cos_sim_mat(1,:,:)),v,'r','ShowText','on')
hold on
contour(snis,flip(dnis),squeeze(cos_sim_mat(2,:,:)),v,'b','ShowText','on')
contour(snis,flip(dnis),squeeze(cos_sim_mat(3,:,:)),v,'g','ShowText','on')
contour(snis,flip(dnis),squeeze(cos_sim_mat(4,:,:)),v,'k','ShowText','on')
%%
cos_rt_mat(isnan(cos_rt_mat))=0;
v = [0.5 0.5];
figure; 
contour(snis,flip(dnis),squeeze(cos_rt_mat(1,:,:)),v,'r','ShowText','on')
hold on
contour(snis,flip(dnis),squeeze(cos_rt_mat(2,:,:)),v,'b','ShowText','on')
contour(snis,flip(dnis),squeeze(cos_rt_mat(3,:,:)),v,'g','ShowText','on')
contour(snis,flip(dnis),squeeze(cos_rt_mat(4,:,:)),v,'k','ShowText','on')
%%
v = [0.5 0.5];
figure; contour(snis,flip(dnis),squeeze(cos_sim_mat(1,:,:)),v,'r')
hold on
contour(snis,flip(dnis),squeeze(cos_sim_mat(2,:,:)),v,'b')
contour(snis,flip(dnis),squeeze(cos_sim_mat(3,:,:)),v,'g')
contour(snis,flip(dnis),squeeze(cos_sim_mat(4,:,:)),v,'k')
contour(snis,flip(dnis),squeeze(cos_rt_mat(1,:,:)),v,'r')
contour(snis,flip(dnis),squeeze(cos_rt_mat(2,:,:)),v,'b')
contour(snis,flip(dnis),squeeze(cos_rt_mat(3,:,:)),v,'g')
contour(snis,flip(dnis),squeeze(cos_rt_mat(4,:,:)),v,'k')

%%
Ans = readtable('path\to\PercAnswM-nInp_7-g_0.05-gin_0.005-gb_0.01-delay_0.01-NL_20-dni_0.3-sni_0.4-th_0.5-N_100.csv');
NRisp = size(find(Ans.Variables>0.7),1);
GoodNN = find(Ans.Variables>0.7);
%%

rT = readtable('path\to\ReactTimesSDs-nInp_7-g_0.05-gin_0.005-gb_0.01-delay_0.01-NL_20-dni_0.3-sni_0.4-th_0.5-N_100.csv');
T = readtable('path\to\AnchorsExp-nInp_7-g_0.05-gin_0.005-gb_0.01-delay_0.01-NL_20-dni_0.3-sni_0.4-th_0.5-N_100.csv');

figure
AllPairs = T.Variables;
for i=GoodNN
    hold on;
    plot(1:6,AllPairs(i,1:6),'k.-')
    plot(7:11, AllPairs(i,7:11),'k.-')
    plot(12:15, AllPairs(i,12:15),'k.-')
    plot(16:18, AllPairs(i,16:18),'k.-')
    plot(19:20, AllPairs(i,19:20),'k.-')
    plot(21, AllPairs(i,21),'k.-')
end
  
%%
FigSize = [10 5];
set(gcf,'PaperUnits','inch','PaperSize',FigSize,'PaperPosition',[0 0 FigSize]);
print('-painters','-dpdf','Behavior');
%%
Rts = rT.Variables;
figure
for i=1:numel(GoodNN)
    hold on
    % plot((Rts(GoodNN(i),:))*1.65,'k.-')
    plot((Rts(GoodNN(i),:))*0.69,'k.-')
end
xlim([0.5 6.5])
hold on
errorbar(1:6,SDErt,SDErtErr/2,'b.-', 'MarkerSize',10)
% errorbar(1:6,SDval,SDer,'b.-', 'MarkerSize',10)
%%
% FigSize = [7 5];
% set(gcf,'PaperUnits','inch','PaperSize',FigSize,'PaperPosition',[0 0 FigSize]);
% print('-painters','-dpdf','BehaviorRt');
%%
output = readtable('path\to\MaxOutSDs-nInp_7-g_0.05-gin_0.005-gb_0.01-delay_0.01-NL_20-dni_0.3-sni_0.4-th_0.5-N_100.csv');
out = mean(output.Variables);
figure
plot(out)
%%
c = flip(abs(SDLine(1:6)));
d = [c;SDLine(7:end)];
e = flip(stdSDLinePlot);
f = [e(1:6); stdSDLinePlot(7:end)];
g = mean(f)/sqrt(2);
h = mean(d);
a= output.Variables;
figure
for i=1:numel(GoodNN)
    plot(a(GoodNN(i),:)/a(GoodNN(i),1))
    hold on
end
hold on
errorbar(h/h(1),g/h(1),'k.-')
xlim([0.5 6.5])
%%
load('path\to\esn_results_gb~0.02_responseTH~0.7.mat')
figure; imagesc(snis,dnis,squeeze(n_nets_mat))
colormap(brewermap(100,'PuBuGn'))
caxis([0 100])
colorbar
%%
load('path\to\esn_results_gb~0.01_responseTH~0.7.mat')
figure; imagesc(snis,dnis,squeeze(n_nets_mat))
colormap(brewermap(100,'PuBuGn'))
caxis([0 100])
colorbar
%%
load('path\to\esn_results_gb~0_responseTH~0.7.mat')
figure; imagesc(snis,dnis,squeeze(n_nets_mat))
colormap(brewermap(100,'PuBuGn'))
caxis([0 100])
colorbar