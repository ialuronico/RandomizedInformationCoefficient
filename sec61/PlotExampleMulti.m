clear;
close all;
clc;

n = 100;
m = 2;
typ = 2; % Choose the relationship Type

noise = 3;
numnoise = 30;
l1 = 1;
l2 = 10;

x=rand(m,n); 
[y, name] = gen_fun_multi(x,n,noise,l1,numnoise,typ); % typ is the last

h = figure;

s1 = subplot(1,2,1);
scatter3(x(1,:),x(2,:),y(1,:),2);
view([45 15]);
xlabel('$X_1$','Interpreter','Latex');
ylabel('$X_2$','Interpreter','Latex');
zlabel('$Y$','Interpreter','Latex');
%set(s1,'Position',[.1 .1 .3 .3]);
zlim([-0.3,1.1]);

subplot(1,2,2);
plot(sum(x,1)/m,y,'o','MarkerSize',2);
grid on;
xlabel('$X'' = \frac{X_1 + X_2}{2}$','Interpreter','Latex');
ylabel('$Y$','Interpreter','Latex');
ylim([-0.3,1.1]);

set(h, 'Position', [800 850 500 200])
set(h,'PaperSize',[13 5.4],'PaperPositionMode','auto');
saveas(h,'ExampleQuadratic','pdf');

h2 = figure;

scatter3(x(1,:),x(2,:),y(1,:),20);
view([45 15]);
xlabel('$X_1$','Interpreter','Latex');
ylabel('$X_2$','Interpreter','Latex');
zlabel('$Y$','Interpreter','Latex');
%set(s1,'Position',[.1 .1 .3 .3]);
zlim([-0.3,1.1]);

set(h2, 'Position', [800 850 270 200])
set(h2,'PaperSize',[7.5 5.4],'PaperPositionMode','auto');
saveas(h2,'ExampleQuadratic3d','pdf');
