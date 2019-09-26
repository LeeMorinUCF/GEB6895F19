##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# Logistic Regression Demo
# Examples of Model Specfication: Logistic vs OLS
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# September 24, 2019
# 
##################################################
# 
# Credit_Logistic_Reg gives an example of OLS 
#   and logistic regression using data imported from a spreadsheet.
# 
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder' 
wd_path <- '~/Class_Exercises/upstream/GEB6895F19/demo_05_OLS_in_R' # On Windows

setwd(wd_path)

# Verify that the path was assigned correctly. 
getwd()

# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)




##################################################
# Loading the Data and Conducting Initial Assessment
##################################################

credit_data <- read.csv('credit_data.csv')

# Inspect the contents.
summary(credit_data)
# Make sure there are no problems with the data. 

# Inspect the dependent variable. 
hist(credit_data[, 'default'])

# Inspect the correlations between numeric explanatory variables.
cor(credit_data[, 2:ncol(credit_data)])
# Be aware of any explanatory variables that are highly correlated
# (both positively and negatively) with each other.

##################################################
# Generating New Variables
##################################################

# You can create new variables by adding commands 
# within this program that add new columns to the 
# credit_data data frame. 




##################################################
# Estimating a Regression Model
# Model 1: Linear model for default probability
# Start with a full model that includes all variables.
##################################################

# Estimate a regression model.
lm_model_1 <- lm(data = credit_data, 
                 formula = default ~ bmaxrate + amount + 
                   close + AA + A + B + C + D + bankcardutil)

# Output the results to screen.
summary(lm_model_1)

# Calculate the predictions of this model.
credit_data[, 'default_prob_lm'] <- predict(lm_model_1)

summary(credit_data[, 'default_prob_lm'])
# Does anything look unusual?


##################################################
# Estimating a Regression Model
# Model 2: Linear model for default probability
# Trimming down the model by omitting variables. 
##################################################

# Estimate a regression model.
lm_model_2 <- lm(data = credit_data, 
                 formula = default ~ 
                   # Remove some variables from here: 
                   bmaxrate + amount + 
                   close + AA + A + B + C + D + bankcardutil)
# Note that the '+' signs allow for the formula to continue
# to the next line. 

# Output the results to screen.
summary(lm_model_2)




##################################################
# Estimating a Regression Model
# Model 3: Logistic model for default probability
# 
##################################################

# Estimate a logistic regression model.
logit_model_1 <- glm(data = credit_data, 
                     formula = default ~ bmaxrate + amount + 
                       close + AA + A + B + C + D + bankcardutil, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


# Calculate the predictions of this model.
credit_data[, 'default_prob_logit'] <- predict(logit_model_1, type = 'response')

summary(credit_data[, 'default_prob_logit'])
# Does this look better?



##################################################
# End
##################################################