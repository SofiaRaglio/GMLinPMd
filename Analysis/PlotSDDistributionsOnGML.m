% Plot SD Distributions on GML
% This script reproduces the distributions on the left side of Figure 3C,D.

%%
colorSignMulti = flip([
    206 0 127  ;
    190 54 135 ;
    176 73 142 ;
    162 86 148 ;
    149 95 154 ;
    137 102 159;
    125 108 163;
    113 113 166;
    102 116 169;
    90 120 172 ;
    74 123 175 ;
    50 127 179  
    ]/255);
%%
distrSDContinous = {};
n_inputs = 7;
% distrSDContinous = [ flip(sxdc24C) sdxc24C];
% [[flip(sxdc24) sdxc24] [flip(sxdc21) sdxc21] [flip(sxdp24) sdxp24] [flip(sxdp21) sdxp21]];
for i=1:6
    distrSDContinous{7-i} = [sxdc24C{i}-mean(sxdc24C{i}) sxdc21C{i}-mean(sxdc21C{i}) sxdp24C{i}-mean(sxdp24C{i}) sxdp21C{i}-mean(sxdp21C{i})];
    distrSDContinous{i+6} = [sdxc24C{i}-mean(sxdc24C{i}) sdxc21C{i}-mean(sxdc21C{i}) sdxp24C{i}-mean(sxdp24C{i}) sdxp21C{i}-mean(sxdp21C{i})];
end
%%
YL_SD = 2.0;
% if PlotFigures
    figure
    for k=1:2*(n_inputs-1)
        % histogram(distrSDContinous{k},50,"Normalization","pdf", ...
            % "FaceColor",colorSignMulti(k,:),"FaceAlpha",0.25,"EdgeColor",colorSignMulti(k,:),"EdgeAlpha",0.0);
        hold on
        pd = fitdist(distrSDContinous{k}','Normal');
        xgrid = linspace(min(distrSDContinous{k}),max(distrSDContinous{k}),100)';
        pdfEst = pdf(pd,xgrid); 
        line(xgrid,pdfEst,'Color',colorSignMulti(k,:),'LineWidth',3);
        plot(mean(distrSDContinous{k}), 0, 'LineStyle', 'none', 'Marker', '|', ...
            'Color',colorSignMulti(k,:),'MarkerSize',10,'MarkerFaceColor',colorSignMulti(k,:),'LineWidth',4);
    end
    colormap(gca,colorSignMulti);
    xlabel('Mental Projection')
    cbTicks = (0.5:2*n_inputs)/(2*(n_inputs-1));
    ss = zeros(1,2*(n_inputs-1));
    ss(1:(n_inputs-1)) = -n_inputs+1:-1;
    ss(n_inputs:end) = 1:n_inputs-1;
    cb = colorbar('north', 'Ticks', cbTicks,...
        'TickLabels', ss, 'FontSize',12, "TickDirection","out");

    %cb.Label.String = 'Symb.';
    %cb.Label.FontSize = 10;
    ax = gca;
    axpos = ax.Position; 
    cb.Position(4) = 0.5*cb.Position(4);
    cb.Position(2) = 1.05*cb.Position(2);
    ax.Position = axpos;
    ax.YColor = [1 1 1];
    ax.YTick = [];
    box off

    pbaspect([4 1 1])

    %ylim([0 YL_SD]);
    xlim([-1.5,1.5])

% end