clear all;
close all;
clc;

load('varRIC');

h = figure;
for i=1:length(ns)
  n = ns(i);
  varRICforN = std(RIC_Kr_n(:,:,i)).^2;
  plot(Krs,varRICforN,'k-','linewidth',2);
  xp = 60;
  yp = varRICforN(length(Krs)) + 0.00018;
  strp = ['$n = ' num2str(n) '$'];
  text(xp,yp,strp,'HorizontalAlignment','right','Interpreter','latex')  
  hold on;
  grid on;
end 
xlim([2 Krs(length(Krs))]);
title('Var(RIC)','interpreter','latex');
xlabel('$K_r$','interpreter','latex');

set(h, 'Position', [800 850 580 180])
set(h,'PaperSize',[13 4.8],'PaperPositionMode','auto');
saveas(h,'plotVarRIC','pdf');