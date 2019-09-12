# Write an R function that performs the following: Ask a user to enter a number. 
# If the number is between 0 and 10, write the word blue. If the number is between 10 and 20, write the word red.
# If the number is between 20 and 30, write the word green. 
# If it is any other number, write that it is not a correct color option. 


# Get number from user.
num_in <- as.integer(readline(prompt="Enter a number: "))

# Determine what color to print.
if (num_in >= 0 && num_in <= 10) {
  print('blue')
} else if (num_in > 10 && num_in <= 20) {
  print('red')
} else if (num_in > 20 && num_in <= 30) {
  print('green')
} else {
  print('Your number is not a correct color option.')
} 
