clear;
close all;
clc;

% Experiment proposed in Section 5.2: Equitability

% presaved
load('resultsEquitability');


% Relationship names
rowNames = cell(1,ntypes);

h = figure;hold on;
subplot(6,3,1);
for typ=1:ntypes
    plot(valr2(typ,:),valmi_e(typ,:),'k-','MarkerSize',2);
grid on; hold on; title('$I_{\textup{ew}}$','interpreter','latex');
end
subplot(6,3,2);
for typ=1:ntypes
    plot(valr2(typ,:),valmi_ef(typ,:),'k--','MarkerSize',2);    
grid on; hold on; title('$I_{\textup{ef}}$','interpreter','latex');
end
subplot(6,3,3);
for typ=1:ntypes
    plot(valr2(typ,:),valmi_cell(typ,:),'ks-','MarkerSize',2);    
grid on; hold on; title('$I_{A}$','interpreter','latex');
end
subplot(6,3,4);
for typ=1:ntypes
    plot(valr2(typ,:),valmi_kde(typ,:),'kx-','MarkerSize',2);        
grid on; hold on; title('$I_{\textup{KDE}}$','interpreter','latex');
end
subplot(6,3,5);
for typ=1:ntypes
    plot(valr2(typ,:),valmi_k(typ,:),'ko-','MarkerSize',2);
grid on; hold on; title('$I_{k\textup{NN}}$','interpreter','latex');
end
subplot(6,3,6);
for typ=1:ntypes   
    plot(valr2(typ,:),valmi_mean(typ,:),'ro-','MarkerSize',2); 
grid on; hold on; title('$I_{\textup{mean}}$','interpreter','latex');
end
subplot(6,3,7);
for typ=1:ntypes   
    plot(valr2(typ,:),valcor(typ,:),'xb-','MarkerSize',2);   
grid on; hold on; title('$r^2$','interpreter','latex');
end
subplot(6,3,8);
for typ=1:ntypes 
    plot(valr2(typ,:),valdcor(typ,:),'go-','MarkerSize',2);  
grid on; hold on; title('dCorr','interpreter','latex');
end
subplot(6,3,9);
for typ=1:ntypes  
    plot(valr2(typ,:),valrdc(typ,:),'b>-','MarkerSize',2); 
grid on; hold on; title('RDC','interpreter','latex');
end
subplot(6,3,10);
for typ=1:ntypes   
    plot(valr2(typ,:),valace(typ,:),'bo-','MarkerSize',2);  
grid on; hold on; title('ACE','interpreter','latex');
end
subplot(6,3,11);
for typ=1:ntypes  
    plot(valr2(typ,:),valhsic(typ,:),'g>-','MarkerSize',2);  
grid on; hold on; title('HSIC','interpreter','latex');
end
subplot(6,3,12);
for typ=1:ntypes  
    plot(valr2(typ,:),valmid(typ,:),'>--','Color',[1 .5 0],'MarkerSize',2);    
grid on; hold on; title('MID','interpreter','latex');
end
subplot(6,3,13);
for typ=1:ntypes
    plot(valr2(typ,:),valmine(typ,:),'rv-','MarkerSize',2); 
grid on; hold on; title('MIC','interpreter','latex');
end
subplot(6,3,14);
for typ=1:ntypes   
    plot(valr2(typ,:),valgmic(typ,:),'<-','Color',[1 .1 1],'MarkerSize',2); 
grid on; hold on; title('GMIC','interpreter','latex');
end
subplot(6,3,15);
for typ=1:ntypes 
    plot(valr2(typ,:),valtice(typ,:),'s-','Color',[.6 .1 .6],'MarkerSize',2);
grid on; hold on; title('TIC$_e$','interpreter','latex');
end
subplot(6,3,16);
for typ=1:ntypes  
    plot(valr2(typ,:),valmice(typ,:),'rs-','MarkerSize',2);   
grid on; hold on; title('MIC$_e$','interpreter','latex');
end
subplot(6,3,17);
for typ=1:ntypes  
    plot(valr2(typ,:),valric(typ,:),'k-','LineWidth',2);   
grid on; hold on; title('RIC','interpreter','latex');
end    
 

%vars = {'$I_{\textup{ew}}$','$I_{\textup{ef}}$','$I_{\textup{A}}$','$I_{\textup{KDE}}$','$I_{\textup{kNN}}$',...
%        '$I_{\textup{mean}}$','$r^2$','dCorr','RDC','ACE','HSIC','MID','MIC','GMIC','TIC$_e$',...        
%        'RIC'};

%leg = legend(vars);
%set(leg,'Position',[0.5 -0.07 .01 .2],'Interpreter','latex','Orientation','Horizontal');
set(h, 'Position', [100 100 500 1100])
set(h,'PaperSize',[4.2 10],'PaperPositionMode','auto');
saveas(h,'resultsEquitability.pdf');

% Plot worst equitability for every measure

resr2 = 0.02;
Dvalr2 = floor(valr2/resr2) + 1;
nb = 30;
pconst = 100; % to avoid cell =0

maa = max(max(valmi_e));
mii = min(min(valmi_e));
Dval = floor(valmi_e/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(1) = max(rightI - leftI)*resr2;

maa = max(max(valmi_ef));
mii = min(min(valmi_ef));
Dval = floor(valmi_ef/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(2) = max(rightI - leftI)*resr2;

maa = max(max(valmi_cell));
mii = min(min(valmi_cell));
Dval = floor(valmi_cell/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(3) = max(rightI - leftI)*resr2;

maa = max(max(valmi_kde));
mii = min(min(valmi_kde));
Dval = floor(valmi_kde/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(4) = max(rightI - leftI)*resr2;

maa = max(max(valmi_k));
mii = min(min(valmi_k));
Dval = floor(valmi_k/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(5) = max(rightI - leftI)*resr2;

valmi_mean = real(valmi_mean); % glitch
maa = max(max(valmi_mean));
mii = min(min(valmi_mean));
Dval = floor(valmi_mean/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(6) = max(rightI - leftI)*resr2;

maa = max(max(valcor));
mii = min(min(valcor));
Dval = floor(valcor/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(7) = max(rightI - leftI)*resr2;

maa = max(max(valdcor));
mii = min(min(valdcor));
Dval = floor(valdcor/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(8) = max(rightI - leftI)*resr2;

maa = max(max(valrdc));
mii = min(min(valrdc));
Dval = floor(valrdc/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(9) = max(rightI - leftI)*resr2;

maa = max(max(valace));
mii = min(min(valace));
Dval = floor(valace/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(10) = max(rightI - leftI)*resr2;

maa = max(max(valhsic));
mii = min(min(valhsic));
Dval = floor(valhsic/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(11) = max(rightI - leftI)*resr2;

maa = max(max(valmid));
mii = min(min(valmid));
Dval = floor(valmid/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(12) = max(rightI - leftI)*resr2;

maa = max(max(valmine));
mii = min(min(valmine));
Dval = floor(valmine/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(13) = max(rightI - leftI)*resr2;

maa = max(max(valgmic));
mii = min(min(valgmic));
Dval = floor(valgmic/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(14) = max(rightI - leftI)*resr2;

maa = max(max(valtice));
mii = min(min(valtice));
Dval = floor(valtice/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(15) = max(rightI - leftI)*resr2;

maa = max(max(valmice));
mii = min(min(valmice));
Dval = floor(valmice/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(16) = max(rightI - leftI)*resr2;

maa = max(max(valric));
mii = min(min(valric));
Dval = floor(valric/(maa - mii)*nb) + pconst;
cont = Contingency(Dvalr2(:),Dval(:));
cont0 = cont > 0;
% Find first element not 0
[mmm,leftI] = max(cont0);
% find last element not 0
[mmm,rightI] = max(flipud(cont0));
rightI = size(cont0,1) - rightI;
% worst spread
D(17) = max(rightI - leftI)*resr2;

[D, indD] = sort(D,'ascend');
Dnames = {'$I_{\textup{ew}}$','$I_{\textup{ef}}$','$I_{\textup{A}}$','$I_{\textup{KDE}}$','$I_{\textup{kNN}}$',...
        '$I_{\textup{mean}}$','$r^2$','dCorr','RDC','ACE','HSIC','MID','MIC','GMIC','TIC$_e$','MIC$_e$',...        
        'RIC'};
Dnames = Dnames(indD);


h = figure(3);
b=bar(1:length(Dnames),D,'w');
hold on;

set(gca,'YGrid','on')  % horizontal grid
xlim([0 18  ]); 
ylim([0 max(D)+0.1]);

set(0,'DefaultTextInterpreter', 'latex');
set(gca,'XTick',(1:17));
set(gca,'XTickLabel',Dnames);
format_ticks(gca,' ');
ylabel('Worst Case Equitability','Interpreter','latex');

set(h, 'Position', [800 920 840 290])
set(h,'PaperSize',[19.5 7.5],'PaperPositionMode','auto');
saveas(h,'HistEquitability','pdf');

disp('Done.');