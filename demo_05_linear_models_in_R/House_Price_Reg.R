##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# OLS Regression Demo
# Regression with Data from Spreadsheet
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# September 9, 2019
# 
##################################################
# 
# House_Price_Reg gives an example of OLS regression
#   using data imported from a spreadsheet.
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
wd_path <- '~/Teaching/GEB6895_Fall_2019/GitRepos/demo_05_OLS_in_R' # On Windows

setwd(wd_path)

# Check folder:
getwd()

# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)


##################################################
# Read the dataset and run regression
##################################################

# Read the newly saved dataset.
housing_data <- read.csv(file = 'housing_data.csv')

# Inspect the data.
summary(housing_data)


# Check that earthquakes occurred only in California:
table(housing_data[, 'in_cali'])
table(housing_data[, 'in_cali'], housing_data[, 'earthquake'])
# Data errors are the largest cause of problems in model-building.

class(housing_data)

colnames(housing_data)
head(housing_data[, 'income'], 10)
head(housing_data[, 3], 10)
head(housing_data[, 4], 10)

# Plot a scattergraph of income and housing prices. 
plot(housing_data[, 'income'], 
     housing_data[, 'house_price'], 
     main = c('House Prices vs. Income', '(all figures in millions)'), 
     xlab = 'Income', 
     ylab = 'House Prices', 
     col = 'blue')

# Calculate a correlation matrix for selected variables. 
corr_matrix <- cor(housing_data[, c('house_price', 'income', 'in_cali', 'earthquake')])
print(round(corr_matrix, 3))


##################################################
# Estimating the Regression Model
# Model 1: All Variables Included
##################################################

# Note the formula object:
# Y ~ X_1 + X_2 + X_3


# Estimate a regression model.
lm_full_model <- lm(data = housing_data, 
                    formula = house_price ~ income + in_cali + earthquake)

# Output the results to screen.
summary(lm_full_model)

# See what's inside the lm_full_model object:
class(lm_full_model)
attributes(lm_full_model)

lm_full_model$coefficients
lm_full_model$coefficients['income']
lm_full_model$coefficients[2]

coef(lm_full_model)

# Model predictions:
summary(predict(lm_full_model))
housing_data[, 'predictions'] <- predict(lm_full_model)

attributes(summary(lm_full_model))

lm_full_model_summ <- summary(lm_full_model)
lm_full_model_summ$adj.r.squared


##################################################
# Estimating the Regression Model
# Model 2: Omitting One Variable
##################################################

# Estimate a regression model.
lm_no_earthquakes <- lm(data = housing_data, 
                        formula = house_price ~ income + in_cali) # earthquake removed.

# Output the results to screen.
summary(lm_no_earthquakes)


##################################################
# 
# Exercise:
# 
# Observe the values of the coefficient for earthquakes.
# Then compare the change in coefficient on California 
# with and without the earthquake variable.
# 
##################################################

# If it helps, observe summary statistics 
# both with and without earthquakes.

summary(housing_data[housing_data[, 'earthquake'] == 0, ])

summary(housing_data[housing_data[, 'earthquake'] == 1, ])


##################################################
# Plot regression results for selected model.
##################################################


# Calculate the predictions from the fitted model.
housing_data[, 'predictions'] <- predict(lm_full_model, 
                                         newdata = housing_data)

summary(housing_data[, c('house_price', 'predictions')])

plot(housing_data[, c('house_price', 'predictions')],
     main = 'Regression Model Predictions', 
     xlab = 'House Price',
     ylab = 'Prediction')



# Plot the actual house prices against the regression model predictions.
plot(housing_data[, 'house_price'], housing_data[, 'predictions'],
     main = 'Regression Model Predictions', 
     xlab = 'House Price',
     ylab = 'Prediction')
points(housing_data[housing_data[, 'in_cali'] == 1, 'house_price'], 
       housing_data[housing_data[, 'in_cali'] == 1, 'predictions'],
       col = 'green')
points(housing_data[housing_data[, 'earthquake'] == 1, 'house_price'], 
       housing_data[housing_data[, 'earthquake'] == 1, 'predictions'],
       col = 'red')


##################################################
# Exercise: Add some regression lines to compare 
# the predictions to the actual observations. 
##################################################

# Plot the actual house prices against the regression model predictions.
plot(housing_data[, 'income'], housing_data[, 'house_price'],
     main = 'Regression Model Predictions', 
     xlab = 'Income',
     ylab = 'House Price')
points(housing_data[housing_data[, 'in_cali'] == 1, 'income'], 
       housing_data[housing_data[, 'in_cali'] == 1, 'house_price'],
       col = 'green')
points(housing_data[housing_data[, 'earthquake'] == 1, 'income'], 
       housing_data[housing_data[, 'earthquake'] == 1, 'house_price'],
       col = 'red')

# Use the lines() command to append to the above figure. 
# You will need to create a vector of values on the line
# using the regression coefficients from the estimated model. 

summary(lm_full_model)

coef(lm_full_model)
beta_0_hat <- coef(lm_full_model)['(Intercept)']
beta_income_hat <- coef(lm_full_model)['income']

income_grid <- seq(0.07, 0.13, by = 0.01)
reg_line_not_cali <- beta_0_hat + beta_income_hat*income_grid

lines(income_grid, reg_line_not_cali, 
      lwd = 3, col = 'black')

# Repeat for california without earthquakes (green)
# and earthquakes (red). 


##################################################
# End
##################################################

