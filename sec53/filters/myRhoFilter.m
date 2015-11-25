function [ranking]=myRhoFilter(a,C,nfeature,echo)
[n dim]=size(a);
if nargin<3 nfeature=50;end;
if nargin<4 echo=0;end;

ranking = zeros(1,dim);
for j=1:dim
    R=corrcoef(a(:,j)',C');
    ranking(j) = R(1,2)^2; 
end

ranking(isnan(ranking)) = -Inf; % for constant features
[val, ind] = sort(ranking,'descend');

ranking = ind(1:nfeature);