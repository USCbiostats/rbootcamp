---
title: miniGWAS
keywords: [genetic association, GWAS]
difficulty: medium
author: Miguel Pereira
---

# Description

You have [a dataset](https://raw.githubusercontent.com/USCbiostats/rbootcamp/master/projects/17-gwas1/mini-gwas-data.zip) with phenotype and genotype data and the goal is to discover newe genetic variants associated with the outcome 'fvcmax', a measure of lung function.

# Objectives

1.  Run a genetic association analysis to identify which SNPs are associated
    with FVC (variable 'fvcmax' in the dataset).

Things to consider:

1.  The phenotype and genotype data are in different files. There is one file
    with phenotype and outcome and 22 files with the genotype data, one file
    per chromossome.
    
2.  The goal is to open one file at a time, run a regression analysis adjusting
    for the phenotype variables and one SNP in each regression.

3.  After you obtain the regression results for each SNP, select the ones that
    are signigicantly related with fvcmax. All regression analyses should be
    adjusted for age, sex and the principal components (PCs), which are measure
    of population ancestry. Note: you need to consider a p-value correction method
    to obtain a significance thresold (e.g. Bonferroni correction, the most
    commonly used method in genetic association analysis).


