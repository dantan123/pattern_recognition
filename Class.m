classdef Class
  properties
      mu
      covar
      size
      scatter
      colour
  end
  methods
      function obj = Class(mu, covar, size, colour)
          if nargin == 4
              obj.mu = mu;
              obj.covar = covar;
              obj.size = size;
              obj.colour = colour;
              R = chol(covar);
              obj.scatter = repmat(mu,size,1) + randn(size,2)*R;
          end
      end
      
      function plotClassScatter(class)
            plot(class.scatter(:,1), class.scatter(:,2), strcat(class.colour,'.'));
      end
      
      function plotClassMean(class)
          plot(class.mu(1), class.mu(2), strcat(class.colour,'*'));
      end
  end
  
      methods (Static = true)
          
      function class = min(CD, CE, DE)
          % belongs to class C
           if CD < 0 && CE < 0
                class = 1;
          % belongs to class E
           elseif CD > 0 && DE < 0
                class = 2;
          % belongs to class D
           else
                class = 3;
           end
      end
      
      function plotEllipses(class) 
            % returns the eigenvector and eigenvalue matrices
            [eigenvec, eigenval] = eig(class.covar);

            % t is the angle parameter varying from 0 to 2*pi (360 degrees)
            t = linspace(0,2*pi,1000);
            if (eigenval(1,1) >= eigenval(2,2))
            % theta is the angle of rotation based on the rotation matrix
            theta = atan(eigenvec(1,2)/eigenvec(1,1));

            % correspond to scaling the the x-axis
            a = sqrt(eigenval(1,1));

            % correspond to scaling the y-axis
            b = sqrt(eigenval(2,2));
            else
            % theta is the angle of rotation based on the rotation matrix
            theta = atan(eigenvec(2,2)/eigenvec(2,1));

            % correspond to scaling the the x-axis
            a = sqrt(eigenval(2,2));

            % correspond to scaling the y-axis
            b = sqrt(eigenval(1,1));
            end
            % ellipse origins
            x0 = class.mu(1,1);
            y0 = class.mu(1,2);

            % Apply rotation matrix to ellipse equation in parametric form
            % rotation matrix: [cos(theta), sin(theta); -sin(theta), cos(theta)]
            % ellipse eqn: [xo + a*cos(theta); yo + b*sin(theta)]
            x = x0 + a*cos(t)*cos(theta) - b*sin(t)*sin(theta);
            y = y0 + a*cos(t)*sin(theta) + b*sin(t)*cos(theta);

            % plot ellipse
            plot(x,y,class.colour)
      end
      
      end
end
             
        