clear;
close all;
clc;

% Use After runMIDERmultiMeausures.m
% It compare the mAP (Mean Average Precision) with t-tests and 
% Wilcoxon signed rank test

% results will be saved in the folder ./results/
% so see some pre-saved experiment with 
% 50 bootstrap repetitions use ./resultsPreSaved/

folderName = 'resultsPreSaved/';
%folderName = 'results/';
files = dir([ folderName '*.mat']);
whichData = [1 2 3 4 5 6 7 8 9 10]; % test on all datasets
times = 50; % number of bootstrap repetitions used

toDisp = [];
allPerf = {};

% get RIC results to compute t-test
load([folderName 'RIC']);
resRIC = res(whichData,:);
clear res;    

forBoxPlot = [];
methodNames = {};
cellTable = cell(length(files),1+length(whichData));

i = 1;
for file = files'
    load([folderName file.name]);
    
    res = res(whichData,:);
       
    %disp(sprintf('%s  \n',file.name));
    
    [h p] = ttest(res', resRIC','tail','left');  
    
    % statistical significance level alpha = 0.05
    for u=1:length(p');
       locP = p(u);
       if(locP < 0.05)
           pSt{u} = '$(-)$';
       elseif (locP > 0.95)
           pSt{u} = '$(+)$';
       else
           pSt{u} = '$(=)$';
       end
    end
    
    allMean = mean(res,2);
    allStd = (std(res')');
    
    toDisp = [toDisp allMean allStd p'];
    
    cellTable{i,1} = file.name;
    for j=1:length(whichData)
        ds = whichData(j);
        cellTable{i,j+1} = [num2str(allMean(j),'%2.1f') '$\pm$' num2str(allStd(j),'%2.1f') pSt{j}];
    end
       
    allPerf{i} = res(:);
       
    methodNames = [methodNames, file.name];
    i = i + 1;
    clear res;
end
meanVal = mean(toDisp);


figure;
whichOnes = (1:3:length(files)*3);

Frank = [];
for i=1:length(allPerf)
  Frank = [ Frank mean(reshape(allPerf{i},[length(whichData) times]),2)];
end
 
[p, tbl, stats ] = friedman(100-Frank,1,'off');
D = stats.meanranks;  

[D, indD] = sort(D,'ascend');

Dnames = methodNames;
Dnames = Dnames(indD);


h = figure(1);
b=bar(1:length(files),D,'w');   %  bar plot
hold on;
%S=errorbar(1:length(files),D,S,'k.');

set(gca,'YGrid','on')  % horizontal grid

xlim([0 17]);
ylim([min(D)-2 max(D)+0.5]);

set(0, 'defaultTextInterpreter', 'latex');
set(gca,'XTick',(1:16)); % it has to be 1 less than xlim
% Substitutes the latex (but it has to be sorted first)
Dnames = {'RIC','dCorr','$I_{\textup{KDE}}$','$I_{\textup{kNN}}$','HSIC','ACE','MIC$_e$','$r^2$','GMIC','$I_{\textup{ef}}$','$I_{\textup{A}}$','RDC','$I_{\textup{ew}}$','$I_{\textup{mean}}$','MIC','MID'};
set(gca,'XTickLabel',Dnames);
format_ticks(gca,' ');
ylabel('Average Rank - Mean Average Precision','Interpreter','latex');

set(h, 'Position', [800 920 880 290])
set(h,'PaperSize',[20 7.5],'PaperPositionMode','auto');
saveas(h,'MAPnetworks','pdf');

% Disp latex table
[n m ] = size(cellTable);
for i=1:n
    st = sprintf('%s ', cellTable{i,1});
    for j=2:m
        st = [st sprintf('& %s ', cellTable{i,j})];
    end
    disp([st ' \\']);
end
