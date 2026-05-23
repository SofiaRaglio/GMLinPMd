% Motor Decision and Action Trajectories Figure
% This script plots the 3D scatter plot of the MUA projected on the motor decision and action decoders for the example session of Monkey C.
% It reproduces Figure 2E.
clear all;
%%
%loading and example session of Monkey C.
Params = setParams();
Params.animal=1;
Params.session=1;
Params.TestedT = 0:0.005:1.5;
EC = setEncodes();
[Data] = computeMUAandEvents(Params);
cndTrials = selectTrialWithConditions(Data.Trials, Data.Events, Params.AllConditions); 
CorrectTrials = selectTrialWith2Events(cndTrials, Data.Events, EC.CORRECT_RESPONSE,EC.RT);
ErrorTrials = selectTrialWith2Events(cndTrials, Data.Events, EC.RESPONSE_WRONG,EC.RT);
[P_tot1, T, tEC] = InputOutput(Params,CorrectTrials,1);
%%
P_tot=[];
for i=1:85
    for j=1:317
        P_tot(i,j,:) = [squeeze(P_tot1(i,j,:))'];
    end
end
%%
% computing the MUA for the correct trials.
MUA =[];
for i=4001:4042
    ndx=find(CorrectTrials.condition==i);
    MUA(:,:,i-4000) = squeeze(mean(P_tot(:,ndx,:),2));
end
%%
% computing the MUA for the different SDs dividing right and left trials.
SD1d=[];
SD1s=[];
SD2d=[];
SD2s=[];
SD3d=[];
SD3s=[];
SD4d=[];
SD4s=[];
SD5d=[];
SD5s=[];
SD6d=[];
SD6s=[];

SD1d= mean(MUA(:,:,1:2:12),3);
SD1s= mean(MUA(:,:,2:2:12),3);
SD1d = [SD1d;ones(1,size(P_tot,3))];
SD1s = [SD1s;ones(1,size(P_tot,3))];

SD2d= mean(MUA(:,:,13:2:22),3);
SD2s= mean(MUA(:,:,14:2:22),3);
SD2d = [SD2d;ones(1,size(P_tot,3))];
SD2s = [SD2s;ones(1,size(P_tot,3))];

SD3d= mean(MUA(:,:,23:2:30),3);
SD3s= mean(MUA(:,:,24:2:30),3);
SD3d = [SD3d;ones(1,size(P_tot,3))];
SD3s = [SD3s;ones(1,size(P_tot,3))];

SD4d= mean(MUA(:,:,31:2:36),3);
SD4s= mean(MUA(:,:,32:2:36),3);
SD4d = [SD4d;ones(1,size(P_tot,3))];
SD4s = [SD4s;ones(1,size(P_tot,3))];

SD5d= mean(MUA(:,:,37:2:40),3);
SD5s= mean(MUA(:,:,38:2:40),3);
SD5d = [SD5d;ones(1,size(P_tot,3))];
SD5s = [SD5s;ones(1,size(P_tot,3))];

SD6d= mean(MUA(:,:,41),3);
SD6s= mean(MUA(:,:,42),3);
SD6d = [SD6d;ones(1,size(P_tot,3))];
SD6s = [SD6s;ones(1,size(P_tot,3))];
%%
%loading the motor decision decoder for the example session of Monkey C.
load('path\to\AllC24.mat')
AnsTC24 = AnsT{1};
%%
%loading the motor action decoder for the example session of Monkey C.
load('path\to\MotT.mat')
MotTC24 = Mot{1};
%%
%plotting the 3D scatter plot of the MUA projected on the motor decision and action decoders for the example session of Monkey C.
ms = 11;
mb = 20;
t=41:121;
figure
x=SD1d'*AnsTC24;
y=SD1d'*MotTC24;
z=ones(1,size(x,1));
c = linspace(1,10,length(x));
scatter3(x,y,z,7,c,'filled')
xlim([-1,1])
ylim([-1,1])
xline(0,'--')

yline(0,'--')
hold on
scatter3(mean(x(t)),mean(y(t)),mean(z(t)),'ro');

scatter3(SD1s'*AnsTC24,SD1s'*MotTC24,z,7,c,'filled')
x=SD1s'*AnsTC24;
y=SD1s'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t)),'ro')


scatter3(SD2s'*AnsTC24,SD2s'*MotTC24,z.*2,7,c,'filled')
x=SD2s'*AnsTC24;
y=SD2s'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*2,'ko')

scatter3(SD2d'*AnsTC24,SD2d'*MotTC24,z.*2,7,c,'filled')
x=SD2d'*AnsTC24;
y=SD2d'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*2,'ko')

scatter3(SD3s'*AnsTC24,SD3s'*MotTC24,z.*3,7,c,'filled')
x=SD3s'*AnsTC24;
y=SD3s'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*3,'bo')
scatter3(SD3d'*AnsTC24,SD3d'*MotTC24,z.*3,7,c,'filled')
x=SD3d'*AnsTC24;
y=SD3d'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*3,'bo')

scatter3(SD4s'*AnsTC24,SD4s'*MotTC24,z.*4,7,c,'filled')
x=SD4s'*AnsTC24;
y=SD4s'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*4,'go')
scatter3(SD4d'*AnsTC24,SD4d'*MotTC24,z.*4,7,c,'filled')
x=SD4d'*AnsTC24;
y=SD4d'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*4,'go')

scatter3(SD5s'*AnsTC24,SD5s'*MotTC24,z.*5,7,c,'filled')
x=SD5s'*AnsTC24;
y=SD5s'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*5,'mo')
scatter3(SD5d'*AnsTC24,SD5d'*MotTC24,z.*5,7,c,'filled')
x=SD5d'*AnsTC24;
y=SD5d'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*5,'mo')

scatter3(SD6s'*AnsTC24,SD6s'*MotTC24,z.*6,7,c,'filled')
x=SD6s'*AnsTC24;
y=SD6s'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*6,'co')
scatter3(SD6d'*AnsTC24,SD6d'*MotTC24,z.*6,7,c,'filled')
x=SD6d'*AnsTC24;
y=SD6d'*MotTC24;
scatter3(mean(x(t)),mean(y(t)),mean(z(t))*6,'co')
s.SizeData = 1000;

