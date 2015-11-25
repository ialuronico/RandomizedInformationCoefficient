% Function to compute the AUC between the continuous values obtained 
% for a positive class and a negative class.

function [ auc_ ] = auc( neg, pos)

n = length(neg);

spec = zeros(1,n);
TP = zeros(1,n);
sens = zeros(1,n);

negsort = sort(neg);
for i=1:n
    spec(i) = i/n;
    TP(i) = sum(pos >= negsort(i));
    sens(i) = TP(i)/n;
end

spec = [0 spec 1];
sens = [1 sens 0];

% It is also possible to plot it.
%figure;
%plot(1-spec,sens);

auc_ = trapz(spec,sens);

end

