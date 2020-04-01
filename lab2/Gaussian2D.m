function [mu_x, cov_x] = Gaussian2D(x)
mu_x = mean(x);
cov_x = cov(x);
end
