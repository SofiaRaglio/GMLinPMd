% Plot Integrator on GML
% This script computes the RTs for correct and incorrect responses on the GML.
% It reproduces Figure 4D. You can alternatively load the RTs from the file 'path\to\RTs1-2RS90Th0-8.mat'.
%% Params and colors.
% NoiseSize = 0.075*sqrt(2);
% NoiseSize = 0.5*sqrt(2);
NoiseSize = 1.4;
RandomSamples = 50;

Example = 1;
switch Example
   case 1
      % SymbolRank = [4 3 1]; % A B D
       SymbolRank = [7 6 5 4 3 2 1]; 
      SDCM = SymbDistCM(max(SymbolRank));
end

%% PDF of OU process
RelPeakSize = 0.15;
NormPDF = @(x,m,s) RelPeakSize*exp(-(x-m).^2/(2*s^2))/(s*sqrt(2*pi));

Tau = 0.1;
Life = 0.35;

Mu = @(t,m,tau) m*(1-exp(-t/tau));
Sigma = @(t,s,tau) sqrt(s^2*(1-exp(-(2*t)/tau)));

NormPrctl = norminv([0.075 0.2:0.1:0.8 0.925])';
NoP = numel(NormPrctl);

figure
hold on

for SD = [-6 -5 -4 -3 -2 -1 1 2 3 4 5 6]
   MInf = SD;
   SInf = NoiseSize;
   t = linspace(0,Life,100);
   y = zeros(numel(NormPrctl),numel(t));
   for k = 1:numel(t)
      y(:,k) = NormPrctl * Sigma(t(k),SInf,Tau) + Mu(t(k),MInf,Tau);
   end

   MaxK = floor(NoP/2);
   for k = 1:MaxK
      Color = SDCM(SD + max(SymbolRank) + 1,:);
      Color = [1 1 1]*(MaxK-k+3)/(MaxK+3) + Color*k/(MaxK+3);
      patch([t fliplr(t)],[y(k,:) fliplr(y(NoP-k+1,:))],Color,'EdgeColor','none')
   end
   plot(t,y(5,:),'-','LineWidth',0.75,'Color',SDCM(SD + max(SymbolRank) + 1,:))

   CurvAbsc = linspace(MInf-3.5*SInf,MInf+3.5*SInf,100);
   plot(Life - NormPDF(CurvAbsc,MInf,SInf),CurvAbsc,'-','LineWidth',0.75,'Color',SDCM(SD + max(SymbolRank) + 1,:))
end
set(gca,'TickDir','out')
xlabel('Time, t [s]')
ylabel('GML integrator, y(t)')
grid on 
xlim([0 Life])
ylim([-6 4])

FigSize = [4 6];
set(gcf,'PaperUnit','inch','PaperPosition',[0 0 FigSize],'PaperSize',FigSize);
print('-dpdf', '-painters', 'IntegratorOUVsTime');

%% OU Integrator sample realizations.
Life = 0.75;
dt = 1/1000;
Threshold =1;%0.8;

t = 0:dt:Life;

Trj = [];
Trj_tot = [];

figure
hold on
for SD = [-6 -5 -4 -3 -2 -1 1 2 3 4 5 6] % [-3 1]
   MInf = SD;
   SInf = NoiseSize;
   for n = 1:RandomSamples
      x = 0*t;
      GWN = randn(size(t))*sqrt(2*dt/Tau);
      for k = 1:numel(t)-1
         x(k+1) = ((-x(k) + MInf)*dt/Tau + SInf*GWN(k)) + x(k);
      end
      % plot(t,x,'-')
      Trj(n,:) = x;
   end
   Trj_tot = [Trj_tot; Trj];
end
plot([0 Life],[1 1]*Threshold,'k--')
plot([0 Life],-[1 1]*Threshold,'k--')
set(gca,'TickDir','out')
xlabel('Time, t [s]')
ylabel('GML integrator, y(t)')
grid on 
xlim([0 Life])
ylim([-6 4])

FigSize = [4 6];
set(gcf,'PaperUnit','inch','PaperPosition',[0 0 FigSize],'PaperSize',FigSize);
print('-dpdf', '-painters', sprintf('IntegratorOUVsTime_SD=%d',SD));
%%
RT = zeros(size(Trj_tot,1),numel(t));
for k=1:numel(t)
    for j=1:size(Trj_tot,1)
        if Trj_tot(j,k)>=Threshold
            RT(j,k) = 1;
        elseif Trj_tot(j,k)<=-Threshold
            RT(j,k) = -1;
        end
    end
end
figure
imagesc(RT)
%%
RT_corr=[];
RT_err=[];
RTs = [];

for i=1:(size(RT,1))
    RTs(i) = find(RT(i,:)~=0,1);
    if RT(i,RTs(i))==-1
        if i<=(size(RT,1)/2)
            RT_corr = [RT_corr RTs(i)];
        elseif i>(size(RT,1)/2)
            RT_err = [RT_err RTs(i)];
        end
    elseif RT(i,RTs(i))==1
        if i<=(size(RT,1)/2)
            RT_err = [RT_err RTs(i)];
        elseif i>(size(RT,1)/2)
            RT_corr = [RT_corr RTs(i)];
        end
    end
end
%%
Accuracy = numel(RT_corr)/numel(RTs);
%%
sym1 = t(RT_corr);
sym2 = t(RT_err);
ValRange1 = [max(sym1) min(sym1)];
ValRange2 = [max(sym2) min(sym2)];
BIN_NUM = 50;
X1 = linspace(ValRange1(1), ValRange1(2), BIN_NUM);
X2 = linspace(ValRange2(1), ValRange2(2), BIN_NUM);
Y1 = ksdensity(sym1,X1);
Y2 = ksdensity(sym2,X2);
figure
plot(X1,Y1, 'Linewidth', 2)
hold on
plot(X2,Y2, 'Linewidth', 2)