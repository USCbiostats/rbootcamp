### Read GWAS file and filter genetic variants by p value threshold
library(tidyverse)
library(data.table)

args <- commandArgs(trailingOnly=TRUE)
filename <- args[1]         # file name
pval <- as.numeric(args[2]) # p value threshold (not log scale)
outpath <- args[3]          # path to output data

indir <- "/project/ekawaguc_906/RBootcamp2022/data/"

## Read in data
## if not bgz file, you can try fread() to read in large files
## set more threads if you need by setDTthreads()
dat <- read_delim(gzfile(paste0(indir, filename)), delim='\t')
print(paste0("Finish read in", filename))

## filter on selected p value and remove low confidence
dat %>% 
  filter((!is.na(beta_EUR) & !is.na(se_EUR) & low_confidence_EUR == FALSE)) %>% 
  filter(pval_EUR < log(pval)) %>% 
  select(chr, pos, ref, alt, pval_EUR) %>% 
  fwrite(paste0(outpath, "/", filename), sep='\t')
