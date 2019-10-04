##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# Machine Learning Demo
# k-means Clustering
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# October 3, 2019
# 
##################################################
# 
# Clustering.R demonstrates k-means clustering analysis.
# 
##################################################



##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)

# Set working directory
# (could do this using buttons in File panel).
setwd("~/Teaching/GEB6895_Fall_2019/GitRepos/demo_09_machine_learning_in_R")


##################################################
# Loading Data
##################################################

# Start with a well-known dataset
data(iris)

summary(iris)

# Summarize separately for each type of flower.
summary(iris[iris[, 'Species'] == 'setosa', ])
summary(iris[iris[, 'Species'] == 'versicolor', ])
summary(iris[iris[, 'Species'] == 'virginica', ])

# Plot a scattergraph by species.
x_var <- 'Petal.Length'
y_var <- 'Petal.Width'
# x_var <- 'Sepal.Length'
# y_var <- 'Sepal.Width'
plot(iris[iris[, 'Species'] == 'setosa', x_var], 
     iris[iris[, 'Species'] == 'setosa', y_var], 
     main = 'Comparison of Iris Species', 
     xlab = x_var, 
     ylab = y_var, 
     xlim = c(min(iris[, x_var]), max(iris[, x_var])), 
     ylim = c(min(iris[, y_var]), max(iris[, y_var])), 
     col = 'blue', pch = 19)
points(iris[iris[, 'Species'] == 'versicolor', x_var], 
       iris[iris[, 'Species'] == 'versicolor', y_var], 
       col = 'red', pch = 19)
points(iris[iris[, 'Species'] == 'virginica', x_var], 
       iris[iris[, 'Species'] == 'virginica', y_var], 
       col = 'green', pch = 19)





##################################################
# Clustering Analysis
##################################################

# Perform clustering anaysis using the numerical variables only.
# Goal is to demonstrate the technique by recovering the species.
clust_var_list <- colnames(iris)[1:4]

# Estimate with chosen number of clusters.
k <- 3
k_Clusters <- kmeans(iris[, clust_var_list], centers = k)



# Summarize and investigate segmentation.
# summary(k_Clusters)

# Verify WSS (Within Sum of Squares) for chosen -means. 
sum(k_Clusters$withinss) # The value of the objective function. 

# Calculate the number of observations in each cluster.
table(k_Clusters$cluster)

# Display the centers of the clusters.
k_Clusters$centers


# Assign cluster centers and classes.
iris[,'classes'] <- fitted(k_Clusters, method = 'classes')
iris[,'centers'] <- fitted(k_Clusters, method = 'centers')

# Tabulate counts in each class by species. 
table(iris[,'classes'], iris[,'Species'], useNA = 'ifany')
# Note that, with 3 clusters, almost all are on the diagonal.
# Only a few are miclassified. 


# Plot a scattergraph by cluster.
color_list <- rainbow(k)
x_var <- 'Petal.Length'
y_var <- 'Petal.Width'
# x_var <- 'Sepal.Length'
# y_var <- 'Sepal.Width'
cluster_num <- 1
plot(iris[iris[, 'classes'] == cluster_num, x_var], 
     iris[iris[, 'classes'] == cluster_num, y_var], 
     main = 'Comparison of Iris Clusters', 
     xlab = x_var, 
     ylab = y_var, 
     xlim = c(min(iris[, x_var]), max(iris[, x_var])), 
     ylim = c(min(iris[, y_var]), max(iris[, y_var])), 
     col = color_list[cluster_num], pch = 19)
for (cluster_num in 2:k) {
  
  points(iris[iris[, 'classes'] == cluster_num, x_var], 
         iris[iris[, 'classes'] == cluster_num, y_var], 
         col = color_list[cluster_num], pch = 19)
  
}
# With k = 3 clusters (the correct number of species)
# this looks very much like the plot by species.



##################################################
# End
##################################################

