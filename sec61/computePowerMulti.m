clear;
close all;
clc;

tic;


% Experiment proposed in Section 6.1: Identification of Multi-variable 
% Noisy Relationships.
%
% The code should be able to run on 64bit Linux systems. If you use another
% system you might need to compile some of the dependency measures.
%
% Also, it uses parfor in Matlab.

randn('seed',0)
 
nsim = 300; % Number of relatioships from the negative class (complete noise)
nsim2 = nsim;% Number of relationships from the positive clas (noisy relationships)

numnoise = 30; % The number of different noise levels used
noise = 2;  % A constant to determine the amount of noise. It is just another parameter 

n=320; %320         % Number of data points per simulation

ntypes = 12; % The total number of relationship types

% Choose how many variables in the set X
p = 3;

% Vectors holding the values of the statistics for the
% negative class

% Randomized Information Coefficient - RIC
valric=zeros(ntypes,numnoise,nsim);
% Distance Correlation - dCorr
valdcor=zeros(ntypes,numnoise,nsim);
% Randomized Dependency Coefficient - RDC
valrdc=zeros(ntypes,numnoise,nsim);
% Mutual Information (Krakov's Nearest Neighbour) 
valmi_k=zeros(ntypes,numnoise,nsim);
% Mutual Information (Discretization Equal-width)
valmi_e=zeros(ntypes,numnoise,nsim);
% Mutual Information (Discretization Equal-frequency)
valmi_ef=zeros(ntypes,numnoise,nsim);
% Mutual Information (Kernel Density Estimator)
valmi_kde=zeros(ntypes,numnoise,nsim);
% Mutual Information (k-Means)
valmi_kmeans=zeros(ntypes,numnoise,nsim);
% Hilbert-Schmit Independece Criterion - HSIC
valhsic=zeros(ntypes,numnoise,nsim);
% Mutual Information (Mean Neareast Neighbour) 
valmi_mean=zeros(ntypes,numnoise,nsim);

% Vectors holding the values of the statistics for the
% positive class

valric2=zeros(ntypes,numnoise,nsim);
valdcor2=zeros(ntypes,numnoise,nsim);
valrdc2=zeros(ntypes,numnoise,nsim);
valmi_k2=zeros(ntypes,numnoise,nsim);
valmi_e2=zeros(ntypes,numnoise,nsim);
valmi_ef2=zeros(ntypes,numnoise,nsim);
valmi_kde2=zeros(ntypes,numnoise,nsim);
valmi_kmeans2=zeros(ntypes,numnoise,nsim);
valmi_mean2=zeros(ntypes,numnoise,nsim);
valhsic2=zeros(ntypes,numnoise,nsim);

% Loop through different noise levels
for l =1:numnoise    
    for typ = 1:ntypes
        fprintf('Level= %d, Rel.Typ.= %d \n',l,typ);
               
        %
        % Negative class
        %      
        
        parfor ii = 1:nsim
            x=rand(p,n); 
           
            y = gen_fun_multi(x,n,noise,l,numnoise,typ);
            
            x = rand(p,n);           
            
            [dCor_,RDC_,RIC_,MI_k_,MI_e_,MI_ef_,MI_kde_,MI_kmeans_,HSIC_,MImean_]= computeStatisticsMulti(x,y);
             
            Vdcor(ii)=dCor_;       
            Vrdc(ii)=RDC_;
            Vric(ii)=RIC_;           
            Vmi_k(ii)=MI_k_;            
            Vmi_e(ii)=MI_e_;            
            Vmi_ef(ii)=MI_ef_;
            Vmi_kde(ii)=MI_kde_;                        
            Vmi_kmeans(ii)=MI_kmeans_;
            Vmi_mean(ii)=MImean_;
            Vhsic(ii)=HSIC_;
            
        end % end - nsim
        
        valdcor(typ,l,:) = Vdcor;
        valrdc(typ,l,:) = Vrdc;
        valmi_k(typ,l,:) = Vmi_k;
        valmi_e(typ,l,:) = Vmi_e;
        valmi_ef(typ,l,:) = Vmi_ef;
        valmi_kde(typ,l,:) = Vmi_kde;
        valmi_kmeans(typ,l,:) = Vmi_kmeans;               
        valmi_mean(typ,l,:) = Vmi_mean;
        valhsic(typ,l,:) = Vhsic;        
        valric(typ,l,:) = Vric;
    
        %
        % Positive class
        %
          
        parfor ii = 1:nsim2
            x=rand(p,n);

            y = gen_fun_multi(x,n,noise,l,numnoise,typ);
            
            [dCor_,RDC_,RIC_,MI_k_,MI_e_,MI_ef_,MI_kde_,MI_kmeans_,HSIC_,MImean_]= computeStatisticsMulti(x,y);
             
            Vdcor2(ii)=dCor_;       
            Vrdc2(ii)=RDC_;
            Vric2(ii)=RIC_;           
            Vmi_k2(ii)=MI_k_;            
            Vmi_e2(ii)=MI_e_;            
            Vmi_ef2(ii)=MI_ef_;
            Vmi_kde2(ii)=MI_kde_;                        
            Vmi_kmeans2(ii)=MI_kmeans_;
            Vmi_mean2(ii)=MImean_;            
            Vhsic2(ii)=HSIC_;            
            
        end % end - nsim2
                
        valdcor2(typ,l,:) = Vdcor2;
        valrdc2(typ,l,:) = Vrdc2;
        valmi_k2(typ,l,:) = Vmi_k2;
        valmi_e2(typ,l,:) = Vmi_e2;
        valmi_ef2(typ,l,:) = Vmi_ef2;
        valmi_kde2(typ,l,:) = Vmi_kde2;
        valmi_kmeans2(typ,l,:) = Vmi_kmeans2;
        valmi_mean2(typ,l,:) = Vmi_mean2;
        valhsic2(typ,l,:) = Vhsic2;
        valric2(typ,l,:) = Vric2;

    end % end - type
end % end - numnoise

% Saving     
disp('Saving...');
save('resultsPowerMulti');
disp('Done.');
toc;