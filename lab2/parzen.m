% Parzen - compute 2-D density estimates
%
% [p,x,y] = parzen( data, res, win )    
%
%  data - two-column matrix of (x,y) points
%         (third row/col optional point frequency)
%  res  - resolution (step size)
%         optionally [res lowx lowy highx highy]
%  win  - optional, gives form of window 
%          if a scalar - radius of square window
%          if a vector - radially symmetric window
%          if a matrix - actual 2D window shape
%
%  x    - locations along x-axis
%  y    - locations along y-axis
%  p    - estimated 2D PDF
%

%
% P. Fieguth
% Nov. 1997
%

function [p,x,y] = parzen( data, res, win )

% size(data,2) returns the number of columns in data
% size(data,1) returns the number of rows in data
% transpose data if the number of columns is greater than the number of
% rows
if (size(data,2)>size(data,1))
    data = data'; 
end

% if there are two columns in data, data is concatenated with ones of the
% same size
if (size(data,2)==2)
    data = [data ones(size(data))];
end

% number of points is equal to the total sum of rows(by taking the sum of
% column 3 which is all ones)
numpts = sum(data(:,3));

% dl is defined as the lower bound (gives the minimum values in both
% columns)
dl = min(data(:,1:2));

% dh is defined as the upper bound (gives the max values in both columns)
dh = max(data(:,1:2));

% if the res is concatenated
% dl = [loxx lowy];
% dh = [highx highy];

if length(res)>1
    dl = [res(2) res(3)]; 
    dh = [res(4) res(5)]; 
    res = res(1); 
end

% not too sure what nargin is 
if (nargin == 2)
    win = 10; 
end

% if the difference between the upper bound and the lower bound divided by
% the step size is greater than 1000; there there is an error (a check)
if (max(dh-dl)/res>1000)
  error('Excessive data range relative to resolution.');
end

% if the length of window is equal to one (in other words scalar), create a
% window of one row and # of win columns
if length(win)==1
    win = ones(1,win); 
end

% res is step
if min(size(win))==1
    win = win(:) * win(:)'; 
end

win = win / (res*res*sum(sum(win)));

% p is made of columns of zero based on maxx, minx,maxy,miny,and step size
% dh(2) - dl(2) = maxy - miny; similar for dh(1) - dl(1)
p = zeros(2+(dh(2)-dl(2))/res,2+(dh(1)-dl(1))/res);

% find where data in column 1 is greater than minx
% find where data in that column 1 less than maxx
% find where data in that column 2 is greater than miny
% find where data in that column 2 is less than maxy
% use embedding in this case
% find () returns a vector containing the linear indices of each nonzero
% element in the array (or column in this case)
fdl1 = find(data(:,1) > dl(1));
fdh1 = find(data(fdl1,1) < dh(1));
fdl2 = find(data(fdl1(fdh1),2) > dl(2));
fdh2 = find(data(fdl1(fdh1(fdl2)),2) < dh(2));

% iterate through each element in the window
for i=fdl1(fdh1(fdl2(fdh2)))'
  j1 = round(1+(data(i,1)-dl(1))/res);
  j2 = round(1+(data(i,2)-dl(2))/res);
  p(j2,j1) = p(j2,j1) + data(i,3);
end

% conv() returns a 2D convolution of matrices P and win
p = conv2(p,win,'same')/numpts
x = [dl(1):res:(dh(1)+res)]; x = x(1:size(p,2));
y = [dl(2):res:(dh(2)+res)]; y = y(1:size(p,1));
end