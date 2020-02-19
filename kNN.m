classdef kNN
   methods (Static = true)
       function plotBoundry(xRange, yRange, boundry, colour)
            contourf(xRange,yRange,boundry,'Color', colour);
       end
       
       % seperate test and training data
          function [distance] = getDistanceTokNN(point, class, k,factor)
           infColumn = Inf(size(class.scatter, 1),1);
           scatterDistance = [class.scatter infColumn];
           for i=factor*size(class.scatter, 1)+1:size(class.scatter,1)
               % point is 2 * 1 array
               % scatterDistance(i, 3) = sqrt((point - potential_proto) * (point - potential_proto)');
               scatterDistance(i,3) = sqrt(((point(1,1)-class.scatter(i,1))^2 + (point(1,2)-class.scatter(i,2))^2))
           end
           
           % sort distances in ascending order
           sortedDistances = sortrows(scatterDistance, 3)
           
           % nn case
           if(k<=1)
               distance = sortedDistances(1,3);
               
           % knn case
           else
               nearestPrototypes = sortedDistances(1:k,3);
               prototype = mean(nearestPrototypes);
               distance = prototype;
           end
       end
       
       
%        function calculate(A, B, k)
%         point = [4 5];
%         x = KNN.getDistanceToKNN(point,A,k);
%         y = KNN.getDistanceToKNN(point,B,K);
%         fprintf('%i\n', x)
%         fprintf('%i\n', y)
%        end
    %         

        function [classMap] = calculate(xRange, yRange, A, B, k)
                classMap = zeros(size(xRange, 1), size(yRange, 2));
                for i=1:size(xRange, 1)
                    for j=1:size(yRange, 2)
                        fprintf('%i\n', i)
                        point = [xRange(i, j) yRange(i, j)];
                        distance = kNN.getDistanceTokNN(point, A,k,0) - kNN.getDistanceTokNN(point, B,k,0); 
                        if(distance > 0)
                            classMap(i,j) = 1; 
                        else
                            classMap(i,j) = -1;
                        end
                    end
                end
        end

       function [ classMap ] = calculate3(xRange, yRange, C, D, E, k)
            classMapCD = kNN.calculate(xRange, yRange, C, D, k);
            classMapCE = kNN.calculate(xRange, yRange, C, E, k);
            classMapDE = kNN.calculate(xRange, yRange, D, E, k);
            
            classMap = zeros(size(xRange, 1), size(yRange, 2));
            for i=1:size(xRange, 1)
                for j=1:size(yRange, 2)
                    classMap(i, j) = Class.min(classMapCD(i, j), classMapCE(i, j), classMapDE(i, j));
                end
            end
       end
    
       
       
   % error analysis for NN/KNN
   % factor for seperating training and testing data; set factor to 0.5
   % when calling
   
       function [num_AB,num_AA] = search2(A,B,k,factor)

         num_AB = 0;
         num_AA = 0;
         
         % for testing
         % for i = 1:20
          for i= 1: factor * size(A.scatter,1)
             
                % for all points in class A
                % two columns
                 point = A.scatter(i,1:2)
                 distance =  kNN.getDistanceTokNN(point, A,k,factor) - kNN.getDistanceTokNN(point, B,k,factor); 
                 if distance > 0
                     % closer to B
                     num_AB = num_AB + 1
                 else 
                     num_AA = num_AA + 1
                 end  
         end
         
       end
       
   
   function [num_CC, num_CD,num_CE] = search3(C,D,E,k,factor)
   num_CC = 0;
   num_CD = 0;
   num_CE = 0;
   
        %for i = 1:20
        for i = 1: factor * size(C.scatter,1)
               point = C.scatter(i,1:2);

               distance1 = kNN.getDistanceTokNN(point,C,k,factor) - kNN.getDistanceTokNN(point,D,k,factor); 
               distance2 = kNN.getDistanceTokNN(point,C,k,factor) - kNN.getDistanceTokNN(point,E,k,factor);

               if distance1 < 0 && distance2 < 0
                   % classified as C:
                   num_CC = num_CC + 1
               elseif distance1 > 0 && distance2 < 0
                   % classified as D
                   % closer to D between C and D and closer to C between C
                   % and E
                   num_CD = num_CD + 1
               else
                   % otherwise, classified as E
                   num_CE = num_CE + 1
               end
       end
   end
   
   end
end