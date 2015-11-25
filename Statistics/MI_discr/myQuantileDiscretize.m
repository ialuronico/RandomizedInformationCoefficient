%GlobalMIT: a toolbox for learning optimal dynamic Bayesian network structure with
%the Mutual Information Test (MIT) scoring metric
%(C) 2010-2011 Nguyen Xuan Vinh   
%Email: vinh.nguyen@monash.edu, vinh.nguyenx@gmail.com
%Reference: 
% [1] Vinh, N. X., Chetty, M., Coppel, R., and Wangikar, P. P. (2011).
% GlobalMIT: Learning Globally Optimal Dynamic Bayesian Network with the Mutual Information Test (MIT) Criterion, Bioinformatics, doi: 10.1093/bioinformatics/btr457, 
%
%Usage: discretize data by collumn, using quantile discretization (d is the number of quantiles)
function b=myQuantileDiscretize(a,d)
if nargin<2 d=3;end;

[n dim]=size(a);
b=zeros(n,dim);
for i=1:dim
   b(:,i)=doDiscretize(a(:,i),d);
end
b=b+1;

% ----------------------------------------
function y_discretized= doDiscretize(y,d)
% ----------------------------------------
% discretize a vector
ys=sort(y);
y_discretized=y;

pos=ys(round(length(y)/d *[1:d]));
for j=1:length(y)
    y_discretized(j)=sum(y(j)>pos);
end