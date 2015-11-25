clear;
close all;
clc;

% Experiment proposed in Section 5.2: 
% Application of Network Inference 
%
% The code should be able to run on 64bit Linux systems. If you use another
% system you might need to compile some of the dependency measures.
%
% Also, it uses parfor in Matlab.


disp('Running MIDER...'); 
tic;

% Input data file:
datafiles = {'b1_glycolysis',...
             'b2_enzyme_cat_chain',...
             'b3_small_chain',...
             'b4_irma_on_off',...
             'b5_mapk','b6_dream4_10_1',...
             'b7_dream4_100_1',...                                  
             'b10_synTren1',...
             'b11_synTren1_small',...
             'synTren_dag'};

% Number of Bootstrap repetitions
times =  50;

% Which measures
measures = {...
            'Imean',...
            'GMIC',...
            'HSIC',...
            'ACE',...
            'EF',...
            'EI',...
            'Iadap',...
            'MI-KDE',...
            'MI-KNN',...
            'corr',...
            'dCorr',...
            'RDC',...
            'MIC',...
            'MID',...       
            'TICe',...
            'RIC'...
            };

for mm=1:length(measures)

mea = measures{mm};
disp(['Dependency Measure: ' mea]);

% Maximum time lag considered (> 0):
options.taumax = 3;

res = zeros(length(datafiles),times);          
% Many bootstrap repetition for significance test
for t=1:times        
        disp(['Times = ' num2str(t) ]);
        for fil=1:length(datafiles)
            datafile = datafiles{fil};
            disp(datafile);

            load(datafile); 
            npoints = size(x,1); % number of data points
            ntotal  = size(x,2); % number of variables
            
            % Resample the data points with replacement
            resampled = randi(npoints,npoints,1);
            x = x(resampled,:);

            %disp(options);
            Output = miderChooseMea(x,options,mea);

            % Load ground truth
            load([datafile '_true.mat']);

            
            labelList = zeros(1,Output.npairs);
            % Label the true positives
            for i=1:Output.npairs
              edge = Output.edgeList(i);
              found = ~isempty(find(trueEdgeList == edge, 1));
              labelList(i) = found;
            end
            % not the 0 dist
            notzero = Output.distList > 0;
            [~,~,~,AP] = precisionRecall(Output.distList(notzero), labelList(notzero));
            res(fil,t) = AP;
        end
end

% Save result for each measure in a separate file
save(['results/' mea],'res');
end

toc;