num_in <- readline(prompt = "enter a number:")

num_in <- as.integer(num_in)

if (0 <= num_in & num_in <= 10)
  print('blue')

if (11 <= num_in & num_in <= 20)
  print('red')

if (21 <= num_in & num_in <= 30)
  print('green')

if (num_in >= 31)
  print('not a correct color option')

