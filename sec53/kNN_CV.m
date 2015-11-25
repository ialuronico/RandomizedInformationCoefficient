function CVErr=kNN_CV(data, C, cplist, salist, topK, method)
CVErr = zeros(length(cplist),1);
for t=1:length(cplist);
    cp = cplist{t};
    sa = salist{t};
    Csample = C(sa);
    dataSample = data(sa,:);    
    pred = [];
    orig = [];       
    for k=1:cp.NumTestSets
        trainSet = dataSample(training(cp,k),:);
        trainC = Csample(training(cp,k));
        testSet  = dataSample(test(cp,k),:);
        testC = Csample(test(cp,k));
        predicted = myFilteredKNN(trainSet,trainC,testSet,topK,method);
        pred = [pred; predicted];
        orig = [orig; testC];
    end
    CVErr(t,1) = corr(pred,orig).^2; % correlation coefficient
end