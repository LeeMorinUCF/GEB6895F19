#Excercise Three IF color Code
#new attempt SUCCESSFUL
enter.number <- as.integer(readline(prompt="Enter a number: "))
#must enter before continuing to if statement
if(enter.number < 0) {
  print("that is not a correct color option")
} else if(enter.number < 10) {
    print("blue")
} else if(enter.number < 20) {
  print("red")
} else if(enter.number < 30) {
  print("green")
} else 
  print("that is not a correct color option")
#END successful Attempt

#new quasi successful attempt 
enter.number <- as.integer(readline(prompt="Enter a number: "))
#must enter before continuing to if statement
number.as.color.function <- function(enter.number) {
if(enter.number < 10) {
  color <- "blue"
} else if(enter.number < 20) {
  color <- "red"
} else if(enter.number < 30) {
  color <- "green"
} else if(enter.number < 0) {
  color <- "that is not a correct color option"
} else {
  color <- "that is not a correct color option"
} return(color)
}
#END quasi successful Attempt


#New Attempt (failed)
#Has to be run and returned with a value before running if function
if.color.function <- function(enter.number){
  if(0 < enter.number < 10){
  return("blue")
} else if(10 < enter.number <= 20){
  return("red")
} else if(20 < enter.number <= 30){
  return("green")
} else 
  return("that is not a correct color option")
}
#END 
#FAILED NEXT


#NEXT ATTEMPT (Failed) 
enter.number <- readline(prompt="Enter a number: ")
#Has to be run and returned with a value before running if function
if(enter.number > 0 & enter.number < 10) {
    print("blue")
  } else if(enter.number >= 10 & enter.number < 20){
    print("red")
  } else if(enter.number >= 20 & enter.number < 30){
    print("green")
  } else 
    print("that is not a correct color option")
}
#END (Attempt failed)

#new attempt SUCCESSFUL
enter.number <- readline(prompt="Enter a number: ")
#must enter before continuing to if statement
color.function <- function(enter.number) {
if(enter.number < 10) {
  return("blue")
} else if(enter.number < 20) {
  return("red")
} else if(enter.number < 30) {
  return("green")
} else if(enter.number < 0) {
  return("that is not a correct color option")
} else 
  return("that is not a correct color option")
}