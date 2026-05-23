% Mental Line Figure
% This script reproduces Figure 3C,D,E, Figure S4C.
load('path\to\AllC24.mat')
Params = setParams;
Params.animal = 1;
Params.session = 1;
Params.task = 2;
[~, ~, ~, ~, ~, MLC24C, ~] = MentalLine(Params,DifC, AnsC);
Params.task = 3;
[~, ~, ~, ~, ~, MLC24T, ~] = MentalLine(Params,DifT, AnsT);
[SDLineC24, stdLineC24, ~, sdxc24, sxdc24] = PredictLine(Params, MLC24T);
[SDLineC24C, stdLineC24C, ~, sdxc24C, sxdc24C] = PredictLine(Params, MLC24C);
%%
load('path\to\AllC21.mat')
Params = setParams;
Params.animal = 1;
Params.session = 2;
Params.task = 2;
[~, ~, ~, ~, ~, MLC21C, ~] = MentalLine(Params,DifC, AnsC);
Params.task = 3;
[~, ~, ~, ~, ~, MLC21T, ~] = MentalLine(Params,DifT, AnsT);
[SDLineC21, stdLineC21, ~, sdxc21, sxdc21] = PredictLine(Params, MLC21T);
[SDLineC21C, stdLineC21C, ~, sdxc21C, sxdc21C] = PredictLine(Params, MLC21C);
%%
load('path\to\AllP24.mat')
Params = setParams;
Params.animal = 2;
Params.session = 1;
Params.task = 2;
[~, ~, ~, ~, ~, MLP24C, ~] = MentalLine(Params,DifC, AnsC);
Params.task = 3;
[~, ~, ~, ~, ~, MLP24T, ~] = MentalLine(Params,DifT, AnsT);
[SDLineP24, stdLineP24, ~, sdxp24, sxdp24] = PredictLine(Params, MLP24T);
[SDLineP24C, stdLineP24C, ~, sdxp24C, sxdp24C] = PredictLine(Params, MLP24C);
%%
load('path\to\AllP21.mat')
Params = setParams;
Params.animal = 2;
Params.session = 2;
Params.task = 2;
[~, ~, ~, ~, ~, MLP21C, ~] = MentalLine(Params,DifC, AnsC);
Params.task = 3;
[~, ~, ~, ~, ~, MLP21T, ~] = MentalLine(Params,DifT, AnsT);
[SDLineP21, stdLineP21, ~, sdxp21, sxdp21] = PredictLine(Params, MLP21T);
[SDLineP21C, stdLineP21C, ~, sdxp21C, sxdp21C] = PredictLine(Params, MLP21C);
%%
close all;
%%
% recentering the mental lines to the origin
SDLineC24 = SDLineC24-mean(SDLineC24);
SDLineC21 = SDLineC21-mean(SDLineC21);
SDLineP24 = SDLineP24-mean(SDLineP24);
SDLineP21 = SDLineP21-mean(SDLineP21);
%%
SDLine = [];
SDLine(:,:,1) = SDLineC24;
SDLine(:,:,2) = SDLineC21;
SDLine(:,:,3) = SDLineP21;
SDLine(:,:,4) = SDLineP24;
SDLine = mean(SDLine,3);
%%
% recentering the mental lines to the origin
SDLineC24C = SDLineC24C-mean(SDLineC24C);
SDLineC21C = SDLineC21C-mean(SDLineC21C);
SDLineP24C = SDLineP24C-mean(SDLineP24C);
SDLineP21C = SDLineP21C-mean(SDLineP21C);
%%
SDLineC = [];
SDLineC(:,:,1) = SDLineC24C;
SDLineC(:,:,2) = SDLineC21C;
SDLineC(:,:,3) = SDLineP21C;
SDLineC(:,:,4) = SDLineP24C;
SDLineC = mean(SDLineC,3);
%%
stdLine = [];
errStdLine = [];
stdLine(:,:,1) = stdLineC24;
stdLine(:,:,2) = stdLineC21;
stdLine(:,:,3) = stdLineP21;
stdLine(:,:,4) = stdLineP24;
errStdLine(:,1) = std(squeeze(stdLine(:,1,:))')';
errStdLine(:,2) = std(squeeze(stdLine(:,2,:))')';
stdLine = mean(stdLine,3);
%%
stdLineC = [];
errStdLineC = [];
stdLineC(:,:,1) = stdLineC24C;
stdLineC(:,:,2) = stdLineC21C;
stdLineC(:,:,3) = stdLineP21C;
stdLineC(:,:,4) = stdLineP24C;
errStdLineC(:,1) = std(squeeze(stdLineC(:,1,:))')';
errStdLineC(:,2) = std(squeeze(stdLineC(:,2,:))')';
stdLineC = mean(stdLineC,3);

%%
figure
x = [-6:-1 1:6];
plot(x,SDLine,'o')
hold on
xlabel('SDist')
ylabel('Output')
xlim([-6.5 6.5])
grid on
xline(0,'--')
p1 = polyfit(x(1:6),SDLine(1:6),1);
ics1 = linspace(x(1),x(6));
f1 = polyval(p1,ics1);
plot(ics1,f1,'r--')
p2 = polyfit(x(7:end),SDLine(7:end),1);
ics2 = linspace(x(7),x(end));
f2 = polyval(p2,ics2);
plot(ics2,f2,'r--');
%%
figure
plot(stdLine(:,1),'.-','MarkerSize',15)
grid on
xticks([1:7])
xlabel('SDist')
ylabel('Standard Deviation')
hold on
plot(stdLine(:,2),'.-','MarkerSize',15)
%%
figure
x = [-6:-1 1:6];
plot(x,SDLineC,'o')
hold on
xlabel('SDist')
ylabel('Output')
xlim([-6.5 6.5])
grid on
xline(0,'--')
p1 = polyfit(x(2:6),SDLineC(2:6),1);
ics1 = linspace(x(1),x(6));
f1 = polyval(p1,ics1);
plot(ics1,f1,'r--')
p2 = polyfit(x(7:end-1),SDLineC(7:end-1),1);
ics2 = linspace(x(7),x(end));
f2 = polyval(p2,ics2);
plot(ics2,f2,'r--');
