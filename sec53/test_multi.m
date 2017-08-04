close all;
clear;clc;

% Experiments in Section 5.3 about 
% Feature filtering for regression

%nfolds = 10;
%times = 3;
%topFeatures = 10;

nfolds = 10;
times = 3;
topFeatures = 10;


n = 1;
newNames{n} = 'bodyfat'; n = n + 1;
newNames{n} = 'pyrim'; n = n + 1;
newNames{n} = 'triazines'; n = n + 1;
newNames{n} = 'QSAR'; n = n + 1;
newNames{n} = 'QSAR2'; n = n + 1;
newNames{n} = 'wisconsin'; n = n + 1;
newNames{n} = 'pole'; n = n + 1;
newNames{n} = 'crime'; n = n + 1;


tic;

for f=1:length(newNames)
    newName = newNames{f};      
    disp(['Dataset: ' newName]);
    load(['../DatasetsRegression/' newName]);

    % remove missing
    notMiss = sum(isnan(data),2) < 1;
    data = data(notMiss,:);
    C = C(notMiss,:);

    [N dim]=size(data);
    maxFeature=min(topFeatures,dim);

    cplist = cell(1,times);
    salist = cell(1,times);
    if (N > 1000)
        for t=1:times  
            sa = randsample(N,1000);
            Csa = C(sa);
            cplist{t} = cvpartition(Csa,'k',nfolds); 
            salist{t} = sa;
        end
        N = 1000;
    else
        for t=1:times  
            sa = (1:1:N);
            Csa = C;
            cplist{t} = cvpartition(Csa,'k',nfolds); 
            salist{t} = sa;
        end
    end

    step=1;
    parfor nfeature=1:step:maxFeature
        disp(['Filter with k = ' num2str(nfeature) ' features']);    
        CV_RIC(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'RIC');    
        CV_GMIC(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'GMIC');    
        CV_MID(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'MID');    
        CV_RDC(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'RDC');    
        CV_MI_K(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'MI_K');   
        CV_Rho(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'Rho');   
        CV_Dcor(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'Dcor');           
        CV_MIC(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'MIC');
        CV_MI_e(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'MI_e');
        CV_MI_ef(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'MI_ef');
        CV_MI_kde(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'MI_kde');
        CV_MI_A(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'MI_A');        
        CV_ACE(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'ACE');
        CV_HSIC(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'HSIC');
        CV_Imean(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'Imean');
        CV_TICe(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'TICe');
        CV_MICe(:,nfeature) = kNN_CV(data,C,cplist,salist,nfeature,'MICe');
    end
    
    % Save a file for each dataset
    save(['results/' newName]);
     
end
disp('Done.');

toc;
