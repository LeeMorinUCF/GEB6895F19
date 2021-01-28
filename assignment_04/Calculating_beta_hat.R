##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# OLS Regression Demo
# Regression with Data Entered Directly into the Script
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# September 16, 2019
# 
##################################################
# 
# Calculating_beta_hat gives an example of OLS regression
#   using data entered within this script.
#   It includes exercises to calculate the OLS
#   estimates from direct calculation and optimization.
# 
# Dependencies:
#   None. 
# 
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder' 
# Not required, since this program does not interact with other files.

# setwd(wd_path)

# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)


##################################################
# Enter the dataset and run regression
##################################################

# Enter the numbers in the dataset.
income_data  <- c(14, 18, 18, 16, 16, 26, 20, 18, 20, 22)
agg_pct_data <- c(9, 10, 8, 7, 10, 4, 5, 5, 6, 7)
agg_data <- data.frame(income = income_data, 
                       agg_pct = agg_pct_data)

# Inspect the data.
summary(agg_data)

# Plot a scattergraph of income and housing prices. 
plot(agg_data[, 'income'], 
     agg_data[, 'agg_pct'], 
     main = 'Aggregate Income vs. Pct. in Agriculture', 
     xlab = 'Income', 
     ylab = 'Pct. in Agriculture', 
     col = 'blue')



# Estimate a regression model.
lm_model <- lm(data = agg_data, 
                 formula = income ~ agg_pct)

# Output the results to screen.
summary(lm_model)

# Store the slope coefficient. 
beta_1_hat_lm <- NA


##################################################
# Estimating beta from direct calculation
##################################################

# Calculate the estimate of the slope coefficient above. 

y <- agg_data[, 'income']
x <- agg_data[, 'agg_pct']

# ...

beta_1_hat_calc <- NA

# Compare with the output above. 


##################################################
# Estimating beta from solving equations
##################################################

# Part i: Define matrices for normal equations.

X_T_x <- NA

X_T_y <- NA

# Part ii: Solve the equations for beta. 

beta_hat_norm <- NA


##################################################
# Estimating beta from optimization
##################################################

# Part i: Sum of Squared residuals.

# Note that beta is a vector of two coefficients. 

ssr <- function(beta, y, x) {
  
  beta_0 <- beta[1]
  beta_1 <- beta[2]
  
  # ...
  
  ssr <- NA
  
  return(ssr)
}

# Part ii: Plot the SSR function on a graph.

# Draw several lines for fixed values of beta_0, 
# with candidate values of beta_1 on the horizontal axis.

# Verify that the maximum is at the beta_hat estimate.


# Part iii: Optimize the SSR function w.r.t. beta. 

# ...

beta_hat_opt <- NA


# Compare with the output above. 


##################################################
# End
##################################################

