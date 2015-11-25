function [dcor,nV2T2] = myFastDistCorr(x,y)

% This function calculates the distance correlation between x and y.
% Reference: http://en.wikipedia.org/wiki/Distance_correlation 
% Date: 18 Jan, 2013
% Author: Shen Liu (shen.liu@hotmail.com.au)

%Vinh Nguyen: Faster version using sqdistance.

% Check if the sizes of the inputs match
if size(x,1) ~= size(y,1);
    error('Inputs must have the same number of rows')
end

% Delete rows containing unobserved values
N = any([isnan(x) isnan(y)],2);
x(N,:) = [];
y(N,:) = [];

% Calculate doubly centered distance matrices for x and y
%a = pdist2(x,x);

a = sqrt( sqdistance(x',x'));
[n n]=size(a);

A = a - bsxfun(@plus,mean(a),mean(a,2))+mean(a(:));

% clear a;

%b = pdist2(y,y);

b = sqrt( sqdistance(y',y'));
B = b - bsxfun(@plus,mean(b),mean(b,2))+mean(b(:));

% clear b;

% Calculate squared sample distance covariance and variances
% dcov = sum(sum(A.*B))/(size(mrow,1)^2);
% dvarx = sum(sum(A.*A))/(size(mrow,1)^2);
% dvary = sum(sum(B.*B))/(size(mrow,1)^2);

dcov = sum(sum(A.*B))/(n^2);
dvarx = sum(sum(A.*A))/(n^2);
dvary = sum(sum(B.*B))/(n^2);

% Calculate the distance correlation
dcor = sqrt(dcov/sqrt(dvarx*dvary));

nV2T2=1;

%%%compute normalized V2
T2=sum(sum(b))*sum(sum(a))/n^4;
nV2T2=n*dcov/T2;