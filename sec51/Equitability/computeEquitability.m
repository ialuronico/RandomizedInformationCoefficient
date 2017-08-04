clear;
close all;
clc;

% Experiment proposed in Section 5.2: Equitability

tic; % For Timing

numnoise = 300; % The number of different noise levels used
noise = 1;  % A constant to determine the amount of noise. It is just another parameter 

n = 320; %320         % Number of data points per simulation

% Only functional relationships
funtypes = [1,2,3,4];
ntypes = length(funtypes); % The total number of relationship types

% Vectors holding the values of the statistics for the
% negative class

% R2 values
valr2=zeros(ntypes,numnoise);
% Randomized Information Coefficient - RIC
valric=zeros(ntypes,numnoise);
% Pearson Correlation Squared - r^2
valcor=zeros(ntypes,numnoise);
% Distance Correlation - dCorr
valdcor=zeros(ntypes,numnoise);
% Maximal Information Coefficient  - MIC
valmine=zeros(ntypes,numnoise); 
% Randomized Dependency Coefficient - RDC
valrdc=zeros(ntypes,numnoise);
% Mutual Information Dimension - MID
valmid=zeros(ntypes,numnoise);
% Mutual Information (Krakov's Nearest Neighbour) 
valmi_k=zeros(ntypes,numnoise);
% Mutual Information (Discretization Equal-width)
valmi_e=zeros(ntypes,numnoise);
% Mutual Information (Discretization Equal-frequency)
valmi_ef=zeros(ntypes,numnoise);
% Mutual Information (Kernel Density Estimator)
valmi_kde=zeros(ntypes,numnoise);
% Mutual Information (Adaptive Partitioning)
valmi_cell=zeros(ntypes,numnoise);
% Generalized Mean Information Coefficient - GMIC
valgmic=zeros(ntypes,numnoise);
% Alternative Conditional Expectation - ACE
valace=zeros(ntypes,numnoise);
% Hilbert-Schmit Independece Criterion - HSIC
valhsic=zeros(ntypes,numnoise);
% Mutual Information (Mean Neareast Neighbour) 
valmi_mean=zeros(ntypes,numnoise);
% Total Information Coefficient - TIC_e
valtice=zeros(ntypes,numnoise);
% New Maximal Information Coefficient - MIC_e
valmice=zeros(ntypes,numnoise);


% Loop through different noise levels
for t = 1:ntypes
  typ = funtypes(t);
  % generate noiseless relationship
  % Generate equally spaced X in [0,1]
  x = (0:1/n:1-1/n);
  y_noiseless = gen_fun_equitability(x,n,noise,1,numnoise,typ);
  %y_noiseless = gen_fun(x,n,0,0,numnoise,typ);
  parfor l =1:numnoise    
        fprintf('Level= %d, Rel.Typ.= %d \n',l,typ);             
        % Function to generate different relationship types with
        % Additive Noise
        y = gen_fun_equitability(x,n,noise,l,numnoise,typ);
        %y = gen_fun(x,n,noise,l-1,numnoise,typ);

        % Compute the R^2 of this relationship
        r = corr(y_noiseless',y');
        Vr2(l) = r^2;         

        [cor,dCor,MIC,RDC,RIC,MID,MI_k,MI_e,MI_ef,MI_kde,MI_cell,GMIC,MI_mean,HSIC,ACE,TICe,MICe]= computeStatisticsDefault(x,y);

        Vcor(l)=cor ;  
        Vdcor(l)=dCor;   
        Vmine(l)=MIC;    
        Vrdc(l)=RDC;
        Vric(l)=RIC;            
        Vmid(l)=MID;            
        Vmi_k(l)=MI_k;            
        Vmi_e(l)=MI_e;            
        Vmi_ef(l)=MI_ef;
        Vmi_kde(l)=MI_kde;                        
        Vmi_cell(l)=MI_cell;
        Vgmic(l)=GMIC;
        Vmi_mean(l)=MI_mean;
        Vhsic(l)=HSIC;
        Vace(l)=ACE;
        Vtice(l)=TICe;       
        Vmice(l)=MICe;     
    
    end % end - numnoise
    
    % Sort everything based on the R^2
    [val, ind] = sort(Vr2);
    
    % This just because of parfor    
    valr2(t,:) = Vr2(ind);
    valric(t,:) = Vric(ind);
    valcor(t,:) = Vcor(ind);
    valdcor(t,:) = Vdcor(ind);
    valmine(t,:) = Vmine(ind);
    valrdc(t,:) = Vrdc(ind);
    valmid(t,:) = Vmid(ind);
    valmi_k(t,:) = Vmi_k(ind);
    valmi_e(t,:) = Vmi_e(ind);
    valmi_ef(t,:) = Vmi_ef(ind);
    valmi_kde(t,:) = Vmi_kde(ind);
    valmi_cell(t,:) = Vmi_cell(ind);
    valgmic(t,:) = Vgmic(ind);
    valmi_mean(t,:) = Vmi_mean(ind);
    valhsic(t,:) = Vhsic(ind);
    valace(t,:) = Vace(ind);        
    valtice(t,:) = Vtice(ind);      
    valmice(t,:) = Vmice(ind);  
end % end - typ

% Saving     
disp('Saving...');
save('resultsEquitability');
disp('Done.');
toc;