num_in <- readline(prompt = "enter a number:")

num_in <- as.integer(num_in)

if (5 == num_in)
  print(' your number is a five')
  
if (6 == num_in)
  print('your number is a six')

if (4 >= num_in)
  print('your number is not a five or six')

if (7 <= num_in)
  print('your number is not a five or six')
  