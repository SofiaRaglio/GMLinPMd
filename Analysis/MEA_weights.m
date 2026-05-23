%% Spatial distribution of decoding weights on the MEA.
% This script reproduces Figure S2C.

clear all;
%%
load('path\to\AllC24.mat')
AnsTC24 = AnsT{1};
%%
load('path\to\AllC21.mat')
AnsTC21 = AnsT{1};
%%
load('path\to\AllP24.mat')
AnsTP24 = AnsT{1};
%%
load('path\to\AllP21.mat')
AnsTP21 = AnsT{1};
%%
zC24 = zscore(AnsTC24);

figure
plot(zC24,'d--')

chC24 = find(zC24>2);
chC24 = [chC24' find(zC24<-2)'];
%%
zC21 = zscore(AnsTC21);

figure
plot(zC21,'d--')

chC21 = find(zC21>2);
chC21 = [chC21' find(zC21<-2)'];
%%
zP24 = zscore(AnsTP24);

figure
plot(zP24,'d--')

chP24 = find(zP24>2);
chP24 = [chP24' find(zP24<-2)'];
%%
zP21 = zscore(AnsTP21);

figure
plot(zP21,'d--')

chP21 = find(zP21>2);
chP21 = [chP21' find(zP21<-2)'];
%%
Params = setParams();
Params.animal =1;
Params.session=1;
Params.task=3;
Params.output=2;
Params.TestedT=-0.6:0.005:2.5
[Data, CorrectTrials, ErrorTrials, TotTrials]=computeMUAandEvents(Params);
[P_tot, T, tEC] = InputOutput(Params,CorrectTrials,1);
%%
n=0;
m=0;
PDx=[];
PSx=[];
for i=1:numel(CorrectTrials.condition)
    if T(i)==1
        n=n+1;
        PDx(:,:,n)=squeeze(P_tot(:,i,:));
    else
        m=m+1;
        PSx (:,:,m)=squeeze(P_tot(:,i,:));
    end
end

PDx = mean(PDx,3);
PSx = mean(PSx,3);

%%
Ch=2;
%P = squeeze(mean(P_tot,2));
figure
plot(Params.TestedT,PDx(Ch,:))
hold on
plot(Params.TestedT,PSx(Ch,:))
box off
xlim([-0.2 0.6])
%%
Ch = setdiff(1:96, [26 37 39 40 58 89 91 93 66 76 11]);
AllCh=1:96;
MEAMap1 = [ 0 41 39 37 43 45 47  1  5  0;
96 73 95 25 33 24 22  3  7  9;
94 75 93 27 35 16 20 10 11 13;
92 77 91 29 55 18 14  8  6 15;
90 79 89 31 49 57 61 12  4 17;
88 81 48 46 51 53 59 71  2 19;
86 83 44 42 38 63 65 67 69 21;
84 85 50 40 36 34 32 30 28 23;
82 87 52 54 74 72 70 62 26 66;
0 80 78 76 56 58 60 68 64  0];
PerformanceTest=AnsTC24;
%%
figure
[~,ndxCh2Map] = sort(MEAMap1(:));
ndxCh2Map = ndxCh2Map(5:end);
%         ndxCh2Map = ndxCh2Map(8:end);
%         [~,ndxM] = max(abs(LC.kernel));%mi dà quale degli istanti di tempo è il più importante per ogni canale
MeasureMap = zeros(size(MEAMap1));
%         MeasureMap(ndxCh2Map(LC.channels-96)) = PerformanceTest;
MeasureMap(ndxCh2Map(Ch)) = PerformanceTest(1:end-1);
imagesc(MeasureMap);
colorbar();
%         caxis([0.5 0.85])
%caxis([0 0.8])
%         colormap(BlueRedCM);
hold on
%         Z = mean(LC.kernel(1:3,:));
%         for k = find(Z > std(LC.kernel(:)))
%             [r,c] = find(MEAMap==LC.channels(k));
%             plot(c,r,'ko','MarkerFaceColor','w','MarkerSize',12*Z(k)/max(Z));
%         end
for channel=Ch
[r,c] = find(MEAMap1==channel);
text(c,r,num2str(channel),'HorizontalAlignment','center','VerticalAlignment','middle')
end
set(gca,'TickDir','out','Box','on','Layer','top')
xlabel('X MEA')
ylabel('Y MEA')
colormap(brewermap(20,'PiYg'))
caxis([-0.8 0.8])
%%
vec = [AnsTC24(1:end-1) AnsTC21(1:end-1) AnsTP24(1:end-1) AnsTP21(1:end-1)]; 
figure;
imagesc(vec)
colormap(brewermap(20,'PiYg'))
caxis([-0.8 0.8])
hold on
xline(2.5,'--')
colorbar()