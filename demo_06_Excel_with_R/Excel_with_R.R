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
wd_path <- '~/Teaching/GEB6895_Fall_2019/GitRepos/demo_06_Excel_with_R' # On Windows

setwd(wd_path)

# Check folder:
getwd()

# Load libraries.

# Load library to interact with Microsoft Excel.
library(openxlsx)


##################################################
# Open an Existing Workbook
##################################################

# Open the workbook and create a workbook object.
wb_in <- loadWorkbook(file = 'housing_data.xlsx')


# Obtain data from the worksheet. 
housing_data_frame <- readWorkbook(xlsxFile = wb_in, 
                                   sheet = 'Data')

# Inspect the data for accuracy. 
summary(housing_data_frame)



# Perform some analysis with the data. 

# Correlation matrix.
corr_matrix <- cor(housing_data_frame[, c('house_price', 'income', 'in_cali', 'earthquake')])
print(round(corr_matrix, 3))

# Regression model.
lm_full_model <- lm(data = housing_data_frame, 
                    formula = house_price ~ income + in_cali + earthquake)

# Generate the results to write to the worksheet.
reg_results <- summary(lm_full_model)
reg_results$coefficients


# Create new worksheets to store these results. 
addWorksheet(wb = wb_in, 'Correlation')
addWorksheet(wb = wb_in, 'Regression')


# Write the output to the workbook object. 
writeData(wb = wb_in, sheet = 'Correlation', 
          x = 'Correlation Matrix for Housing Data')
writeData(wb = wb_in, sheet = 'Correlation', 
          x = corr_matrix, 
          startCol = 2, startRow = 3, rowNames = TRUE)


# Load the regression results into the workbook. 
writeData(wb = wb_in, sheet = 'Regression', 
          x = 'Regression Results for Housing Data')
writeData(wb = wb_in, sheet = 'Regression', 
          x = reg_results$coefficients, 
          startCol = 2, startRow = 3, rowNames = TRUE)



# Write the workbook object to a new version of the Excel workbook. 
saveWorkbook(wb = wb_in, 'housing_data_out.xlsx', 
             overwrite = TRUE)



##################################################
# Create a New Workbook
##################################################


# Create a blank workbook object.
wb_out <- createWorkbook()


# Create worksheets. 
addWorksheet(wb = wb_out, 'Data')
addWorksheet(wb = wb_out, 'Regression 1')
addWorksheet(wb = wb_out, 'Regression 2')


# Create some content. 

# Regression 1: Full Model
lm_full_model <- lm(data = housing_data_frame, 
                    formula = house_price ~ income + in_cali + earthquake)
reg_results_1 <- summary(lm_full_model)

# Regression 2: No Earthquakes
lm_no_earthquakes <- lm(data = housing_data_frame, 
                    formula = house_price ~ income + in_cali)
reg_results_2 <- summary(lm_no_earthquakes)


# Load the data into the workbook. 
writeData(wb = wb_out, sheet = 'Data', 
          x = housing_data_frame)


# Load the first regression results into the workbook. 
writeData(wb = wb_out, sheet = 'Regression 1', 
          x = 'Regression Results for Housing Data: Full Model')
writeData(wb = wb_out, sheet = 'Regression 1', 
          x = reg_results_1$coefficients, 
          startCol = 2, startRow = 3, rowNames = TRUE)

# Load the second regression results into the workbook. 
writeData(wb = wb_out, sheet = 'Regression 2', 
          x = 'Regression Results for Housing Data: No Earthquakes')
writeData(wb = wb_out, sheet = 'Regression 2', 
          x = reg_results_2$coefficients, 
          startCol = 2, startRow = 3, rowNames = TRUE)



# Write the workbook object to an Excel workbook. 
saveWorkbook(wb = wb_out, "housing_data_new.xlsx", 
             overwrite = TRUE)



##################################################
# End
##################################################



