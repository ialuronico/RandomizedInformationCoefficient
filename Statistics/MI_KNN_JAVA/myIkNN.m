function [ MI_k ] = myIkNN( x, y, k)
if nargin < 3
    kNN = num2str(6);
else
    kNN = num2str(k);
end


% From JIDT
% Be careful the path has to be correct
javaaddpath('../Statistics/MI_KNN_JAVA/infodynamics.jar');
%javaclasspath('-dynamic');
miCalc=javaObject('infodynamics.measures.continuous.kraskov.MutualInfoCalculatorMultiVariateKraskov2');
% Compute an MI value between x and y (Kraskov's)
[p n] = size(x);
[q n] = size(y);
miCalc.initialise(p,q); 
miCalc.setProperty('k', kNN); 

miCalc.setObservations(x',y');
MI_k = miCalc.computeAverageLocalOfObservations();
clear('miCalc');

end


