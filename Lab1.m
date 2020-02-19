% Syde 372 Lab 1

close all;

% -----------------
% 1. define classes
% -----------------
NA = 200;
MuA = [5 10];
CovarA = [8 0;0 4];
Colour = 'r';
A = Class(MuA, CovarA, NA, Colour);

% class 2
NB = 200; 
MuB = [10 15];
CovarB = [8 0;0 4];
Colour = 'B';
B = Class(MuB, CovarB, NB, Colour);

% class 3
NC = 100;
MuC = [5 10];
CovarC = [8 4;4 40];
Colour = 'r';
C = Class(MuC, CovarC, NC, Colour);

% class 4
ND = 200;
MuD = [15 10];
CovarD = [8 0; 0 8];
Colour = 'g';
D = Class(MuD, CovarD, ND, Colour);

% class 5
NE = 150;
MuE = [10 5];
CovarE = [10 -5; -5 20];
Colour = 'b';
E = Class(MuE, CovarE, NE,Colour);

% ---------------------
% 2. Plot Classes and Standared Devation Contours
% ---------------------
figure(1);
hold on;
title('Scatter Plots of Class A and Class B');
legend([A.scatter, B.scatter], {'Class A', 'Class B'}, 'Location', 'northeast');
xlabel('X');
ylabel('Y');
axis equal;

A.plotClassScatter();
A.plotClassMean();
A.plotEllipses(A); 

B.plotClassScatter();
B.plotClassMean();
B.plotEllipses(B);

figure(2);
hold on;
title('Scatter Plots of Class A and Class B');
legend([A.scatter, B.scatter], {'Class A', 'Class B'}, 'Location', 'northeast');
xlabel('X');
ylabel('Y');

C.plotClassScatter();
C.plotClassMean();
C.plotEllipses(C); 

D.plotClassScatter();
D.plotClassMean();
C.plotEllipses(D);  

E.plotClassScatter();
E.plotClassMean();
E.plotEllipses(E); 

% ----------------
% Step 3 - MED, GED, MAP Classifiers
% ----------------
step = 3; % The smaller the number the more fine the meshgrid will be

figure(3);
hold on;
title('Scatter Plots of Class A and Class B');
% legend([A.scatter, B.scatter], {'Class A', 'Class B'}, 'Location', 'northeast');
xlabel('X');
ylabel('Y');
axis equal

A.plotClassScatter();
A.plotClassMean();
A.plotEllipses(A); 

B.plotClassScatter();
B.plotClassMean();
B.plotEllipses(B);

xRangeAB = min([A.scatter(:,1);B.scatter(:,1)])-1:step:max([A.scatter(:,1);B.scatter(:,1)])+1;
yRangeAB = min([A.scatter(:,2);B.scatter(:,2)])-1:step:max([A.scatter(:,2);B.scatter(:,2)])+1;
[XAB, YAB] = meshgrid(xRangeAB,yRangeAB);
boundry = MED.calculate(XAB, YAB, A, B);
MED.plotBoundry(XAB, YAB, boundry);
boundry = GED.calculate(XAB, YAB, A, B);
GED.plotBoundry(XAB, YAB, boundry);

%MAP boundry is equivelant to the GED Boundry (Overlap) becuase class A and
%B have the same det(covar) and the same prior (same size)

boundry = MAP.calculate(XAB, YAB, A, B);
MAP.plotBoundry(XAB, YAB, boundry);

figure(4);
hold on;
title('Scatter Plots of Classes C,D,E');
% legend([A.scatter, B.scatter], {'Class A', 'Class B'}, 'Location', 'northeast');
xlabel('X');
ylabel('Y');

C.plotClassScatter();
C.plotClassMean();
C.plotEllipses(C); 

D.plotClassScatter();
D.plotClassMean();
C.plotEllipses(D);  

E.plotClassScatter();
E.plotClassMean();
C.plotEllipses(E); 

xRangeCDE = min([C.scatter(:,1);D.scatter(:,1);E.scatter(:,1)])-1:step:max([C.scatter(:,1);D.scatter(:,1);E.scatter(:,1)])+1;
yRangeCDE = min([C.scatter(:,2);D.scatter(:,2);E.scatter(:,2)])-1:step:max([C.scatter(:,2);D.scatter(:,2);E.scatter(:,2)])+1;
[XCDE, YCDE] = meshgrid(xRangeCDE,yRangeCDE);
boundry = MED.calculate3(XCDE, YCDE, C, D, E);
MED.plotBoundry(XCDE, YCDE, boundry);

boundry = GED.calculate3(XCDE, YCDE, C, D, E);
GED.plotBoundry(XCDE, YCDE, boundry);

%will take into account the priors (size of the class) so D will have the
%hieghest prior and E will have the next highest. This will skew the GED
%Boundries infavor of the Green and Blue classes and take away space from
%the Red class

boundry = MAP.calculate3(XCDE, YCDE, C, D, E);
MAP.plotBoundry(XCDE, YCDE, boundry);

% 
% % ----------------
% % Step 3 - NN Classifier
% % ----------------
figure(5);
hold on;
title('Scatter Plots of Class A and Class B');
% legend([A.scatter, B.scatter], {'Class A', 'Class B'}, 'Location', 'northeast');
xlabel('X');
ylabel('Y');
axis equal

map = [1 0.7 0.7
    0.7 0.7 1];
colormap(map);

xRangeAB = min([A.scatter(:,1);B.scatter(:,1)])-1:step:max([A.scatter(:,1);B.scatter(:,1)])+1;
yRangeAB = min([A.scatter(:,2);B.scatter(:,2)])-1:step:max([A.scatter(:,2);B.scatter(:,2)])+1;
[XAB, YAB] = meshgrid(xRangeAB,yRangeAB);

boundry = kNN.calculate(XAB, YAB, A, B, 1)
kNN.plotBoundry(XAB, YAB, boundry, 'cyan')

A.plotClassScatter();
A.plotClassMean();
A.plotEllipses(A); 

B.plotClassScatter();
B.plotClassMean();
B.plotEllipses(B);

figure(6);
hold on;
title('Scatter Plots of Class A and Class B');
% legend([A.scatter, B.scatter], {'Class A', 'Class B'}, 'Location', 'northeast');
xlabel('X');
ylabel('Y');

map = [1 0.7 0.7
    0.7 1 0.7
    0.7 0.7 1];
colormap(map);

xRangeCDE = min([C.scatter(:,1);D.scatter(:,1);E.scatter(:,1)])-1:step:max([C.scatter(:,1);D.scatter(:,1);E.scatter(:,1)])+1;
yRangeCDE = min([C.scatter(:,2);D.scatter(:,2);E.scatter(:,2)])-1:step:max([C.scatter(:,2);D.scatter(:,2);E.scatter(:,2)])+1;
[XCDE, YCDE] = meshgrid(xRangeCDE,yRangeCDE);
boundry = kNN.calculate3(XCDE, YCDE, C, D, E, 1);
kNN.plotBoundry(XCDE, YCDE, boundry, 'cyan');

C.plotClassScatter();
C.plotClassMean();
C.plotEllipses(C); 

D.plotClassScatter();
D.plotClassMean();
D.plotEllipses(D);  

E.plotClassScatter();
E.plotClassMean();
E.plotEllipses(E); 

% ----------------
% Step 3 - KNN Classifiers
% ----------------
figure(7);
hold on;
title('Scatter Plots of Class A and Class B');
% legend([A.scatter, B.scatter], {'Class A', 'Class B'}, 'Location', 'northeast');
xlabel('X');
ylabel('Y');
axis equal

map = [1 0.7 0.7
    0.7 0.7 1];
colormap(map);

xRangeAB = min([A.scatter(:,1);B.scatter(:,1)])-1:step:max([A.scatter(:,1);B.scatter(:,1)])+1;
yRangeAB = min([A.scatter(:,2);B.scatter(:,2)])-1:step:max([A.scatter(:,2);B.scatter(:,2)])+1;
[XAB, YAB] = meshgrid(xRangeAB,yRangeAB);

boundry = kNN.calculate(XAB, YAB, A, B, 5);
kNN.plotBoundry(XAB, YAB, boundry, 'black');

A.plotClassScatter();
A.plotClassMean();
A.plotEllipses(A); 

B.plotClassScatter();
B.plotClassMean();
B.plotEllipses(B);

figure(8);
hold on;
title('Scatter Plots of Class A and Class B');
% legend([A.scatter, B.scatter], {'Class A', 'Class B'}, 'Location', 'northeast');
xlabel('X');
ylabel('Y');

map = [1 0.7 0.7
    0.7 1 0.7
    0.7 0.7 1];
colormap(map);

xRangeCDE = min([C.scatter(:,1);D.scatter(:,1);E.scatter(:,1)])-1:step:max([C.scatter(:,1);D.scatter(:,1);E.scatter(:,1)])+1;
yRangeCDE = min([C.scatter(:,2);D.scatter(:,2);E.scatter(:,2)])-1:step:max([C.scatter(:,2);D.scatter(:,2);E.scatter(:,2)])+1;
[XCDE, YCDE] = meshgrid(xRangeCDE,yRangeCDE);

boundry = kNN.calculate3(XCDE, YCDE, C, D, E, 5);
kNN.plotBoundry(XCDE, YCDE, boundry, 'black');

C.plotClassScatter();
C.plotClassMean();
C.plotEllipses(C); 

D.plotClassScatter();
D.plotClassMean();
D.plotEllipses(D);  

E.plotClassScatter();
E.plotClassMean();
E.plotEllipses(E); 

% -----------------------------------------------------------------------
% Error analysis for MED
[num_AB,num_AA,num_BA,num_BB] = MED.search2(A,B);
[num_CC, num_CD,num_CE] = MED.search3(C,D,E);
[num_DD, num_DC, num_DE] = MED.search3(D,C,E);
[num_EE, num_EC, num_ED] = MED.search3(E,C,D);
MED_confusion_matrix1 = zeros(2,2);
MED_confuison_matrix2 = zeros(3:3);
MED_confusion_matrix1(1:2,1:2) = [num_AA,num_AB;num_BA,num_BB]
MED_2class_error = 1 - (num_AA+num_BB)/(NA+NB)
MED_confusion_matrix2(1:3,1:3) = [num_CC,num_CD,num_CE;num_DC,num_DD,num_DE;num_EC,num_ED,num_EE]
MED_3class_error = 1 - (num_CC + num_DD + num_EE)/ (NC+ND+NE)

% Error analysis for GED
[num_AB,num_AA,num_BA,num_BB] = GED.search2(A,B);
[num_CC, num_CD,num_CE] = GED.search3(C,D,E);
[num_DD, num_DC, num_DE] = GED.search3(D,C,E);
[num_EE, num_EC, num_ED] = GED.search3(E,C,D);
GED_confusion_matrix1 = zeros(2,2);
GED_confuison_matrix2 = zeros(3:3);
GED_confusion_matrix1(1:2,1:2) = [num_AA,num_AB;num_BA,num_BB];
GED_2class_error = 1 - (num_AA+num_BB)/(NA+NB);
GED_confusion_matrix2(1:3,1:3) = [num_CC,num_CD,num_CE;num_DC,num_DD,num_DE;num_EC,num_ED,num_EE];
GED_3class_error = 1 - (num_CC + num_DD + num_EE)/ (NC+ND+NE);


% Error analysis for MAP
[num_AB,num_AA] = MAP.search2(A,B);
[num_BA, num_BB] = MAP.search2(B,A);
[num_CC, num_CD,num_CE] = MAP.search3(C,D,E);
[num_DD, num_DC, num_DE] = MAP.search3(D,C,E);
[num_EE, num_EC, num_ED] = MAP.search3(E,C,D);
MAP_confusion_matrix1 = zeros(2,2);
MAP_confuison_matrix2 = zeros(3:3);
MAP_confusion_matrix1(1:2,1:2) = [num_AA,num_AB;num_BA,num_BB]
MAP_2class_error = 1 - (num_AA+num_BB)/(NA+NB)
MAP_confusion_matrix2(1:3,1:3) = [num_CC,num_CD,num_CE;num_DC,num_DD,num_DE;num_EC,num_ED,num_EE]
MAP_3class_error = 1 - (num_CC + num_DD + num_EE)/ (NC+ND+NE)

% Error analysis for NN: k=1
[num_AB,num_AA] = kNN.search2(A,B,1,0.5);
[num_BA, num_BB] = kNN.search2(B,A,1,0.5);
[num_CC, num_CD,num_CE] = kNN.search3(C,D,E,1,0.5);
[num_DD, num_DC, num_DE] = kNN.search3(D,C,E,1,0.5);
[num_EE, num_EC, num_ED] = kNN.search3(E,C,D,1,0.5);
NN_confusion_matrix1 = zeros(2,2);
NN_confuison_matrix2 = zeros(3:3);
NN_confusion_matrix1(1:2,1:2) = [num_AA,num_AB;num_BA,num_BB]
NN_2class_error = 1 - (num_AA+num_BB)/(num_AA+num_AB+num_BA+num_BB)
NN_confusion_matrix2(1:3,1:3) = [num_CC,num_CD,num_CE;num_DC,num_DD,num_DE;num_EC,num_ED,num_EE]
NN_3class_error = 1 - (num_CC + num_DD + num_EE)/ (num_CC+num_CD+num_CE+num_DC+num_DD+num_DE+num_EC+num_ED+num_EE)

% Error analysis for KNN: k=5
[num_AB,num_AA] = kNN.search2(A,B,5,0.5);
[num_BA, num_BB] = kNN.search2(B,A,5,0.5);
[num_CC, num_CD,num_CE] = kNN.search3(C,D,E,5,0.5);
[num_DD, num_DC, num_DE] = kNN.search3(D,C,E,5,0.5);
[num_EE, num_EC, num_ED] = kNN.search3(E,C,D,5,0.5);
kNN_confusion_matrix1 = zeros(2,2);
kNN_confuison_matrix2 = zeros(3:3);
kNN_confusion_matrix1(1:2,1:2) = [num_AA,num_AB;num_BA,num_BB]
kNN_2class_error = 1 - (num_AA+num_BB)/(num_AA+num_AB+num_BA+num_BB)
kNN_confusion_matrix2(1:3,1:3) = [num_CC,num_CD,num_CE;num_DC,num_DD,num_DE;num_EC,num_ED,num_EE]
kNN_3class_error = 1 - (num_CC + num_DD + num_EE)/(num_CC+num_CD+num_CE+num_DC+num_DD+num_DE+num_EC+num_ED+num_EE)

