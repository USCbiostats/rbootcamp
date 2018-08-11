dat <- readLines("projects/secret1/secret1-original-message.txt")

set.seed(854133)

letters2 <- c(letters, " ", ",", ".", "'", "(", ")") 
dict <- c(sample(letters),  " ", ",", ".", "'", "(", ")")

encode <- function(x) {
  
  if (length(x) > 1)
    return(unname(sapply(x, encode)))
  
  # Get the string
  y <- strsplit(x, NULL)[[1]]
  y <- tolower(y)
  y <- match(y, letters2)
  
  paste(dict[y], collapse="")
  
  
}

decode <- function(x) {
  
  if (length(x) > 1)
    return(unname(sapply(x, decode)))
  
  # Get the string
  y <- strsplit(x, NULL)[[1]]
  y <- tolower(y)
  y <- match(y, dict)
  
  paste(letters2[y], collapse="")
  
}

# Encoded message, and dictionary
cat(encode(dat), sep="\n")
dump("dict", file="")

# Recoded message
cat(decode(encode(dat)), sep="\n")
