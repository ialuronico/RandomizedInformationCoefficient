function HSIC_ = computeHSIC(x,y,p)
    if (nargin < 3)
        % By default sigma_x and sigma_y are set equal to 
        % the median euclidean distance.
        % Here I update sigmax_x with sigma_x * p
        % same sigma_y is updated with sigma_y * p
        p = 1; 
    end
    
    %Set kernel size to median distance between points
    %Use at most 100 points to save time.
    size1=size(x,1);
    if size1>100
      Xmed = x(1:100,:);
      size1 = 100;
    else
      Xmed = x;
    end
    G = sum((Xmed.*Xmed),2);
    Q = repmat(G,1,size1);
    R = repmat(G',size1,1);
    dists = Q + R - 2*Xmed*Xmed';
    dists = dists-tril(dists);
    dists=reshape(dists,size1^2,1);
    sx = sqrt(0.5*median(dists(dists>0)));  %rbf_dot has factor of two in kernel

    size1=size(y,1);
    if size1>100
      Ymed = y(1:100,:);
      size1 = 100;
    else
      Ymed = y;
    end    
    G = sum((Ymed.*Ymed),2);
    Q = repmat(G,1,size1);
    R = repmat(G',size1,1);
    dists = Q + R - 2*Ymed*Ymed';
    dists = dists-tril(dists);
    dists=reshape(dists,size1^2,1);
    sy = sqrt(0.5*median(dists(dists>0)));
    
    % Update by a percentage
    sx = sx*p;
    sy = sy*p;
    
    paramsHSIC.bruteForce = 0;
    paramsHSIC.shuff = 1;
    paramsHSIC.sigx = sx; 
    paramsHSIC.sigy = sy;
    [~, HSIC_] = hsicTestBoot(x,y,0.05,paramsHSIC);
return