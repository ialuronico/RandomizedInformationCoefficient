clear;
close all;
clc;

% Used after running computePowerMulti.m
% it saves a file like resultsPowerMulti.mat
%load('resultsPowerMulti');

% Used these pre saved results 
load('resultsPowerMultiPreSaved');

% Relationship names
rowNames = cell(1,ntypes);

% There might some glitches
valmi_mean = real(valmi_mean);
valmi_mean2 = real(valmi_mean2);

for typ=1:ntypes
    parfor l=1:numnoise
        ric(typ,l)= powerCont(valric(typ,l,:),valric2(typ, l,:));
        dcor(typ,l)= powerCont(valdcor(typ,l,:),valdcor2(typ, l,:));
        rdc(typ,l)= powerCont(valrdc(typ,l,:),valrdc2(typ, l,:));
        mi_k(typ,l)= powerCont(valmi_k(typ,l,:),valmi_k2(typ, l,:));
        mi_e(typ,l)= powerCont(valmi_e(typ,l,:),valmi_e2(typ, l,:));
        mi_ef(typ,l)= powerCont(valmi_ef(typ,l,:),valmi_ef2(typ, l,:));
        mi_kde(typ,l)= powerCont(valmi_kde(typ,l,:),valmi_kde2(typ, l,:));
        mi_kmeans(typ,l)= powerCont(valmi_kmeans(typ,l,:),valmi_kmeans2(typ, l,:));
        mimean(typ,l)= powerCont(valmi_mean(typ,l,:),valmi_mean2(typ, l,:));
        hsic(typ,l)= powerCont(valhsic(typ,l,:),valhsic2(typ, l,:));
    end
end

h = figure;hold on;
for typ=1:ntypes
    subplot(4,3,typ);hold on;        
    plot((1:numnoise),mi_e(typ,:),'k-','MarkerSize',4);    
    plot((1:numnoise),mi_ef(typ,:),'k--','MarkerSize',4);    
    plot((1:numnoise),mi_kmeans(typ,:),'k*-','MarkerSize',4);    
    plot((1:numnoise),mi_kde(typ,:),'kx-','MarkerSize',4);    
    plot((1:numnoise),mi_k(typ,:),'ko-','MarkerSize',4);   
    plot((1:numnoise),mimean(typ,:),'ro-','MarkerSize',4);    
    plot((1:numnoise),dcor(typ,:),'go-','MarkerSize',4);    
    plot((1:numnoise),rdc(typ,:),'b>-','MarkerSize',4);    
    plot((1:numnoise),hsic(typ,:),'g>-','MarkerSize',4);   
    plot((1:numnoise),ric(typ,:),'k-','LineWidth',2)    

    grid on;    
    ylim([0 1]);
    
    if (typ > 9); xlabel('Noise Lev.','Interpreter','latex'); end;
    if (mod(typ,3) == 1); ylabel('Power','Interpreter','latex'); end;
    
    % Just to get the relationship name
    x = rand(1,500);
    [y,name] = gen_fun(x,500,0,0,numnoise,typ);
    title([name ' $p = ' num2str(p) '$'],'Interpreter','latex');    
    rowNames{typ} = name;    
end

vars = {'$I_{\textup{ew}}$','$I_{\textup{ef}}$','$I_{k-\textup{means}}$','$I_{\textup{KDE}}$','$I_{\textup{kNN}}$',...
        '$I_{\textup{mean}}$','dCorr','RDC','HSIC',...
        'RIC'};
leg = legend(vars);
set(leg,'Position',[0.5 -0.07 .01 .2],'Interpreter','latex','Orientation','Horizontal');
set(h, 'Position', [600 650 1770 920])
set(h,'PaperSize',[40 24],'PaperPositionMode','auto');
saveas(h,'resultsPowerMulti.pdf');

% Average results across relationships

hS = figure;
hold on;
grid on;
plot((1:numnoise),mean(mi_e),'k-','MarkerSize',4);    
plot((1:numnoise),mean(mi_ef),'k--','MarkerSize',4);    
plot((1:numnoise),mean(mi_kmeans),'k*-','MarkerSize',4);    
plot((1:numnoise),mean(mi_kde),'kx-','MarkerSize',4);    
plot((1:numnoise),mean(mi_k),'ko-','MarkerSize',4);    
plot((1:numnoise),mean(mimean),'ro-','MarkerSize',4);   
plot((1:numnoise),mean(dcor),'go-','MarkerSize',4);    
plot((1:numnoise),mean(rdc),'b>-','MarkerSize',4);    
plot((1:numnoise),mean(hsic),'g>-','MarkerSize',4);
plot((1:numnoise),mean(ric),'k-','LineWidth',2);    
ylabel('Power','Interpreter','latex');
xlabel('Noise Lev.','Interpreter','latex');

leg = legend(vars);
set(leg,'Interpreter','latex');
set(leg,'Position',[0.7 0.3 .17 .4]);
set(hS, 'Position', [800 850 700 340])
set(hS,'PaperSize',[16.5 8.8],'PaperPositionMode','auto');
saveas(hS,'resultsPowerMultiAverage.pdf');

% Plots the histogram

AllVals = [mean(mi_e,2),...
mean(mi_ef,2),...
mean(mi_kmeans,2),...
mean(mi_kde,2),...
mean(mi_k,2),...
mean(mimean,2),...
mean(dcor,2),...
mean(rdc,2),...
mean(hsic,2),...
mean(ric,2)
]; 


[p, tbl, stats ] = friedman(1-AllVals,1,'off');
D = stats.meanranks;

[D, indD] = sort(D,'ascend');
Dnames = vars;
Dnames = Dnames(indD);


h = figure(3);
b=bar(1:length(Dnames),D,'w');
hold on;

set(gca,'YGrid','on')  % horizontal grid
xlim([0 11]); 
ylim([0 max(D)+0.5]);

set(0,'DefaultTextInterpreter', 'latex');
set(gca,'XTickLabel',Dnames);
format_ticks(gca,' ');
ylabel('Average Rank - Power','Interpreter','latex');

set(h, 'Position', [800 920 840 290])
set(h,'PaperSize',[19.5 7.5],'PaperPositionMode','auto');
saveas(h,'HistPerfPowerMulti','pdf');


disp('Done.');