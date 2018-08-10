newton_raphson <- function(x0, fdx, f2dx2, criter = 1e-4, maxiter=50) {
  
  i    <- 2
  x    <- vector("numeric", maxiter)
  x[1] <- x0
  x[i] <- x0 - fdx(x0)/f2dx2(x0)
  
  while ((abs(x[i] - x[i-1]) > criter) & (i < maxiter)) {
    
    i <- i + 1 
    x[i] <- x[i-1] - fdx(x[i-1])/f2dx2(x[i-1])
    
  }
  
  list(
    x0 = x0,
    x  = x[1:i]
  )
  
}

newton_raphson(20, function(x) 3*(x - pi)^2, function(x) 6*(x - pi))
