num_1 <- readline(prompt = "please enter your first number:") 

num_2 <- readline(prompt = "please enter your second number:") 

num_3 <- readline(prompt = "please enter your third number:") 

num_4 <- readline(prompt = "please enter your fourth number:") 

num_5 <- readline(prompt = "please enter your fifth number:") 

  x1 <- as.double(num_1)
  x2 <- as.double(num_2)
  x3 <- as.double(num_3)
  x4 <- as.double(num_4)
  x5 <- as.double(num_5)


  minimum <- min (x1, x2, x3, x4, x5)
  
  maximum <- max (x1, x2, x3, x4, x5)
  
  sum_of_numbers <- (x1 + x2 + x3 + x4 + x5)
  
  average <-  (sum_of_numbers/5)
  

  print('the minimum number is')
  print(minimum)
  
  print('the maximum number is')
  print(maximum)
  
  print('the average number is')
  print(average)
  

  
