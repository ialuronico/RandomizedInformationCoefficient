function [ranking]=myMI_eFilter(a,C,nfeature,echo)
[n dim]=size(a);
if nargin<3 nfeature=50;end;
if nargin<4 echo=0;end;

ranking = zeros(1,dim);
for j=1:dim
    R=corrcoef(a(:,j)',C');
    if (~isnan(R(1,2)))
        aF = myIntervalDiscretize(a(:,j), floor(sqrt(n/5)));
        b = myIntervalDiscretize(C, floor(sqrt(n/5)));
        ranking(j) = mi(aF',b');
    else
        ranking(j) = -Inf;
    end
end

[val, ind] = sort(ranking,'descend');
ranking = ind(1:nfeature);