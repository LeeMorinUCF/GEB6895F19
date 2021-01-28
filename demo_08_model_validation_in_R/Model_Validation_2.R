##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# OLS Regression Demo
# Effects of Omitted Variables and 
# Testing for Misspecification from Omitted Variables
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
# Model_Validation gives an example of regression model testing
#   by first estimating a model with omitted variables on a training dataset
#   and then detecting the misspecification on a testing dataset.
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
# setwd("~/Teaching/GEB6895_Fall_2019/GitRepos/demo_08_model_validation_in_R")
setwd('/cloud/project') # On RStudio Cloud.

# Read function for sampling data. 
source('House_Price_Sim_Data.R')
# This is the same as running the House_Price_Sim_Data.R script first.
# It assumes that the script is saved in the same working folder.


##################################################
# Setting the Parameters
##################################################

# Dependent Variable: Property values (in Millions)

beta_0          <-   0.10    # Intercept
beta_income     <-   5.00    # Slope ceofficient for income
beta_cali       <-   0.25    # Slope coefficient for California
beta_earthquake <- - 0.50    # Slope coefficient for earthquake
# beta_earthquake <- - 0.00    # Slope coefficient for earthquake

# Distribution of incomes (also in millions).
avg_income <- 0.1
sd_income <- 0.01

# Fraction of dataset in California.
pct_in_cali <- 0.5

# Frequency of earthquakes (only in California).
# prob_earthquake <- 0.05
prob_earthquake <- 0.15 # More earthquakes to illustrate. 

# Additional terms:
sigma_2 <- 0.1        # Variance of error term
num_obs <- 200        # Number of observations in entire dataset
num_obs_estn <- 100   # Number of observations for estimation.
# Notice num_obs is twice as large, saving half for out-of-sample testing.

# Select the variables for estimation at random. 
obsns_for_estimation <- runif(num_obs) < num_obs_estn/num_obs
# Test how many are in each sample. 
table(obsns_for_estimation)



##################################################
# Generating the Data
##################################################

# Call the housing_sample function from ECO6416_Sim_Data.R. 
housing_data <- housing_sample(beta_0, beta_income, beta_cali, beta_earthquake, 
                               avg_income, sd_income, pct_in_cali, prob_earthquake, 
                               sigma_2, num_obs)

# Summarize the data.
summary(housing_data)

# Check that earthquakes occurred only in California:
table(housing_data[, 'in_cali'], housing_data[, 'earthquake'])
# Data errors are the largest cause of problems in model-building.

# Check for the subsamples for estimation and testing. 
# Estimation sample:
table(housing_data[obsns_for_estimation, 'in_cali'], 
      housing_data[obsns_for_estimation, 'earthquake'])
# Testing sample:
table(housing_data[!obsns_for_estimation, 'in_cali'], 
      housing_data[!obsns_for_estimation, 'earthquake'])
# ! means 'not'.

housing_data[, 'state'] <- NA
housing_data[housing_data[, 'in_cali'] == 1, 'state'] <- 'California'
housing_data[housing_data[, 'in_cali'] != 1, 'state'] <- 'Not California'
housing_data[, 'was_there_earthquake'] <- NA
housing_data[housing_data[, 'earthquake'] == 1, 'was_there_earthquake'] <- 'earthquake'
housing_data[housing_data[, 'earthquake'] != 1, 'was_there_earthquake'] <- 'Not earthquake'


table(housing_data[obsns_for_estimation, 'state'], 
      housing_data[obsns_for_estimation, 'was_there_earthquake'])



##################################################
# Estimating the Regression Model
# Model 1: Omitting One Variable
# We know that this is the wrong model
# but we can use it to demonstrate the approach to model testing. 
##################################################

# Estimate a regression model.
lm_no_earthquakes <- lm(data = housing_data[obsns_for_estimation, ], 
                        # Notice only first set of observations (training dataset).
                        formula = house_price ~ income + in_cali) # earthquake removed.

# Output the results to screen.
summary(lm_no_earthquakes)


##################################################
# Calculate the predictions of the 'No earthquakes' model
##################################################

# Store predictions for the entire dataset (both training and testing)
# based on the model built on only the training dataset. 
housing_data[, 'pred_no_earthquakes'] <- predict(lm_no_earthquakes, 
                                                 newdata = housing_data) # All observations, including testing sample. 


##################################################
# Testing the Regression Model
# Model 2: All Variables Included
# Note that the prediction is also included
##################################################

# Estimate a regression model.
lm_testing_model_1 <- lm(data = housing_data[!obsns_for_estimation, ], 
                         # Notice only second set of observations (testing dataset).
                         formula = house_price ~ pred_no_earthquakes + in_cali + earthquake)
# Dropped income because of multicollinearity. 
# Want to test accuracy for california and relevance of earthquakes.

# Output the results to screen.
summary(lm_testing_model_1)






##################################################
# 
# Exercise 1 (in class):
# 
# Observe the values of the coefficients for california and earthquakes.
# Then compare these to the bias recorded for the first (misspecified) regression.
# 
##################################################




##################################################
# 
# Exercise 2 (after class):
# 
# Estimate the true model (including earthquakes).
# Then perform the second regression to test the correct model. 
# Observe the values of the coefficients for california and earthquakes.
# Compare the results with the test of the incorrect model above.
# 
##################################################


##################################################
# Estimating the Regression Model
# Model 2: Full Model, with no omitted variable
# We know from the parameter values that this is the correct model
# but we can use it to demonstrate the approach to model testing. 
##################################################


# Estimate a regression model.
lm_full_model <- lm(data = housing_data[obsns_for_estimation, ], 
                    # Notice only first set of observations (training dataset).
                    formula = house_price ~ income + in_cali + earthquake) 

# Output the results to screen.
summary(lm_full_model)


# Store predictions for the entire dataset (both training and testing)
# based on the model built on only the training dataset. 
housing_data[, 'prediction_full'] <- predict(lm_full_model, 
                                             newdata = housing_data) # All observations, including testing sample. 


##################################################
# Testing the Regression Model
# Model 2: Full Model, with no omitted variable
# Note that the prediction is also included
##################################################

# Estimate a regression model.
lm_testing_full_model_1 <- lm(data = housing_data[!obsns_for_estimation, ], 
                              # Notice only second set of observations (testing dataset).
                              formula = house_price ~ prediction_full + in_cali + earthquake)
# Dropped income because of multicollinearity. 
# Want to test accuracy for california and relevance of earthquakes.

# Output the results to screen.
summary(lm_testing_full_model_1)



##################################################
# Bonus round: Notice what happened above. 
# Try a different version of the testing model.
# Subract predictions from actual house prices.
# Use the difference as the regressand. 
##################################################

housing_data[, 'prediction_diff_full']  <- housing_data[, 'house_price'] -
  housing_data[, 'prediction_full'] # Preditions from full model. 

# Estimate a regression model.
lm_testing_full_model_2 <- lm(data = housing_data[!obsns_for_estimation, ], 
                              # Notice only second set of observations (testing dataset).
                              formula = prediction_diff_full ~ income + in_cali + earthquake)


# Output the results to screen.
summary(lm_testing_full_model_2)



##################################################
# 
# Exercise 3:
# 
# Observe the values of the coefficients for california and earthquakes.
# Then compare these to the bias recorded for the first (misspecified) regression.
# 
##################################################


housing_data[, 'prediction_diff']  <- housing_data[, 'house_price'] -
  housing_data[, 'pred_no_earthquakes'] # Preditions from the no esarthquakes model. 

# Estimate a regression model.
lm_testing_no_earthquakes_2 <- lm(data = housing_data[!obsns_for_estimation, ], 
                                  # Notice only second set of observations (testing dataset).
                                  formula = prediction_diff ~ income + in_cali + earthquake)


summary(lm_testing_no_earthquakes_2)



##################################################
# End
##################################################
