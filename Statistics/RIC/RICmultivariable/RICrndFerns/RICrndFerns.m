% Compute RICrndFerns with default parameters:
% Dmax - maximum number of random cut-offs 
% Kr - number of random discretizations
function ric_ = RICrndFerns(x, y, Kr, Dmax)

n = length(x); % number of records

switch nargin
    case 3
        Dmax = floor(log2(n)) - 1;
    case 2
        Kr = 20;
        Dmax = floor(log2(n)) - 1;
end

ric_ = RICrndFerns_mex(x,y,Kr,Dmax);
