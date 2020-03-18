classdef MED 
   methods (Static = true)
   
       function plotBoundry (xRange, yRange, boundry)
            contour(xRange,yRange,boundry, 'Color', 'magenta');
       end
       
       function int = getDistance(point, mean)
%             int = ((point(1,1)- mean(1,1))^2 + (point(1,2)- mean(1,2))^2)^(1/2)
            int = sqrt((point - mean) * (point - mean)');
       end
       
       function [ classMap ] = calculate(xRange, yRange, A, B)
            classMap = zeros(size(xRange, 1), size(yRange, 2));

            for i=1:size(xRange, 1)
                for j=1:size(yRange, 2)
                    point = [xRange(i, j) yRange(i, j)];
                    distance = MED.getDistance(point, A.mu) - MED.getDistance(point, B.mu); 
                    if(distance > 0)
                        classMap(i,j) = 1; 
                    else
                        classMap(i,j) = -1;
                    end
                end
            end
       end
       
       function [ classMap ] = calculate3(xRange, yRange, C, D, E)
            classMapCD = MED.calculate(xRange, yRange, C, D);
            classMapCE = MED.calculate(xRange, yRange, C, E);
            classMapDE = MED.calculate(xRange, yRange, D, E);
            
            classMap = zeros(size(xRange, 1), size(yRange, 2));
            for i=1:size(xRange, 1)
                for j=1:size(yRange, 2)
                    classMap(i, j) = Class.min(classMapCD(i, j), classMapCE(i, j), classMapDE(i, j));
                end
            end
       end
      
     

       % error analysis
       function [num_AB,num_AA,num_BA,num_BB] = search2(A,B)

         num_AB = 0;
         num_AA = 0;
         for i=1:size(A.scatter,1)
                % for all points in class A
                 point = A.scatter(i,1:2);
                 distance = MED.getDistance(point, A.mu) - MED.getDistance(point, B.mu);
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
                 distance = MED.getDistance(point, B.mu) - MED.getDistance(point, A.mu);
                 if distance > 0
                     num_BA = num_BA + 1;
                 else
                     num_BB = num_BB + 1;
                 end
         end
         
       end
       
   
   function [num_CC, num_CD,num_CE] = search3(C,D,E)
   num_CC = 0;
   num_CD = 0;
   num_CE = 0;
   
       for i = 1:size(C.scatter,1)
               point = C.scatter(i,1:2);

               distance1 = MED.getDistance(point, C.mu) - MED.getDistance(point,D.mu);
               distance2 = MED.getDistance(point, C.mu) - MED.getDistance(point,E.mu);

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
