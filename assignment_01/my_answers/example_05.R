# Write an R function that will count all the even numbers up to a user defined stopping point.

# Get number from user.
upper_limit <- as.integer(readline(prompt="At what number would you like to stop?: "))

x <- 2

while (x <= upper_limit){
  print(x)
  x <- x + 2
}
