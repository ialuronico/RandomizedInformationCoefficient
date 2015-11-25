% Function to generate different relationship types at different levels of
% white noise. 

% input:    x - random variable
%           n - number of points 
%           l - noise level
%           numnoise - total number of noise levels
%           typ - relationship type to generate
% output:   y - random variable
%           name - relationship name

function [ y,name ] = gen_fun_white(x,n,l,numnoise,typ)
    
y=zeros(1,n);
    
    % Linear
    if typ==1
        y=x;
    end

    % Quadratic
    if typ==2
        y=4*(x-.5).^2;
    end

    % Cubic
    if typ==3
        y=128*(x-1/3).^3-48*(x-1/3).^3-12*(x-1/3);
    end

    % Sinusoidal low frequency
    if typ==4
        y=sin(4*pi*x);
    end

    % Sinusoidal high frequency
    if typ==5
        y=sin(16*pi*x);
    end

    %  4th root
    if typ==6
        y=x.^(1/4);
    end

    %  Circle
    if typ==7        
        y=sign(randn(1,n)).* (sqrt(1 - (2*x - 1).^2));
    end

    % Step Function
    if typ==8
        y = 1*(x > 0.5);
    end
    
    % Two lines
    if typ==9
        y = 0.5 + 0.5*sign(randn(1,n)).*x;     
    end
    
    % X
    if typ==10
        y = sign(randn(1,n)).*(0.5-x);   
    end
    
    % Exponential (BUG: it should have been sinusoidal varying frequency)
    if typ==11
        y = exp(x*6)/400;       
    end
    
    % Circle-bar
    if typ==12
        y=(randi(3,1,n)-2).* (sqrt(1 - (2*x - 1).^2));
    end
    
    % Just noise
    if typ==13
        y= rand(1,n);
    end
    
    % Add white noise with offset (does not start from 0)    
    howmany = floor(n*(.65 + 0.35*l/numnoise));
    if(howmany > n)
        howmany = n;
    end    
    min_y = min(y);
    max_y = max(y);
    y(randsample(n,howmany)') = min_y + (max_y - min_y)* rand(1,howmany);

    type_description={'Linear','Quadratic','Cubic','Sinusoidal low freq.','Sinusoidal high freq.','4th Root','Circle','Step Function','Two Lines','X','Sinusoidal varying freq.','Circle-bar','Noise'};
    name = type_description{typ};
end

