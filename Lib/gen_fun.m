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

function [ y,name ] = gen_fun(x,n,noise,l,numnoise,typ)

    y=zeros(1,n);
    
    % Linear
    if typ==1
        y=x+ noise *(l/numnoise)* randn(1,n);
    end

    % Quadratic
    if typ==2
        y=4*(x-.5).^2+  noise * (l/numnoise) * randn(1,n);
    end

    % Cubic
    if typ==3
        y=128*(x-1/3).^3-48*(x-1/3).^3-12*(x-1/3)+10* noise  * (l/numnoise) *randn(1,n);
    end

    % Sinusoidal low frequency
    if typ==4
        y=sin(4*pi*x) + 2*noise * (l/numnoise) *randn(1,n);
    end

    % Sinusoidal high frequency
    if typ==5
        y=sin(16*pi*x) + noise * (l/numnoise) *randn(1,n);
    end

    % 4th root
    if typ==6
        y=x.^(1/4) + noise * (l/numnoise) *randn(1,n);
    end

    % Circle
    if typ==7
        y=sign(randn(1,n)).* (sqrt(1 - (2*x - 1).^2)) + noise/4*l/numnoise *randn(1,n);
    end

    % Step function
    if typ==8
        y = (x > 0.5) + noise*5*l/numnoise *randn(1,n);
    end
    
    % Two lines
    if typ==9
        y = 0.5 + 0.5*sign(randn(1,n)).*x + noise/3*(l/numnoise)* randn(1,n);        
    end
    
    % X
    if typ==10
        y = sign(randn(1,n)).*(0.5-x) + noise/3*(l/numnoise)* randn(1,n);        
    end
    
    % Sinusoidal varying frequency
    if typ==11
         y=sin(6*pi*x.^2) + 2*noise * (l/numnoise) *randn(1,n);
    end
    
    % Circle-bar
    if typ==12
        y=(randi(3,1,n)-2).* (sqrt(1 - (2*x - 1).^2)) + noise/4*l/numnoise *randn(1,n);
    end
    
    % Just noise
    if typ==13
        y= rand(1,n);
    end
    
    type_description={'Linear','Quadratic','Cubic','Sinusoidal low freq.','Sinusoidal high freq.','4th Root','Circle','Step Function','Two Lines','X','Sinusoidal varying freq.','Circle-bar','Noise'};
    name = type_description{typ};
end

