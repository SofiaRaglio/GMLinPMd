function [MeanY, StdY] = plotYDistributionVsX(X, Ys, Color)
%
%  [MeanY, StdY] = plotYDistributionVsX(X, Ys[, Color])
%

if exist('Color') == 0
   Color = [0 0 1];
else
   if ischar(Color)
      switch lower(Color)
         case 'r'
            Color = [1 0 0];
         case 'b'
            Color = [0 0 1];
         case 'g'
            Color = [0 1 0];
         case 'm'
            Color = [1 0 1];
         case 'k'
            Color = [0 0 0];
      end
   end
end

%%   Plot Ys isodensity patches and its average versus X...
%
% figure
hold on

% Patches representing different percetiles...
XP = [X fliplr(X)];
for prc = 20:10:40%10:10:40
%    clr = [1-prc/100 1-prc/100 1];
   clr = repmat(1-prc/100, 1, 3) .* (1-Color) + Color;
   YP = prctile(Ys, [prc 100-prc]);
   patch(XP, [YP(1,:) fliplr(YP(2,:))], clr, 'EdgeColor', 'none');
end

MeanY = mean(Ys);
StdY = std(Ys);
plot(X, MeanY, '-', 'Color', Color, 'LineWidth', 1., 'MarkerFaceColor', 'w');

set(gca, 'XLim', [X(1) X(end)]);
set(gca, 'TickDir', 'out', 'Layer', 'top', 'Box', 'off');

xlabel('X (a.u.)');
ylabel('Y(X) (a.u.)');

% set(gcf, 'PaperUnits', 'inch', 'PaperPosition', [1.5 3.5 5 4]);
% print('-deps2c', 'MedianPSDofLFP.eps');
