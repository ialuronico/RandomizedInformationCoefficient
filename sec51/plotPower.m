clear;
close all;
clc;

% Experiment proposed in Section 5.1: Identification of Noisy
% Relationships. Based on [Simon and Tibshirani 2011]'s code for power
% analysis of different dependency measures.
%
% Used after running computePower.m
% it saves a file like resultsPower.mat
%load('resultsPower');

% presaved
% Experiments on White noise
%load('resultsPowerWhite'); 
% Experiments on Additive noise
load('resultsPowerAdditive');

% Relationship names
rowNames = cell(1,ntypes);

% There might some glitches
valmi_mean = real(valmi_mean);
valmi_mean2 = real(valmi_mean2);
valace = real(valace);
valace2 = real(valace2);


for typ=1:ntypes
    parfor l=1:numnoise
        ric(typ,l)= powerCont(valric(typ,l,:),valric2(typ, l,:));
        cor(typ,l) = powerCont(valcor(typ,l,:),valcor2(typ,l,:));
        dcor(typ,l)= powerCont(valdcor(typ,l,:),valdcor2(typ, l,:));
        mine(typ,l)= powerCont(valmine(typ,l,:),valmine2(typ, l,:));
        rdc(typ,l)= powerCont(valrdc(typ,l,:),valrdc2(typ, l,:));
        mid(typ,l)= powerCont(valmid(typ,l,:),valmid2(typ, l,:));
        mi_k(typ,l)= powerCont(valmi_k(typ,l,:),valmi_k2(typ, l,:));
        mi_e(typ,l)= powerCont(valmi_e(typ,l,:),valmi_e2(typ, l,:));
        mi_ef(typ,l)= powerCont(valmi_ef(typ,l,:),valmi_ef2(typ, l,:));
        mi_kde(typ,l)= powerCont(valmi_kde(typ,l,:),valmi_kde2(typ, l,:));
        mi_cell(typ,l)= powerCont(valmi_cell(typ,l,:),valmi_cell2(typ, l,:));
        gmic(typ,l)= powerCont(valgmic(typ,l,:),valgmic2(typ, l,:));
        mimean(typ,l)= powerCont(valmi_mean(typ,l,:),valmi_mean2(typ, l,:));
        hsic(typ,l)= powerCont(valhsic(typ,l,:),valhsic2(typ, l,:));
        ace(typ,l)= powerCont(valace(typ,l,:),valace2(typ, l,:));
        tice(typ,l)= powerCont(valtice(typ,l,:),valtice2(typ, l,:));
    end
end

h = figure;hold on;
for typ=1:ntypes
    subplot(4,3,typ);hold on;        
    plot((1:numnoise),mi_e(typ,:),'k-','MarkerSize',4);    
    plot((1:numnoise),mi_ef(typ,:),'k--','MarkerSize',4);    
    plot((1:numnoise),mi_cell(typ,:),'ks-','MarkerSize',4);    
    plot((1:numnoise),mi_kde(typ,:),'kx-','MarkerSize',4);    
    plot((1:numnoise),mi_k(typ,:),'ko-','MarkerSize',4);   
    plot((1:numnoise),mimean(typ,:),'ro-','MarkerSize',4);    
    plot((1:numnoise),cor(typ,:),'x-','MarkerSize',4);    
    plot((1:numnoise),dcor(typ,:),'go-','MarkerSize',4);    
    plot((1:numnoise),rdc(typ,:),'b>-','MarkerSize',4);    
    plot((1:numnoise),ace(typ,:),'bo-','MarkerSize',4);    
    plot((1:numnoise),hsic(typ,:),'g>-','MarkerSize',4);    
    plot((1:numnoise),mid(typ,:),'>--','Color',[1 .5 0],'MarkerSize',4);    
    plot((1:numnoise),mine(typ,:),'rv-','MarkerSize',4);    
    plot((1:numnoise),gmic(typ,:),'<-','Color',[1 .1 1],'MarkerSize',4);  
    plot((1:numnoise),tice(typ,:),'s-','Color',[.6 .1 .6],'MarkerSize',4);  
    plot((1:numnoise),ric(typ,:),'k-','LineWidth',2)    

    grid on;
    
    
    if (typ > 9); xlabel('Noise Lev.','Interpreter','latex'); end;
    if (mod(typ,3) == 1); ylabel('Power','Interpreter','latex'); end;
    
    % Just to get the relationship name
    x = rand(1,500);
    [y,name] = gen_fun(x,500,0,0,numnoise,typ);
    title(name,'Interpreter','latex');    
    rowNames{typ} = name;    
end

vars = {'$I_{\textup{ew}}$','$I_{\textup{ef}}$','$I_{\textup{A}}$','$I_{\textup{KDE}}$','$I_{\textup{kNN}}$',...
        '$I_{\textup{mean}}$','$r^2$','dCorr','RDC','ACE','HSIC','MID','MIC','GMIC','TIC$_e$',...        
        'RIC'};
leg = legend(vars);
set(leg,'Position',[0.5 -0.07 .01 .2],'Interpreter','latex','Orientation','Horizontal');
set(h, 'Position', [600 650 1770 920])
set(h,'PaperSize',[40 24],'PaperPositionMode','auto');
saveas(h,'resultsPower.pdf');

% Average results across relationships

hS = figure;
hold on;
grid on;
plot((1:numnoise),mean(mi_e),'k-','MarkerSize',4);    
plot((1:numnoise),mean(mi_ef),'k--','MarkerSize',4);    
plot((1:numnoise),mean(mi_cell),'ks-','MarkerSize',4);    
plot((1:numnoise),mean(mi_kde),'kx-','MarkerSize',4);    
plot((1:numnoise),mean(mi_k),'ko-','MarkerSize',4);    
plot((1:numnoise),mean(mimean),'ro-','MarkerSize',4);   
plot((1:numnoise),mean(cor),'x-','MarkerSize',4);           
plot((1:numnoise),mean(dcor),'go-','MarkerSize',4);    
plot((1:numnoise),mean(rdc),'b>-','MarkerSize',4);    
plot((1:numnoise),mean(ace),'bo-','MarkerSize',4);    
plot((1:numnoise),mean(hsic),'g>-','MarkerSize',4);
plot((1:numnoise),mean(mid),'>--','Color',[1 .5 0],'MarkerSize',4);    
plot((1:numnoise),mean(mine),'rv-','MarkerSize',4); 
plot((1:numnoise),mean(gmic),'<-','Color',[1 .1 1],'MarkerSize',4);     
plot((1:numnoise),mean(tice),'s-','Color',[.6 .1 .6],'MarkerSize',4);  
plot((1:numnoise),mean(ric),'k-','LineWidth',2);    
ylabel('Power','Interpreter','latex');
xlabel('Noise Lev.','Interpreter','latex');

leg = legend(vars);
set(leg,'Interpreter','latex');
set(leg,'Position',[0.7 0.3 .17 .4]);
set(hS, 'Position', [800 850 700 340])
set(hS,'PaperSize',[16.5 8.8],'PaperPositionMode','auto');
saveas(hS,'resultsPowerAverage.pdf');

% Plots the histogram of average ranking

AllVals = [mean(mi_e,2),...
mean(mi_ef,2),...
mean(mi_cell,2),...
mean(mi_kde,2),...
mean(mi_k,2),...
mean(mimean,2),...
mean(cor,2),...
mean(dcor,2),...
mean(rdc,2),...
mean(ace,2),...
mean(hsic,2),...
mean(mid,2),...
mean(mine,2),...
mean(gmic,2),...
mean(tice,2),...
mean(ric,2)
]; 

[p, tbl, stats ] = friedman(1 - AllVals,1,'off');
D = stats.meanranks;

[D, indD] = sort(D,'ascend');
Dnames = {'$I_{\textup{ew}}$','$I_{\textup{ef}}$','$I_{\textup{A}}$','$I_{\textup{KDE}}$','$I_{\textup{kNN}}$',...
        '$I_{\textup{mean}}$','$r^2$','dCorr','RDC','ACE','HSIC','MID','MIC','GMIC','TIC$_e$',...        
        'RIC'};
Dnames = Dnames(indD);


h = figure(3);
b=bar(1:length(Dnames),D,'w');
hold on;

set(gca,'YGrid','on')  % horizontal grid
xlim([0 17]); 
ylim([0 max(D)+0.5]);

set(0,'DefaultTextInterpreter', 'latex');
set(gca,'XTick',(1:16));
set(gca,'XTickLabel',Dnames);
format_ticks(gca,' ');
ylabel('Average Rank - Power','Interpreter','latex');

set(h, 'Position', [800 920 840 290])
set(h,'PaperSize',[19 7.5],'PaperPositionMode','auto');
saveas(h,'HistPerfPower','pdf');

disp('Done.');