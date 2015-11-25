clear;
close all;
clc;

% Experiments about variance of RIC at the variation of
% sample size

% function generation parameters
sigma_x = 1;
sigma_e = 1;

Dmax = 4;

% Show an example
%figure;
%n = 1000;
%x = sigma_x*randn(1,n);
%y = x + sigma_e*randn(1,n);
%plot(x,y,'o');


nsim = 1000;
Krs = (2:1:100);
ns = [50 100 500];

RIC_Kr_n = zeros(nsim, length(Krs), length(ns));

parfor s=1:nsim
  disp(s);
  RICmat = zeros(length(Krs),length(ns));
  for i=1:length(ns)
    n = ns(i);
    x = sigma_x*randn(1,n);
    y = x + sigma_e*randn(1,n);
    for k=1:length(Krs)
      Kr = Krs(k);
       RICmat(k,i) = RIC(x,y,Kr,Dmax);
    end
  end
  RIC_Kr_n(s,:,:) = RICmat;
end

save('varRIC');
disp('Done');
