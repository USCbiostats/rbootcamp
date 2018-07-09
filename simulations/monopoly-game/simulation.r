# Global values
UTILITIES <- c(electric=12L, water=28L)
RAILROADS <- c(reading = 6L, penn = 16L, bo=26L, sl=36L)

CHANCE          <- c(8L, 23L, 37L)
COMMUNITY_CHEST <- c(3L, 18L, 34L)

init_community <- function() {
  
  # Actions to happen in community
  cards <- c(list(
    go2go   = function(i) 1L,
    go2jail = function(i) 11L
  ),
  replicate(16, function(i) i)
  )
  
  # Shuffling cards
  cards <- cards[order(runif(length(cards)))]
  
  # Returns a functioon that changes the position of the
  # token
  function(i) {
    # Applying the action
    i <- cards[[1]](i)
    
    # Putting the card to the bottom of the deck
    cards <<- c(cards[-1], cards[1])
    i
  }
}

init_chance <- function() {
  
  
  
  # Actions to happen in community
  cards <- c(list(
    go2go   = function(i) 1L,
    go2illi = function(i) 25L,
    go2stchar = function(i) 12L,
    go2util   = function(i) {
      
      # Which is closests
      d <- UTILITIES - i
      d[d < 0] <- 40L + d[d < 0]
      UTILITIES[which.min(d)]
      
    },
    go2rail = function(i) {
      
      # Which is closests
      d <- RAILROADS - i
      d[d < 0] <- 40L + d[d < 0]
      RAILROADS[which.min(d)]
      
    },
    goback3 = function(i) {
      
      if (i <= 3L)
        return(40L - (3L - i))
      
      i - 3L
      
    },
    go2jail = function(i) 11L,
    go2reading = function(i) 6L,
    go2boardwlk = function(i) 40L
  ),
  replicate(7, function(i) i)
  )
  
  # Shuffling cards
  cards <- cards[order(runif(length(cards)))]
  
  # Returns a functioon that changes the position of the
  # token
  function(i) {
    # Applying the action
    i <- cards[[1]](i)
    
    # Putting the card to the bottom of the deck
    cards <<- c(cards[-1], cards[1])
    i
  }
}

init_die <- function(times) {
  
  # To make it faster, we sample 1 million of these
  die <- matrix(sample.int(6, 4*times, replace = TRUE),ncol = 2)
  n   <- 1L
  
  function(i) {
    
    # Adding die sum
    i <- i + sum(die[n, ])
    n <<- n + 1
    
    # Duplets!
    if (die[n - 1, 1] == die[n - 1, 2]) {
      
      i <- i + sum(die[n, ])
      n <<- n + 1
      
      if (die[n - 1, 1] == die[n - 1, 2]) {
        
        n <<- n + 1
        
        # Jail!
        if (die[n - 1, 1] == die[n - 1, 2]) {
          
          return(11L)
          
        }
        
      }
        
    }
    
    
    # Over 40?
    if (i > 40)
      i <- (i - 40L)
      
    i
  }
  
}

monopoly_sim <- function(times) {
  
  # Current position
  token <- 1
  
  # Initializing the board
  roll_die       <- init_die(times)
  draw_community <- init_community()
  draw_chance    <- init_chance()
  
  counts <- double(40L)
  counts[1] <- 1
  
  i <- 1L
  while (i < times) {
    
    # Roll the die
    token <- roll_die(token)
    
    # Is it a chance
    if (token %in% CHANCE)
      token <- draw_chance(token)
    else if (token %in% COMMUNITY_CHEST) 
      token <- draw_community(token)
    
    counts[token] <- counts[token] + 1
    
    
    
    # Is it jail?
    if (token == 31L)
      token <- 11L
    
    i <- i + 1
    
  }
  
  structure(
    counts,
    names = 1:40
  )
  
  
}

library(parallel)
cl <- makeForkCluster(4L)
ans <- parLapply(cl, 1:1e5, function(z) monopoly_sim(500))
ans <- do.call(rbind, ans)
boxplot(ans[, -c(CHANCE, COMMUNITY_CHEST)], cex.axis=.75)
abline(h=quantile(ans, .5), lwd=2, col="tomato")
stopCluster(cl)
