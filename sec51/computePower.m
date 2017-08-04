clear;
close all;
clc;

% Experiment proposed in Section 5.1: Identification of Noisy
% Relationships. Based on [Simon and Tibshirani 2011]'s code for power
% analysis of different dependency measures.
%
% Change the function that generates noise to change noise model.
%
% The code should be able to run on 64bit Linux systems. If you use another
% system you might need to compile some of the dependency measures.
%
% Also, it uses parfor in Matlab.

tic; % For Timing

nsim = 500; % Number of relatioships from the negative class (complete noise)
nsim2 = nsim;% Number of relationships from the positive clas (noisy relationships)

numnoise = 30; % The number of different noise levels used
noise = 3;  % A constant to determine the amount of noise. It is just another parameter 

n = 320; %320         % Number of data points per simulation

ntypes = 12; % The total number of relationship types

% Vectors holding the values of the statistics for the
% negative class

% Randomized Information Coefficient - RIC
valric=zeros(ntypes,numnoise,nsim);
% Pearson Correlation Squared - r^2
valcor=zeros(ntypes,numnoise,nsim);
% Distance Correlation - dCorr
valdcor=zeros(ntypes,numnoise,nsim);
% Maximal Information Coefficient  - MIC
valmine=zeros(ntypes,numnoise,nsim); 
% Randomized Dependency Coefficient - RDC
valrdc=zeros(ntypes,numnoise,nsim);
% Mutual Information Dimension - MID
valmid=zeros(ntypes,numnoise,nsim);
% Mutual Information (Krakov's Nearest Neighbour) 
valmi_k=zeros(ntypes,numnoise,nsim);
% Mutual Information (Discretization Equal-width)
valmi_e=zeros(ntypes,numnoise,nsim);
% Mutual Information (Discretization Equal-frequency)
valmi_ef=zeros(ntypes,numnoise,nsim);
% Mutual Information (Kernel Density Estimator)
valmi_kde=zeros(ntypes,numnoise,nsim);
% Mutual Information (Adaptive Partitioning)
valmi_cell=zeros(ntypes,numnoise,nsim);
% Generalized Mean Information Coefficient - GMIC
valgmic=zeros(ntypes,numnoise,nsim);
% Alternative Conditional Expectation - ACE
valace=zeros(ntypes,numnoise,nsim);
% Hilbert-Schmit Independece Criterion - HSIC
valhsic=zeros(ntypes,numnoise,nsim);
% Mutual Information (Mean Neareast Neighbour) 
valmi_mean=zeros(ntypes,numnoise,nsim);
% Total Information Coefficient - TIC_e
valtice=zeros(ntypes,numnoise,nsim);
% Total Information Coefficient - MIC_e
valmice=zeros(ntypes,numnoise,nsim);

% Vectors holding the values of the statistics for the
% positive class

valric2=zeros(ntypes,numnoise,nsim);
valcor2=zeros(ntypes,numnoise,nsim);
valdcor2=zeros(ntypes,numnoise,nsim);
valmine2=zeros(ntypes,numnoise,nsim);
valrdc2=zeros(ntypes,numnoise,nsim);
valmid2=zeros(ntypes,numnoise,nsim);
valmi_k2=zeros(ntypes,numnoise,nsim);
valmi_e2=zeros(ntypes,numnoise,nsim);
valmi_ef2=zeros(ntypes,numnoise,nsim);
valmi_kde2=zeros(ntypes,numnoise,nsim);
valmi_cell2=zeros(ntypes,numnoise,nsim);
valgmic2=zeros(ntypes,numnoise,nsim);
valmi_mean2=zeros(ntypes,numnoise,nsim);
valhsic2=zeros(ntypes,numnoise,nsim);
valace2=zeros(ntypes,numnoise,nsim);
valtice2=zeros(ntypes,numnoise,nsim);
valmice2=zeros(ntypes,numnoise,nsim);

% Loop through different noise levels
for l =1:numnoise    
    for typ = 1:ntypes
        fprintf('Level= %d, Rel.Typ.= %d \n',l,typ);
               
        %
        % Negative class
        %      
        
        parfor ii = 1:nsim
            x=rand(1,n); % X is generated uniformly in [0,1]
           
            % Function to generate different relationship types with
            % Additive Noise
            %y = gen_fun(x,n,noise,l,numnoise,typ);
            % White noise
            y = gen_fun_white(x,n,l,numnoise,typ);
            
            x = rand(1,n);  % Re-generate X to produce complete noise
            
            % Use this function with parameters optimized for 
            % power under Additive noise
            %[cor,dCor,MIC,RDC,RIC,MID,MI_k,MI_e,MI_ef,MI_kde,MI_cell,GMIC,MI_mean,HSIC,ACE,TICe,MICe]= computeStatisticsAdditive(x,y);
            % this functions for white noise
            [cor,dCor,MIC,RDC,RIC,MID,MI_k,MI_e,MI_ef,MI_kde,MI_cell,GMIC,MI_mean,HSIC,ACE,TICe,MICe]= computeStatisticsWhite(x,y);
                                  
            Vcor(ii)=cor ;  
            Vdcor(ii)=dCor;   
            Vmine(ii)=MIC;    
            Vrdc(ii)=RDC;
            Vric(ii)=RIC;            
            Vmid(ii)=MID;            
            Vmi_k(ii)=MI_k;            
            Vmi_e(ii)=MI_e;            
            Vmi_ef(ii)=MI_ef;
            Vmi_kde(ii)=MI_kde;                        
            Vmi_cell(ii)=MI_cell;
            Vgmic(ii)=GMIC;
            Vmi_mean(ii)=MI_mean;
            Vhsic(ii)=HSIC;
            Vace(ii)=ACE;
            Vtice(ii)=TICe;            
            Vmice(ii)=MICe;
            
        end % end - nsim
        
        % This just because of parfor
        valric(typ,l,:) = Vric;
        valcor(typ,l,:) = Vcor;
        valdcor(typ,l,:) = Vdcor;
        valmine(typ,l,:) = Vmine;
        valrdc(typ,l,:) = Vrdc;
        valmid(typ,l,:) = Vmid;
        valmi_k(typ,l,:) = Vmi_k;
        valmi_e(typ,l,:) = Vmi_e;
        valmi_ef(typ,l,:) = Vmi_ef;
        valmi_kde(typ,l,:) = Vmi_kde;
        valmi_cell(typ,l,:) = Vmi_cell;
        valgmic(typ,l,:) = Vgmic;
        valmi_mean(typ,l,:) = Vmi_mean;
        valhsic(typ,l,:) = Vhsic;
        valace(typ,l,:) = Vace;        
        valtice(typ,l,:) = Vtice;  
        valmice(typ,l,:) = Vmice;  
    
        %
        % Positive class
        %
      
        parfor ii = 1:nsim2
            x=rand(1,n);
            
            % Additive noise
            %y = gen_fun(x,n,noise,l,numnoise,typ);
            % White noise
            y = gen_fun_white(x,n,l,numnoise,typ);
                  
            % Use this function with parameters optimized for 
            % power under Additive noise
            %[cor,dCor,MIC,RDC,RIC,MID,MI_k,MI_e,MI_ef,MI_kde,MI_cell,GMIC,MI_mean,HSIC,ACE,TICe,MICe]= computeStatisticsAdditive(x,y);
            % this functions for white noise
            [cor,dCor,MIC,RDC,RIC,MID,MI_k,MI_e,MI_ef,MI_kde,MI_cell,GMIC,MI_mean,HSIC,ACE,TICe,MICe]= computeStatisticsWhite(x,y);
            
            Vric2(ii)=RIC;        
            Vcor2(ii)=cor;          
            Vdcor2(ii)=dCor ;   
            Vmine2(ii)=MIC;     
            Vrdc2(ii)=RDC;                    
            Vgmic2(ii)=GMIC;
            Vmid2(ii)=MID;        
            Vmi_k2(ii)=MI_k;                
            Vmi_e2(ii)=MI_e;                        
            Vmi_ef2(ii)=MI_ef;                
            Vmi_kde2(ii)=MI_kde;                
            Vmi_cell2(ii)=MI_cell;
            Vmi_mean2(ii)=MI_mean;
            Vhsic2(ii)=HSIC;
            Vace2(ii)=ACE;
            Vtice2(ii)=TICe;
            Vmice2(ii)=MICe;
            
        end % end - nsim2
        
        
        valric2(typ,l,:) = Vric2;
        valcor2(typ,l,:) = Vcor2;
        valdcor2(typ,l,:) = Vdcor2;
        valmine2(typ,l,:) = Vmine2;
        valrdc2(typ,l,:) = Vrdc2;
        valmid2(typ,l,:) = Vmid2;
        valmi_k2(typ,l,:) = Vmi_k2;
        valmi_e2(typ,l,:) = Vmi_e2;
        valmi_ef2(typ,l,:) = Vmi_ef2;
        valmi_kde2(typ,l,:) = Vmi_kde2;
        valmi_cell2(typ,l,:) = Vmi_cell2; 
        valgmic2(typ,l,:) = Vgmic2;
        valmi_mean2(typ,l,:) = Vmi_mean2;
        valhsic2(typ,l,:) = Vhsic2;
        valace2(typ,l,:) = Vace2;
        valtice2(typ,l,:) = Vtice2;
        valmice2(typ,l,:) = Vmice2;
        
    end % end - typ
end % end - numnoise

% Saving     
disp('Saving...');
save('resultsPower');
disp('Done.');
toc;