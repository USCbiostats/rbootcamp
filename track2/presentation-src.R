## ------------------------------------------------------------------------
mymat <- matrix(1:9, ncol=3) # A matrix with numbers 1 through 9 with 3 columns
mymat
str(mymat)


## ---- collapse=TRUE------------------------------------------------------
mymat[1, 2] # The element in the (1, 2) location of the matrix
mymat[4]    # The fourth element in the vector... which is (1, 2)


## ----eg-ols-sim----------------------------------------------------------
# Simulating an Linear Model
set.seed(181)
X <- cbind(1, rnorm(1000))
y <- X %*% cbind(c(2.3, 5)) + rnorm(1000)

# Estimating the model using the lm function
coef(lm(y ~ -1 + X))

# O a la linear algebra :)
solve(t(X) %*% X) %*% t(X) %*% y


## ---- R.options=list(digits=2)-------------------------------------------
set.seed(122)
A <- matrix(rnorm(12), ncol=3)
B <- matrix(rnorm(12), nrow=3)
C <- A %*% cbind(1:3) + rnorm(4) # Adding a vector of length 4!


## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # Matrix multiplication:
## A %*% B
## 
## # Transpose
## t(A)
## 
## # Element-wise product
## A*t(B)
## 
## # Inverse
## solve(t(A) %*% A)
## 
## # OLS
## solve(t(A) %*% A) %*% t(A) %*% C


## ----eg-indexing-columns-dgp1--------------------------------------------
set.seed(11122)

dat <- matrix(runif(100*5), nrow = 100)
head(dat)


## ----eg-indexing-columns-sol1, include=FALSE-----------------------------
# To get the min is equivalent to get the max of the negative!
idx <- max.col(-dat)
head(idx)

# Let's just see the first observations
cbind(
  head(dat),
  lowest = head(dat[cbind(1:100, idx)])
)


## ----eg-indexing-columns-dgp2--------------------------------------------
set.seed(881)

dat <- matrix(runif(100*5), nrow = 5)
str(dat)


## ----eg-indexing-columns-sol2, include = FALSE---------------------------
# Well... we don't have a max.row... but we can always transpose it!
idx <- max.col(-t(dat))
head(idx)

cbind(
  head(dat),
  lowest = head(dat[cbind(idx, 1:100)])
)


## ----solution-er, eval=FALSE, echo=FALSE---------------------------------
## set.seed(81)
## # How many edges
## n   <- 1e3
## m   <- rbinom(1, n^2, .05)
## 
## # Where are the edges?
## idx <- sample.int(n^2, m, FALSE)
## mat <- matrix(0, 1e3, 1e3)
## mat[idx] <- 1L
## 
## image(mat)


## ----solution-er2--------------------------------------------------------
set.seed(81)
# How many edges
n   <- 5e4
m   <- rbinom(1, n^2, .0005)

# Where are the edges?
idx <- sample.int(n^2, m, FALSE)

library(Matrix)
# Getting the row
idx_row <- (idx - 1) %% n + 1
idx_col <- (idx - 1) %/% n + 1

# Empty sparse
mat <- sparseMatrix(
  i = idx_row,
  j = idx_col,
  x = rep(1, length(idx_row)),
  dims = c(n, n)
  )

# Is it working?
sum(mat) == m


## ----er-space-saver------------------------------------------------------
print(object.size(mat), units = "Mb") # Sparse matrix
(8 * n^2) / 1024^2 # Dense matrix


## ------------------------------------------------------------------------
devtools::session_info()

