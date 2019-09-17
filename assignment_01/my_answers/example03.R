#Write an R Function that performs the following:Ask a user
#to enter a numbe. If the number s between 0 and 10,write
#the word blue. If 10-20, write the word red. If the number is
#between 20 and 30, write the word green. If any other number, write
#not correct color option. 
  
#splitting problems into parts:Input, Processing, & Output. 

#prompt the user to enter a number.So, in ordert to make it easier, lets
#define a function "getnumbesr()"which would be called in each program.

getnumbers = function() 
#this line defines the object getnumber as a function
{
 numbers <- readline(prompt = 'Enter the numbers:') 
#This is used to prompt the user.
 numbers <-scan(text = numbers,quiet=TRUE,sep=",")
#scan function is used to read data from the console. The first argument
#"text" refers to the data that you want to read, for example
#here we have a data in the variable "numbers". The second argument "quiet"
#is set to true,if this is FALSE(default option). The scan()
#will print a line, saying how many items have been read. Since we 
#do not require this, we set it to TRUE. The third argument is the sperator
#which is used to seperate multiple values entered.1,2 will be
#be taken as two values.
 cat("Your Numbers are:", numbers,"\n")
#The "cat" function is used to concatenate and turn the arguments into character strings.
 invisible(numbers)
#the "invisible" function is used when you don't want to print the value that the function retruns
}

#once you execute this block, just call the function
getnumbers()

#Now, lets focus on the main question, which wants us to test the inputted number
#for some conditions:
#This would be simple if else loop which would be executed in a function that will define.
#let us call that function as "CHECKCOLOR"

checkcolor<-function()
{
  num_in=as.integer(getnumbers())
#The above lines calls the getnumbers() fucntion which we had defined above.
#this prompts the user for the input. Once the user inputs a number, the
#"as.integer" command converts the inputted value to a number and then stores the
#same in num_in variable :)
  if(num_in>=0&&num_in<10)
  {
    return ("BLUE")
    
  }
  else if (num_in>=10&&num_in<20)
  {
    return ("RED")
  }
  else if (num_in>=20&&num_in<30)
  {
    return("GREEN")
  }
  else
  {
    return("Tthis is not a correct color option")
  }

}

#call the function

checkcolor()