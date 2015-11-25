function [ranking]=myImeanFilter(a,C,nfeature,echo)
[n dim]=size(a);
if nargin<3 nfeature=50;end;
if nargin<4 echo=0;end;

ranking = zeros(1,dim);
for j=1:dim
    ranking(j) = Imean(a(:,j)',C');
end

[val, ind] = sort(ranking,'descend');
ranking = ind(1:nfeature);