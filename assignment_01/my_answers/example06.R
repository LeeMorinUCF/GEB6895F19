getnumbers = function()
{
  numbers <- readline(prompt='Enter the Numbers: ')
  numbers <-scan(text=numbers,quiet=TRUE,sep=",")
  cat("Your Numbers are:",numbers,"\n")
  invisible(numbers)
}

average<-function()
{
  num_in <-as.integer(getnumbers())
  m <-mean(num_in)
  print(paste("Average is:",m))

}

average()
