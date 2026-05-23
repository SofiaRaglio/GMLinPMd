% Performance in time of position-invariant decoder and position-dependent decoder of symbols.
% This script reproduces Figure 3B, S3C,S4A.

clear all;
%%
Params = setParams();
SelCh = AllCh(Params);
%%
load('path\to\AllC24.mat')
Params.target = 4;
Params.task = 2;
Params.animal =1;
Params.session=1;
[PerfInTimeC24Sx, BaselineC24Sx] = FromPairOnAUC(Params,SelCh, SxC);
Params.task = 3;
[PerfInTimeC24testSx, BaselineC24testSx] = FromPairOnAUC(Params,SelCh, SxT);

Params.target = 3;
Params.task = 2;
Params.animal =1;
Params.session=1;
[PerfInTimeC24Dx, BaselineC24Dx] = FromPairOnAUC(Params,SelCh, DxC);
Params.task = 3;
[PerfInTimeC24testDx, BaselineC24testDx] = FromPairOnAUC(Params,SelCh,DxT);

Params.target = 2;
Params.task = 2;
Params.animal =1;
Params.session=1;
[PerfInTimeC24pure, BaselineC24pure] = FromPairOnAUC(Params,SelCh,PureC);
Params.task = 3;
[PerfInTimeC24testPure, BaselineC24testPure] = FromPairOnAUC(Params,SelCh, PureT);
%%
load('path\to\AllC21.mat')
Params.target = 4;
Params.task = 2;
Params.animal =1;
Params.session=2;
[PerfInTimeC21Sx, BaselineC21Sx] = FromPairOnAUC(Params,SelCh, SxC);
Params.task = 3;
[PerfInTimeC21testSx, BaselineC21testSx] = FromPairOnAUC(Params,SelCh, SxT);

Params.target = 3;
Params.task = 2;
Params.animal =1;
Params.session=2;
[PerfInTimeC21Dx, BaselineC21Dx] = FromPairOnAUC(Params,SelCh, DxC);
Params.task = 3;
[PerfInTimeC21testDx, BaselineC21testDx] = FromPairOnAUC(Params,SelCh, DxT);

Params.target = 2;
Params.task = 2;
Params.animal =1;
Params.session=2;
[PerfInTimeC21pure, BaselineC21pure] = FromPairOnAUC(Params,SelCh, PureC);
Params.task = 3;
[PerfInTimeC21testPure, BaselineC21testPure] = FromPairOnAUC(Params,SelCh, PureT);
%%
load('path\to\AllP21.mat')
Params.target = 4;
Params.task = 2;
Params.animal =2;
Params.session=2;
[PerfInTimeP21Sx, BaselineP21Sx] = FromPairOnAUC(Params,SelCh, SxC);
Params.task = 3;
[PerfInTimeP21testSx, BaselineP21testSx] = FromPairOnAUC(Params,SelCh, SxT);

Params.target = 3;
Params.task = 2;
Params.animal =2;
Params.session=2;
[PerfInTimeP21Dx, BaselineP21Dx] = FromPairOnAUC(Params,SelCh, DxC);
Params.task = 3;
[PerfInTimeP21testDx, BaselineP21testDx] = FromPairOnAUC(Params,SelCh, DxT);

Params.target = 2;
Params.task = 2;
Params.animal =2;
Params.session=2;
[PerfInTimeP21pure, BaselineP21pure] = FromPairOnAUC(Params,SelCh, PureC);
Params.task = 3;
[PerfInTimeP21testPure, BaselineP21testPure] = FromPairOnAUC(Params,SelCh, PureT);
%%
load('path\to\AllP24.mat')
Params.target = 4;
Params.task = 2;
Params.animal =2;
Params.session=1;
[PerfInTimeP24Sx, BaselineP24Sx] = FromPairOnAUC(Params,SelCh, SxC);
Params.task = 3;
[PerfInTimeP24testSx, BaselineP24testSx] = FromPairOnAUC(Params,SelCh, SxT);

Params.target = 3;
Params.task = 2;
Params.animal =2;
Params.session=1;
[PerfInTimeP24Dx, BaselineP24Dx] = FromPairOnAUC(Params,SelCh, DxC);
Params.task = 3;
[PerfInTimeP24testDx, BaselineP24testDx] = FromPairOnAUC(Params,SelCh, DxT);

Params.target = 2;
Params.task = 2;
Params.animal =2;
Params.session=1;
[PerfInTimeP24pure, BaselineP24pure] = FromPairOnAUC(Params,SelCh, PureC);
Params.task = 3;
[PerfInTimeP24testPure, BaselineP24testPure] = FromPairOnAUC(Params,SelCh, PureT);
%%
PerfInTimePure = [];
BaselinePure = [];
PerfInTimePure(:,:,:,1) = PerfInTimeC24pure;
PerfInTimePure(:,:,:,2) = PerfInTimeC21pure;
PerfInTimePure(:,:,:,3) = PerfInTimeP21pure;
PerfInTimePure(:,:,:,4) = PerfInTimeP24pure;
PerfInTimePure = squeeze(mean(PerfInTimePure,3));
Baseline(:,:,:,1) = BaselineC24pure;
Baseline(:,:,:,2) = BaselineC21pure;
Baseline(:,:,:,3) = BaselineP21pure;
Baseline(:,:,:,4) = BaselineP24pure;
Baseline = mean(Baseline,4)
%%
PerfInTimetestPure = [];
Baselinetest = [];
PerfInTimetestPure(:,:,:,1) = PerfInTimeC24testPure;
PerfInTimetestPure(:,:,:,2) = PerfInTimeC21testPure;
PerfInTimetestPure(:,:,:,3) = PerfInTimeP21testPure;
PerfInTimetestPure(:,:,:,4) = PerfInTimeP24testPure;
PerfInTimetestPure = squeeze(mean(PerfInTimetestPure,3));
Baselinetest(:,:,:,1) = BaselineC24testPure;
Baselinetest(:,:,:,2) = BaselineC21testPure;
Baselinetest(:,:,:,3) = BaselineP21testPure;
Baselinetest(:,:,:,4) = BaselineP24testPure;
Baselinetest = mean(Baselinetest,4)

%%
PerfInTimeDx = [];
BaselineDx = [];
PerfInTimeDx(:,:,:,1) = PerfInTimeC24Dx;
PerfInTimeDx(:,:,:,2) = PerfInTimeC21Dx;
PerfInTimeDx(:,:,:,3) = PerfInTimeP21Dx;
PerfInTimeDx(:,:,:,4) = PerfInTimeP24Dx;
PerfInTimeDx = squeeze(mean(PerfInTimeDx,3));
Baseline(:,:,:,1) = BaselineC24Dx;
Baseline(:,:,:,2) = BaselineC21Dx;
Baseline(:,:,:,3) = BaselineP21Dx;
Baseline(:,:,:,4) = BaselineP24Dx;
Baseline = mean(Baseline,4)
%%
PerfInTimetestDx = [];
Baselinetest = [];
PerfInTimetestDx(:,:,:,1) = PerfInTimeC24testDx;
PerfInTimetestDx(:,:,:,2) = PerfInTimeC21testDx;
PerfInTimetestDx(:,:,:,3) = PerfInTimeP21testDx;
PerfInTimetestDx(:,:,:,4) = PerfInTimeP24testDx;
PerfInTimetestDx = squeeze(mean(PerfInTimetestDx,3));
Baselinetest(:,:,:,1) = BaselineC24testDx;
Baselinetest(:,:,:,2) = BaselineC21testDx;
Baselinetest(:,:,:,3) = BaselineP21testDx;
Baselinetest(:,:,:,4) = BaselineP24testDx;
Baselinetest = mean(Baselinetest,4)

%%
PerfInTimeSx = [];
BaselineSx = [];
PerfInTimeSx(:,:,:,1) = PerfInTimeC24Sx;
PerfInTimeSx(:,:,:,2) = PerfInTimeC21Sx;
PerfInTimeSx(:,:,:,3) = PerfInTimeP21Sx;
PerfInTimeSx(:,:,:,4) = PerfInTimeP24Sx;
PerfInTimeSx = squeeze(mean(PerfInTimeSx,3));
Baseline(:,:,:,1) = BaselineC24Sx;
Baseline(:,:,:,2) = BaselineC21Sx;
Baseline(:,:,:,3) = BaselineP21Sx;
Baseline(:,:,:,4) = BaselineP24Sx;
Baseline = mean(Baseline,4)
%%
PerfInTimetestSx = [];
Baselinetest = [];
PerfInTimetestSx(:,:,:,1) = PerfInTimeC24testSx;
PerfInTimetestSx(:,:,:,2) = PerfInTimeC21testSx;
PerfInTimetestSx(:,:,:,3) = PerfInTimeP21testSx;
PerfInTimetestSx(:,:,:,4) = PerfInTimeP24testSx;
PerfInTimetestSx = squeeze(mean(PerfInTimetestSx,3));
Baselinetest(:,:,:,1) = BaselineC24testSx;
Baselinetest(:,:,:,2) = BaselineC21testSx;
Baselinetest(:,:,:,3) = BaselineP21testSx;
Baselinetest(:,:,:,4) = BaselineP24testSx;
Baselinetest = mean(Baselinetest,4)
%%
perf = PerfInTimeP24pure;
x=Params.TestedT;
xint = x(1):0.005:x(end);
f=[];
for i=1:7
    y = griddedInterpolant(x,mean(perf(:,i,:),3)','spline');
    f(i,:)=y(xint);
end
base = griddedInterpolant(x,mean(mean(Baseline,3),2)','spline');
figure
for i=1:7
hold on
% plot(Params.TestedT,mean(PerfInTime(:,i,:),3)','.-')
plot(xint,f(i,:),'-')
end
plot(xint,base(xint),'k-')
ylim([0 1])
% grid on
if Params.output==1
    legend({'A','B','C', 'D', 'E', 'F', 'G'})
else
    legend({'Motor Choice'})
end
ylabel('AUC of best channels')
xlabel('Time from PairOn')


%%
% perf = PerfInTimeC21Sx;
% perf1 = PerfInTimeC21Dx;
perf = PerfInTimetestSx;
perf1 = PerfInTimetestDx;
% perf = [PerfInTimeP24 PerfInTimeC24 PerfInTimeP21 PerfInTimeC21];
% base = Baseline;
figure
x=Params.TestedT;
xint = x(1):0.005:x(end);
f=[];
f1=[];
for i=1:7
    y = griddedInterpolant(x,squeeze(mean(perf(:,i,:),3))','spline');
    f(i,:)=y(xint);
    y1 = griddedInterpolant(x,squeeze(mean(perf1(:,i,:),3))','spline');
    f1(i,:)=y1(xint);
end

b= reshape(Baseline,[25,50*7]);
ba=[];
for i=1:350
    y = griddedInterpolant(x,b(:,i)','spline');
    ba(i,:)=y(xint);
end

[MeanY, StdY] = plotYDistributionVsX(xint, f,'b')
hold on

[MeanY, StdY] = plotYDistributionVsX(xint, f1,'r')

% [MeanY, StdY] = plotYDistributionVsX(Params.TestedT, squeeze(mean(perf,3))',blue)

[MeanY, StdY] = plotYDistributionVsX(xint,ba, 'k')
xlabel('Time from PairOn')
ylabel('AUC of symbols decoding')
% ylim([0.3 1])
ylim([0.4 0.9])
