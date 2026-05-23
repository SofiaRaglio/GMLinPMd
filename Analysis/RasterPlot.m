%% Raster Plot
% This script plots the raster plot of one channel in the left and right decision conditions, ordering trials by SD and within SD by RT.
% It reproduces Figure 2B.

clear all;
%%
EC = setEncodes();
Params = setParams;
Params.output=2;
[Data, CorrectTrials, ErrorTrials, TotTrials]=computeMUAandEvents(Params);
%%
Params.TestedT = -0.2:0.005:2;
[P_tot, T, tEC] = InputOutput(Params,CorrectTrials,1);
Options.EventsToPlot.Codes = [EC.TEST1_OFF EC.RT EC.TOUCH_PERIPHERICAL];
Options.EventsToPlot.Styles = {'kd','rd','md'};

Options.Time.CentralEvent = EC.PAIR_ON;
Options.Time.Range = [-0.2 2];

%%
cmap = [
    % 247,252,240
% 224,243,219
8,64,129
8,104,172
43,140,190
78,179,211

123,204,196
168,221,181
204,235,197
% 224,243,219
% 247,252,240
]/255;
discreteColors = cmap; 
numEntries = 256;
continuousColors = interp1(linspace(0, 1, size(discreteColors, 1)), discreteColors, linspace(0, 1, numEntries));
colormap(continuousColors)
%%
for ch=20%:85
    raster=[];
    tEC = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.Time.CentralEvent);
    TestedTimes=Options.Time.Range(1):0.005:Options.Time.Range(2);
    
    t_go = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.EventsToPlot.Codes(1));
    t_rt = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.EventsToPlot.Codes(2));
    t_touch = getTriggerFromEventCode(CorrectTrials, Data.Events, Options.EventsToPlot.Codes(3));
    
    go = t_go-tEC;
    go(t_go<0) = NaN;
    rt = t_rt-tEC;
    rt(t_rt<0) = NaN;
    touch = t_touch-tEC;
    touch(t_touch<0) = NaN;
    

    raster = squeeze(P_tot(ch,:,:));
    %%
    [v,n] = sort(T);%1:177
    raster1 = raster(n(1:177),:);
    raster2 = raster(n(178:end),:);
    rt1 = rt(n(1:177));
    rt2 = rt(n(178:end));
    
    go1 = go(n(1:177));
    go2 = go(n(178:end));
    
    touch1 = touch(n(1:177));
    touch2 = touch(n(178:end));
    
    [val1,ndx1] = sort(CorrectTrials.condition(n(1:177)));
    [val2,ndx2] = sort(CorrectTrials.condition(n(178:end)));
    
    a1 = ndx1(1:45);
    b1 = ndx1(46:86);
    c1 = ndx1(87:124);
    d1 = ndx1(125:152);
    e1 = ndx1(153:169);
    f1 = ndx1(179:end);

    [va1,na1] = sort(rt1(a1));
    [vb1,nb1] = sort(rt1(b1));
    [vc1,nc1] = sort(rt1(c1));
    [vd1,nd1] = sort(rt1(d1));
    [ve1,ne1] = sort(rt1(e1));
    [vf1,nf1] = sort(rt1(f1));
    
    a2 = ndx2(1:37);
    b2 = ndx2(38:79);
    c2 = ndx2(80:105);
    d2 = ndx2(106:131);
    e2 = ndx2(132:149);
    f2 = ndx2(150:end);

    [va2,na2] = sort(rt2(a2));
    [vb2,nb2] = sort(rt2(b2));
    [vc2,nc2] = sort(rt2(c2));
    [vd2,nd2] = sort(rt2(d2));
    [ve2,ne2] = sort(rt2(e2));
    [vf2,nf2] = sort(rt2(f2));
    %%
    ndx_r = [a1(na1) b1(nb1) c1(nc1) d1(nd1) e1(ne1) f1(nf1)];
    ndx_l = [a2(na2) b2(nb2) c2(nc2) d2(nd2) e2(ne2) f2(nf2)];
    %%


% 
    y =[1:numel(ndx_r)];
    figure
    imagesc(TestedTimes,y,movmean(raster1(ndx_r,:),10,2))
    caxis([0 0.6])
    hold on
    plot(go1(ndx_r),y,'r.')
    plot(touch1(ndx_r),y,'k.')
    plot(rt1(ndx_r),y,'m.')
    plot(zeros(numel(ndx_r)),y,'g.')
    % colormap(continuousColors)
    colormap(1-gray());
    colorbar()
    FigSize = [12 3];
    set(gcf,'PaperUnits','inch','PaperSize',FigSize,'PaperPosition',[0 0 FigSize]);
    print('-painters','-dpdf','Right');


    y =[1:numel(ndx_l)];
    figure
    imagesc(TestedTimes,y,movmean(raster2(ndx_l,:),10,2))
    hold on
    plot(go2(ndx_l),y,'r.')
    plot(touch2(ndx_l),y,'k.')
    plot(rt2(ndx_l),y,'m.')
    plot(zeros(numel(ndx_l)),y,'g.')
    % colormap(continuousColors)
    colormap(1-gray());
    colorbar()
    
    FigSize = [12 3];
    set(gcf,'PaperUnits','inch','PaperSize',FigSize,'PaperPosition',[0 0 FigSize]);
    print('-painters','-dpdf','Left');

end

