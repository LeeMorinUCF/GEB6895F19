# Write an R function that will count all the even numbers up to a user defined stopping point.

# Get number from user.
upper_limit <- as.integer(readline(prompt="At what number would you like to stop?: "))

# Set x to 2 (so 0 doesn't populate in answer)
x <- 2

# Loop to give multiples of two until it hits the upper limit
while (x <= upper_limit){
  print(x)
  x <- x + 2
}
