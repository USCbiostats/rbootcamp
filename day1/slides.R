## ----set-up------------------------------------------------------------------------------------------
library(ggplot2)
data("diamonds")


## ----head-of-diamonds-tibble, echo=FALSE-------------------------------------------------------------
head(diamonds)


## ----head-of-diamonds-dataframe, echo=FALSE----------------------------------------------------------
head(as.data.frame(diamonds))


## ----quick-data-look, results='hold'-----------------------------------------------------------------
# How many rows and columns?
nrow(diamonds)
ncol(diamonds)


## ----viz-0a, echo=FALSE, cache=TRUE------------------------------------------------------------------
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price, color = clarity)) +
  facet_wrap(~color) + 
  labs(
    title    = "Price of Diamonds (by color)",
    subtitle = "data from the ggplot2 R package",
    x        = "Weight of the diamond (carat)",
    y        = "Price in US dollars",
    color    = "Clarity from \n I1 (worst) to IF (best)"
    )


## ----viz-0b------------------------------------------------------------------------------------------
ggplot(data = diamonds)


## ----viz-0c, eval = FALSE----------------------------------------------------------------------------
## ggplot(data = diamonds) +
##   geom_point()


## ----viz-1, cache=TRUE-------------------------------------------------------------------------------
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))


## ----viz-2, cache=TRUE-------------------------------------------------------------------------------
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price, color = clarity))


## ----viz-3, cache=TRUE-------------------------------------------------------------------------------
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price, color = clarity)) +
  facet_wrap(~color)


## ----viz-4, cache=TRUE-------------------------------------------------------------------------------
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price, color = clarity)) +
  facet_wrap(~color) + 
  labs(
    title    = "Price of Diamonds (by color)",
    subtitle = "data from the ggplot2 R package",
    x        = "Weight of the diamond (carat)",
    y        = "Price in US dollars",
    color    = "Clarity from \n I1 (worst) to IF (best)"
    )


## ----mpg-sol, eval=FALSE, echo=FALSE-----------------------------------------------------------------
## data(mpg)
## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
##   labs(
##     title    = "Fuel economy data",
##     subtitle = "(1999 - 2008)",
##     x        = "Engine displacement (liters)",
##     y        = "Highway MPG",
##     color    = "Drive train"
##   )

