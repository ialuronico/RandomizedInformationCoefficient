function [ I ] = kernelmi( x, y, h, ind )
% Kernel-based estimate for mutual information I(X, Y)
% h - kernel width; ind - subset of data on which to estimate MI

[Nx, Mx]=size(x);
[Ny, My]=size(y);

if any(My ~= Mx)
    error('Bad sizes of arguments');
end

if nargin < 3
    % Yields unbiased estiamte when Mx->inf 
    % and low MSE for two joint gaussian variables
    %alpha = 0.25;
    %h = (Mx + 1) / sqrt(12) / Mx ^ (1 + alpha);
    % Different choice of bandwidth provide different results
    h=(4/(Nx + Ny+2))^(1/( Nx + Ny +4))*Mx^(-1/(Nx + Ny +4));
end

if nargin < 4
    ind = 1:Mx;
end

% Copula-transform variables
%x = ctransform(x);
%y = ctransform(y);
% normalize (possible to normalize every dimension)
maxi = max(x,[],2);
mini = min(x,[],2);
x = repmat(mini,1,Mx) + x./repmat(maxi - mini,1,Mx);
maxi = max(y,[],2);
mini = min(y,[],2);
y = repmat(mini,1,My) + y./repmat(maxi - mini,1,My);

h2 = h^2;

% Pointwise values for kernels
Kx = exp(-sqdistance(x,x)/h2);
Ky = exp(-sqdistance(y,y)/h2);

% Kernel sums for marginal probabilities
Cx = sum(Kx);
Cy = sum(Ky);

% Kernel product for joint probabilities
Kxy = Kx.*Ky;

f = sum(Cx.*Cy)*sum(Kxy)./(Cx*Ky)./(Cy*Kx);
I = mean(log(f(ind)));

end


