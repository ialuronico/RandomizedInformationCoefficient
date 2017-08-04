% Function to generate different relationship types at different levels of
% additive noise. 

% input:    x - random variable
%           n - number of points 
%           noise - constant to determine the noise level
%           l - noise level
%           numnoise - total number of noise levels
%           typ - relationship type to generate
% output:   y - random variable
%           name - relationship name

function [ y,name ] = gen_fun_equitability(x,n,noise,l,numnoise,typ)

    l = l - 1; % Allow noiseless relationships
    y=zeros(1,n);
    
    % Linear
    if typ==1
        y=x+ noise *(l/numnoise)* randn(1,n);
    end

    % Quadratic
    if typ==2
        % x in -0.5,0.5
        x = x - 0.5;
        y=4*(x).^2+  noise * (l/numnoise) * randn(1,n);
    end

    % Cubic
    if typ==3
        % x in -1.3,1
        x = 2.3*x - 1.3;
        y=4*(x).^3+(x).^2-4*(x)+ 5*noise  * (l/numnoise) *randn(1,n);
    end
    
    % Sine low freq
    if typ==4
      y = sin(x*8*pi) +  5*noise * (l/numnoise) * randn(1,n);
    end

    type_description={'Linear','Quadratic','Cubic','Sinusoidal low freq.','Sinusoidal high freq.','4th Root','Circle','Step Function','Two Lines','X','Sinusoidal varying freq.','Circle-bar','Noise'};
    name = type_description{typ};
end

