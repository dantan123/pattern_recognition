function class = ML(mu_a,mu_b,mu_c,cov_a,cov_b,cov_c,x,y)

% estimate which class a data set belongs to: whether a or b
% the idea here is to use log likelihood for classification

% use the ML classification 
% for every point in x, there is a correspoinding prior liklihood
% express in log form

% create a zero matrix
sx = size(x,2);
sy = size(y,2);
matrix_a = zeros(sx,sy);
matrix_b = zeros(sx,sy);
matrix_c = zeros(sx,sy);
class = zeros(sx,sy);

for i = 1:sx
    for j = 1:sy
        point = [x(1,i) y(1,j)];
        
        % use log liklihood
        matrix_a(i,j) = -log(2*pi*sqrt(det(cov_a))) - 0.5*(point-mu_a)*inv(cov_a)*transpose(point-mu_a);
        matrix_b(i,j) = -log(2*pi*sqrt(det(cov_b))) - 0.5*(point-mu_b)*inv(cov_b)*transpose(point-mu_b);
        matrix_c(i,j) = -log(2*pi*sqrt(det(cov_c))) - 0.5*(point-mu_c)*inv(cov_c)*transpose(point-mu_c);
        
        % classification
        if max([matrix_a(i,j),matrix_b(i,j),matrix_c(i,j)]) == matrix_a(i,j)
            % classified as class a
            class(i,j) = 1;
        elseif max([matrix_a(i,j),matrix_b(i,j),matrix_c(i,j)]) == matrix_b(i,j)
            % classified as class b
            class(i,j) = 2;
        elseif max([matrix_a(i,j),matrix_b(i,j),matrix_c(i,j)]) == matrix_c(i,j)
            % classified as class c
            class(i,j) = 3;
        else 
            % boundary
            class(i,j) = 0;
        end
    end
end

end
    
