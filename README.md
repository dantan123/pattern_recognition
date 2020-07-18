# Pattern Recognition

# Dynamic Time Warping
The dynamic time wapring project is a mini project during my research internship where I explored R's DTW library and delved into the algorithms for matching predicted vs observed time series hydrologic data in the csv format. I even wrote a report about the use of DTW for hydrologic model calibration which you can find in the folder. Enjoy :)!

# Project 1: Clusters & Classification Boundaries
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

# Project 2: Model Estimation & Discriminant Functions

lab 2 involves model estimation and learning through both parametric and nonparametric methods using MLE and parzen windows (kernal density estimation) as well as sequential discriminants. 

## 2D parametric & non-parametric estimations:
- For the parametric estimation, each cluster is assumed to be normally distributed. The mean & sample variance are determined and the ML (maximum liklihood) classification boundaries are plotted. The cluster data are superimposed with the classification boundaries on the plot.

- For the non-parametric estimation, a Gaussian parzen window is used to estimate a PDF for each cluster. The ML classifier is applied to the estimated PDFs
and the classfication boundaries are plotted together with the cluster data. 

Those links explain the methodologies: 
- https://milania.de/blog/Introduction_to_kernel_density_estimation_%28Parzen_window_method%29#mjx-eqn-eqParzenWindow_KernelDensity
- https://people.missouristate.edu/songfengzheng/Teaching/MTH541/Lecture%20notes/MLE.pdf

## Sequential Discriminants
Points are stored in the format of (x,y) format. For a given discriminant G, there is the probability that P(true class is Ci|G says Ck). The idea is to have at least one class Ci close to the probability of being 1. 

The following algorithm is used:
1. Let a and b represent points in classes A and B. Let j = 1. 
2. Randomly select one point from A and one point from B
3. Create a discriminant G using MED with two points as prototypes
4. Based on the data in a and b, construct the confusion matrices where 
    naB = #times G classifies a point from a as class B
    nbA = #times G classifies a point from b as class A
5. If neither naB nor nbA are equal to 0, return to step 2.
6. The discrimiant is 0 and it is saved as
    Gj = G, naB,j = naB, nbA,j = nbA, j = j + 1
7. If naB = 0, remove all points from b that G classifies as B.
8. If nbA = 0, remove all points from a that G classifies as A. 
9. If a and b still contain points, return to step 2. 

# Acknowledgement: 
The projects were done in collaboration as part of SYDE372 at UWaterloo and involved other annonymous contributors. 
