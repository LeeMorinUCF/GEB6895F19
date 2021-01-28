##################################################
# 
# GEB 6895: Business Intelligence
# 
# The data.table Package
# SQL queries done (computationally) cheap
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# October 11, 2018
# 
##################################################
# 
# datatable_and_merge gives examples of
#   joining data in the common types of joins 
#   often handled by SQL queries. 
#   It uses the data.table package to execute concise 
#   commands that could otherwise be achieved with SQL queries. 
# 
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Load data.table library.
# install.packages('data.table')
library(data.table)


# Set path for working directory.
course_path <- '~/Teaching/GEB6895_Fall_2019'
git_path <- 'GitRepos'
folder_name <- '/demo_15_data_table_merge'
wd_path <- sprintf('%s/%s/%s', course_path, git_path, folder_name)

setwd(wd_path)



##################################################
# Loading Data
##################################################

# Read the tables.
Employees <- fread('Employees.csv')
Departments <- fread('Departments.csv')


##################################################
# Data Analysis the data.table Way
##################################################

# Compare commands to those on data frames. 
Employees_df <- as.data.frame(Employees)
Departments_df <- as.data.frame(Departments)

# Data frames take in a separate (temporary) object
# for subsetting:
Employees_df[, 'Salary'] > 750
# in
Employees_df[Employees_df[, 'Salary'] > 750, ]
# which can often be wasteful, in terms of memory usage. 

# It can also be quite cumbersome to include multiple "WHERE" conditions:
Employees_df[Employees_df[, 'Salary'] > 750 &
            Employees_df[, 'Salary'] < 950 &
            Employees_df[, 'EmployeeName'] %in% c('Alice', 'Daniel'), 'Department']



# The data.table version is more concise.
Employees[Salary > 750, ]

# You can still execute some commands on the data.table
# as you would with a data frame:
Employees$Salary
Employees[Employees$Salary > 750, ]

# Except that, in a data.table, the variable names 
# can be used as if they were variables themselves.
Employees[ , Salary]
# In a sense, the variable Salary is a variable 
# in the environment of a data.table. 

# Compare this to a data frame, where the column names are 
# one of very few ways to subset columns. 
Employees_df[ , 'Salary']
Employees_df[ , Salary]

# This still works in a data.table but you can do so much more. 
Employees[ , 'Salary']

# Calculate functions of the existing data.table columns 
# as if the columns were variables already defined (they are). 
Employees[ , Salary*2]

# Create new columns as functions of the existing variables. 
Employees[ , Salary_squared := Salary^2]
# Note that it only created the new variable with the assignment operator ':=',
# No printing was required. 
# Take a look at the new Employees data.table:
Employees

# Multiple creation of variables can be achieved with a list of operations. 
Employees[ , ':='( Salary_cubed = Salary^3, 
                   Salary_fourthed = Salary^4)]
# In an SQL dialect, this is equivalent to:
# SELECT 
#   *,
# FROM
#   Employees AS e1
# LEFT JOIN
#  (SELECT
#    Salary_cubed = Salary^3,
#    Salary_fourthed = Salary^4
#  FROM
#    Employees) AS e2
# ON 
#   e1.row_number = e2.row_number
# ;  
# with some duplication for emphasis.

# Similarly for the following example:
Employees[ Employee >= 2, sum_salary := sum(Salary), by = c('Department')]
# SELECT 
#   *,
# FROM
#   Employees AS e1
# LEFT JOIN
#  (SELECT
#    sum_salary = sum(Salary)
#  FROM
#    Employees
#  WHERE
#    Employee >= 2
#  GROUP BY 
#    Department) AS e2
# ON 
#   e1.row_number = e2.row_number
# ;  
# again, with some duplication for emphasis,
# since there are other commands to achieve this in SQL.

# Without the ':=' operator, the result returns only the 
# subset specified by the query.
Employees[ Employee >= 2, sum(Salary_squared), by = c('Department')]
#  SELECT
#    V1 = sum(Salary_squared)
#  FROM
#    Employees
#  WHERE
#    Employee >= 2
#  GROUP BY 
#    Department
# ;



##################################################
# Merging data.tables
##################################################

# The key to the above examples is that the first argument of 
# a data table is the where clause.
# In the joins below, it is also used as the ON clause.
# Since, implicitly, you would select the rows of the first table
# that correspond to matching rows in the other table. 
# Any unmatched rows return missing values for the columns in the LEFT table.

# The first step is to declare the join keys in advance. 

# Set the ON clause as keys of the tables.
setkey(Employees,Department)
setkey(Departments,Department)



# Then the joins look like they are dropping the entire LEFT data.table 
# into the subset argument, but instead it is just like saying 
# "WHERE key_names IN (SELECT DISTINCT key_names FROM Employees)".



# INNER JOIN

# Perform the join, eliminating not matched rows from Right
inner_dt <- Employees[Departments, nomatch=0]
inner_dt

# Take attendance and see who is missing.

# Compare this with ```merge```:

inner_merge <- merge(Employees, Departments)
inner_merge


# LEFT OUTER JOIN

left_outer_dt <- Departments[Employees]
left_outer_dt

left_outer_merge <- merge(Employees, Departments, all.x = TRUE)
left_outer_merge



# RIGHT OUTER JOIN

right_outer_dt <- Employees[Departments]
right_outer_dt

right_outer_merge <- merge(Employees, Departments, all.y = TRUE)
right_outer_merge



# FULL OUTER JOIN

full_outer_merge <- merge(Employees, Departments, all = TRUE)
full_outer_merge

# Not supported on all platforms. 







##################################################
# End
##################################################
