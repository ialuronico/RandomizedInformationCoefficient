% Compute RIC with default parameters:
% Dmax - maximum number of random cut-offs 
% Kr - number of random discretizations
function ric_ = RIC(x, y, Kr, Dmax)

n = length(x); % number of records

switch nargin
    case 3
        Dmax = floor(sqrt(n)) - 1;
    case 2
        Kr = 20;
        Dmax = floor(sqrt(n)) - 1;
end

ric_ = RIC_mex(x,y,Kr,Dmax);
