Slides available [here](https://xukeren.rbind.io/slides/20200813/slides#1)

Install from CRAN
```r
install.packages('rmarkdown')
```

Or if you want to test the development version,
install from GitHub
```r
if (!requireNamespace("devtools"))
  install.packages('devtools')
devtools::install_github('rstudio/rmarkdown')
```

If you want to generate PDF output, you will need to install LaTeX  
```{r}
install.packages('tinytex')
tinytex::install_tinytex()  # install TinyTeX
```

LaTeX formats and templates [link](https://github.com/rstudio/rticles)  
```{r}
install.packages("rticles")
```
If you wish to install the development version from GitHub (which often contains new article formats), you can do this:  
```{r}
remotes::install_github("rstudio/rticles")
```

Tufte handout [link](http://rstudio.github.io/tufte/?_ga=2.140306931.1982063938.1597208258-1758657860.1582655687)  
```{r}
install.packages("tufte")
```
