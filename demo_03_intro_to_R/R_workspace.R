################################################################################
# 
# ECO 5445: Introduction to Business Analytics
# Introductory Examples: R Workspace
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# September 24, 2018
# 
################################################################################
# 
# This program provides introductory examples of R code that demonstrate
# data types and conditional logic.
# 
# 
# 
################################################################################


# The '#' declares the entire line as a comment. R ignores these lines.
# Use it often:
# Be a good citizen and include comments, whenever they are helpful.


################################################################################
# Getting Help
################################################################################

'?'(lm)
help(lm)

# With any open source language, Google is your best friend.
# Google 'r name_of_function', etc.
# Caution: Solutions on online fora tend to escalate to the most concise or 'elegant' solution.
# Sometimes you want the solution that is most clear.


################################################################################
# Clearing Workspace and Declaring Packages
################################################################################

# Clear workspace.
# The remove function removes everything in the workspace when the list is all.
rm(list=ls(all=TRUE))

# Load library of functions.
# source('MyRcode1.R')

# Set working directory.
# The '<-' operator denotes right-to-left assignment.
# wdPath <- '/path/to/your/folder'
wdPath <- 'C:/Users/le279259/Documents/Teaching/ECO5445_Fall2018/GitRepos/ECO5445F18/demo_11_intro_to_R'
setwd(wdPath)

# Check this in unix (doesn't always work in Windows).
system('pwd')
system('ls -lh')

# Set paths to other folders.
dataPath <- sprintf('%s/data', wdPath)

# Create this folder in unix to make sure that it exists.
system('mkdir data')


# The strings above are in the workspace. 
# Let's save this workspace for later.

# See what is in the workspace, so that we know what we are saving.
ls()

# Save current workspace image.
workspaceFileName <- 'myWorkspace1'
workspacePath <- sprintf('%s/%s.RData', wdPath, workspaceFileName)
save.image(workspacePath)

# Now remove some variables. 
rm(dataPath)
dataPath

# Check the workspace again.
ls()


# Load existing workspace image.
workspaceFileName <- 'myWorkspace1'
workspacePath <- sprintf('%s/%s.RData', wdPath, workspaceFileName)
load(workspacePath)



################################################################################
# Data Types and Mathematical Operations
################################################################################

# The variables above are character strings.
class(workspacePath)

# The sprintf() is handed down from C.
# (Many C and FORTRAN programs are used in the background in R.)
string1 <- 'first string'
string2 <- 'second string'
full_string <- sprintf('Put the %s before the %s.', string1, string2)
# The '%s' is called an 'escape sequence'. 
# It tells the sprintf() function to look for the next argument (which should be a string)
# And insert it in the place of the '%s'.
class(full_string)


# Most characters can be used in variable names.
some_numbers.integers <- 1:10
class(some_numbers.integers)

# Numeric is a broader class of, well, numeric variables.
value_of_pi <- pi
class(value_of_pi)

# Logical values denote true or false conditions.
true_statement1 <- value_of_pi == pi
class(true_statement1)
false_statement1 <- value_of_pi == pi + 2
class(false_statement1)




# Adding numeric variables can change the type.
pi_plus <- some_numbers.integers + value_of_pi

# Notice anything unusual?



# The concatenation function c() is used to form lists of objects.
more_integers <- c(some_numbers.integers, 11:15)


# Lets make a vector of important numbers.
value_of_e <- exp(1)
important_numbers <- c(value_of_pi, value_of_e)

# Try adding these to the integers.
important_numbers_plus <- some_numbers.integers + important_numbers
# What happened this time?

# Recycling might save the planet, but it might ruin your code.
# Use with caution!

three_important_numbers <- c(important_numbers, sqrt(pi))
three_important_numbers_plus <- some_numbers.integers + three_important_numbers


# What if we concatenate variables of different types?
mystery <- c(some_numbers.integers, 'This is a string')
# R 'coerces' variables to the more general type.
class(mystery)

# Similarly for numeric types.
mixed_numbers <- c(some_numbers.integers, value_of_pi)
class(mixed_numbers)


# You can coerce the types of variables yourself.
num_string <- as.character(some_numbers.integers)
as.numeric(num_string)




# You can assemble several variables into a list (preserving individual types).
list_of_stuff <- list(thing1 = some_numbers.integers, 
                      thing2 = value_of_pi)

other_list <- list(item1 = x1 <- 2, item2 = 'string')
x1


# Print it to screen.
list_of_stuff
class(list_of_stuff)

# Select an element of a list.
list_of_stuff$thing1
list_of_stuff['thing1']
list_of_stuff[2]
list_of_stuff[[1]]


bigger_list <- list(first_list = list_of_stuff, next_list = seq(5))

bigger_list$first_list$thing1
# bigger_list['first_list'][[1]] # Fail.



# Data frames behave similarly (because a data frame IS a list).
df1 <- data.frame(var1 = 1:10, var2=sprintf('row%d', 1:10))
# Note '%d' is the escape sequence for integers.


# Many statistical functions use a formula object

# Note the specific endpoint for a command that is continued on the next line.
# There is no terminal symbol in R (like the semicolon in C).
# R will determine that a command is unfinished and wait for more.

# Run this line:
df2 <- data.frame(var1 = 11:20, 
                  
                  # The '+' prompt indicates that R is waiting for the rest of an unfinished command.
                  
                  
                  # Now run this:                  
                  var2=sprintf('row%d', 11:20))
# And everything worked out.

# Multi-line commands must end with a symbol that indicates that a command is incomplete.
# An open bracket after a comma will work:
# Run both lines together:
df3 <- data.frame(var1 = 21:30, 
                  var2=sprintf('row%d', 21:30))


# Create a matrix.
# B = matrix( 
#   +   c(2, 4, 3, 1, 5, 7), 
#   +   nrow=3, 
#   +   ncol=2) 


# Categorical variables are called 'factors'.
df4 <- data.frame(var1 = 21:30, 
                  var2=as.factor(sprintf('Group %d', rep(1:2,5))))

df4$var2
is.factor(df4$var2)
is.character(df4$var2)


# Be careful with ambiguous operators:
value1 <- 7
value2 <- 10
total = value1 
  + value2

print(total)

# Try again:
total = value1 +
  value2

print(total)

# The first example saw the second line 
+ value2
# as a second command, with the (positive) value of value2.



################################################################################
# Mathematical Operations
################################################################################

# Standard mathematical operators work as expected: *,/,+,-.
some_numbers.integers * 2

# Notice that the type changes to the more general numeric.
some_numbers.integers * 2.5


# There are many mathematical functions in base R.
max(c(1,2))
min(c(1,2))
log(c(1,2,7))
exp(c(1,2))
sum(some_numbers.integers)
cumsum(some_numbers.integers)



# Special values.


# Divide by zero.
7/0
-7/0

# Add them together.
7/0-7/0
7/0+7/0
-7/0-7/0


# We saw the exponential function above, how far can we push it?
exp(100)
exp(709)
exp(710)
# Overflow.

# Try to generate some other special values.
log(0:1)


# Boolean operators (for logicals).

# Create some logicals.
5 == 3+3
5 == 3+2
is.integer(some_numbers.integers)
is.numeric(some_numbers.integers)
is.character('this is a character string')


# How about this?
'R' == 'fun'
# Should we continue?


# See what happens when you use mathematical operations on logicals:
T + T
T + F
T*T
T*F
class(T+T)
# R coerces the logical value to integer 1 or 0.

# Similarly for numeric.
value_of_pi + TRUE
class(value_of_pi + TRUE)



# Try this:
5 == 'five'

# How about this?
5 == '5'


################################################################################
# Conditional Logic
################################################################################

# Set parameters for conditions.
weather <- 'rainy'
# weather <- 'sunny'


# Single if statement.
if (weather == 'rainy') {
  print('Bring an umbrella.')
} 


weather <- 'sunny'

# Compound if statement.
if (weather == 'rainy') {
  print('Bring an umbrella.')
} else if (weather == 'sunny') {
  print('Bring sunglasses.')
} 



weather <- 'tornado'

# Compound if statement.
if (weather == 'rainy') {
  print('Bring an umbrella.')
} else if (weather == 'sunny') {
  print('Bring sunglasses.')
} else {
  print('Weather type not recognized.')
}



# For loop.
total <- 0
for(i in 1:10) {
  
  # Do the computations here.
  total <- total + i
  
  # Print a progress report.
  print('Cumulative total is')
  print(total)
  print(sprintf('Completed iteration %d', i))
}

total


# While loop.
i <- 0
while(i < 10) {
  i <- i + 1
  print(sprintf('Completed iteration %d', i))
}


# Be careful with runaway while statements.
i <- 0
while(i != 'rainy') {
  
  # This is running smoothly.
  i <- i + 1
  print(sprintf('Completed iteration %d', i))
  
  if (i > 100) {
    # This is getting out of control.
    # Stop it before the computer explodes!
    break
  }
  
}





################################################################################
# Functions and Packages
################################################################################


# Take an example from above.
cumsum(some_numbers.integers)

# Can also specify arguments by name.
cumsum(x = some_numbers.integers)

# What if the argument contains missing values.
contains_missing_values <- c(2,5,NA,7)
cumsum(contains_missing_values)

# For some functions, you can tell R to remove missing values.
sum(contains_missing_values)
sum(contains_missing_values, na.rm=TRUE)
# (Whether or not you think this is good might tell you about your preferred software.)


# Find the locations of the missing values and remove them yourself.
is.na(contains_missing_values)
without_missing_values <- contains_missing_values[!is.na(contains_missing_values)]
sum(without_missing_values)



# With multiple arguments, you can specify the arguments in any order,
# if you specify them by name.
sum(x = contains_missing_values, na.rm=TRUE)
sum(na.rm=TRUE, x = contains_missing_values)


# Notice that the sum() function has default value na.rm=FALSE.
help(sum)


# You can make your own functions, with the 'function()' function.
addTwoNumbers <- function(first_number, second_number) {
  
  total <- first_number + second_number
  
  return(total)
}

# Call the function.
addTwoNumbers(3,4)

# Try this.
addTwoNumbers(3,4,5)


# Lets make a function that allows for a flexible number of parameters.
addSeveralNumbers <- function(...) {
  
  # Get arguments.
  list_of_numbers <- list(...)
  
  # Add numbers.
  total <- 0
  for (i in 1:length(list_of_numbers)) {
    
    total <- total + list_of_numbers[[i]]
    
  }
  
  return(total)
}

addSeveralNumbers(3,2,1)
addSeveralNumbers(3,2,1,0,-1)

# What happens with a missing value?
addSeveralNumbers(3,2,1,NA,-1)


# Modify the function to remove missing values.
addSeveralNumbers <- function(..., na.rm=FALSE) {
  
  # Get arguments.
  list_of_numbers <- list(...)
  
  # Add numbers.
  total <- 0
  for (i in 1:length(list_of_numbers)) {
    
    # Add if either na.rm=FALSE or the number is not missing (or both, by definition of 'or').
    if (!na.rm | !is.na(list_of_numbers[[i]])) {
      
      total <- total + list_of_numbers[[i]]
      
    }
    # Adding skipped if both na.rm=TRUE and number is missing.
    
  }
  
  return(total)
}


# Try the modified version.
addSeveralNumbers(3,2,1,NA,-1, na.rm=TRUE)

# The original call is unchanged (good coding practice).
addSeveralNumbers(3,2,1,NA,-1)



################################################################################
# Loading packages.
################################################################################

# Syntax:
# library(name_of_R_package_goes_here) # No quotes: it's an object, not a string.

# If this package is not already installed, you have to install the package:
# install.packages('name_of_R_package_goes_here') # Argument is a string.


# Load libraries for time series analysis.

# install.packages('timeSeries')
library(timeSeries)

# install.packages('xts')
library(xts)

# install.packages('tseries')
library(tseries)

# install.packages('forecast')
library(forecast)




################################################################################
# End
################################################################################


