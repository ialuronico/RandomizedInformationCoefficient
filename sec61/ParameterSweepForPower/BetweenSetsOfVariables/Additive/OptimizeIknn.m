clear;
close all;
clc;

% Tunes the parameters of a dependency measure to obtain high power
% Additive - noise, relationships between variables

ntypes = 12; % The total number of relationship types

% Define the parameters
% paramters to tune
ParToTune = [6 10 20 30];
% store the values here
powerToPlot = zeros(ntypes,length(ParToTune));

tic; % For Timing

nsim = 300; % Number of relatioships from the negative class (complete noise)
nsim2 = nsim;% Number of relationships from the positive clas (noisy relationships)

numnoise = 30; % The number of different noise levels used
noise = 2;  % A constant to determine the amount of noise. It is just another parameter 

% Choose how many variables in the set X
p = 3;

n = 320; %320         % Number of data points per simulation

% Vectors to store the values of the statistic
valM=zeros(ntypes,numnoise,nsim);
valM2=zeros(ntypes,numnoise,nsim);

% For every value of the parameter
for a=1:length(ParToTune)  
fprintf('\n');
disp(['val = ' num2str(ParToTune(a))]);
parfor l =1:numnoise    
    %fprintf('%d,',l);
    for typ = 1:ntypes
        %fprintf('l= %d, typ = %d \n',l,typ);
        
        VM=zeros(1,nsim);        
        for ii = 1:nsim
            x=rand(p,n); 
           
            y = gen_fun_multi(x,n,noise,l,numnoise,typ);
            
            x = rand(p,n);   
            
            k = ParToTune(a);
            val = myIkNN(x,y,k);
            VM(ii) = val;
        end %nsim
        valM(typ,l,:) = VM;
    
        VM2=zeros(1,nsim);
        for ii = 1:nsim2
            x=rand(p,n); 
           
            y = gen_fun_multi(x,n,noise,l,numnoise,typ);
                    
            k = ParToTune(a);
            val = myIkNN(x,y,k); 
            VM2(ii) = val;
        end %nsim2
        valM2(typ,l,:) = VM2;

    end % end - typ
end % end - numnoise

% Compute Power

powerM = zeros(ntypes,numnoise);
for typ=1:ntypes
    parfor l=1:numnoise
        powerM(typ,l)= powerCont(valM(typ,l,:),valM2(typ, l,:));        
    end
end

% Compute average power for a relationship
powerToPlot(:,a) = mean(powerM,2);
end

% saving
sprintf('\n\n');
disp('Saving...');
save('./saved/testIknn');

disp('Done.');
toc;