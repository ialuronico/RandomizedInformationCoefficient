% Compute RIC for sets of variables using
% discretization with random seeds.
% It also uses default parameters.
% Dmax - maximum number of random cut-offs 
% Kr - number of random discretizations
function [ RIC_ ] = RICrndSeeds(x,y,Kr,Dmax)
    [p n] = size(x);
    [q n] = size(y);
    
    switch nargin
    case 3
        Dmax = floor(sqrt(n));
    case 2
        Kr = 20;
        Dmax = floor(sqrt(n));
    end

    BinLabelX = zeros(n,Kr);
    BinLabelY = zeros(n,Kr);
    for k=1:Kr
        D = Dmax; % Fix to the maximum number of seeds
        seedsIDx = randi(n,1,D); % sample D seeds with replacement
        seedsX = x(:,seedsIDx);
        
        D = Dmax;
        seedsIDy = randi(n,1,D);
        seedsY = y(:,seedsIDy);        
        
        Dx = sqdistance(x,seedsX);     
        [~, BinLabelX(:,k)] = min(Dx,[],2);
        
        Dy = sqdistance(y,seedsY); 
        [~, BinLabelY(:,k)] = min(Dy,[],2);
        
    end
    
    % Transpose
    BinLabelX = BinLabelX';
    BinLabelY = BinLabelY';
    
    % Compute NMI between all the pairs of discretizations
    VRIC = zeros(Kr,Kr);
    for k=1:Kr
        for kp=1:Kr
            % this is implemented in C
            VRIC(k,kp) = computeNMI(BinLabelX(k,:),BinLabelY(kp,:));        
            % this is implemented in Matlab
            %VRIC(k,kp) = nmi(BinLabelX(k,:),BinLabelY(kp,:));        
        end
    end        
    %disp(VRIC);
    RIC_ = nanmean(nanmean(VRIC));
end

