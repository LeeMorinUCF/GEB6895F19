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

# My answers:
# lm(formula = income ~ agg_pct, data = agg_data)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max
# -3.1002 -2.3142  0.0905  1.8765  3.8044
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)
# (Intercept)  26.5770     3.0685   8.661 2.45e-05 ***
#   agg_pct      -1.0954     0.4156  -2.635   0.0299 *
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 2.658 on 8 degrees of freedom
# Multiple R-squared:  0.4647,	Adjusted R-squared:  0.3978
# F-statistic: 6.945 on 1 and 8 DF,  p-value: 0.02993
# 
# >
# beta_1 is -1.09

# Store the slope coefficient. 
beta_1_hat_lm <- summary(lm_model)$coefficients['agg_pct', 'Estimate']
beta_1_hat_lm <- coef(lm_model)['agg_pct']

print(beta_1_hat_lm)

##################################################
# Estimating beta from direct calculation
##################################################

# Calculate the estimate of the slope coefficient above. 

y <- agg_data[, 'income']
x <- agg_data[, 'agg_pct']


# From the formula:
beta_1_hat_calc <- sum((y - mean(y)) * (x - mean(x)))/sum((x - mean(x))^2)

# From the relationship between covariance, variance and correlation: 
beta_1_hat_calc <- cor(x, y) * (sd(y) / sd(x))

# Compare with the output above. 
print(beta_1_hat_calc)

##################################################
# Estimating beta from solving equations
##################################################

# Part i: Define matrices for normal equations.

# Vector version (not required but very nice):

ones <- rep(1, length(x))
z <- cbind(ones, x)
t(z)

X_T_x <- t(z)%*%z

X_T_y <- t(z)%*%y

# Scalar version (direct from the formula given):

X_T_x <- matrix(c(length(x), sum(x), sum(x), sum(x^2)), 
                nrow = 2, ncol = 2)

X_T_y <- matrix(c(sum(y), sum(x*y)), 
                nrow = 2, ncol = 1)

# Part ii: Solve the equations for beta. 

beta_hat_norm <- solve(X_T_x, X_T_y)

# Select the second element (they are calculated together). 
beta_1_hat_norm <- beta_hat_norm[2]

# Compare with the output above. 
print(beta_1_hat_norm)


##################################################
# Estimating beta from optimization
##################################################

# Part i: Sum of Squared residuals.

# Note that beta is a vector of two coefficients. 

# Notation to match f(x, a, b)
# where f() -> ssr(), x -> beta, a -> y, b -> x

# Test with this:
beta_test_ssr <- c(coef(lm_model)['(Intercept)'], 
                   coef(lm_model)['agg_pct'])

ssr <- function(beta, y, x) {
  
  beta_0 <- beta[1]
  beta_1 <- beta[2]
  
  
  ssr <- sum((y - beta_0 - beta_1*x)^2)
  
  return(ssr)
}

# 
sqrt(ssr(beta_test_ssr, y, x)/8)
# Should get: 
# Residual standard error: 2.658

# Part ii: Plot the SSR function on a graph.

# Draw several lines for fixed values of beta_0, 
# with candidate values of beta_1 on the horizontal axis.


# An example of one such line:
beta_0_plot <- coef(lm_model)['(Intercept)']
beta_1_plot <- seq(-1.4, -0.8, by = 0.01)
# Calculate corresponding values of SSR:
ssr_plot = rep(NA, length(beta_1_plot))
for (i in 1:length(beta_1_plot)) {
  
  beta_test_ssr_plot <- c(beta_0_plot, beta_1_plot[i])
  ssr_plot[i] <- ssr(beta_test_ssr_plot, y, x)
}

# Now plot this line. 
plot(beta_1_plot, ssr_plot, 
     main = c('Plot of SSR Function', 'for different values of beta_0'), 
     xlab = 'beta_1',
     ylab = 'SSR',
     type = 'l', lwd = 3)
# Repeat for a few other values of beta_0_plot
# and add to the plot with lines().

beta_0_plot_list <- c(24, 25, 26, 27, 28)
color_list <- rainbow(length(beta_0_plot_list))
for (beta_0_num in 1:length(beta_0_plot_list)) {
  
  beta_0_plot <- beta_0_plot_list[beta_0_num]
  
  # Generate another series to plot
  ssr_plot = rep(NA, length(beta_1_plot))
  for (i in 1:length(beta_1_plot)) {
    
    beta_test_ssr_plot <- c(beta_0_plot, beta_1_plot[i])
    ssr_plot[i] <- ssr(beta_test_ssr_plot, y, x)
  }
  
  # Plot this line with the others.
  lines(beta_1_plot, ssr_plot, 
       col = color_list[beta_0_num], lwd = 2)
  
}



# Verify that the maximum is at the beta_hat estimate.


# Part iii: Optimize the SSR function w.r.t. beta. 

# ...

beta_hat_opt <- optim(par = c(0, 0), fn = ssr, y = y, x = x)


# Extract the estimate of the slope coefficient.
beta_1_hat_opt <- beta_hat_opt$par[2]

# Compare with the output above. 
print(beta_1_hat_opt)



##################################################
# Practice with graphs
##################################################


# Plot a scattergraph of income and housing prices. 
plot(agg_data[, 'income'], 
     agg_data[, 'agg_pct'], 
     main = 'Aggregate Income vs. Pct. in Agriculture', 
     sub = 'Subtitle goes here', 
     xlab = 'Income', 
     ylab = 'Pct. in Agriculture', 
     xlim = c(10, 30),
     ylim = c(0, 12),
     col = 'blue')
points(agg_data[, 'income'], 
       agg_data[, 'agg_pct'] + 1, 
       col = 'red')
points(20, 6, col = 'magenta', pch = 16)
points(20, 6, col = 'yellow', pch = 20)
abline(lm_model)
abline(a = 4, # Intercept
       b = 0.1,  # Slope
       lwd = 3, col = 'red')
abline(h = c(10, 25), v = c(3, 10), 
       lwd = 3, col = 'green')
abline(h = c(10, 25), 
       lwd = 3, col = 'yellow')
abline(v = c(17), 
       lwd = 3, col = 'magenta')




plot(agg_data[, 'income'], 
     agg_data[, 'agg_pct'])



# Example of line.
x_vec <- seq(0, 5, by = 0.01)
y_vec <- (x_vec - 2)^2 - 1


plot(x_vec, y_vec, 
     main = 'Title goes here', 
     type = 'l', 
     lwd = 3, # line width.
     col = 'blue')
lines(x_vec, y_vec + 1, col = 'red')
points(x_vec, y_vec + 2, col = 'green')


plot(x_vec, y_vec, 
     main = 'Title goes here', 
     type = 'l', 
     lwd = 3, # line width.
     col = 'black')
color_list <- rainbow(7)
for (i in 1:7) {
  lines(x_vec, y_vec + i, col = color_list[i])
}

##################################################
# End
##################################################
