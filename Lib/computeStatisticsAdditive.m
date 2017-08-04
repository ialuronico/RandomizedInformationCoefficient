% Function to compute the value of the statistics studied in the paper 
% All the parameters are optimized to obtain high power under additive
% noise
% input: x and y random variables

function [cor_,dCor_,MIC_,RDC_,RIC_,MID_,MI_k_, MI_e_, MI_ef_, MI_kde_,MI_cell_,GMIC_,MI_mean_,HSIC_,ACE_,TICe_,MICe_]= computeStatisticsAdditive(x,y)

RIC_=0;
cor_=0;
dCor_=0;
MIC_=0;
RDC_=0;
MID_=0;
MI_k_=0;
MI_e_=0;
MI_ef_ = 0;
MI_kde_ = 0;
MI_cell_ = 0;
GMIC_ = 0;
ACE_ = 0;
HSIC_ = 0;
MI_mean_ = 0;
TICe_ = 0;
MICe_ = 0;

% It is useful to define n - the number of records
n = length(x);

% The Randomized Information Coefficient
Kr = 200;
Dmax = floor(sqrt(n/4)) - 1;
RIC_ = RIC(x,y,Kr,Dmax); 

% Pearson's correlation squared
R=corrcoef(x,y);
cor_=R(1,2)^2 ;           

% Distance Correlation 
dCor_=myFastDistCorr(x',y');

% Maximal Information Coefficient
c = 5;
alpha = 0.35;
minestat = mine(x,y,alpha,c);
MIC_ = minestat.mic;         

% Generalized Mean Information Coefficient
c = 5;
alpha = 0.65;
minestat = mine(x,y,alpha,c);
GMIC_ = minestat.gmic;

% Total Information Coefficient (e-version) - TIC_e
c = 5;
alpha = 0.65;
minestat = mine_e(x,y,alpha,c);
TICe_ = minestat.tic;

% Maximal Information Coefficient (e-version) - MIC_e
c = 5;
alpha = 0.45;
minestat = mine_e(x,y,alpha,c);
MICe_ = minestat.mic;   

% Randomized Dependency Coefficient
k = 20;
p = 0.8;
RDC_=rdc(x',y',k,p);

% Mutual Information Dimension
MID_ = MID_mex(x,y);

% Mutual Information (Kernel Density Estimation)
h0 = 0.2;
MI_kde_ = kernelmi(x,y,h0);

% Mutual Information (Discretization Equal-Width)
c = 10;
xd = myIntervalDiscretize(x', floor(sqrt(n/c)));
yd = myIntervalDiscretize(y', floor(sqrt(n/c)));
MI_e_ = mi(xd',yd');

% Mutual Information (Discretization Equal-Frequency)
c = 10;
xd = myQuantileDiscretize(x', floor(sqrt(n/c)));
yd = myQuantileDiscretize(y', floor(sqrt(n/c)));
MI_ef_ = mi(xd',yd');

% Mutual Information (Adaptive Discretization)
frac  = 0.1*(log10(n)-1); 
if frac < 0.01; frac = 0.01; end %lower bound=0.01
MI_cell_ = mi_fs(x,y,frac);

% Mutual Information kNN
k = 30;
MI_k_ = MI_Kraskov_mex(x,y,k); 

% Mutual Information (Mean nearest neighbours)
MI_mean_ = Imean(x,y);

% HSIC 
p = 1.2; % percentage of the euclidean median
HSIC_ = computeHSIC(x',y',p);

% ACE 
ACE_ = computeACE(x,y);

return;