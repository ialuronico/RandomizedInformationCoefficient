% Function to compute the value of the statistics studied in the paper 
% input: x and y sets of variables variables


function [dCor_,RDC_,RIC_,MI_k_,MI_e_,MI_ef_,MI_kde_,MI_kmeans_,HSIC_,MImean_]= computeStatisticsMulti(x,y)

RIC_=0;
dCor_=0;
RDC_=0;
MI_k_=0;
MI_e_=0;
MI_ef_=0;
MI_kde_=0;
MI_kmeans_=0;
HSIC_=0;
MImean_=0;

% Useful for discretization
[m n] = size(x);

Kr = 200;
Dmax = floor(sqrt(n/6));
RIC_ = RICrndSeeds(x,y,Kr,Dmax);

k = 20;
p = 3;
RDC_ = rdc(x',y',k,p);

dCor_ = myFastDistCorr(x',y');

MImean_ = Imean(x,y);

p = 1;
HSIC_ = computeHSIC(x',y',p);

h0 = 0.4;
MI_kde_ = kernelmi(x,y,h0);

k = 20;
MI_k_ = myIkNN(x,y,k);

% These are obtained according to the 
% analysis in the paper
Dx = 2;
Dy = 5;

a = myIntervalDiscretize(x', Dx);
b = myIntervalDiscretize(y', Dy);
% encode it
a = (a-1)*([1,(1:m-1)*Dx])' + 1;

% Matlab
%MI_e = mi(a',b');
% C++ faster
MI_e_ = computeMI(a',b');

a = myQuantileDiscretize(x', Dx);
b = myQuantileDiscretize(y', Dy);
% encode it
a = (a-1)*([1,(1:m-1)*Dx])' + 1;

% Matlab
%MI_ef = mi(a',b');
% C++ faster
MI_ef_ = computeMI(a',b');

nclu = floor(sqrt(n/6));
a = kmeans(x',nclu);
b = kmeans(y',nclu);
% Matlab
%MI_cell = mi(a',b');
% C++ faster
MI_kmeans_ = computeMI(a',b');
