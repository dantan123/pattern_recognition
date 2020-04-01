% lab 2 2D Estimation

clear;
close all;

% load file 
load('lab2_2.mat')

% Parametric Estimation----------------------------------------------------
% first set boundaries and intervals
minx_bound = floor(min([min(al(:,1)),min(bl(:,1)), min(cl(:,1))]));
maxx_bound = ceil(max([max(al(:,1)),max(bl(:,1)), max(cl(:,1))]));
miny_bound = floor(min([min(al(:,2)),min(bl(:,2)),min(cl(:,2))]));
maxy_bound = ceil(max([max(al(:,2)),max(bl(:,2)),max(cl(:,2))]));

% x and y correspond to the first and second coloumns respectively
x = minx_bound:1:maxx_bound;
y = miny_bound:1:maxy_bound;

% find the estimated means and covariances
[mu_al,cov_al] = Gaussian2D(al);
[mu_bl,cov_bl] = Gaussian2D(bl);
[mu_cl,cov_cl] = Gaussian2D(cl);

% find the ML(maximum liklihood)
class = ML(mu_al,mu_bl,mu_cl,cov_al,cov_bl,cov_cl,x,y);

% plot
[x_ML,y_ML] = meshgrid(y,x);

figure(1)
hold on
plot(al(:,1), al(:,2),'rs');
plot(bl(:,1),bl(:,2),'bo');
plot(cl(:,1),cl(:,2),'yd');
contour(x_ML,y_ML,class);
legend('al','bl','cl','ML boundaries');
xlabel('x');
ylabel('y');
title('ML Classification');
hold off

% Non-parametric Estimation -----------------------------------------------
% Define parameters; use Gaussian window with variance of 400
% define mean to be half of variance
k = 400; %parzen window
mu = [k/2 k/2];
cov = [k 0;0 k];
res = 1;

% generate a meshgrid from 1 to 400
[x_ML,y_ML] = meshgrid(1:res:400);

% returns the pdf values of points in x_ML and y_ML
% outputs the window
win = mvnpdf([x_ML(:) y_ML(:)],mu,cov);
win = reshape(win,length(x_ML),length(y_ML));

% the minx_bound, miny_bound, maxx_bound, and maxy_bound remain the same
% set res
res = [res minx_bound miny_bound maxx_bound maxy_bound];

% distributions
[p_a,x_a,y_a] = parzen(al,res,win);
[p_b,x_b,y_b] = parzen(bl,res,win);
[p_c,x_c,y_c] = parzen(cl,res,win);

% plot
figure(2)
hold on 
plot(al(:,1),al(:,2),'rs');
contour(x_a,y_a,p_a);
plot(bl(:,1),bl(:,2),'bo');
contour(x_b,y_b,p_b);
plot(cl(:,1),cl(:,2),'yd');
contour(x_c,y_c,p_c);
legend('al','parzen al','bl','parzen bl','cl','parzen cl');
xlabel('x');
ylabel('y');
title('ML Classification using Parzen Windows');
hold off

