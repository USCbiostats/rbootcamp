

init_ant <- function(init = c(26, 26), n = 51) {
  
  board <- matrix(0, ncol=n, nrow=n)
  board[rbind(init)] <- 1L
  
  list2env(list(
    board       = board,
    n           = n,
    pos         = init,
    orientation = 1L,
    step        = 0L
  ))
  
}

move_ant <- function(x) {
  
  # Increasing the number of step
  x$step <- x$step + 1L
  
  if (!x$board[x$pos[1], x$pos[2]]) {
    
    # Rotating 90 degrees to the right
    x$orientation <- ifelse(x$orientation == 4, 1, x$orientation + 1)
    
    # Flipping the color of the square
    x$board[x$pos[1], x$pos[2]] <- 1L
    
    
  } else {
    
    # Rotating 90 degrees to the left
    x$orientation <- ifelse(x$orientation == 1, 4, x$orientation - 1)
    
    # Flipping the color of the square
    x$board[x$pos[1], x$pos[2]] <- 0L
    
  }
  
  # Move forward one unit (x axis)
  if (x$orientation == 2) 
    x$pos[1] <- ifelse(x$pos[1] == 1, x$n, x$pos[1] + 1)
  else if (x$orientation == 4) 
    x$pos[1] <- ifelse(x$pos[1] == 1, x$n, x$pos[1] - 1)
  
  # Move forward one unit (y axis)
  if (x$orientation == 1) 
    x$pos[2] <- ifelse(x$pos[2] == 1, x$n, x$pos[2] - 1)
  else if (x$orientation == 3) 
    x$pos[2] <- ifelse(x$pos[2] == x$n, 1, x$pos[2] + 1)
  
  # Returning
  invisible()
  
  
}

ant <- init_ant(c(51,51), n = 101)
ant_raster <- magick::image_read("simulations/langtons-ant/ant-icon.png")

graphics.off()
fig <- magick::image_device(400, 400)
for (i in 1:11000) {
  
  move_ant(ant)
  
  if (!(i %% 100) | i > 10950) {

    # Image
    image(
      x = 1:ant$n,
      y = 1:ant$n,
      ant$board[,],
      col =c("white", "black"),
      sub=sprintf("Step number %i", ant$step),
      main="Langton's Ant", xlab = "", ylab="",
      xaxs = "i", yaxs = "i", bty="n"
      )
    
    # Adding an ant
    rot_ant <- magick::image_rotate(
      ant_raster,
      180 - (ant$orientation - 1)*90
    )
    rasterImage(
      rot_ant,
      xleft   = ant$pos[1] - 2,
      ybottom = ant$pos[2] - 2,
      xright  = ant$pos[1] + 2,
      ytop    = ant$pos[2] + 2
      )
    
    # So people can see that there's an ant
    rasterImage(
      rot_ant,
      xleft = 0,
      ybottom = 90,
      xright = 10,
      ytop = 100
      )
  
  }
  
}

dev.off()

animation <- magick::image_animate(fig, fps = 10)
magick::image_write(animation, "simulations/langtons-ant/ant.gif")

