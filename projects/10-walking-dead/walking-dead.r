#' Initializes the data
#' @param n,m Population size and number of initial infected.
#' @param infect Probability of infection on the contact.
#' @param infect_radious Exposure radious at which an individual can get
#' infected.
init_population <- function(
  n,
  m,
  infect = .75,
  infect_radius = .075
  ) {
  
  # Creating the baseline environment
  ans <- list2env(list(
    n      = n,
    pos    = matrix(runif(n*2), ncol=2),
    degree = runif(n, 0, 2*pi),
    sick   = (1:n) %in% sample.int(n, m),
    infect = infect,
    radii  = infect_radius,
    speed  = runif(n, 0.005, .025)/2
  ))
  
  # Computing distances
  ans$D <- as.matrix(dist(ans$pos))
  ans
  
}

update_status <- function(x) {
  
  # Moving contagion
  if (sum(x$sick) < x$n) {
    newsick <- which(
      (apply(x$D[, x$sick, drop=FALSE], 1, min) < x$radii) &
        (runif(x$n) < x$infect)
    )
    x$sick[newsick] <- TRUE
  }

  invisible()
  
}

weighted_avg <- function(x, W) {
  
  invW <- 1/(W^2 + 1e-5)
  invW %*% x / rowSums(invW)
  
}

update_pos <- function(x) {
  
  # Update angle
  
  if (sum(x$sick) < x$n) {
    
    attraction <- weighted_avg(
      x$pos[!x$sick,,drop=FALSE], x$D[x$sick, !x$sick, drop=FALSE]
      ) - x$pos[x$sick, ,drop=FALSE]
    
    repulsion  <- weighted_avg(
      x$pos[x$sick,,drop=FALSE], x$D[!x$sick, x$sick, drop=FALSE]
      ) - x$pos[!x$sick, ,drop=FALSE]
  
    # Arctan2. We add pi to the healthy indivuduals' angle so that they go in the
    # opposite direction
    x$degree[x$sick]  <- atan2(attraction[,2], attraction[,1]) +
      runif(sum(x$sick, 0, pi/4)) 
    x$degree[!x$sick] <- atan2(repulsion[,2], repulsion[,1]) +
      runif(sum(!x$sick, 0, pi/4)) + pi
    
  } else
    x$degree <- runif(x$n, 0, 2*pi)
  
  # Update position
  x$pos <- x$pos + x$speed*cbind(cos(x$degree), sin(x$degree))

  # Boundaries
  x$pos[x$pos > 1] <- 1
  x$pos[x$pos < 0] <- 0
  
  
  x$D <- as.matrix(dist(x$pos))
  
  invisible()
  
}

plot_process <- function(x) {
  
  op <- par(mar=rep(1, 4), mai = rep(0, 4))
  on.exit(par(op))
  
  plot.new()
  
  plot.window(c(0,1), c(0,1))
  rect(0,0,1,1, col = "gray70", border = "transparent")
  points(
    x$pos,
    bg = c("black", "red")[x$sick+1],
    pch = 21, col="white", cex=2
  )
  
}

# ------------------------------------------------------------------------------

# Initialize
set.seed(1)
ans <- init_population(100, 2, infect = .75)

# Setting animation
graphics.off()
fig <- magick::image_device(300, 300)

for (i in 1:200) {
  
  update_status(ans)
  plot_process(ans)
  update_pos(ans)
  # Sys.sleep(.10)
  
}

dev.off()

animation <- magick::image_animate(fig, fps = 20)
magick::image_write(animation, "projects/walking-dead/walking-dead.gif")
