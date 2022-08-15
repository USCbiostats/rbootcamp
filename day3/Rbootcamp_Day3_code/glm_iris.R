##### Estimate standard error using bootstrap #####

# install tidyverse: install.packages("tidyverse")
library(tidyverse)
library(parallel)

args <- commandArgs(trailingOnly=TRUE)
var_name <- args[1]  # which variable you want to run Species ~ ?
seed_idx <- as.integer(args[2]) # seed index for reproducibility
outdir <- args[3] # output directory

# subset to versicolor and virginica (100 samples)
iris_subset <- iris[which(iris$Species %in% c("versicolor", "virginica")),]

trials <- seq(1, 1000)
boot_fx <- function(trial, dat, var_name) {
  ind <- sample(1:nrow(dat), nrow(dat), replace=TRUE)
  result1 <- glm(as.formula(paste0("Species ~ ", var_name)), 
                 family=binomial(logit), 
                 data=dat[ind,])
  beta1 <- coefficients(result1)[[2]]
  return(beta1)
}

# run bootstrap
# Note: you can also try sapply(), which is a wrapper of lapply but return a vector instead of list
set.seed(seed_idx)
boot_results <- lapply(trials, boot_fx, iris_subset, var_name)

# write out result
out_df <- tibble(var_name = var_name,
                 seed_idx = seed_idx,
                 boot_se = sd(unlist(boot_results)))

out_df %>% write_tsv(paste0(outdir, "/", var_name, ".tsv"))
