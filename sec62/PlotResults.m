close all;
clear;clc;

% Run test_multi before
%folder = './results/';
% pre saved results from the paper 
folder = './resultsPresaved/';

maxFeature = 10; % Select the same number as the experiment

n = 1;
nameToPlot{n} = 'pyrim'; n = n + 1;
nameToPlot{n} = 'bodyfat'; n = n + 1;
nameToPlot{n} = 'triazines'; n = n + 1;
nameToPlot{n} = 'wisconsin'; n = n + 1;
nameToPlot{n} = 'crime'; n = n + 1;
nameToPlot{n} = 'pole'; n = n + 1;
nameToPlot{n} = 'QSAR'; n = n + 1;
nameToPlot{n} = 'QSAR2'; n = n + 1;

totDS = length(nameToPlot);

totRIC = [];
totRDC = [];
totMI_K = [];
totMI_e = [];
totMI_ef = [];
totMI_kmeans = [];
totMI_kde = [];
totDcor = [];
totHSIC = [];
totImean = [];


%cellTable = cell(length(nameToPlot));
cellTable = {'$I_{\textup{ew}}$','$I_{\textup{ef}}$','$I_{k-\textup{means}}$','$I_{\textup{KDE}}$','$I_{\textup{kNN}}$','$I_{\textup{mean}}$','dCorr','RDC','HSIC','RIC'};
for myF=1:length(nameToPlot)
    name = nameToPlot{myF};    
    load([folder name]);
    %disp(name);
    
    CV_mea = CV_MI_e;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{1} = [cellTable{1} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
    
    CV_mea = CV_MI_ef;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{2} = [cellTable{2} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
    
    CV_mea = CV_MI_kmeans;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{3} = [cellTable{3} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
    
    CV_mea = CV_MI_kde;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{4} = [cellTable{4} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
    
    CV_mea = CV_MI_K;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{5} = [cellTable{5} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
    
    CV_mea = CV_MI_mean;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{6} = [cellTable{6} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
        
    CV_mea = CV_Dcor;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{7} = [cellTable{7} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
    
    CV_mea = CV_RDC;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{8} = [cellTable{8} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
    
    CV_mea = CV_HSIC;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{9} = [cellTable{9} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') pSt];  
        
    CV_mea = CV_RIC;
    mu = mean(mean(CV_mea));
    sigma = std(mean(CV_mea));
    [~, p] = ttest(CV_mea(:), CV_RIC(:),'tail','left');  
    if(p < 0.05)
        pSt = '$(-)$';
    elseif (p > 0.95)
        pSt = '$(+)$';
    else
        pSt = '$(=)$';
    end
    cellTable{10} = [cellTable{10} ' &' num2str(mu,'%1.3f') '$\pm$' num2str(sigma,'%1.3f') ];  
        

    totImean = [totImean mean(CV_MI_mean(:))];
    totHSIC = [totHSIC mean(CV_HSIC(:))];
    totRIC = [totRIC mean(CV_RIC(:))];
    totRDC = [totRDC mean(CV_RDC(:))];
    totMI_K = [totMI_K mean(CV_MI_K(:))];
    totMI_e = [totMI_e mean(CV_MI_e(:))];
    totMI_ef = [totMI_ef mean(CV_MI_ef(:))];
    totMI_kmeans = [totMI_kmeans mean(CV_MI_kmeans(:))];
    totMI_kde = [totMI_kde mean(CV_MI_kde(:))];
    totDcor = [totDcor mean(CV_Dcor(:))];

end


s = [];
for i=1:length(nameToPlot)
    s = [s ' &' capitalize(lower(nameToPlot{i}))];
end
disp([s ' \\']);

[n m ] = size(cellTable);
for j=1:m
    st = sprintf('%s', cellTable{j});
    disp([st ' \\']);
end


% Print histogram

vars = {'$I_{\textup{ew}}$','$I_{\textup{ef}}$','$I_{k-\textup{means}}$','$I_{\textup{KDE}}$','$I_{\textup{kNN}}$','$I_{\textup{mean}}$','dCorr','RDC','HSIC','RIC'};

AllVals = [totMI_e(:)';
totMI_ef(:)';
totMI_kmeans(:)';
totMI_kde(:)';
totMI_K(:)';
totImean(:)';
totDcor(:)';  
totRDC(:)';
totHSIC(:)'; 
totRIC(:)'
];

[p, tbl, stats ] = friedman(1-AllVals',1,'off');
D = stats.meanranks;  

[D, indD] = sort(D,'ascend');
Dnames = vars;
Dnames = Dnames(indD);

h = figure(3);
b=bar(1:length(vars),D,'w');   %  bar plot
hold on;
%errorbar(1:length(vars),D,S,'k.');

set(gca,'YGrid','on')  % horizontal grid
xlim([0 11]); 
ylim([0 max(D)+0.5]);

set(0, 'defaultTextInterpreter', 'latex');
set(gca,'XTickLabel',Dnames)
format_ticks(gca,' ');
ylabel('Average Rank - Correlation Coefficient','Interpreter','latex');


set(h, 'Position', [800 920 840 290])
set(h,'PaperSize',[19.5 7.5],'PaperPositionMode','auto');
%set(h,'PaperOrientation','landscape');
saveas(h,'HistSub','pdf');