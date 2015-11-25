function [ranking]=myDcorFilter(a,C,nfeature,echo)
[n dim]=size(a);
if nargin<3 nfeature=50;end;
if nargin<4 echo=0;end;

ranking = zeros(1,dim);
parfor j=1:dim
    R=corrcoef(a(:,j)',C');
    if (~isnan(R(1,2)))
        ranking(j) = myFastDistCorr(a(:,j),C);    
    else
        ranking(j) = -Inf;
    end
end

[val, ind] = sort(ranking,'descend');
ranking = ind(1:nfeature);