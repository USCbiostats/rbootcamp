
sample_from_ball <- function(n, dim = 2) {
  
  ans    <- matrix(ncol=dim, nrow=n)
  ntries <- 0
  i      <- 1
  
  while (i < n) {
    
    # Number of tries
    ntries <- ntries + 1
    
    # Drawing a vector of size d
    v <- runif(dim, -1, 1)
    
    if (sum(v^2) <= 1) {
      ans[i,] <- v
      i <- i + 1
    }

  }
  
  list(
    points = ans,
    ntries = ntries
  )
  
  
}

set.seed(123)
ans <- sample_from_ball(10000, 2)

# Measuring time

d2 <- sample_from_ball(1e3, 2)
d4 <- sample_from_ball(1e3, 4)
d6 <- sample_from_ball(1e3, 6)
d10 <- sample_from_ball(1e3, 10)

graphics.off()
png("projects/rejection/rejection.png", width = 800, height = 400)
op <- par(mfrow=c(1, 2))
smoothScatter(
  ans$points, xlab = "x-coord", ylab = "y-coord",
  main="Smooth Scatter Plot\n10,000 points",
  sub = sprintf("Sample using rejection method with %i tries.",ans$ntries)
  )
barplot(
  cbind("2" = 1e3/d2$ntries, "4" = 1e3/d4$ntries, "6" = 1e3/d6$ntries, "10" = 1e3/d10$ntries),
  ylim = c(0, 1),
  xlab = "Dimension",
  main = "Acceptance Rate"
  )
par(op)
dev.off()
