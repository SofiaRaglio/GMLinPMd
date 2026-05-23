%% Behavioral Performance Figure
% This script plots the behavioral performance of the animals performing the TI task.
% It reproduces Figure 1E,F (green plots, animal behavior) and Figure S1D,F


Params = setParams();
Params.animal =1;
Params.session=1;
[AccC24, SDEpC24, SDErtC24,errSDErtC24, SPEC24, AllPairsC24,AnsPercC24] = BehavioralPerf(Params);
Params.animal =1;
Params.session=2;
[AccC21, SDEpC21, SDErtC21,errSDErtC21, SPEC21,AllPairsC21,AnsPercC21] = BehavioralPerf(Params);
Params.animal =2;
Params.session=2;
[AccP21, SDEpP21, SDErtP21,errSDErtP21, SPEP21, AllPairsP21,AnsPercP21] = BehavioralPerf(Params);
Params.animal =2;
Params.session=1;
[AccP24, SDEpP24, SDErtP24, errSDErtP24,SPEP24, AllPairsP24,AnsPercP24] = BehavioralPerf(Params);
%%
SDEp = mean([SDEpC24' SDEpC21' SDEpP21' SDEpP24'],2);
SDEpErr = std([SDEpC24' SDEpC21' SDEpP21' SDEpP24']');
SDErt = mean([SDErtC24' SDErtC21' SDErtP21' SDErtP24'],2);
SDErtErr = std([SDErtC24' SDErtC21' SDErtP21' SDErtP24']');
SPE = mean([SPEC24' SPEC21' SPEP21' SPEP24'],2);
SPEErr = std([SPEC24' SPEC21' SPEP21' SPEP24']');
%%
figure
errorbar(1:6,SDEp,SDEpErr/2,'r.-', 'MarkerSize',10)
xlabel('SDist')
ylabel('Performance')
xlim([0.5 6.5])
ylim([0.5 1.05])
%%
figure
errorbar(1:6,SDErt,SDErtErr/2,'b.-', 'MarkerSize',10)
xlabel('SDist')
ylabel('Reaction Times')
xlim([0.5 6.5])
ylim([0 0.5])
%%
figure
errorbar(1:7,SPE,SPEErr/2,'g.-', 'MarkerSize',10)
xticks([1:7])
xticklabels({'A', 'B', 'C', 'D', 'E', 'F', 'G'})
ylabel('Performance')
xlim([0.5 7.5])
ylim([0.5 1])
%%
AllPairsBehavior(:,1) = AllPairsC21;
AllPairsBehavior(:,2) = AllPairsC24;
AllPairsBehavior(:,3) = AllPairsP21;
AllPairsBehavior(:,4) = AllPairsP24;
%%
AllPairsB = mean(AllPairsBehavior,2);
errAllPairs = std(AllPairsBehavior');
%%
AllPairs = AllPairsBehavior;

figure; hold on

colors = lines(4);              % 4 distinct, readable colors
h = gobjects(4,1);              % handles for legend

for i = 1:4
    c = colors(i,:);

    % plot segments with same color
    plot(1:6,   AllPairs(1:6,i),   '.-', 'Color', c)
    plot(7:11,  AllPairs(7:11,i),  '.-', 'Color', c)
    plot(12:15, AllPairs(12:15,i), '.-', 'Color', c)
    plot(16:18, AllPairs(16:18,i), '.-', 'Color', c)
    plot(19:20, AllPairs(19:20,i), '.-', 'Color', c)

    % store one handle for the legend
    h(i) = plot(21, AllPairs(21,i), '.-', 'Color', c);
end

ylim([0 1.1])
xlabel('Pair index')
ylabel('Behavior')

legend(h, {'i = 1','i = 2','i = 3','i = 4'}, 'Location','best')
