classdef GED
    methods (Static = true)
        
        function plotBoundry(xRange, yRange, boundry)
             contour(xRange,yRange,boundry,'Color', 'yellow');
        end
        
        function int = getDistance(point, mu,covar)
            int = sqrt((point - mu) * inv(covar) *(point - mu)');
        end
        
        function [ classMap ] = calculate(xRange, yRange, A, B)
            classMap = zeros(size(xRange, 1), size(yRange, 2));
            for i=1:size(xRange, 1)
                for j=1:size(yRange, 2)
                    point = [xRange(i, j) yRange(i, j)];
                    distance = GED.getDistance(point, A.mu, A.covar) - GED.getDistance(point, B.mu, B.covar); 
                    if(distance > 0)
                        classMap(i,j) = 1; 
                    else
                        classMap(i,j) = -1;
                    end
                end
            end
        end
        
        
        function [ classMap ] = calculate3(xRange, yRange, C, D, E)
            classMapCD = GED.calculate(xRange, yRange, C, D);
            classMapCE = GED.calculate(xRange, yRange, C, E);
            classMapDE = GED.calculate(xRange, yRange, D, E);
            
            classMap = zeros(size(xRange, 1), size(yRange, 2));
            for i=1:size(xRange, 1)
                for j=1:size(yRange, 2)
                    classMap(i, j) = Class.min(classMapCD(i, j), classMapCE(i, j), classMapDE(i, j));
                end
            end  
        end
      
        % error analysis
        % for 2 class case
       function [num_AB,num_AA,num_BA,num_BB] = search2(A,B)
           
         num_AB = 0;
         num_AA = 0;
         for i=1:size(A.scatter,1)
                % for all points in class A
                 point = A.scatter(i,1:2);
                 distance = GED.getDistance(point, A.mu,A.covar) - GED.getDistance(point, B.mu,B.covar);
                 if distance > 0
                     num_AB = num_AB + 1;
                 else 
                     num_AA = num_AA + 1;
                 end  
         end
         
         num_BA=0;
         num_BB=0;
         
         for i=1:size(B.scatter,1)
                 point = B.scatter(i,1:2);
                 distance = GED.getDistance(point, B.mu,B.covar) - GED.getDistance(point, A.mu,A.covar);
                 if distance > 0
                     num_BA = num_BA + 1;
                 else
                     num_BB = num_BB + 1;
                 end
         end
       end
       
   % for three class case
   function [num_CC, num_CD,num_CE] = search3(C,D,E)
   num_CC = 0;
   num_CD = 0;
   num_CE = 0;
   
       for i = 1:size(C.scatter,1)
               point = C.scatter(i,1:2);

               distance1 = GED.getDistance(point, C.mu,C.covar) - GED.getDistance(point,D.mu,D.covar);
               distance2 = GED.getDistance(point, C.mu,C.covar) - GED.getDistance(point,E.mu,E.covar);

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
