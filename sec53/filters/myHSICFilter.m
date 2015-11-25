function [ranking]=myHSICFilter(a,C,nfeature,echo)
[n dim]=size(a);
if nargin<3 nfeature=50;end;
if nargin<4 echo=0;end;

ranking = zeros(1,dim);
for j=1:dim
    params.bruteForce = 0;
    params.shuff = 1;
    params.sigx = -1; % median euclidean distance
    params.sigy = -1;
    [~, HSIC] = hsicTestBoot(a(:,j),C,0.05,params);
    ranking(j) = HSIC;
end

[val, ind] = sort(ranking,'descend');
ranking = ind(1:nfeature);