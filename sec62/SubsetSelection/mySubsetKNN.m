function [predicted_label, newSelected] =mySubsetKNN(trainData, trainClass, testData, topK, method,alreadySelected)

if (strcmp(method,'RIC'))
    [ind, newSelected] = myRICsubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'Dcor'))
    [ind, newSelected] = myDcorsubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'RDC'))
    [ind, newSelected] = myRDCsubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'MI_kde'))
    [ind, newSelected] = myMI_kdesubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'MI_knn'))
    [ind, newSelected] = myMI_knnsubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'MI_mean'))
    [ind, newSelected] = myMI_meansubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'HSIC'))
    [ind, newSelected] = myHSICsubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'MI_e'))
    [ind, newSelected] = myMI_esubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'MI_ef'))
    [ind, newSelected] = myMI_efsubset(trainData,trainClass,topK,alreadySelected);
end
if (strcmp(method,'MI_kmeans'))
    [ind, newSelected] = myMI_kmeanssubset(trainData,trainClass,topK,alreadySelected);
end
IDX = knnsearch(trainData(:,ind),testData(:,ind),'K',3);
predicted_label = mean(trainClass(IDX),2);
