multiplytwo.function <- function(x,y)
{
  z = x*y
  print(z)
}

x <- readline(prompt = "Enter first number: ")
y <- readline(prompt = "Enter second number: ")

x<- as.integer(x)
y<- as.integer(y)

multiplytwo.function(x,y)