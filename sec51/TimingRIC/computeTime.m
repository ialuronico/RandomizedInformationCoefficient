close all;
clear all;
clc;

n = 1000; % number of points

nsim = 3; % number of simulations

c_s = [0.1 1 4];
Kr_s = [5 10 20 70 100 200];
toPlotTimeRIC = zeros(length(c_s),length(Kr_s),nsim);

for i=1:nsim
  disp(['Simulation n.=' num2str(i)]);
  for j=1:length(c_s)
    c = c_s(j);
    for k=1:length(Kr_s)
      Kr = Kr_s(k);
   
      x = rand(1,n);
      y = rand(1,n);
  
      Dmax = floor(sqrt(n/c)) - 1;
      
      tic;
      RIC(x,y,Kr,Dmax);
      toPlotTimeRIC(j,k,i) = toc;
    end
  end  
end

save('timeRIC');
disp('Done.');