# Write an R function that will perform the following
# a) Read in 5 separate numbers
# b) Calculate the average of the five numbers
# c) Find the smallest (minimum) and largest (maximum) of the five entered numbers
# d) Write out the results found from steps b and c with a message describing the results, i.e. maximum is ....

# Get 5 numbers from user.
n1 <- as.integer(readline(prompt="Please tell me five numbers. Number 1: "))
n2 <- as.integer(readline(prompt="Number 2: "))
n3 <- as.integer(readline(prompt="Number 3: "))
n4 <- as.integer(readline(prompt="Number 4: "))
n5 <- as.integer(readline(prompt="Number 5: "))

# Calculate average
avg <- (n1 + n2 + n3 + n4 + n5) / 5

# Calculate minimum
min <- min(n1, n2, n3, n4, n5)  

# Calculate maximum
max <- max(n1, n2, n3, n4, n5) 

# Tell user the total.
print(sprintf("The average is %f, the minimum is %i, and the maximum is %i.",avg, min, max))
