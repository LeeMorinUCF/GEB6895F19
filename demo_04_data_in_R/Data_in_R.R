
################################################################################
# 
# GEB 6895: Tools for Business Intelligence
# Introductory Examples: Data Loading and Manipulation
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# September 16, 2019
# 
################################################################################
# 
# This program provides introductory examples of R code for loading
# and handling data.
# 
# 
# 
################################################################################

# Clear workspace.
# The remove function removes everything in the workspace when the list is all.
rm(list=ls(all=TRUE))

# Load library of functions.
# source('MyRcode1.R')

# Load packages.
# library(name_of_R_package_goes_here)


# Set working directory.
# The '<-' operator denotes right-to-left assignment.
wd_path <- '/path/to/your/folder'
setwd(wd_path)


# Set paths to other folders.
# data_path <- sprintf('%s/data', wd_path)
# Optional: Organize data for larger projects.


################################################################################
# Reading and writing tables, csv files and data frames.
################################################################################


# Load some sample datasets and inspect their contents.

data(cars)

# Display the entire dataset (not for large files!).
cars  


# Write this to your data path.
# write.table(cars, file=sprintf('%s/%s', data_path, 'cars.txt'))
write.table(cars, file = 'cars.txt')

# Read in your copy.
# carsDf <- read.table(file=sprintf('%s/%s', data_path, 'cars.txt'))
carsDf <- read.table(file = 'cars.txt')

# Should be the same.



# Read in another sample dataset.
data(iris)

# Display the entire dataset (not for large files!).
iris


# Write this to your data path in csv format.
# write.csv(iris, file=sprintf('%s/%s', data_path, 'iris.csv'))
write.csv(iris, file = 'iris.csv')

# Read in your copy.
# irisDf <- read.csv(file=sprintf('%s/%s', data_path, 'iris.csv'))
irisDf <- read.csv(file = 'iris.csv')


# See what hapened on the file system (except on Windows).
# system('ls -lh data')
# Works on unix platforms. 


################################################################################
# Load data and analyze
################################################################################

# Reload the datasets created earlier.

# The cars dataset.
# carsDf <- read.table(file=sprintf('%s/%s', data_path, 'cars.txt'))
carsDf <- read.table(file = 'cars.txt')
carsDf

# This is a data frame:
class(carsDf)

# Summarize the data.
summary(carsDf)

# Get the dimensions of the data.
dim(carsDf)

# Get the numbers of rows and columns separately.
nrow(carsDf)
ncol(carsDf)

# Show the first few rows of the dataset.
head(carsDf)

# Show the column names of the data.
colnames(carsDf)


# Select a variable using numeric indices.
carsDf[2:5,2]


# Select a variable using variable names.
carsDf[2:5,'dist']
carsDf$dist[2:5]

# The second approach is a compound statement,
# taking a subset of rows from a single column.
summary(carsDf$dist)


# You can also select using logical arguments.
colnames(carsDf) == 'dist'
carsDf[2:5, colnames(carsDf) == 'dist']

# Another approach.
selCols <- substring(colnames(carsDf), 1, 1) == 'd'
carsDf[2:5, selCols]


# Select based on values.
summary(carsDf$speed)
selRows <- carsDf$speed > mean(carsDf$speed)
carsDf[selRows, ]
# The empty argument in [,] select all elements.


# A data frame is essentially a list of objects.
class(carsDf$dist)




# The iris dataset has categorical variables.
# irisDf <- read.csv(file=sprintf('%s/%s', data_path, 'iris.csv'))
irisDf <- read.csv(file = 'iris.csv')
irisDf


# This is also a data frame:
class(irisDf)

# Summarize the data.
summary(irisDf)

# Get the dimensions of the data.
dim(irisDf)

# Get the numbers of rows and columns separately.
nrow(irisDf)
ncol(irisDf)

# Show the first few rows of the dataset.
head(irisDf)

# Show the column names of the data.
colnames(irisDf)

# The last column is a factor.
class(irisDf$Species)
levels(irisDf$Species)


# For factors, it is often useful to create a table.
# Create a table of counts of each level.
table(irisDf$Species)


# Could put two arguments for a two-dimensional table.
table(irisDf$Species, irisDf$Petal.Width)
# You can see that different species have different widths.



# Create new variables.
irisDf$Petal.Area <- irisDf$Petal.Width * irisDf$Petal.Length
summary(irisDf)

# Drop this variable and reorganize.
columnsToKeep <- c('Species', 'Petal.Length', 'Petal.Width', 'Sepal.Length', 'Sepal.Width')
irisDf <- irisDf[,columnsToKeep]
summary(irisDf)



# Create a new data frame.
irisAreaDf <- data.frame(Species=irisDf$Species,
                         Petal.Area=irisDf$Petal.Width * irisDf$Petal.Length)
summary(irisAreaDf)



# Bind columns to the side of a data frame.
irisWideDf <- cbind(irisDf, irisAreaDf)
summary(irisWideDf)



# Bind additional rows below.
irisTallDf <- rbind(irisDf, irisDf)
summary(irisTallDf)

# Twice as many rows.
nrow(irisTallDf)




# Remove duplicates.
irisDf2 <- irisDf[!duplicated(irisDf$Species),]
irisDf2
# In this case, this selects one of each. 



# Sort the data by one variable.
irisDf[order(irisDf$Petal.Length),]




################################################################################
# End
################################################################################



