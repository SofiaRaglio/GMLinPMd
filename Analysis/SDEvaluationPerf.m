%% This script evaluates plateau and steepness of the performance in time for the different SDs.
% It reproduces Figure S2A (same principle for Figure S2B).

% load performance data (for decision or action)

Perf1(:,:,:,1) = Perf1c24;
Perf1(:,:,:,2) = Perf1c21;
Perf1(:,:,:,3) = Perf1p21;
Perf1(:,:,:,4) = Perf1p24;

Perf2(:,:,:,1) = Perf2c24;
Perf2(:,:,:,2) = Perf2c21;
Perf2(:,:,:,3) = Perf2p21;
Perf2(:,:,:,4) = Perf2p24;

Perf3(:,:,:,1) = Perf3c24;
Perf3(:,:,:,2) = Perf3c21;
Perf3(:,:,:,3) = Perf3p21;
Perf3(:,:,:,4) = Perf3p24;

Perf4(:,:,:,1) = Perf4c24;
Perf4(:,:,:,2) = Perf4c21;
Perf4(:,:,:,3) = Perf4p21;
Perf4(:,:,:,4) = Perf4p24;

Perf5(:,:,:,1) = Perf5c24;
Perf5(:,:,:,2) = Perf5c21;
Perf5(:,:,:,3) = Perf5p21;
Perf5(:,:,:,4) = Perf5p24;

Perf6(:,:,:,1) = Perf6c24;
Perf6(:,:,:,2) = Perf6c21;
Perf6(:,:,:,3) = Perf6p21;
Perf6(:,:,:,4) = Perf6p24;
%%
a = squeeze(mean(Perf1,3));
b = squeeze(mean(Perf2,3));
c = squeeze(mean(Perf3,3));
d = squeeze(mean(Perf4,3));
e = squeeze(mean(Perf5,3));
f = squeeze(mean(Perf6,3));
plateau = [mean(mean(a(21:25,:))) mean(mean(b(21:25,:))) mean(mean(c(21:25,:))) mean(mean(d(21:25,:))) mean(mean(e(21:25,:))) mean(mean(f(21:25,:)))];
errplat = [std(mean(a(21:25,:))) std(mean(b(21:25,:))) std(mean(c(21:25,:))) std(mean(d(21:25,:))) std(mean(e(21:25,:))) std(mean(f(21:25,:)))];
%%
figure;
errorbar(plateau,errplat/2,'ko--', "LineWidth",2)
hold on
plot(plateau, "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 6.5])
ylim([0.5 1])
%%
n1 = 12;
n2=17;
fl1c24 = fit(Params.TestedT(n1:n2)',a(n1:n2,1),'poly1');
fl1c21 = fit(Params.TestedT(n1:n2)',a(n1:n2,2),'poly1');
fl1p21 = fit(Params.TestedT(n1:n2)',a(n1:n2,3),'poly1');
fl1p24 = fit(Params.TestedT(n1:n2)',a(n1:n2,4),'poly1');

fl2c24 = fit(Params.TestedT(n1:n2)',b(n1:n2,1),'poly1');
fl2c21 = fit(Params.TestedT(n1:n2)',b(n1:n2,2),'poly1');
fl2p21 = fit(Params.TestedT(n1:n2)',b(n1:n2,3),'poly1');
fl2p24 = fit(Params.TestedT(n1:n2)',b(n1:n2,4),'poly1');

fl3c24 = fit(Params.TestedT(n1:n2)',c(n1:n2,1),'poly1');
fl3c21 = fit(Params.TestedT(n1:n2)',c(n1:n2,2),'poly1');
fl3p21 = fit(Params.TestedT(n1:n2)',c(n1:n2,3),'poly1');
fl3p24 = fit(Params.TestedT(n1:n2)',c(n1:n2,4),'poly1');

fl4c24 = fit(Params.TestedT(n1:n2)',d(n1:n2,1),'poly1');
fl4c21 = fit(Params.TestedT(n1:n2)',d(n1:n2,2),'poly1');
fl4p21 = fit(Params.TestedT(n1:n2)',d(n1:n2,3),'poly1');
fl4p24 = fit(Params.TestedT(n1:n2)',d(n1:n2,4),'poly1');

fl5c24 = fit(Params.TestedT(n1:n2)',e(n1:n2,1),'poly1');
fl5c21 = fit(Params.TestedT(n1:n2)',e(n1:n2,2),'poly1');
fl5p21 = fit(Params.TestedT(n1:n2)',e(n1:n2,3),'poly1');
fl5p24 = fit(Params.TestedT(n1:n2)',e(n1:n2,4),'poly1');

fl6c24 = fit(Params.TestedT(n1:n2)',f(n1:n2,1),'poly1');
fl6c21 = fit(Params.TestedT(n1:n2)',f(n1:n2,2),'poly1');
fl6p21 = fit(Params.TestedT(n1:n2)',f(n1:n2,3),'poly1');
fl6p24 = fit(Params.TestedT(n1:n2)',f(n1:n2,4),'poly1');
%%
stepness = [mean([fl1c24.p1 fl1c21.p1 fl1p21.p1 fl1p24.p1]) mean([fl2c24.p1 fl2c21.p1 fl2p21.p1 fl2p24.p1]) mean([fl3c24.p1 fl3c21.p1 fl3p21.p1 fl3p24.p1]) mean([fl4c24.p1 fl4c21.p1 fl4p21.p1 fl4p24.p1]) mean([fl5c24.p1 fl5c21.p1 fl5p21.p1 fl5p24.p1]) mean([fl6c24.p1 fl6c21.p1 fl6p21.p1 fl6p24.p1])];
errstep = [std([fl1c24.p1 fl1c21.p1 fl1p21.p1 fl1p24.p1]) std([fl2c24.p1 fl2c21.p1 fl2p21.p1 fl2p24.p1]) std([fl3c24.p1 fl3c21.p1 fl3p21.p1 fl3p24.p1]) std([fl4c24.p1 fl4c21.p1 fl4p21.p1 fl4p24.p1]) std([fl5c24.p1 fl5c21.p1 fl5p21.p1 fl5p24.p1]) std([fl6c24.p1 fl6c21.p1 fl6p21.p1 fl6p24.p1])];
figure;
errorbar(stepness,errstep/2,'ko--', "LineWidth",2)
hold on
plot(stepness, "LineStyle", "none", "Marker", ".", "MarkerSize", 16, 'Color', "w")
xlim([0.5 6.5])
ylim([0.5 1.5])
%%
