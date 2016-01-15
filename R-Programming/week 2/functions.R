
greater <- function(x, n=15) {
  
  x[x>n]
  
}

column_m <- function(x, isn=TRUE) {
  n<-ncol(x)
  m<-numeric(n)
  for (i in 1:n) {
    m[i]<-mean(x[,i],na.rm = isn)
  }
  m
}

extra<-function (...) {
  z=1
  print_z<- function(){
    print(z)  
  }
  print_z
}

