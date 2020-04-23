library("dtw")

# specify library path
.libPaths()

# generate comparisons of hydrograph

# load the sample data
setwd("/Applications/DTW/")
hy <- read.csv("Irondequoit_Hydrographs.csv")

Hydro.sim <- hy[,c(6)]
Hydro.obs <- hy[,c(5)]

# average alignment distance for non-dtw 
Hydro.length <- length(Hydro.obs)
overall.distance <- 0

for (i in 3:Hydro.length)
{
  distance <- Hydro.obs[i] - Hydro.sim[i]
  print(distance)
  overall.distance <- abs(distance) + overall.distance
  print(overall.distance)
}

average.distance <- overall.distance/Hydro.length
print(average.distance)

# par(mfrow = c(3,3))

ref <- window(Hydro.obs, start = 100, end = 300)
test <- window(Hydro.sim, start = 100, end = 300)

# observed vs simulated
plot(test, col = 'black',type ='l')
lines(ref,col = 'red')

# global windowing constraints
dtwWindow.plot(itakuraWindow, main="So-called Itakura parallelogram window")
dtwWindow.plot(slantedBandWindow, window.size=2,
               reference=13, query=17, main="The slantedBandWindow at window.size=2")

# Choose which step pattern to use

alignment.rj <- dtw(test,ref, k = TRUE,
                    step.pattern = rabinerJuangStepPattern(4, "c", TRUE))
rj.avg <- alignment.rj$normalizedDistance
dtwPlotTwoWay(alignment.rj, test, ref)

alignment.as <- dtw(test, ref, k = TRUE, step.pattern = asymmetric)
as.avg <- alignment.as$normalizedDistance

alignment.s1 <- dtw(test, ref, k = TRUE, step.pattern = symmetric1)
s1.avg <- alignment.s1$normalizedDistance

alignment.s2 <- dtw(test, ref, k = TRUE, step.pattern = symmetric2)
s2.avg <- alignment.s2$normalizedDistance

smallest.avg <- min(rj.avg, as.avg, s1.avg, s2.avg, na.rm = TRUE)

if (rj.avg == smallest.avg && is.na(rj.avg) == FALSE) {
  print("Use rabinerJuangStepPattern")
  dtwPlotTwoWay(alignment.rj, test, ref)
} else if (as.avg == smallest.avg && is.na(as.avg) == FALSE) {
  print("Use Asymmetric step pattern")
  dtwPlotTwoWay(alignment.as, test, ref)
} else if (s1.avg == smallest.avg && is.na(s1.avg) == FALSE) {
  print("Use Symmetric 1 step pattern")
  dtwPlotTwoWay(alignment.s1, test, ref)
} else if (is.na(s2.avg) == FALSE) {
  print("Use Symmetric 2 step pattern")
  dtwPlotTwoWay(alignment.s2, test, ref)
} else {
  print("Try again")
}

# # plotting local cost matrix
dtwPlotThreeWay(alignment.s2, test, ref)

ratio <- average.distance / alignment.rj$normalizedDistance
print(ratio)

# Export a csv file
write.csv(ratio, file = "dtwmetric.csv")
