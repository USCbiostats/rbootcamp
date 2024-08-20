
#####################
# R AS A CALCULATOR #
#####################

1 + 1
5 - 3

27 * 34
3 / 7

2 + 3 * 4
(2 + 3) * 4

3^10

sqrt(36)

abs(-5)

log(100)     # natural
log(100, base = 10)

sin(1)      # radians
cos(2pi)
tan(pi/4)

Inf
1/0
0/0

# t distribution
pt(-2.4, df = 15)
pt(2.4, df = 15)

#########################
# VARIABLES AND VECTORS #
#########################

x <- 3

print(X)
x

x <- x + 2
x

c(3, 6, 4, 2)

y <- c(3, 6, 4, 2)

length(y)
mean(y)
sd(y)

y + 2
sqrt(y)
sort(y)

1:10

seq(5, 100, by = 5)
seq(1900, 2024, by = 4)

rep(0, 100)
rep(1:3, each = 20)
rep(1:3, times = 20)

x <- rnorm(100)
x
hist(x)

x <- rnorm(100, mean = 10, sd = 4)
hist(x)

sample(10, 5)
sample(c(0,5,-5), 1)
sample(c(0,5,-5), 50)


###########
# CLASSES #
###########

class(x)

x <- "this"

x
class(x)
sample(c("a","b","c"), 1)
x + 2

x <- FALSE

class(x)

x <- c("b","a","b","c")
sort(x)

x <- factor(x)
class(x)

x

#######################
# INDICES AND SUBSETS #
#######################

x <- c("a","b","c","d","e")

x[1]
x(2)
x[1:3]
x[c(1,3,5)]
x[c(1,1,1)]
x[c(TRUE,FALSE,TRUE,FALSE,TRUE)]

x[-1]
x[-1:3]
x[0]

x == "c"
x[x == "c"]
x[x != "c"]


y <- rnorm(100)

y > 0
y[y > 0]
y <- y[y > 0]

length(y)

# missing values
z <- c(1,2,3,4,NA,5)

is.na(z)
z[!is.na(z)]


###################
# LOGIC AND LOOPS #
###################

x <- 0

if(x > 2){
  print('x is big')
}


if(x > 2){
  print('x is big')
}else{
  print('x is small')
}


x <- 1:10

ifelse(x > 2, 'big', 'small')


for(i in 1:10){
  print(i)
}

for(x in c(3,-5,12,2)){
  print(x * 4)
}

x


x <- 1
while(x < 10){
  print(x)
  x <- x + 1
}

while(x >= 10){
  print(x)
  x <- x + 1
}


sapply(1:10, sqrt)
sapply(c(3,-5,12,2), abs)
sapply(c(3,-5,12,2), sqrt)

x


###############
# DATA FRAMES #
###############
iris
iris <- iris

iris[1,]
iris[,1]
iris[3:7,]
iris[3:7, 1]
iris[3:7, 1:2]

iris[,1]
iris$Sepal.Length
iris$Species

class(iris$Sepal.Length)
class(iris$Species)

# note: tab completion!
# iris$

dim[iris]
nrow(iris)
ncol(iris)
summary(iris)

# basic plots
hist(iris$Sepal.Width)
plot(iris$Sepal.Length, iris$Sepal.Width)
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species)

# combining concepts
iris[sample(150, 10), ]
iris[iris$Sepal.Width > 3, ]
iris[iris$Species == "setosa", ]
sapply(1:ncol(iris), function(j){
  class(iris[,j])
})

# adding variables
iris$Sepal.Length / 2.54
iris$Sepal.Length.in <- iris$Sepal.Length / 2.54
iris$newvar <- 1


############
# PACKAGES #
############

# CRAN
install.packages('ggplot2')
library(ggplot2)


#############
# FUNCTIONS #
#############

myFun <- function(){
  print("OK")
}
myFun()

myFun <- function(x){
  (x + 5) / 2
}
myFun()

myFun <- function(x){
  y <- (x + 5) / 2
  if(y > 10){
    return(11)
  }else{
    return(y)
  }
}
myFun(2)
myFun(50)


sapply(1:10, function(i){
  # do something complicated
  j <- i + 5
  if(j > 7){
    j <- j - 2
  }
  k <- j/3
  2*k - 1
})

