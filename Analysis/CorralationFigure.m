% Correlation Figure
% This script computes the correlations between position-dependent, position-invariant and Test SD=1 items representations.
% It reproduces Figure 6A,B,C,D, Figure S4D.
clear all;
%%
load('path\to\AllC24.mat')
pureC = [];
pureT = [];
difC = [];
difT = [];
ansT = [];
ansC=[];

for i=1:7
    pureC(i,:,1) = PureC{i};
    pureT(i,:,1) = PureT{i};
    difC(i,:,1) = DifC{i};
    difT(i,:,1) = DifT{i};
    dxC(i,:,1) = DxC{i};
    dxT(i,:,1) = DxT{i};
    sxC(i,:,1) = SxC{i};
    sxT(i,:,1) = SxT{i};
end
ansT(:,1) = AnsT{1};
ansC(:,1) = AnsC{1};
%%
load('path\to\AllP24.mat')
for i=1:7
    pureC(i,:,2) = PureC{i};
    pureT(i,:,2) = PureT{i};
    difC(i,:,2) = DifC{i};
    difT(i,:,2) = DifT{i};
    dxC(i,:,2) = DxC{i};
    dxT(i,:,2) = DxT{i};
    sxC(i,:,2) = SxC{i};
    sxT(i,:,2) = SxT{i};
end
ansT(:,2) = AnsT{1};
ansC(:,2) = AnsC{1};
%%
load('path\to\AllP21.mat')
for i=1:7
    pureC(i,:,3) = PureC{i};
    pureT(i,:,3) = PureT{i};
    difC(i,:,3) = DifC{i};
    difT(i,:,3) = DifT{i};
    dxC(i,:,3) = DxC{i};
    dxT(i,:,3) = DxT{i};
    sxC(i,:,3) = SxC{i};
    sxT(i,:,3) = SxT{i};
end
ansT(:,3) = AnsT{1};
ansC(:,3) = AnsC{1};
%%
load('path\to\AllC21.mat')
for i=1:7
    pureC(i,:,4) = PureC{i};
    pureT(i,:,4) = PureT{i};
    difC(i,:,4) = DifC{i};
    difT(i,:,4) = DifT{i};
    dxC(i,:,4) = DxC{i};
    dxT(i,:,4) = DxT{i};
    sxC(i,:,4) = SxC{i};
    sxT(i,:,4) = SxT{i};
end
ansT(:,4) = AnsT{1};
ansC(:,4) = AnsC{1};

%%
pure(:,:,1) = corrcoef([pureC(:,1:end-1,1)' pureT(:,1:end-1,1)']);
pure(:,:,2) = corrcoef([pureC(:,1:end-1,2)' pureT(:,1:end-1,2)']);
pure(:,:,3) = corrcoef([pureC(:,1:end-1,3)' pureT(:,1:end-1,3)']);
pure(:,:,4) = corrcoef([pureC(:,1:end-1,4)' pureT(:,1:end-1,4)']);
%%
pure_avg = mean(pure,3);
%%
figure, imagesc(pure_avg,[-1 1])
% title('\xi_C-\xi_T correlation Pure')
BlueRedCM = gradedColormap([0 0 1],[1 0 0]);
colormap(BlueRedCM)
colorbar
xticks([1:14])
xticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
yticks([1:14])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
%%
a=pure_avg(1:7,8:end);
sim = (a+a')/2;
massimo=[];
for i=1:7
    massimo(i)=find(sim(i,:)==max(sim(i,:)));
end
%%
dif(:,:,1) = corrcoef([difC(:,1:end-1,1)' difT(:,1:end-1,1)']);
dif(:,:,2) = corrcoef([difC(:,1:end-1,2)' difT(:,1:end-1,2)']);
dif(:,:,3) = corrcoef([difC(:,1:end-1,3)' difT(:,1:end-1,3)']);
dif(:,:,4) = corrcoef([difC(:,1:end-1,4)' difT(:,1:end-1,4)']);
%%
dif_avg = mean(dif,3);
for i=1:14
    for j=1:14
        dif_err(i,j) = std(dif(i,j,:))/2;
    end
end
%%
figure, imagesc(dif_avg,[-1 1])
% title('\xi_C-\xi_T correlation Pure')
BlueRedCM = gradedColormap([0 0 1],[1 0 0]);
colormap(BlueRedCM)
colorbar
xticks([1:14])
xticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
yticks([1:14])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
%%
figure
plot(diag(1-dif_avg(8:14,8:14),-1))
%distance in the items space
xticks([1:6])
xticklabels({'AB','BC','CD', 'DE', 'EF', 'FG'})
%%
figure
imagesc(dif_avg(1:7,8:14))
%distance in the items space
colormap(brewermap([],'PiYG'))
colorbar
caxis([-1 1])
xticks([1:7])
xticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
yticks([1:7])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
%%
a=dif_avg(1:7,8:end);
sim_dif = (a+a')/2;
massimo_dif=[];
for i=1:7
    massimo_dif(i)=find(sim_dif(i,:)==max(sim_dif(i,:)));
end
%%
lineT = [];
lineC = [];
for j=1:4
    for i=1:7
        lineT(i,j) = corr(sxT(i,1:end-1,j)', ansT(1:end-1,j));
        lineC(i,j) = corr(difC(i,1:end-1,j)', ansC(1:end-1,j));
    end
end
%%
figure, imagesc(pure_avg(1:7,8:end))
caxis([-0.3 0.300001])
% title('\xi_C-\xi_T correlation Pure')
BlueRedCM = gradedColormap([0 0 1],[1 0 0]);
colormap(brewermap([],'PiYG'))
colorbar
xticks([1:7])
xticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
yticks([1:7])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
%%
xint = 1:0.1:7;
f1 = griddedInterpolant(1:7,dif_avg(8,8:end)','pchip');
f2 = griddedInterpolant(0:7,[dif_avg(9,end)';dif_avg(9,8:end)'],'pchip');
f3 = griddedInterpolant(1:7,dif_avg(10,8:end)','pchip');
f4 = griddedInterpolant(1:7,dif_avg(11,8:end)','pchip');
f5 = griddedInterpolant(1:7,dif_avg(12,8:end)','pchip');
f6 = griddedInterpolant(1:8,[dif_avg(13,8:end)'; dif_avg(13,end)'],'pchip');
f7 = griddedInterpolant(1:7,dif_avg(14,8:end)','pchip');
figure;
plot(xint,f1(xint))
hold on
plot(xint,f2(xint))
plot(xint,f3(xint))
plot(xint,f4(xint))
plot(xint,f5(xint))
plot(xint,f6(xint))
plot(xint,f7(xint))
xlim([0.5 7.5])
ylim([-1 1.5])
%%
xint = 1:0.1:7;
f1 = griddedInterpolant(1:7,dif_avg(8,8:end)','pchip');
f1_err = griddedInterpolant(1:7,dif_err(8,8:end)','pchip');
f2 = griddedInterpolant(0:7,[dif_avg(9,end)';dif_avg(9,8:end)'],'pchip');
f2_err = griddedInterpolant(0:7,[dif_err(9,end)';dif_err(9,8:end)'],'pchip');
f3 = griddedInterpolant(1:7,dif_avg(10,8:end)','pchip');
f3_err = griddedInterpolant(1:7,dif_err(10,8:end)','pchip');
f4 = griddedInterpolant(1:7,dif_avg(11,8:end)','pchip');
f4_err = griddedInterpolant(1:7,dif_err(11,8:end)','pchip');
f5 = griddedInterpolant(1:7,dif_avg(12,8:end)','pchip');
f5_err = griddedInterpolant(1:7,dif_err(12,8:end)','pchip');
f6 = griddedInterpolant(1:8,[dif_avg(13,8:end)'; dif_avg(13,end)'],'pchip');
f6_err = griddedInterpolant(1:8,[dif_err(13,8:end)'; dif_err(13,end)'],'pchip');
f7 = griddedInterpolant(1:7,dif_avg(14,8:end)','pchip');
f7_err = griddedInterpolant(1:7,dif_err(14,8:end)','pchip');
figure;
plot(xint,f1(xint),'r')
hold on
plot(xint,f2(xint),'b')
plot(xint,f3(xint),'g')
plot(xint,f4(xint),'m')
plot(xint,f5(xint),'c')
plot(xint,f6(xint),'k')
plot(xint,f7(xint),'r')
plot(xint,f1(xint)+f1_err(xint),'r')
plot(xint,f1(xint)-f1_err(xint),'r')
plot(xint,f2(xint)+f2_err(xint),'b')
plot(xint,f2(xint)-f2_err(xint),'b')
plot(xint,f3(xint)+f3_err(xint),'g')
plot(xint,f3(xint)-f3_err(xint),'g')
plot(xint,f4(xint)+f4_err(xint),'m')
plot(xint,f4(xint)-f4_err(xint),'m')
plot(xint,f5(xint)+f5_err(xint),'c')
plot(xint,f5(xint)-f5_err(xint),'c')
plot(xint,f6(xint)+f6_err(xint),'k')
plot(xint,f6(xint)-f6_err(xint),'k')
plot(xint,f7(xint)+f7_err(xint),'r')
plot(xint,f7(xint)-f7_err(xint),'r')
xlim([0.5 7.5])
ylim([-1 1.5])
%%
c_ans=[];
for i=1:7
    temp=corrcoef(difT(i,1:end-1,1),ansT(1:end-1,1));
    c_ans(i,1) = temp(1,2);
    temp = corrcoef(difT(i,1:end-1,2),ansT(1:end-1,2));
    c_ans(i,2) = temp(1,2);
    temp = corrcoef(difT(i,1:end-1,3),ansT(1:end-1,3));
    c_ans(i,3) = temp(1,2);
    temp = corrcoef(difT(i,1:end-1,4),ansT(1:end-1,4));
    c_ans(i,4) = temp(1,2);
end
%%
figure;
errorbar(mean(c_ans,2),std(c_ans'),'ko--', "LineWidth",2)
hold on
plot(mean(c_ans,2), "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 7.5])
ylim([-1 1])
%%
delta = diff(c_ans, 1, 1);
delta_mean = mean(delta, 2);
delta_sem  = std(delta, 0, 2) / sqrt(size(c_ans, 2));
figure;
errorbar(delta_mean,delta_sem,'ko--', "LineWidth",2)
hold on
plot(delta_mean, "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 7.5])
ylim([-1 1])
%%
load('path\to\NN_C24.mat')
difNN = [];
pureNN = [];

for i=1:7
    difNN(i,:,1) = vecDif{i};
    pureNN(i,:,1) = vecSum{i};
end
%%
load('path\to\NN_C21.mat')


for i=1:7
    difNN(i,:,2) = vecDif{i};
    pureNN(i,:,2) = vecSum{i};
end
%%
load('path\to\NN_P21.mat')

for i=1:7
    difNN(i,:,3) = vecDif{i};
    pureNN(i,:,3) = vecSum{i};
end
%%
load('path\to\NN_P24.mat')

for i=1:7
    difNN(i,:,4) = vecDif{i};
    pureNN(i,:,4) = vecSum{i};
end
%%
NNdif(:,:,1) = corr([difNN(:,1:end-1,1)']);
NNdif(:,:,2) = corr([difNN(:,1:end-1,2)']);
NNdif(:,:,3) = corr([difNN(:,1:end-1,3)']);
NNdif(:,:,4) = corr([difNN(:,1:end-1,4)']);
%%
NNdif_avg = mean(NNdif,3);
%%
figure, imagesc(NNdif_avg,[-1 1])
% title('\xi_C-\xi_T correlation Pure')
BlueRedCM = gradedColormap([0 0 1],[1 0 0]);
colormap(BlueRedCM)
colorbar
xticks([1:14])
xticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
yticks([1:14])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
%%
NNpure(:,:,1) = corr([pureNN(:,1:end-1,1)']);
NNpure(:,:,2) = corr([pureNN(:,1:end-1,2)']);
NNpure(:,:,3) = corr([pureNN(:,1:end-1,3)']);
NNpure(:,:,4) = corr([pureNN(:,1:end-1,4)']);
%%
NNpure_avg = mean(NNpure,3);
%%
figure, imagesc(NNpure_avg,[-1 1])
% title('\xi_C-\xi_T correlation Pure')
BlueRedCM = gradedColormap([0 0 1],[1 0 0]);
colormap(BlueRedCM)
colorbar
xticks([1:14])
xticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
yticks([1:14])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
%%
difNNC(:,:,1) = corrcoef([difC(:,1:end-1,1)' difNN(:,1:end-1,1)']);
difNNC(:,:,2) = corrcoef([difC(:,1:end-1,2)' difNN(:,1:end-1,2)']);
difNNC(:,:,3) = corrcoef([difC(:,1:end-1,3)' difNN(:,1:end-1,3)']);
difNNC(:,:,4) = corrcoef([difC(:,1:end-1,4)' difNN(:,1:end-1,4)']);
%%
difNNC_avg = mean(difNNC,3);
%%
figure, imagesc(difNNC_avg,[-1 1])
% title('\xi_C-\xi_T correlation Pure')
BlueRedCM = gradedColormap([0 0 1],[1 0 0]);
colormap(BlueRedCM)
colorbar
xticks([1:14])
xticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
yticks([1:14])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
%%
pureNNC(:,:,1) = corrcoef([pureC(:,1:end-1,1)' pureNN(:,1:end-1,1)']);
pureNNC(:,:,2) = corrcoef([pureC(:,1:end-1,2)' pureNN(:,1:end-1,2)']);
pureNNC(:,:,3) = corrcoef([pureC(:,1:end-1,3)' pureNN(:,1:end-1,3)']);
pureNNC(:,:,4) = corrcoef([pureC(:,1:end-1,4)' pureNN(:,1:end-1,4)']);
%%
pureNNC_avg = mean(pureNNC,3);
%%
figure, imagesc(pureNNC_avg,[-1 1])
% title('\xi_C-\xi_T correlation Pure')
BlueRedCM = gradedColormap([0 0 1],[1 0 0]);
colormap(BlueRedCM)
colorbar
xticks([1:14])
xticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})
yticks([1:14])
yticklabels({'A','B','C', 'D', 'E', 'F', 'G','A','B','C', 'D', 'E', 'F', 'G'})