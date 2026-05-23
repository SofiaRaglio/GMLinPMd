% SVD Dimensionality in Time
% This script reproduces Figure S2D (you can apply it to the X in 'path\to\SVD_model.mat' to obtain the Dimensionlity for the model).

clear all;
%%
Params = setParams();
Params.animal=1;
Params.session=1;
Params.task=3;
Params.SD = 2;
Params.TestedT = -0.5:0.005:2.5;
[Data, CorrectTrials, ErrorTrials, TotTrials]=computeMUAandEvents(Params);
% [P_tot, T, tEC] = InputOutput(Params,CorrectTrials,1);
[P_tot, T, tEC] = InputOutput(Params,TotTrials,1);
%%
MUA =[];
% for i=4001:4012
for    i=4001:4042
%     ndx=find(CorrectTrials.condition==i);
    ndx=find(TotTrials.condition==i);
    MUA = [MUA squeeze(mean(P_tot(:,ndx,:),2))];
end
%%
LogMUA.value=MUA;
LogMUA.time=1:size(MUA,2);

% LogMUA.value=Data.MUA(:,5000:40000);
% LogMUA.time=Data.MUATime(5000:40000);

% LogMUA.value=squeeze(P_tot(:,1,:));
% LogMUA.value= squeeze(mean(P_tot,2));
% LogMUA.time = Params.TestedT;
%%
X = LogMUA.value';
[U,S,V] = svd(X);
%%
sigs = diag(S);
beta = size(X,2)/size(X,1);

%% Plot the singular values:
%
ndx = 1:(size(S,1)+1):numel(S);
% SV = S(ndx);
SV = S(ndx).^2;
figure

subplot(1,2,1)
plot(SV,'kd-','MarkerFaceColor','w')
xlim([1 size(S,2)])
set(gca,'YScale','log','Layer','top','TickDir','out','Box','off');
grid('on')
xlabel('Singular value index, n');
% ylabel('Singular value, \sigma_n');
ylabel('Eigenmode energy, \sigma_n^2');

subplot(1,2,2)
cSV = cumsum(SV);
cSV = cSV/cSV(end)*100.;
plot(cSV,'kd-','MarkerFaceColor','w')
xlim([1 size(S,2)])
ylim([0 100])
set(gca,'Layer','top','TickDir','out','Box','off');
grid('on')
xlabel('Singular value index, n');
% ylabel('Explained variance, \Sigma_{k=1}^n \sigma_k (%)');
ylabel('Explained variance, \Sigma_{k=1}^n \sigma_k^2 (%)');
%% Computes the instantaneous effective dimension (Schiff et al., Phys Rev Lett 2007).
%
ThresholdEnergy = 0.9;
PlotBorder = 1.5;

ndx = 1:1:size(V,1);
mSV = S(ndx,ndx);
mE = (mSV*U(:,ndx)').^2;
mE = cumsum(mE);
mE = mE./repmat(mE(end,:),numel(ndx),1);

IEDim = zeros(1,size(mE,2));
for k = 1:numel(IEDim)
   IEDim(k) = find(mE(:,k)>ThresholdEnergy,1,'first');
end

figure

subplot(2,1,1)
imagesc(LogMUA.time,1:size(V,1),mE*100)
xlabel('Time, t (s)')
ylabel('Eigenmode n')
title('Instantaneous energy E(t)_n up to mode n')
hcb = colorbar();
set(gca,'YDir','norm','Layer','top','TickDir','out');

subplot(2,1,2)
plot(LogMUA.time,IEDim,'k.-')
hcb = colorbar();
set(hcb,'Visible','off');
ylim([1/PlotBorder max(IEDim)*PlotBorder])
% set(gca,'YScale','log','Layer','top','TickDir','out','Box','off');
grid('on')
xlabel('Time, t (s)');
ylabel('Effective dimension, d(t) (mm)');
title(['Energy threshold = ' num2str(ThresholdEnergy*100.) '%'])
%%
Dim=reshape(IEDim,[1,601,42]);
% Dim=reshape(IEDim,[1,601,12]);
figure
plot(Params.TestedT,mean(Dim,3),'k.-')
hcb = colorbar();
set(hcb,'Visible','off');
% ylim([1/PlotBorder max(IEDim)*PlotBorder])
% set(gca,'YScale','log','Layer','top','TickDir','out','Box','off');
% grid('on')
box('off')
xlabel('Time, t (s)');
ylabel('Effective dimension, d(t) (mm)');
% title(['Energy threshold = ' num2str(ThresholdEnergy*100.) '%'])
%%
figure
cSV = cumsum(SV);
cSV = cSV/cSV(end)*100.;
% plot(cSV,'kd-','MarkerFaceColor','w')
semilogx([1:size(S,2)],cSV,'kd-','MarkerFaceColor','w')
%xlim([1 size(S,2)])
% ylim([0 100])
set(gca,'Layer','top','TickDir','out','Box','off');
% grid('on')
xlabel('Singular value index, n');
% ylabel('Explained variance, \Sigma_{k=1}^n \sigma_k (%)');
ylabel('Explained variance, \Sigma_{k=1}^n \sigma_k^2 (%)');