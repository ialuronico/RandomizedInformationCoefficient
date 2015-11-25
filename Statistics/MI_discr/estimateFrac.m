%--------------------------------------------------------------------------
% estimateH2: obtain joint entropy and mutual information of two variables
% 
%   [mutinfo,fracn,H2] = estimateH2(x,y,pb,q) calculates the joint entropy
%   'H2' and mutual information 'mutinfo' of two variables 'x' and 'y', 
%   using the type of entropy specified by parameter 'q', and estimating the 
%   entropy with 'pb' data points per bin. It also checks if criteria for
%   X^2 (chi-square) test are met, and calculates the X^2 probability to 
%   reject null hypothesis.
% 
%   x       = data vector of the 1st variable
%   y       = data vector of the 2nd variable 
%   pb      = estimated number of points per bin
%   q       = entropic parameter; if q>1 it is Tsallis entropy
%   mutinfo = average mutual information of (x,y)
%   fracn   = fraction of joint prob cells that contain >= 5 points.
%   H2      = joint entropy of (x,y)
% 
%   Dependencies: estimateH2.m is called by mider.m
%
%	Written by Alejandro Fern�ndez Villaverde (afvillaverde@iim.csic.es)
%	Created: 07/10/2011, last modified: 17/04/2013
%--------------------------------------------------------------------------
% Copyright (C) 2013  Alejandro Fern�ndez Villaverde
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------


function [fracn,retHis] = estimateFrac(x,y,pb)

szx     = size(x); if szx(1)>szx(2), x=x'; end  
szy     = size(y); if szy(1)>szy(2), y=y'; end
leng    = length(x);
binsize = ceil(sqrt(pb*leng));   % Estimated bin size for ~pb points/bin
b       = floor(leng/binsize);   % Number of bins
binsize = floor(leng/b);         % Integer number of elements per bin

% Initialize matrices to zero
his = zeros(b,b);
x1  = zeros(b,1);
x2  = zeros(b,1);

% Sort values of X and Y (descending order)
[sx,ix] = sort(x,2,'descend');   
[sy,iy] = sort(y,2,'descend');  

% Replace elements of X and Y by their rank order
linsp  = linspace(1,leng,leng);
sx(ix) = linsp;
sy(iy) = linsp;

% Put sorted elements into bins
sx = ceil(sx/binsize);
sy = ceil(sy/binsize);

% Put largest values in highest bin
for p=1:leng
   if sx(p)>b
        sx(p)=b;
   end
   if sy(p)>b
        sy(p)=b;
   end
end

% Populate histograms
for i=1:leng,
    x = sx(i);
    y = sy(i);
    his(y,x) = (his(y,x)+1);
    x1(x) = (x1(x)+1);
    x2(y) = (x2(y)+1);
end
%return this his
retHis = his;

% Calculate fracn
[a,b]   = size(his);
his     = his*leng;
m =1 ; 
for k=1:a;
    for j=1:b;
        if his(k,j)>0,
            hnz(m)=his(k,j);
            m=m+1;
        end;
    end;
end
lenz = length(hnz); 
num5 = 0; for k=1:lenz;if hnz(k)>=5;num5=num5+1;end;end
fracn = num5/lenz;
