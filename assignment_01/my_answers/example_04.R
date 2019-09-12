# Write an R function to print all multiples of 5 between 1 and n (possibly including n)

# Get number from user.
n <- as.integer(readline(prompt="At what number would you like to stop?: "))

# Set x to 0
x <- 0

# Loop to find all multiples of 5 between 1 and n
while (x <= n){
  if(x > 0)
  print(x)
  x <- x + 5
}
