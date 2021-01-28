##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# OLS Regression Demo
# Generation of Simulated Data for Regression Demos
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
# House_Price_Sim_Data generates simulated data to use in
#     demonstrations of regression analysis.
# 
##################################################
# Inputs:
#    beta_0 # Intercept
#    beta_income # Slope ceofficient for income
#    beta_cali # Slope coefficient for California
#    beta_earthquake # Slope coefficient for earthquake
#    avg_income # Mean income (in millions).
#    sd_income # Standard Deviation of income (in millions).
#    pct_in_cali # Fraction of dataset in California.
#    prob_earthquake # Frequency of earthquakes (only in California).
#    sigma_2 # Variance of error term
#    num_obs # Number of observations in dataset
# 
# Ouput:
#   housing_data, a num_obs x 6 data frame with variables: 
#     obsn_num an integer label for each observation,
#     house_price (property values, in millions), 
#     income (in millions), 
#     in_cali (whether the property is in California), 
#     earthquake (whether an earthquake had occurred), 
#     epsilon (the error term for the model). 
# 
##################################################


##################################################
# Define a Function
##################################################

housing_sample <- function(beta_0, beta_income, beta_cali, beta_earthquake, 
                           avg_income, sd_income, pct_in_cali, prob_earthquake, 
                           sigma_2, num_obs, 
                           number_of_income_variables = 0, measurement_error_income = 0, 
                           number_of_rainfall_variables = 0, prob_rainfall = 0) {
  
  # Initialize variables. 
  housing_data <- data.frame(obsn_num = 1:num_obs, # Label with observation number.
                             house_price = numeric(num_obs), # Fill this in later.
                             income = rnorm(n = num_obs, mean = avg_income, sd = sd_income),
                             in_cali = numeric(num_obs), # Fill this in later.
                             earthquake = numeric(num_obs), # Fill this in later.
                             epsilon = rnorm(n = num_obs, mean = 0, sd = sigma_2))
  
  # Mark first set of observations from California with ones, 
  # the rest at zero.
  housing_data[, 'in_cali'] <- 0
  housing_data[ housing_data[, 'obsn_num'] <= num_obs*pct_in_cali, 'in_cali'] <- 1
  
  # Mark a set of observations as having an earthquake, 
  # but only in California. 
  housing_data[, 'earthquake'] <- 0
  housing_data[ runif(num_obs) <= prob_earthquake & 
                  housing_data[, 'in_cali'] == 1, 'earthquake'] <- 1
  
  # Finally, calculate the simulated value of house prices,
  # according to the regression equation.
  housing_data[, 'house_price'] <- 
    beta_0 + 
    beta_income * housing_data[, 'income'] + 
    beta_cali * housing_data[, 'in_cali'] + 
    beta_earthquake * housing_data[, 'earthquake'] + 
    housing_data[, 'epsilon']
  
  
  ##################################################
  # Generating Additional Data
  # The extra data that is not in the model
  ##################################################
  
  #--------------------------------------------------
  # Assume that true income is not observed but some variables 
  # that are correlated with income are available. 
  #--------------------------------------------------
  if (number_of_income_variables > 0) {
    
    for (income_num in 1:number_of_income_variables) {
      
      income_var_name <- sprintf('income_%d', income_num)
      
      housing_data[, income_var_name] <- 0
      housing_data[, income_var_name] <- housing_data[, 'income'] + 
        rnorm(n = num_obs, mean = 0, sd = measurement_error_income)
      
    }
    
  }
  
  #--------------------------------------------------
  # Further, assume that many rainfall variables 
  # are available for the estimation, even though
  # they do not appear in the model (irrelevant variables). 
  #--------------------------------------------------
  
  if (number_of_rainfall_variables > 0) {
    
    rainfall_variable_list <- sprintf('rainfall_%d', seq(1:number_of_rainfall_variables))
    # Note the shortcut instead of typing every line. 
    
    # Loop on variable number for rainfall
    # and create a variable similar to that for earthquakes. 
    for (var_num in 1:number_of_rainfall_variables) {
      
      # Get the new variable name. 
      this_rainfall_variable <- sprintf('rainfall_%d', var_num)
      
      # Create the new rainfall variable. 
      housing_data[, this_rainfall_variable] <- 0
      housing_data[ runif(num_obs) <= prob_rainfall , this_rainfall_variable] <- 1
      
    }
    
  }
  
  return(housing_data)
  
}

##################################################
# End
##################################################



