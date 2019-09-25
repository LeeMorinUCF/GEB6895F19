#Excercise Two responds that the number they entered is not a 5 or a 6
#OR num in <- readline(prompt="Enter a number: ")
input.one <- as.integer(readline(prompt="Enter a number: "))
#Has to be run and returned with a value before running if function
if(input.one==5){
  print(input.one)
} else if(input.one==6){
  print(input.one)
} else {
  print("this is not a 5 or 6")
}  
#END 1st Attempt


#NEW attempt
input.one <- readline(prompt="Enter a number: ")
input.one <- as.integer(input.one)
#Has to be run and returned with a value before running if function
if.elseif.else.return <- function(input.one){
if(input.one==5) {
  the.statement.is <- input.one
} else if(input.one==6){
  the.statement.is <- input.one
} else {
  the.statement.is <- "this is not a 5 or 6"
} return(the.statement.is) 
}
#END Quasi Successful Attempt


#NEW Failed Attpemt Next: Ask for explanation for failure
# input.one <- #a number#
#OR variable <- readline(prompt="Enter a number: ")
input.one <- as.integer(readline(prompt="Enter a number: "))
#Has to be run and returned with a value before running if function
if(input.one!=5){
  print("This is not a 5 or 6")
} else if(input.one!=6){
  print("This is not a 5 or 6")
} else {
  print(input.one)
}  
#End Failed attempt

#NEW failed attempt: ask why it failed
input.one <- as.integer(readline(prompt="Enter a number: "))
#Has to be run and returned with a value before running if function
if(input.one!=5){
  then.the.statement.is <- "This is not a 5 or 6"
} else if(input.one!=6){
  then.the.statement.is <- "This is not a 5 or 6"
} else {
  then.the.statement.is <- input.one
} return(then.the.statement.is)
#End Failed attempt