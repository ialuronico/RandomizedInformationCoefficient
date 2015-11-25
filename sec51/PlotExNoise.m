clear all;
close all;
clc;

% Code to plot relationships with different amount of noise
% Additive noise and White noise

h1 = figure;
noises = (1:5:30);
numnoise = 30;

typ = 1; % choose just one relationship (1 = linear)
n = 320;

for i=1:length(noises)
    l = noises(i);
    subplot(6,1,i);hold on;  
    x = rand(1,n);
    [y,name] = gen_fun(x,n,3,l,numnoise,typ);
    title(['Noise Lev. ' num2str(l)],'Interpreter','latex');
    plot(x,y,'.','LineWidth', 0.1);    
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
    grid on;
end

set(h1, 'Position', [800 850 90 720])
set(h1,'PaperSize',[3 17],'PaperPositionMode','auto');
saveas(h1,'FigExAdd','pdf');

h2 = figure;
for i=1:length(noises)
    l = noises(i);
    subplot(6,1,i);hold on;  
    x = rand(1,n);
    [y,name] = gen_fun_white(x,n,l,numnoise,typ);
    title(['Noise Lev. ' num2str(l)],'Interpreter','latex');
    plot(x,y,'.','LineWidth', 0.1);    
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
    grid on;
end

set(h2, 'Position', [800 850 90 720])
set(h2,'PaperSize',[3 17],'PaperPositionMode','auto');
saveas(h2,'FigExWhite','pdf');
disp('Done.');

