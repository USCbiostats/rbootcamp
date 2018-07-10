# set.seed(1)
# n <- 30
# x <- matrix(runif(n*n) > .7, ncol=n)
# # X <- array(0, dim = dim(x))

# extend x
expandx <- function(x) {
  
  n <- nrow(x)
  
  xplus <- cbind(x[,n], x, x[,1])
  rbind(xplus[n,], xplus, xplus[1,])
}

# xplus <- expandx(x)


# Survey sides efficiently
survey <- function(x) {
  
  n       <- nrow(x)
  xplus   <- expandx(x)
  xplus[] <- xplus > 0
  X <- array(0, dim = dim(x))
  
  idx <- (1:n) + 1
  for (i in c(-1, 0, 1))
    for (j in c(-1, 0, 1))
      X <- X + xplus[idx - i,][,idx - j]
  
  x0 <- x
  x0[] <- x0>0
  X - x0
}

# Update the state
update_state <- function(x) {
  
  s  <- survey(x)
  x1 <- x
  
  x1[x!=0 & s<=2] <- 0L        # Fewer than 2, dies
  x1[x!=0 & s>=2 & s<=3] <- 2L # 2 to 3 neighbours lives
  x1[x!=0 & s>3 ] <- 0L        # Overpop (more than 3)
  x1[x==0 & s==3] <- 1L        # reproduction
  
  x1
  
}

# Example 1: Glider and the Beacon ---------------------------------------------

x <- matrix(0, ncol=20, nrow=20)

# Glider
x[cbind(
  c(2, 3, 1:3),
  c(1, 2, 3,3,3)
)] <- 1

# Beacon
x[cbind(
  c(10,11,10,11,12,13,12,13),
  c(1,1,2,2,3,3,4,4)
)] <- 1



fig <- magick::image_device(400, 400, res = 96/2)
for (i in 1:20) {
  
  image(x, col=c("white", "steelblue", "tomato"))
  x <- update_state(x)
  
}
dev.off()
animation <- magick::image_animate(fig, fps = 4)
magick::image_write(animation, "simulations/life/life1.gif")


# Example 2: Random ------------------------------------------------------------

n <- 100
set.seed(1)
x <- matrix(as.integer(runif(n*n) > .75), ncol=n)

fig <- magick::image_device(400, 400, res = 96/2)
for (i in 1:200) {
  x <- update_state(x)
  image(x, col = viridis::magma(3))
  Sys.sleep(.1)
}
dev.off()
animation <- magick::image_animate(fig, fps = 10)
magick::image_write(animation, "simulations/life/life2.gif")

