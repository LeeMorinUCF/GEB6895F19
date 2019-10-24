##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# OLS Regression Demo
# Simulation with repeated estimation
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# September 21, 2019
# 
##################################################
# 
# OLS_On_Repeat gives an example of OLS regression
#   using simulated data.
#   It repeats the estimation several times to get a 
#   distribution of estimates. 
# 
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder' 

# setwd(wd_path)

# Or do this in one step (using buttons in  File panel).
# setwd("~/path/to/your/folder")
setwd("~/Teaching/GEB6895_Fall_2019/GitRepos/assignment_05")

# Read function for sampling data. 
source('House_Price_Sim_Data.R')
# This is the same as running the House_Price_Sim_Data.R script first.
# It assumes that the script is saved in the same working folder.

# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)


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

# Extra parameter for measurement error in income. 
measurement_error_income <- 0.01

# Fraction of dataset in California.
pct_in_cali <- 0.5

# Frequency of earthquakes (only in California).
prob_earthquake <- 0.05

# Additional terms:
sigma_2 <- 0.1        # Variance of error term
num_obs <- 100      # Number of observations in dataset

# Set the number of replications in the simulation. 
num_replications <- 1000


##################################################
# Generating the Fixed Data
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


##################################################
# Generating Additional Data
# The extra data that is not in the model
##################################################

#--------------------------------------------------
# Assume that true income is not observed but some variables 
# that are correlated with income are available. 
#--------------------------------------------------

# Income measure 1.
housing_data[, 'income_1'] <- 0
housing_data[, 'income_1'] <- housing_data[, 'income'] + 
  rnorm(n = num_obs, mean = 0, sd = measurement_error_income)

# Income measure 2.
housing_data[, 'income_2'] <- 0
housing_data[, 'income_2'] <- housing_data[, 'income'] + 
  rnorm(n = num_obs, mean = 0, sd = measurement_error_income)

plot(housing_data[, 'income'], housing_data[, 'income_1'])

##################################################
# Running a Simulation
# Estimating Again and Again
##################################################

# Set the list of variables for the estimation. 
# list_of_variables <- c('income', 'in_cali', 'earthquake')
list_of_variables <- c('income_1', 'in_cali', 'earthquake')

# Add beta_0 to the beginning for the full list.
full_list_of_variables <- c('intercept', list_of_variables)

# Create an empty data frame to store the results.
reg_results <- data.frame(reg_num = 1:num_replications)
reg_results[, full_list_of_variables] <- 0
reg_results[, c('income', 'income_1', 'income_2')] <- 0


# Generate repeated realizations of the housing_data dataset.
for (reg_num in 1:num_replications) {
  
  # Print a progress report.
  # print(sprintf('Now estimating model number %d.', reg_num))
  
  ##################################################
  # Generating the Random Data
  ##################################################
  
  # Repeat again and again, replacing only the epsilon values. 
  
  # Generate the error term, which includes everything we do not observe.
  housing_data[, 'epsilon'] <- rnorm(n = num_obs, mean = 0, sd = sigma_2)
  
  # Finally, recalculate the simulated value of house prices,
  # according to the regression equation.
  housing_data[, 'house_price'] <- 
    beta_0 + 
    beta_income * housing_data[, 'income'] + 
    beta_cali * housing_data[, 'in_cali'] + 
    beta_earthquake * housing_data[, 'earthquake'] + 
    housing_data[, 'epsilon']
  # Each time, this replaces the house_price with a different version 
  # of the error term. 
  
  
  ##################################################
  # Estimating the Regression Model
  ##################################################
  
  # Specify the formula to estimate. 
  lm_formula <- as.formula(paste('house_price ~ ', 
                                 paste(list_of_variables, collapse = ' + ')))
  
  # Estimate a regression model.
  lm_full_model <- lm(data = housing_data, 
                      formula = lm_formula)
  # Note that the normal format is:
  # model_name <- lm(data = name_of_dataset, formula = Y ~ X_1 + x_2 + x_K)
  # but the above is a shortcut for a pre-set list_of_variables. 
  
  ##################################################
  # Saving the Results
  ##################################################
  
  # Save the estimates in the row for this particular estimation. 
  reg_results[reg_num, full_list_of_variables] <- coef(lm_full_model)
  
}


##################################################
# Analyzing the Results
##################################################

#--------------------------------------------------
# Display some graphs
# Click the arrows in the bottom right pane to 
# switch between previous figures. 
#--------------------------------------------------

# Plot a histogram for each estimate. 
# Note that some will be empty if they were not included in the estimation. 

hist(reg_results[, 'intercept'], 
     main = 'Distribution of beta_0', 
     xlab = 'Estimated Coefficient', 
     ylab = 'Frequency')

hist(reg_results[, 'income'], 
     main = 'Distribution of beta_income', 
     xlab = 'Estimated Coefficient', 
     ylab = 'Frequency')

hist(reg_results[, 'income_1'], 
     main = 'Distribution of beta_income_1', 
     xlab = 'Estimated Coefficient', 
     ylab = 'Frequency')

hist(reg_results[, 'income_2'], 
     main = 'Distribution of beta_income_2', 
     xlab = 'Estimated Coefficient', 
     ylab = 'Frequency')

hist(reg_results[, 'in_cali'], 
     main = 'Distribution of beta_cali', 
     xlab = 'Estimated Coefficient', 
     ylab = 'Frequency')

hist(reg_results[, 'earthquake'], 
     main = 'Distribution of beta_earthquake', 
     xlab = 'Estimated Coefficient', 
     ylab = 'Frequency')

#--------------------------------------------------
# Output some statistics to screen
#--------------------------------------------------

# Display some statistics for the result. 
summary(reg_results[, full_list_of_variables])

# Calculate the average estimates separately.
print('Average value of the coefficients are:')
sapply(reg_results[, full_list_of_variables], mean)

# Calculate the standard deviation of the estimates.
print('Standard Deviations of the coefficients are:')
sapply(reg_results[, full_list_of_variables], sd)


# Compare these to the standard deviations of the variables.
sapply(housing_data[, full_list_of_variables[2:4]], sd)


##################################################
# End
##################################################