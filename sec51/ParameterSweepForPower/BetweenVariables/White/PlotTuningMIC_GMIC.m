clear all;
close all;
clc;

load './saved/testMIC_GMIC';

% Plot MIC

h = figure;

hold all;
plot(ParToTune,powerToPlotA');
plot(ParToTune,mean(powerToPlotA),'k','Linewidth',2);
grid on;

[maxv maxi] = max(mean(powerToPlotA));
line([ParToTune(maxi) ParToTune(maxi)], [0 1]);
xlim([min(ParToTune) max(ParToTune)]);
xlabel('Parameter ($\alpha$)','Interpreter','latex');
title(['MIC, optimum at $\alpha= ' num2str(ParToTune(maxi)) '$'],'Interpreter','latex');

ylabel('Area Under Power Curve','Interpreter','latex');
set(h, 'Position', [800 920 300 250])
set(h,'PaperSize',[8 7],'PaperPositionMode','auto');
saveas(h,'TuneMIC','pdf');

% Plot GMIC

h = figure;

hold all;
plot(ParToTune,powerToPlotB');
plot(ParToTune,mean(powerToPlotB),'k','Linewidth',2);
grid on;

[maxv maxi] = max(mean(powerToPlotB));
line([ParToTune(maxi) ParToTune(maxi)], [0 1]);
xlim([min(ParToTune) max(ParToTune)]);
xlabel('Parameter ($\alpha$)','Interpreter','latex');
title(['GMIC, optimum at $\alpha= ' num2str(ParToTune(maxi)) '$'],'Interpreter','latex');

ylabel('Area Under Power Curve','Interpreter','latex');
set(h, 'Position', [800 920 300 250])
set(h,'PaperSize',[8 7],'PaperPositionMode','auto');
saveas(h,'TuneGMIC','pdf');