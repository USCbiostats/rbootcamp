require(data.table)


#Phenotype data
phenotype<-fread('phenodata.txt')
head(pheno)

#Loop to read the genotype data from each chromossome and run the regression analysis
regression.results<-c()

for(chr in 1:22){
  #Loading the genotype data
  genotype<-fread(paste('chr',chr,'.txt',sep=''))

  #Regression SNP-by-SNP (uses the apply function to be faster but can be done with a loop)
  regression<-t(apply(genotype,2,FUN=function(a){summary(lm(phenotype$fvcmax~a+phenotype$age+phenotype$sex+phenotype$PC1+phenotype$PC2+phenotype$PC3+phenotype$PC4))}$coef[2,]))
  
  #Final results with all the SNPs (n=500)
  regression.results<-rbind(regression.results,regression)
 
}

#Significantly associated SNPs (for alpha=0.05)
#Using Bonferroni correction
bonferroni<-0.05/500

row.names(regression.results)[which(regression.results[,4]<0.05/500)]
#4 SNPs


#Using false discovery rate (Benjamini-Hochberg)
fdr.p.val<-p.adjust(regression.results[,4],method='BH')

row.names(regression.results)[which(fdr.p.val<0.05)]
#4 SNPs



