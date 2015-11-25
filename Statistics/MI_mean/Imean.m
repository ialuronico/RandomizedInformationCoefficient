function [ Imean_ ] = Imean(x,y)
    [d n] = size(x);
    
    eps = 0.001; % to avoid zero distances
    %H(X)
    Dx = sqrt( sqdistance(x,x)); 
    Dx(eye(n) ~= 0) = 1; % replace with one so the log is 0
    Hx = d * log(Dx + eps)/n/(n-1);
    
    %H(Y)
    Dy = sqrt( sqdistance(y,y));
    Dy(eye(n) ~= 0) = 1; % replace with one so the log is 0
    Hy = d * log(Dy + eps)/n/(n-1);
    
    %H(X,Y)
    Dxy = sqrt( sqdistance([x;y],[x;y]));
    Dxy(eye(n) ~= 0) = 1; % replace with one so the log is 0
    Hxy = 2*d * log(Dxy + eps)/n/(n-1);
    
    % there should be a additive constant function of n and d
    % but we don't care in ranking
    Imean_ = sum(sum(Hx + Hy - Hxy));
end

