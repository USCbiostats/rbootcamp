mycumsum <- function(x) {
  
  n <- length(x)
  
  ans <- vector("numeric", n)
  ans[1] <- x[1]
  for (i in 2:n)
    ans[i] <- x[i] + ans[i-1]
  
  
  ans
}

x <- runif(20)
cumsum(x)
mycumsum(x)