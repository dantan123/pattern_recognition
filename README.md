# Pattern Recognition

# Lab 1 
lab 1 involves calculating orthogononal transformations, creating decision boundaries, and assigning classification errors. 

## step 1:
5 classes are devised: A, B, C, D, E. Class A and B are grouped as case 1 and Class C, D, and E are grouped as case 2. Each class contains the Gaussian bivariate distribution parameters: mean, covariance, and the number of samples. 

## step 2:
Synthetic data are generated as bivariate normally distributed using **randn()**. Contour and unit standard deviations for class A and B are plotted together on one plot and C, D, E on another plot. 

## step 3:
Five distance classfiers are used: **MED, GED, MAP,NN,and kNN**. For each case, the class samples, unit standard deviation contours,
the MED, MICD and MAP boundaries are on the same plot, and the class samples with the NN, 5NN boundaries on a separate plot. 

## step 4:
The experimental error rate and a confusion matrix are created for each classifier. The following link explains how a confusion matrix works:
https://towardsdatascience.com/understanding-confusion-matrix-a9ad42dcfd62.

## Key Observations:
After investigating the various classifications methods, the MAP classifier was found to perform the best out of all the classifiers. This is expected since MAP accounts for both probability and distance measures. The NN and kNN classifiers are generally accurate around decision boundaries. However, they tend to overfit the test data and are sensitive to outliers as well as computationally expensive.

# Lab 2

lab 2 involves model estimation and learning through both parametric and nonparametric methods using MLE and parzen windows (kernal density estimation) as well as sequential discriminants. 

## 2D parametric & non-parametric estimations:
- For the parametric estimation, each cluster is assumed to be normally distributed. The mean & sample variance are determined and the ML (maximum liklihood) classification boundaries are plotted. The cluster data are superimposed with the classification boundaries on the plot.

- For the non-parametric estimation, a Gaussian parzen window is used to estimate a PDF for each cluster. The ML classifier is applied to the estimated PDFs
and the classfication boundaries are plotted together with the cluster data. 

Those links explain the methodologies: 
- https://milania.de/blog/Introduction_to_kernel_density_estimation_%28Parzen_window_method%29#mjx-eqn-eqParzenWindow_KernelDensity
- https://people.missouristate.edu/songfengzheng/Teaching/MTH541/Lecture%20notes/MLE.pdf

## Sequential Discriminants
...

# Dynamic Time Warping
The dynamic time wapring project is a mini project during my research internship where I used DTW algorithms to match predicted vs observed time series hydrologic data from a csv file. I also wrote a report about the use of DTW for hydrologic model calibration which you can find in the folder. 

# Acknowledgement: 
The labs were done in collaboration as part of SYDE372 at UWaterloo and involved other annonymous contributors. 
