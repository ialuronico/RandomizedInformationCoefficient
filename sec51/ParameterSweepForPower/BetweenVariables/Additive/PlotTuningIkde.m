clear all;
close all;
clc;

load './saved/testIkde';

h = figure;

hold all;
plot(ParToTune,powerToPlot');
plot(ParToTune,mean(powerToPlot),'k','Linewidth',2);
grid on;

[maxv maxi] = max(mean(powerToPlot));
line([ParToTune(maxi) ParToTune(maxi)], [0 1]);
xlim([min(ParToTune) max(ParToTune)]);
xlabel('Parameter ($h_0$)','Interpreter','latex');
title(['$I_{\textup{KDE}}$, optimum at $h_0= ' num2str(ParToTune(maxi)) '$'],'Interpreter','latex');

ylabel('Area Under Power Curve','Interpreter','latex');
set(h, 'Position', [800 920 300 250])
set(h,'PaperSize',[8 7],'PaperPositionMode','auto');
saveas(h,'TuneIkde','pdf');
