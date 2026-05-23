function [SDLine, stdLine, SDist, SDx, SxD] = PredictLine(Params, Line)

%
%   [SDLine, stdLine, SDist, SDx, SxD] = PredictLine(Params, Line)
%
%   This functtion computes the mean and standard deviation of the
%   projections of the data on the mental line.
%
%   Params = decoding parameters
%   Line = previously computed mental line
%
%   SDLine = the mean value of the projections depending on symbolic
%       distance
%   stdLine = the standard deviation of the projections depending on
%       symbolic distance
%   SDist = the matrix of all the possible symbolic distances computed with
%       the projections
%   SDx = right winning trials projections divided by SD
%   SxD = left winning trials projections divided by SD
%

[Data, CorrectTrials,~] = computeMUAandEvents(Params);
[P_tot, T , tEC] = InputOutput(Params,CorrectTrials,2);
if Params.output==1
    cond=7;
    [val ndx]=sort(CorrectTrials.condition);
end

TestedTimes = Params.TestedTimes;
for nt = 1:numel(tEC)
    for i=1:numel(TestedTimes)
        Pred(nt,i) = [P_tot(:,ndx(nt),i)' ones(1,1)]*Line;
    end
end


Prediction = mean(Pred,2);

b = {};
c = [];
t = [];
condition = max(CorrectTrials.condition)-4000;
for cnd = 1:condition
    a = find(val==(cnd+4000));
    b{cnd} = Prediction(a);
    t(cnd) = mean(Prediction(a));
    c(cnd) = std(Prediction(a));
%     c(cnd) = prctile(Prediction(a),80)-prctile(Prediction(a),20);
end

% SD = sum(T.*repmat((1:size(T,1))',1,size(T,2)));
% SD= abs(SD);
% for i=1:6
%     ind = find(SD==i);
%     stdLine(i) = std(abs(Prediction(ind)));
% end

if Params.task ==3
    d = b(1:2:end);
    e = b(2:2:end);
    f = t(1:2:end);
    h = t(2:2:end);
    
    SDx = [];
    SxD = [];
    stdLineDx = [];
    stdLineSx = [];
    array = zeros(1,6);
    for j=2:6
        array(j) = array(j-1)+6-(j-2);
    end
    
    for k=1:6
        SDx = [SDx {k}];
        SxD = [SxD {k}];
        SDx{k} = d{array(k)+1}';
        SxD{k} = e{array(k)+1}';
    end
    
    for k=1:5
        for g=2:(7-k)
            SDx{k} = [SDx{k} d{array(k)+g}'];
            SxD{k} = [SxD{k} e{array(k)+g}'];
        end
    end
    
    for k=1:6
        Line1(6-k+1) = mean(SxD{k});
        stdSx(k) = std(SxD{k});
%         stdDx(k) = prctile(SDx{k},80)-prctile(SDx{k},20);
        Line2(k) = mean(SDx{k});
        stdDx(k) = std(SDx{k});
%         stdSx(k) = prctile(SxD{k},80)-prctile(SxD{k},20);
    end

else
    SDx = b(1:2:end);
    Line1 = mean(SDx);
    stdDx = std(SDx);
%     stdDx = prctile(SDx,80)-prctile(SDx,20);
    SxD = b(2:2:end);
    Line2 = mean(SxD);
    stdSx = std(SxD);
%     stdSx = prctile(SxD,80)-prctile(SxD,20);
    f = t(1:2:end);
    h = t(2:2:end);
end

SDLine  =[Line1 Line2];
% stdLine = [mean(c(c(1:12)>0)) mean(c(c(13:22)>0)) mean(c(c(23:30)>0)) mean(c(c(31:36)>0)) mean(c(c(37:40)>0)) mean(c(c(41:42)>0))];
% stdLine = [std(c(c(1:12)>0)) std(c(c(13:22)>0)) std(c(c(23:30)>0)) std(c(c(31:36)>0)) std(c(c(37:40)>0)) std(c(c(41:42)>0))];
% stdLine = mean([stdDx' stdSx'],2);
stdLine = [stdDx' stdSx'];
%%
figure
grid on
num = ["SD=1" "SD=2" "SD=3" "SD=4" "SD=5" "SD=6"];
for i=1:6
    hold on
    sym2 = SDx{i};
    sym1 = SxD{i};
    ValRange1 = [max(sym1) min(sym1)];
    ValRange2 = [max(sym2) min(sym2)];
    BIN_NUM = 20;
    X1 = linspace(ValRange1(1), ValRange1(2), BIN_NUM);
    X2 = linspace(ValRange2(1), ValRange2(2), BIN_NUM);
    Y1 = ksdensity(sym1,X1);
    Y2 = ksdensity(sym2,X2);
    plot(X1,Y1, 'Linewidth', 2)
    plot(X2,Y2, 'Linewidth', 2)
end
legend(num)
xlabel('Projection');
ylabel('Distribution')

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

figure
plot(stdSx,'.-','MarkerSize',15)
hold on
plot(stdDx,'.-','MarkerSize',15)
grid on
xticks([1:7])
xlabel('SDist')
ylabel('Projections')

SDist =zeros(7,7);
SDist(2:7+1:end) = f(1:6);
SDist(3:7+1:end-7) = f(7:11);
SDist(4:7+1:end-14) = f(12:15);
SDist(5:7+1:end-21) = f(16:18);
SDist(6:7+1:end-28) = f(19:20);
SDist(7:7+1:end-35) = f(21);
SDist(7+1:7+1:end) = h(1:6);
SDist(14+1:7+1:end) = h(7:11);
SDist(21+1:7+1:end) = h(12:15);
SDist(28+1:7+1:end) = h(16:18);
SDist(35+1:7+1:end) = h(19:20);
SDist(42+1:7+1:end) = h(21);

figure
imagesc(SDist)
colorbar()
colormap(brewermap(20,'RdBu'))

