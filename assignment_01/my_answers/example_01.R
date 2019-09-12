# Write an R function that reads two numbers, multiplies them together and prints out their product. 
# You could start out with multiply_two <- function(num_1, num_2) ( ... }

# Define function for multiplying two numbers.
multiply_two <- function(num_1, num_2) {
  
  total <- num_1 * num_2
  
  return(total)
}

# Get first number from user.
num_1 <- as.integer(readline(prompt="Enter number 1 of 2: "))

# Get second number from user.
num_2 <- as.integer(readline(prompt="Enter number 2 of 2: "))

# Define result of multiplication.
total <- multiply_two(num_1, num_2)

# Tell user the total.
print(sprintf("%i x %i = %i",num_1, num_2, total))
