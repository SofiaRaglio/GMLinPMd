% Decision and Action Performances
% This script plots the exchange of the motor decision and action performances in time for the example session of Monkey C.
% It reproduces Figure 2D.

clear all;close all;clc;
%%
Params = setParams;
SelCh = AllCh(Params);
%%
load('path\to\MotVec.mat')
Params.output = 2;
Params.TestedT = -0.5:0.05:2.5; 

Params.animal=1;
Params.session=1; 
[PerfInTimeC24m, Baseline] = FromPairOnMot(Params,SelCh, MotC24,0.052,0);
[PerfInTimeC24, Baseline] = FromPairOn(Params,SelCh, MotC24,0.052,0);

Params.animal=2;
Params.session=1; 
[PerfInTimeP24m, Baseline] = FromPairOnMot(Params,SelCh, MotP24,0.016,0);
[PerfInTimeP24, Baseline] = FromPairOn(Params,SelCh, MotP24,0.016,0);

Params.animal=2;
Params.session=2; 
[PerfInTimeP21m, Baseline] = FromPairOnMot(Params,SelCh, MotP21,0.094,0);
[PerfInTimeP21, Baseline] = FromPairOn(Params,SelCh, MotP21,0.094,0);

Params.animal=1;
Params.session=2; 
[PerfInTimeC21m, Baseline] = FromPairOnMot(Params,SelCh, MotC21,-0.012,0);
[PerfInTimeC21, Baseline] = FromPairOn(Params,SelCh, MotC21,-0.012,0);

PerfInTime = [];
PerfInTimem = [];
Baseline = [];
PerfInTime(:,:,:,1) = PerfInTimeC24;
PerfInTime(:,:,:,2) = PerfInTimeC21;
PerfInTime(:,:,:,3) = PerfInTimeP21;
PerfInTime(:,:,:,4) = PerfInTimeP24;
PerfInTime = mean(PerfInTime,4);

PerfInTimem(:,:,:,1) = PerfInTimeC24m;
PerfInTimem(:,:,:,2) = PerfInTimeC21m;
PerfInTimem(:,:,:,3) = PerfInTimeP21m;
PerfInTimem(:,:,:,4) = PerfInTimeP24m;
PerfInTimem = mean(PerfInTimem,4);
%%
load('path\to\AllC24.mat')
Params.animal=1;
Params.session=1; 
[PerfDecC24m, Baseline] = FromPairOnMot(Params,SelCh, AnsT,0.043,0);
[PerfDecC24, Baseline] = FromPairOn(Params,SelCh, AnsT,0.043,0);
%%
load('path\to\AllC21.mat')
Params.animal=1;
Params.session=2; 
[PerfDecC21m, Baseline] = FromPairOnMot(Params,SelCh, AnsT,-0.072,0);
[PerfDecC21, Baseline] = FromPairOn(Params,SelCh, AnsT,-0.072,0);
%%
load('path\to\AllP24.mat')
Params.animal=2;
Params.session=1; 
[PerfDecP24m, Baseline] = FromPairOnMot(Params,SelCh, AnsT,-0.003,0);
[PerfDecP24, Baseline] = FromPairOn(Params,SelCh, AnsT,-0.003,0);
%%
load('path\to\AllP21.mat')
Params.animal=2;
Params.session=2; 
[PerfDecP21m, Baseline] = FromPairOnMot(Params,SelCh, AnsT,0.027,0);
[PerfDecP21, Baseline] = FromPairOn(Params,SelCh, AnsT,0.027,0);
%%
PerfDec(:,:,:,1) = PerfDecC24;
PerfDec(:,:,:,2) = PerfDecC21;
PerfDec(:,:,:,3) = PerfDecP21;
PerfDec(:,:,:,4) = PerfDecP24;
PerfDec = mean(PerfDec,4);

PerfDecm(:,:,:,1) = PerfDecC24m;
PerfDecm(:,:,:,2) = PerfDecC21m;
PerfDecm(:,:,:,3) = PerfDecP21m;
PerfDecm(:,:,:,4) = PerfDecP24m;
PerfDecm = mean(PerfDecm,4);
%%
f=[];
x=Params.TestedT;
xint = x(1):0.005:x(end);
f= griddedInterpolant(x,squeeze(mean(PerfInTime,3))','spline');
f1= griddedInterpolant(x,squeeze(mean(PerfInTimem,3))','spline');
f2= griddedInterpolant(x,squeeze(mean(PerfDec,3))','spline');
f3= griddedInterpolant(x,squeeze(mean(PerfDecm,3))','spline');
base = griddedInterpolant(x,mean(Baseline,2)','spline');

figure
plot(xint,f(xint))
hold on
plot(xint,f2(xint))
plot(xint,base(xint))
ylim([0.3 1])
xlim([-0.5 1.5])

figure
plot(xint,f1(xint))
hold on
plot(xint,f3(xint))
plot(xint,base(xint))
xlim([-0.5 1.5])
ylim([0.3 1])