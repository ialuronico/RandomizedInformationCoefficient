function [ranking]=myMI_AFilter(a,C,nfeature,echo)
[n dim]=size(a);
if nargin<3 nfeature=50;end;
if nargin<4 echo=0;end;

ranking = zeros(1,dim);
for j=1:dim
    R=corrcoef(a(:,j)',C');
    if (~isnan(R(1,2)))
        frac  = 0.1*(log10(n)-1); 
        if frac < 0.01; frac = 0.01; end %lower bound=0.01
        ranking(j) = mi_fs(a(:,j)',C',frac);
    else
        ranking(j) = -Inf;
    end
end

[val, ind] = sort(ranking,'descend');
ranking = ind(1:nfeature);