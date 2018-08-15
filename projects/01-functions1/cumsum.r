# Here is an example with the cumulative sum function
mycumsum <- function(x) {
  
  # How big is the vector?
  n <- length(x)
  
  # Making room for the new vector
  ans <- vector("numeric", n)
  ans[1] <- x[1]
  
  # Calculating the cumulative sum
  for (i in 2:n) {
    ans[i] <- x[i] + ans[i-1]
  }
  
  # Returning the result
  ans
}

x <- runif(20)
cumsum(x)
mycumsum(x)