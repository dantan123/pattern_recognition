classdef MAP
    methods(Static = true)
        
       function plotBoundry (xRange, yRange, boundry)
            contour(xRange,yRange,boundry, 'Color', 'cyan');
       end
       
       function int = getDistance(point,covar_a,covar_b,mu_a,mu_b,size_a,size_b)
           Q0 = inv(covar_a) - inv(covar_b);
           Q1 = 2*(mu_b * inv(covar_b) - mu_a * inv(covar_a));
           Q2 = mu_a * inv(covar_a) * mu_a' - mu_b * inv(covar_b) * mu_b';
           Q3 = log(size_b/size_a);
           Q4 = log(det(covar_a)/det(covar_b));
           int = point * Q0 * point' + Q1 * point' + Q2 + 2 * Q3 + Q4;
       end
       
       function [ classMap ] = calculate(xRange, yRange,A,B)
            classMap = zeros(size(xRange, 1), size(yRange, 2));
            
            for i=1:size(xRange, 1)
                for j = 1:size(yRange,2)
                    point = [xRange(i,j) yRange(i,j)]
                    distance = MAP.getDistance(point,A.covar,B.covar,A.mu,B.mu,A.size,B.size)
                    if(distance > 0)
                        classMap(i,j) = 1; 
                    else
                        classMap(i,j) = -1;
                    end
                end
            end
       end
       
       
       function [ classMap ] = calculate3(xRange, yRange, C, D, E)
            classMapCD = MAP.calculate(xRange, yRange, C, D);
            classMapCE = MAP.calculate(xRange, yRange, C, E);
            classMapDE = MAP.calculate(xRange, yRange, D, E);
            
            classMap = zeros(size(xRange, 1), size(yRange, 2));
            for i=1:size(xRange, 1)
                for j=1:size(yRange, 2)
                    classMap(i, j) = Class.min(classMapCD(i, j), classMapCE(i, j), classMapDE(i, j));
                end
            end
       end
       
       
       % error analysis
        
        % for class A
       function [num_AB,num_AA] = search2(A,B)
           
         % generate a mesh of 5 by 5
         % confusion_matrix = zeros(5,5);

         num_AB = 0;
         num_AA = 0;
         
         for i=1:size(A.scatter,1)
                % for all points in class A
                % two columns
                 point = A.scatter(i,1:2)
                 distance = MAP.getDistance(point,A.covar,B.covar,A.mu,B.mu,A.size,B.size)
                 if distance > 0
                     num_AB = num_AB + 1;
                 else 
                     num_AA = num_AA + 1;
                 end  
         end
         
       end
       
   
   function [num_CC, num_CD,num_CE] = search3(C,D,E)
   num_CC = 0;
   num_CD = 0;
   num_CE = 0;
   
       for i = 1:size(C.scatter,1)
               point = C.scatter(i,1:2);

               distance1 = MAP.getDistance(point,C.covar,D.covar,C.mu,D.mu,C.size,D.size)
               distance2 = MAP.getDistance(point,C.covar,E.covar,C.mu,E.mu,C.size,E.size)

               if distance1 < 0 && distance2 < 0
                   % classified as C:
                   num_CC = num_CC + 1;
               elseif distance1 > 0 && distance2 < 0
                   % classified as D
                   % closer to D between C and D and closer to C between C
                   % and E
                   num_CD = num_CD + 1;
               else
                   % otherwise, classified as E
                   num_CE = num_CE + 1;
               end
       end
   end
       
    end
end