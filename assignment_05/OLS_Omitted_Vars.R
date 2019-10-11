##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# OLS Regression Demo
# Regression with Simulated Data: Omitted Variables
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# August 29, 2019
# 
##################################################
# 
# OLS_Omitted_Vars uses simulated data to create an example 
#   that illustrates the change in estimates resulting from 
#   omitted variables.
# 
# Dependencies:
#   ECO6416_Sim_Data.R
# 
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
wd_path <- '/path/to/your/folder' 

setwd(wd_path)

# Or do this in one step (using buttons in  File panel).
setwd("~/path/to/your/folder")

# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)

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
prob_earthquake <- 0.05

# Additional terms:
sigma_2 <- 0.1        # Variance of error term
num_obs <- 100      # Number of observations in dataset


##################################################
# Generating the Data
##################################################

# Call the housing_sample function from ECO6416_Sim_Data.R. 
housing_data <- housing_sample(beta_0, beta_income, beta_cali, beta_earthquake, 
                               avg_income, sd_income, pct_in_cali, prob_earthquake, 
                               sigma_2, num_obs)


# Summarize the data to inspect for data quality.
summary(housing_data)

# Check that earthquakes occurred only in California:
table(housing_data[, 'in_cali'], housing_data[, 'earthquake'])
# Data errors are the most frequent cause of problems in model-building.

# Run it again if no earthquakes ocurred.


##################################################
# Estimating the Regression Model
# Model 1: All Variables Included
##################################################

# Estimate a regression model.
lm_full_model <- lm(data = housing_data, 
                    formula = house_price ~ income + in_cali + earthquake)

# Output the results to screen.
summary(lm_full_model)


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



##################################################
# End
##################################################