%--------------------------------------------------------------------------
% This file is a modification of the source file of MIDER
% MIDER: Mutual Information Distance & Entropy Reduction
% 

function [Output] = miderChooseMea(x,options,mea)

%--------------------------------------------------------------------------
% Read input and options:

ntotal     = size(x,2); 
nrecords    = size(x,1);
taumax     = options.taumax;  

%--------------------------------------------------------------------------
% Initialize arrays:

% Matrix of dependency values for each pair of vars
MeasureM  = zeros(ntotal,ntotal,taumax+1);      

% keep a copy
x_orig = x;

if strcmp(mea,'EF')
    bins = floor(sqrt(nrecords/5));
    for j=1:ntotal
        x(:,j) = myQuantileDiscretize(x(:,j),bins);
    end
end

if strcmp(mea,'EI')
    bins = floor(sqrt(nrecords/5));
    for j=1:ntotal
        x(:,j) = myIntervalDiscretize(x(:,j),bins);
    end
end

fraction = 0;
if strcmp(mea,'Iadap')
    fraction  = 0.1*(log10(nrecords)-1); 
    if fraction < 0.01, fraction = 0.01; end %lower bound=0.01
end

for tau = 0:taumax
    %disp(['t ' num2str(tau)]);
    MeasureMtau = zeros(1,ntotal^2);
    parfor u=1:ntotal^2 % just a way to run a i,j for loop with parfor
        i = ceil(u/ntotal);
        j = mod(u - 1,ntotal) + 1;
        %disp([num2str(i) ' - ' num2str(j)]);        
        switch mea
            case 'RIC'
                MeasureMtau(u) = RIC(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');
            case 'RDC'
                MeasureMtau(u) = rdc(x_orig(1:end-tau,i),x_orig(tau+1:end,j));                
            case 'MID'
                MeasureMtau(u) = MID_mex(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');
            case 'MIC'
                minestat = mine(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');
                MeasureMtau(u) = minestat.mic;    
            case 'TICe'
                c = 5;
                alpha = 0.65;
                minestat = mine_e(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)',alpha,c);
                MeasureMtau(u) = minestat.tic;                
            case 'MICe'
                minestat = mine_e(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');
                MeasureMtau(u) = minestat.mic;                  
            case 'MI-KNN'
                MeasureMtau(u) = MI_Kraskov_mex(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)',6);
            case 'MI-KDE'
                MeasureMtau(u) = kernelmi(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');
            case 'dCorr'
                MeasureMtau(u) = myFastDistCorr(x_orig(1:end-tau,i),x_orig(tau+1:end,j)) ; 
            case 'corr'
                R=corrcoef(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');
                MeasureMtau(u)=R(1,2)^2;
            case 'Iadap'
                pb = 5;
                [fracn, contingency] = estimateFrac(x(1:end-tau,i),x(tau+1:end,j),pb); 
                while fracn < fraction; 
                    pb = pb+1;
                    [fracn, contingency] 
                end
                MeasureMtau(u) = mi(contingency);
            case 'EF'
                xd_i = x(1:end-tau,i);
                xd_j = x(tau+1:end,j);
                contingency = Contingency(xd_i,xd_j);    
                MeasureMtau(u) = mi(contingency);
            case 'EI'
                xd_i = x(1:end-tau,i);
                xd_j = x(tau+1:end,j);
                contingency = Contingency(xd_i,xd_j);        
                MeasureMtau(u) = mi(contingency);                
            case 'GMIC'
                minestat = mine(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');
                MeasureMtau(u) = minestat.gmic;              
            case 'ACE'
                MeasureMtau(u) = computeACE(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');                                           
            case 'Imean'
                Im = Imean(x_orig(1:end-tau,i)',x_orig(tau+1:end,j)');
                MeasureMtau(u) = real(Im) + 1000; % Constant to avoid errors
            case 'HSIC'
                MeasureMtau(u) = computeHSIC(x_orig(1:end-tau,i),x_orig(tau+1:end,j));
        end
    end
    % Unfold and build the matrix
    for u=1:ntotal^2
        i = ceil(u/ntotal);
        j = mod(u - 1,ntotal) + 1;
        MeasureM(i,j,tau+1) = MeasureMtau(u);
    end
end


[dist,taumin] = max(MeasureM,[],3); % find the best time delay

% Compute the sorted list of distances
npairs = ntotal*(ntotal - 1)/2;
distList = zeros(1,npairs);
firstVlist = zeros(1,npairs);
secondVlist = zeros(1,npairs);
edgeList = zeros(1,npairs);
tauminList = zeros(1,npairs);

k = 1;
for i=1:(ntotal-1)
  for j=(i+1):ntotal
    distList(k) = max(dist(i,j),dist(j,i));
    firstVlist(k) = i;
    secondVlist(k) = j;
    edgeList(k) = i + ntotal*j;
    tauminList(k) = taumin(i,j);
    k = k + 1;
  end
end

[distList, ind] = sort(distList,'descend');
firstVlist = firstVlist(ind);
secondVlist = secondVlist(ind);
edgeList = edgeList(ind);
tauminList = tauminList(ind);

Output.distList = distList;
Output.firstVlist = firstVlist;
Output.secondVlist = secondVlist;
Output.edgeList = edgeList;
Output.tauminlist = tauminList;
Output.npairs = npairs;
