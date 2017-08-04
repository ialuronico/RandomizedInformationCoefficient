function predicted_label=myFilteredKNN(trainData, trainClass, testData, topK, method)

if (strcmp(method,'Imean'))
    rank = myHSICFilter(trainData,trainClass,topK);
end
if (strcmp(method,'HSIC'))
    rank = myHSICFilter(trainData,trainClass,topK);
end
if (strcmp(method,'ACE'))
    rank = myACEFilter(trainData,trainClass,topK);
end
if (strcmp(method,'RIC'))
    rank = myRICFilter(trainData,trainClass,topK);
end
if (strcmp(method,'GMIC'))
    rank = myGMICFilter(trainData,trainClass,topK);
end
if (strcmp(method,'MID'))
    rank = myMIDFilter(trainData,trainClass,topK);
end
if (strcmp(method,'RDC'))
    rank = myRDCFilter(trainData,trainClass,topK);
end
if (strcmp(method,'MI_K'))
    rank = myMI_KFilter(trainData,trainClass,topK);
end
if (strcmp(method,'MIC'))
    rank = myMICFilter(trainData,trainClass,topK);
end
if (strcmp(method,'TICe'))
    rank = myTICeFilter(trainData,trainClass,topK);
end
if (strcmp(method,'MICe'))
    rank = myMICeFilter(trainData,trainClass,topK);
end
if (strcmp(method,'Rho'))
    rank = myRhoFilter(trainData,trainClass,topK);
end
if (strcmp(method,'Dcor'))
    rank = myDcorFilter(trainData,trainClass,topK);
end
if (strcmp(method,'MI_e'))
    rank = myMI_eFilter(trainData,trainClass,topK);
end
if (strcmp(method,'MI_ef'))
    rank = myMI_efFilter(trainData,trainClass,topK);
end
if (strcmp(method,'MI_kde'))
    rank = myMI_kdeFilter(trainData,trainClass,topK);
end
if (strcmp(method,'MI_A'))
    rank = myMI_AFilter(trainData,trainClass,topK);
end

IDX = knnsearch(trainData(:,rank(1:topK)),testData(:,rank(1:topK)),'K',3);
predicted_label = mean(trainClass(IDX),2);
