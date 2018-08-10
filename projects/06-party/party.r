
#' Simulates a present party
#' 
#' The present starts at position 1.
#' 
#' @param n Number of attendees
#' @param pheads Probability of moving left (heads).
#' 
present_party <- function(n, pheads = .5) {
  
  visited <- vector("logical", n)
  visited[1] <- TRUE
  nleft   <- n-1
  ntries  <- 0
  pos     <- 1
  
  while (nleft > 0) {
    
    # Increasing the counter
    ntries <- ntries + 1
    
    # Flipping the coin
    pos    <- pos + sample(c(-1,1), size = 1, prob = c(pheads, 1-pheads))
    
    # Adjusting new position
    if (pos < 1)
      pos <- n
    else if (pos > n)
      pos <- 1
    
    # Checking if individual has had the present yet
    if (!visited[pos]) {
      visited[pos] <- TRUE
      nleft <- nleft - 1
    }
      
    
  }
  
  list(
    ntries = ntries,
    pos    = pos
  )
  
}

# Simulating -------------------------------------------------------------------
library(parallel)
cl <- makeForkCluster(2)
ans <- parSapply(cl, 1:5, function(i) replicate(4e3, present_party(10), simplify = FALSE))
stopCluster(cl)

# Barplot of the results -------------------------------------------------------

graphics.off()
svg("projects/party/party.svg")
counts <- sapply(ans, "[[", "pos")
barplot(
  table(counts)/length(counts), ylim=c(0,.15),
  sub    = sprintf("Results from %i parties of %i.", length(ans), 10),
  main   = "Distribution of who gets it last",
  col    = "steelblue",
  border = adjustcolor("steelblue", offset = -rep(.4, 4))
)

abline(h=1/length(unique(counts)), lwd=1.5, lty=2)

dev.off()