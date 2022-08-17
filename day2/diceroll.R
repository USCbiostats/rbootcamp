winPassLine <- function(N) {
  # N = # of Monte Carlo replications (against should be large)
  win <- 0 # Count the # of times we won
  
  for(i in 1:N) {
    roll     <- 0 # Count what roll we are on
    decision <- FALSE # TRUE if we win/lose
    while(decision == FALSE) {
      roll <- roll + 1 # Start roll counter
      dice <- sum(sample(1:6, size = 2, replace = TRUE))
      # What happens with first dice roll?
      if (roll == 1 & dice %in% c(7, 11)) {
        win      <- win + 1
        decision <- TRUE
      } else if (roll == 1 & dice %in% c(2, 3, 12)) {
        win      <- win
        decision <- TRUE
      } else if (roll == 1) {
        point <- dice
      } else if (roll > 1 & dice == point) {
        win      <- win + 1
        decision <- TRUE
      } else if (roll > 1 & dice == 7) {
        win      <- win
        decision <- TRUE
      }
    }
  }
  return(win / N)
}

