# Write an R function that tells a user that the number they entered is not a 5 or a 6.
# You can read input from the keyboard with num_in <- readline(prompt="Enter a number:  ")



# Get number from user.
num_in <- readline(prompt="Enter a number: ")

# Determine if number is a 5 or 6 and inform user of result.
if (num_in == '5') {
  print('You entered a 5.')
} else if (num_in == '6') {
  print('You entered a 6.')
} else {
  print('You did not enter a 5 or a 6')
} 
