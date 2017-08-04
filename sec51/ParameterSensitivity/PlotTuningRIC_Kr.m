clear all;
close all;
clc;

n = 1000;

toLoad = [ './saved/testRICn' num2str(n)];

load(toLoad);

h = figure;

hold all;
plot(ParToTune,powerToPlot','k:');
plot(ParToTune,mean(powerToPlot),'k','Linewidth',2);
grid on;

[maxv maxi] = max(mean(powerToPlot));
%line([ParToTune(maxi) ParToTune(maxi)], [0 1]);
xlim([min(ParToTune) max(ParToTune)]);
xlabel('Parameter ($K_r$)','Interpreter','latex');
title(['RIC, optimum at $K_r= ' num2str(ParToTune(maxi)) '$'],'Interpreter','latex');

ylabel('Area Under Power Curve','Interpreter','latex');
set(h, 'Position', [800 920 300 250])
set(h,'PaperSize',[8 7],'PaperPositionMode','auto');
saveas(h,['TuneRICn' num2str(n)],'pdf');
