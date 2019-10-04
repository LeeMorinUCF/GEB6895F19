##################################################
# 
# ECO 5445: Introduction to Business Analytics
# 
# Regression Tree Demo
# Data Mining over many Irrelevant Variables
# Includes variables with measurement error
# and two highly correlated substitutes.
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
# ECO5445_Regression_Trees gives an example of a basic type
#   of data mining algorithm using simulated data.
#   It estimates a model that searches for relevant variables with 
#   measurement error, correlated variables and irrelevant variables.
# 
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Declare libraries and packages.
# library(name_of_R_package)

# The rpart package partitions data for regression and classification trees. 
library(rpart)
# If it complains, run 
# install.packages('rpart')
# to install (required the first time only).


# Set path for working directory.
course_path <- '~/Teaching/GEB6895_Fall_2019'
git_path <- 'GitRepos'
folder_name <- 'demo_09_machine_learning_in_R'
wd_path <- sprintf('%s/%s/%s', course_path, git_path, folder_name)

setwd(wd_path)

# Read function for sampling data. 
source('../demo_08_model_validation_in_R/House_Price_Sim_Data.R')
# This is the same as running the House_Price_Sim_Data.R script first.
# It assumes that the script is saved in a particular folder.


##################################################
# Setting the Parameters
##################################################

# Dependent Variable: Property values (in Millions)

beta_0          <-   0.10    # Intercept
beta_income     <-   5.00    # Slope ceofficient for income
beta_cali       <-   0.25    # Slope coefficient for California
beta_earthquake <- - 0.50    # Slope coefficient for earthquake (when active in model)
# beta_earthquake <-   0.00    # Slope coefficient for earthquake (when removed from model)

# Distribution of incomes (also in millions).
avg_income <- 0.1
sd_income <- 0.01

# Extra parameter for measurement error in income. 
number_of_income_variables <- 2
measurement_error_income <- 0.002

# Fraction of dataset in California.
pct_in_cali <- 0.5

# Frequency of earthquakes (only in California).
prob_earthquake <- 0.05

# Frequency of rainfall (can happen anywhere). 
prob_rainfall <- 0.25

# Number of additional (irrelevant) rainfall variables to add to dataset.
number_of_rainfall_variables <- 20

# Additional terms:
sigma_2 <- 0.1        # Variance of error term
num_obs <- 20000        # Number of observations in entire dataset
num_obs_estn <- 10000    # Number of observations for estimation.
# Notice num_obs is twice as large, saving half for out-of-sample testing.


# Select the variables for estimation at random. 
obsns_for_estimation <- runif(num_obs) < num_obs_estn/num_obs
# Test how many are in each sample. 
table(obsns_for_estimation)


##################################################
# Generating the Data
# The relevant data in the model
##################################################

# Call the housing_sample function from ECO6416_Sim_Data.R. 
housing_data <- housing_sample(beta_0, beta_income, beta_cali, beta_earthquake, 
                               avg_income, sd_income, pct_in_cali, prob_earthquake, 
                               sigma_2, num_obs, 
                               number_of_income_variables, measurement_error_income, 
                               number_of_rainfall_variables, prob_rainfall)

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


##################################################
# Generating Additional Data
# The extra data that is not in the model
##################################################

#--------------------------------------------------
# Assume that true income is not observed but some variables 
# that are correlated with income are available. 
#--------------------------------------------------

income_variable_list <- sprintf('income_%d', seq(1:number_of_income_variables))
# These variables are created in the House_Price_Sim_Data.R script. 


# Check how strongly the data are correlated. 
cor(housing_data[, c('income', 'income_1', 'income_2')])

correl_income_1_2 <- cor(housing_data[, 'income_1'], 
                         housing_data[, 'income_2'])
plot(housing_data[, 'income_1'], housing_data[, 'income_2'],
     main = c('Scattergraph of two measures of income', 
              sprintf('(r = %f)', correl_income_1_2)),
     xlab = 'Income 1',
     ylab = 'Income 2')

#--------------------------------------------------
# Further, assume that many rainfall variables 
# are available for the estimation, even though
# they do not appear in the model (irrelevant variables). 
#--------------------------------------------------

rainfall_variable_list <- sprintf('rainfall_%d', seq(1:number_of_rainfall_variables))
# These variables are also created in the House_Price_Sim_Data.R script. 

# Summarize the data.
summary(housing_data)
# Should be many new rainfall variables. 




##################################################
# Estimating the Regression Tree Model
# Model 1: All true Variables Included
##################################################

# Fit the regression tree. 
fit_true_model <- rpart(house_price ~ income + in_cali + earthquake, 
                        method = "anova", data = housing_data)

# Display statistics for the relative importance of variables.
printcp(fit_true_model)

# Plot the improvement in errors from cross-validated estimates.  
plotcp(fit_true_model) 

# Create additional plots of improvement in model fit. 
par(mfrow=c(1,2)) # Two plots on one page. 
rsq.rpart(fit_true_model) # Visualize cross-validation results. 
par(mfrow=c(1,1)) # Reset to one plot per page. 

# Display a detailed summary of splits. 
summary(fit_true_model) 

# Plot the Regression Tree 
plot(fit_true_model, uniform=TRUE, 
     main="Regression Tree for House Prices (True Variables)")
text(fit_true_model, use.n=TRUE, all=TRUE, cex=.8)

# Create a more readable postcript plot of tree. 
fig_tree_file_name <- 'housing_tree_true.ps'
fig_tree_path_file_name <- sprintf('%s/%s', wd_path, fig_tree_file_name)
post(fit_true_model, file = fig_tree_path_file_name, 
     title = "Regression Tree for House Prices (True Variables)")


# Calculate the predictions from the fitted tree.
housing_data[, 'tree_pred_true'] <- predict(fit_true_model, 
                                              newdata = housing_data)

summary(housing_data[, c('house_price', 'tree_pred_true')])

# Plot the actual house prices against the tree model predictions.
plot(housing_data[, 'house_price'], housing_data[, 'tree_pred_true'],
     main = 'Regression Tree Predictions', 
     xlab = 'House Price',
     ylab = 'Tree Prediction')
points(housing_data[housing_data[, 'in_cali'] == 1, 'house_price'], 
       housing_data[housing_data[, 'in_cali'] == 1, 'tree_pred_true'],
       col = 'green')
points(housing_data[housing_data[, 'earthquake'] == 1, 'house_price'], 
       housing_data[housing_data[, 'earthquake'] == 1, 'tree_pred_true'],
       col = 'red')






##################################################
# Estimating the Feasible Regression Model
# Model 2: Include only the available income variables. 
##################################################


# Collect all available variables into a single list. 
variable_list <- c(income_variable_list, 'in_cali', 'earthquake', 
                   rainfall_variable_list)
# Note that true income is not in this list.
# We are pretending that it is unobserved. 


# Create a formula object from the full variable list. 
fmla_string <- sprintf('house_price ~  %s', 
                       paste(cbind(variable_list), 
                             sep = '', collapse = ' + '))
fmla <- as.formula(fmla_string)



# Fit the regression tree. 
fit_full_model <- rpart(fmla, 
                        method = "anova", data = housing_data)

# Display statistics for the relative importance of variables.
printcp(fit_full_model)

# Plot the improvement in errors from cross-validated estimates.  
plotcp(fit_full_model) 

# Create additional plots of improvement in model fit. 
par(mfrow=c(1,2)) # Two plots on one page. 
rsq.rpart(fit_full_model) # Visualize cross-validation results. 
par(mfrow=c(1,1)) # Reset to one plot per page. 

# Display a detailed summary of splits. 
summary(fit_full_model) 

# Plot the Regression Tree 
plot(fit_full_model, uniform=TRUE, 
     main="Regression Tree for House Prices (Full Variable List)")
text(fit_full_model, use.n=TRUE, all=TRUE, cex=.8)

# Create a more readable postcript plot of tree. 
fig_tree_file_name <- 'housing_tree_full.ps'
fig_tree_path_file_name <- sprintf('%s/%s', wd_path, fig_tree_file_name)
post(fit_full_model, file = fig_tree_path_file_name, 
     title = "Regression Tree for House Prices (Full Variable List)")



# Calculate the predictions from the fitted tree.
housing_data[, 'tree_pred_full'] <- predict(fit_full_model, 
                                            newdata = housing_data)

summary(housing_data[, c('house_price', 'tree_pred_full')])

# Plot the actual house prices against the tree model predictions.
plot(housing_data[, 'house_price'], housing_data[, 'tree_pred_full'],
     main = 'Regression Tree Predictions', 
     xlab = 'House Price',
     ylab = 'Tree Prediction')
points(housing_data[housing_data[, 'in_cali'] == 1, 'house_price'], 
       housing_data[housing_data[, 'in_cali'] == 1, 'tree_pred_full'],
       col = 'green')
points(housing_data[housing_data[, 'earthquake'] == 1, 'house_price'], 
       housing_data[housing_data[, 'earthquake'] == 1, 'tree_pred_full'],
       col = 'red')



##################################################
# Tuning (Hyper)Parameters
##################################################


# Refine the model by tuning the parameters.
# Default values listed.
# Here only changing the complexity parameter.
rpart_control <- rpart.control(# minsplit = 20, 
                               # minbucket = round(minsplit/3), 
                               # cp = 0.01,
                               cp = 0.001 #,
                               # maxcompete = 4, 
                               # maxsurrogate = 5, 
                               # usesurrogate = 2, 
                               # xval = 10,
                               # surrogatestyle = 0, 
                               # maxdepth = 30
                               )


# Collect all available variables into a single list. 
variable_list <- c(income_variable_list, 'in_cali', 'earthquake', 
                   rainfall_variable_list)
# Note that true income is not in this list.
# We are pretending that it is unobserved. 


# Create a formula object from the full variable list. 
fmla_string <- sprintf('house_price ~  %s', 
                       paste(cbind(variable_list), 
                             sep = '', collapse = ' + '))
fmla <- as.formula(fmla_string)



# Fit the regression tree. 
fit_tuned_model <- rpart(fmla, 
                        method = "anova", data = housing_data,
                        control = rpart_control)

# Display statistics for the relative importance of variables.
printcp(fit_tuned_model)

# Plot the improvement in errors from cross-validated estimates.  
plotcp(fit_tuned_model) 

# Create additional plots of improvement in model fit. 
par(mfrow=c(1,2)) # Two plots on one page. 
rsq.rpart(fit_tuned_model) # Visualize cross-validation results. 
par(mfrow=c(1,1)) # Reset to one plot per page. 

# Display a detailed summary of splits. 
summary(fit_tuned_model) 

# Plot the Regression Tree 
plot(fit_tuned_model, uniform=TRUE, 
     main="Regression Tree for House Prices (Full Variable List)")
text(fit_tuned_model, use.n=TRUE, all=TRUE, cex=.8)

# Create a more readable postcript plot of tree. 
fig_tree_file_name <- 'housing_tree_full.ps'
fig_tree_path_file_name <- sprintf('%s/%s', wd_path, fig_tree_file_name)
post(fit_tuned_model, file = fig_tree_path_file_name, 
     title = "Regression Tree for House Prices (Full Variable List)")



# Calculate the predictions from the fitted tree.
housing_data[, 'tree_pred_tuned'] <- predict(fit_tuned_model, 
                                            newdata = housing_data)

summary(housing_data[, c('house_price', 'tree_pred_tuned')])

# Plot the actual house prices against the tree model predictions.
plot(housing_data[, 'house_price'], housing_data[, 'tree_pred_tuned'],
     main = 'Regression Tree Predictions', 
     xlab = 'House Price',
     ylab = 'Tree Prediction')
points(housing_data[housing_data[, 'in_cali'] == 1, 'house_price'], 
       housing_data[housing_data[, 'in_cali'] == 1, 'tree_pred_tuned'],
       col = 'green')
points(housing_data[housing_data[, 'earthquake'] == 1, 'house_price'], 
       housing_data[housing_data[, 'earthquake'] == 1, 'tree_pred_tuned'],
       col = 'red')



# Plot the tree model predictions against income.
# Compared with a linear model.
plot(housing_data[, 'income'], 
     housing_data[, 'tree_pred_tuned'],
     main = 'Regression Tree Predictions', 
     xlab = 'Income (unobserved)',
     ylab = 'Tree Prediction of House Price')
points(housing_data[housing_data[, 'in_cali'] == 1, 'income'], 
       housing_data[housing_data[, 'in_cali'] == 1, 'tree_pred_tuned'],
       col = 'green')
points(housing_data[housing_data[, 'earthquake'] == 1, 'income'], 
       housing_data[housing_data[, 'earthquake'] == 1, 'tree_pred_tuned'],
       col = 'red')



##################################################
# End
##################################################

