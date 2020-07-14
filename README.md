# Pattern Recognition

# Lab 1 
lab 1 involves calculating orthogononal transformations, creating decision boundaries, and assigning classification errors. 

## step 1:
5 classes are devised: A,B, C, D, E. Class A and B are grouped as case 1 and Class C,D, and E are grouped as case 2. Each class contains the Gaussian bivariate distribution parameters: mean, covariance, and the number of samples. 

## step 2:
Synthetic data are generated as bivariate normally distributed using **randn()**. Contour and unit standard deviations for class A and B are plotted together on one plot and C, D, E on another plot. 

## step 3:
Five distance classfiers are used: **MED, GED, MAP,NN,and kNN**. For each case, the class samples, unit standard deviation contours,
the MED, MICD and MAP boundaries are on the same plot, and the class samples with the NN, 5NN boundaries on a separate plot. 

## step 4:
The experimental error rate and a confusion matrix are created for each classifier. What is a confusion matrix? The following link provides a good introduction:
https://towardsdatascience.com/understanding-confusion-matrix-a9ad42dcfd62.

# Lab 2

lab 2 involves model estimation and learning through both parametric and nonparametric methods using MLE and parzen windows (kernal density estimation).The following links describe the methodologies:

- https://milania.de/blog/Introduction_to_kernel_density_estimation_%28Parzen_window_method%29#mjx-eqn-eqParzenWindow_KernelDensity
- https://people.missouristate.edu/songfengzheng/Teaching/MTH541/Lecture%20notes/MLE.pdf

# Dynamic Time Warping
The dynamic time wapring project is a mini project where I used DTW algorithms to match predicted vs observed time series hydrologic data from a csv file. I also wrote a report about the use of DTW for hydrologic model calibration which you can find in the folder. 

# Acknowledgement: 
The labs were done in collaboration as part of SYDE372 at UWaterloo and involved other annonymous contributors. 
