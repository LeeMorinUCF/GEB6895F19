#Write an R function that will count all the even numbers up to a 
#user defined stopping point. 

#to test if the number is even, we simply check if the remainder after dividing
#the number by 2 is 0.The same logic will be implanted in the if statement which will 
#placed within a for loop which goes to 1 to n.

countevens<- function()
{
  
  num_in<-as.integer(readline(prompt="Enter a number:"))
#the above line prompts the user for input
  count<-0
#the count variable has been defined to work as a counter. This will increment
#by 1 if the number is even
  for(i in 1: num_in)
  {
    if(i%%2==0)
    # "%%" operator is used to get the remainder. Therefore if I=2, i%%2 will be =0
    #and the count will be incremented by 1 as shown below
    {
      count=count+1
    }
  }
   print(count)
}
#call the function

countevens()