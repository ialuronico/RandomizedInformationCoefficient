close all;
clear;clc;

% Experiments in Section 6.2 about 
% Feature selection for regression

nfolds = 10;
times = 3;
topFeatures = 10;

n = 1;
names{n} = 'bodyfat'; n = n + 1;
names{n} = 'pyrim'; n = n + 1;
names{n} = 'triazines'; n = n + 1;
names{n} = 'QSAR'; n = n + 1;
names{n} = 'QSAR2'; n = n + 1;
names{n} = 'wisconsin'; n = n + 1;
names{n} = 'pole'; n = n + 1;
names{n} = 'crime'; n = n + 1;;


tic;

for f=1:length(names)
    name = names{f};    
    disp(['Dataset: ' name]);
    load(['../DatasetsRegression/' name]);

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
    
    % Some auxiliary vectors
    featSelectedRIC = zeros(nfolds,times,maxFeature);
    featSelectedDcor = zeros(nfolds,times,maxFeature);
    featSelectedRDC = zeros(nfolds,times,maxFeature);
    featSelectedMI_kde = zeros(nfolds,times,maxFeature);
    featSelectedMI_knn = zeros(nfolds,times,maxFeature);
    featSelectedMI_mean = zeros(nfolds,times,maxFeature);
    featSelectedHSIC = zeros(nfolds,times,maxFeature);
    featSelectedMI_e = zeros(nfolds,times,maxFeature);
    featSelectedMI_ef = zeros(nfolds,times,maxFeature);
    featSelectedMI_kmeans = zeros(nfolds,times,maxFeature);
    
    step=1;
    for nfeature=1:step:maxFeature
        disp(['Subset with k = ' num2str(nfeature) ' features']);    
        [CV_RIC(:,nfeature), featSelectedRIC] = kNN_CV(data,C,cplist,salist,nfeature,'RIC',featSelectedRIC);
        [CV_RDC(:,nfeature), featSelectedRDC] = kNN_CV(data,C,cplist,salist,nfeature,'RDC',featSelectedRDC);    
        [CV_Dcor(:,nfeature), featSelectedDcor] = kNN_CV(data,C,cplist,salist,nfeature,'Dcor',featSelectedDcor);           
        [CV_MI_kde(:,nfeature), featSelectedMI_kde] = kNN_CV(data,C,cplist,salist,nfeature,'MI_kde',featSelectedMI_kde);           
        [CV_MI_K(:,nfeature), featSelectedMI_knn] = kNN_CV(data,C,cplist,salist,nfeature,'MI_knn',featSelectedMI_knn);           
        [CV_MI_mean(:,nfeature), featSelectedMI_mean] = kNN_CV(data,C,cplist,salist,nfeature,'MI_mean',featSelectedMI_mean);           
        [CV_HSIC(:,nfeature), featSelectedHSIC] = kNN_CV(data,C,cplist,salist,nfeature,'HSIC',featSelectedHSIC);               
        [CV_MI_e(:,nfeature), featSelectedMI_e] = kNN_CV(data,C,cplist,salist,nfeature,'MI_e',featSelectedMI_e);               
        [CV_MI_ef(:,nfeature), featSelectedMI_ef] = kNN_CV(data,C,cplist,salist,nfeature,'MI_ef',featSelectedMI_ef);               
        [CV_MI_kmeans(:,nfeature), featSelectedMI_kmeans] = kNN_CV(data,C,cplist,salist,nfeature,'MI_kmeans',featSelectedMI_kmeans);               
    end
    
    % Save a file for each dataset
    save(['results/' name]);
     
end
disp('Done.');

toc;
