close all;
clear all;
clc;

load 'timeRIC';

hS = figure;

toPlotTimeRIC = mean(toPlotTimeRIC,3);
for j=1:length(c_s)
  c = c_s(j);
  plot(Kr_s,toPlotTimeRIC','k-','linewidth',2);
  xp = Kr_s(length(Kr_s)) - 3;
  yp = toPlotTimeRIC(j,length(Kr_s)) + 0.03;
  strp = ['$c = ' num2str(c) '$'];
  text(xp,yp,strp,'HorizontalAlignment','right','Interpreter','latex')
  hold on;
end
grid on;
ylabel('Seconds','interpreter','latex');
xlabel('$K_r$','interpreter','latex');

set(hS, 'Position', [800 850 200 340])
set(hS,'PaperSize',[5.5 9],'PaperPositionMode','auto');
saveas(hS,'TimeRIC.pdf','pdf');