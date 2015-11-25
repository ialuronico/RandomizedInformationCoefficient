clear;
close all;
clc;

% Tunes the parameters of a dependency measure to obtain high power
% Additive - noise, relationships between variables

ntypes = 12; % The total number of relationship types

% Define the parameters
% fixed parameters
c = 5;
% parameters to tune
ParToTune = (0.1:0.05:0.9);
% store the values here
powerToPlotA = zeros(ntypes,length(ParToTune));
powerToPlotB = zeros(ntypes,length(ParToTune));

tic; % For Timing

nsim = 500; % Number of relatioships from the negative class (complete noise)
nsim2 = nsim;% Number of relationships from the positive clas (noisy relationships)

numnoise = 30; % The number of different noise levels used
noise = 3;  % A constant to determine the amount of noise. It is just another parameter 

n = 320; %320         % Number of data points per simulation

% Vectors to store the values of the statistic
valMA=zeros(ntypes,numnoise,nsim);
valMA2=zeros(ntypes,numnoise,nsim);
valMB=zeros(ntypes,numnoise,nsim);
valMB2=zeros(ntypes,numnoise,nsim);

% For every value of the parameter
for a=1:length(ParToTune)  
fprintf('\n');
disp(['val = ' num2str(ParToTune(a))]);
parfor l =1:numnoise    
    %fprintf('%d,',l);
    for typ = 1:ntypes
        %fprintf('l= %d, typ = %d \n',l,typ);
        
        VMA=zeros(1,nsim);        
        VMB=zeros(1,nsim);        
        for ii = 1:nsim
            x=rand(1,n); 
            
            % Additive
            %y = gen_fun(x,n,noise,l,numnoise,typ);
            % White
            y = gen_fun_white(x,n,l,numnoise,typ);
            
            % Generate X again
            x = rand(1,n);
            
            alpha = ParToTune(a);
            minestats = mine(x,y,alpha,c);            
            VMA(ii) = minestats.mic;
            VMB(ii) = minestats.gmic;
        end %nsim
        valMA(typ,l,:) = VMA;
        valMB(typ,l,:) = VMB;
    
        VMA2=zeros(1,nsim);
        VMB2=zeros(1,nsim);
        for ii = 1:nsim2
            x=rand(1,n);

            % Additive
            %y = gen_fun(x,n,noise,l,numnoise,typ);
            % White
            y = gen_fun_white(x,n,l,numnoise,typ);
            
            alpha = ParToTune(a);
            minestats = mine(x,y,alpha,c);            
            VMA2(ii) = minestats.mic;
            VMB2(ii) = minestats.gmic;
        end %nsim2
        valMA2(typ,l,:) = VMA2;
        valMB2(typ,l,:) = VMB2;

    end % end - typ
end % end - numnoise

% Compute Power MIC

powerMA = zeros(ntypes,numnoise);
for typ=1:ntypes
    parfor l=1:numnoise
        powerMA(typ,l)= powerCont(valMA(typ,l,:),valMA2(typ, l,:));        
    end
end

% Compute average power for a relationship
powerToPlotA(:,a) = mean(powerMA,2);

% Compute Power GMIC

powerMB = zeros(ntypes,numnoise);
for typ=1:ntypes
    parfor l=1:numnoise
        powerMB(typ,l)= powerCont(valMB(typ,l,:),valMB2(typ, l,:));        
    end
end

% Compute average power for a relationship
powerToPlotB(:,a) = mean(powerMB,2);
end

% saving
sprintf('\n\n');
disp('Saving...');
save('./saved/testMIC_GMIC');

disp('Done.');
toc;