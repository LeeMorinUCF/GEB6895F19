#Write an R function to print all multpiles of 5 between 1 and n.
#(possibly including n).

#lets name the function as multiples
multiples <-function()
{
  
  num_in<-as.integer(readline(prompt="Enter a number:"))
#Now we will start a for loop which would start from 1 to n(Number inputted by
  #the user) and multiple I with the number at every increment.
  
  for(i in 1:num_in)
  {
    b<- i*num_in
    print (b)
  #finally printing the numebr/multiple at every iteraton in a loop.
  }
}
#call the function:

multiples()