clear;
close all;
clc;

% Code to plot noiseless relationships between two variables

ntypes = 12;
rowNames = cell(1,ntypes);
numnoise = 30;
n = 320;

h2 = figure;
for typ=1:ntypes
    subplot(4,3,typ);hold on;  
    x = rand(1,n);
    [y,name] = gen_fun(x,n,0,0,numnoise,typ);
    title(name,'Interpreter','latex');
    plot(x,y,'.','LineWidth', 0.1);    
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
    grid on;
end

set(h2, 'Position', [800 850 580 720])
set(h2,'PaperSize',[14.5 17],'PaperPositionMode','auto');
saveas(h2,'FigExRel','pdf');
