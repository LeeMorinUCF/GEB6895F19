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
# Regression_Example gives an example of OLS regression
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
wd_path <- 'C:/Users/le279259/Documents/Teaching/ECO6416_Fall2019/Module02' # On Windows

setwd(wd_path)

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


# Estimate a regression model.
lm_model <- lm(data = housing_data, 
                 formula = house_price ~ income + in_cali + earthquake)

# Output the results to screen.
summary(lm_model)


##################################################
# End
##################################################

