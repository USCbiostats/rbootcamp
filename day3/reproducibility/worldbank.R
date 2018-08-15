library(wbstats)
library(dplyr)
library(countrycode)

"SH.HIV.1524.FE.ZS" # https://data.worldbank.org/indicator/SH.HIV.1524.FE.ZS?view=chart
"SI.POV.GINI" # https://data.worldbank.org/indicator/SI.POV.GINI?view=chart
"IT.CEL.SETS.P2" # https://data.worldbank.org/indicator/IT.CEL.SETS.P2?view=chart

hiv  <- wb(indicator = "SH.HIV.1524.FE.ZS") %>% as_tibble
gini <- wb(indicator = "SI.POV.GINI") %>% as_tibble
cell <- wb(indicator = "IT.CEL.SETS.P2") %>% as_tibble
gdp_ppp <- wb(indicator = "NY.GDP.PCAP.PP.KD") %>% as_tibble

# Filtering datasets
hiv <- hiv %>%
  transmute(
    iso  = iso3c,
    year = date,
    hiv  = value
  )

gini <- gini %>%
  transmute(
    iso  = iso3c,
    year = date,
    gini = value
  )

cell <- cell %>%
  transmute(
    iso  = iso3c,
    year = date,
    cell = value
  )

gdp_ppp <- gdp_ppp %>%
  transmute(
    iso = iso3c,
    year = date,
    gdp_ppp = value
  )

# Merging the data
dat <- hiv %>% 
  full_join(gini) %>%
  full_join(cell) %>%
  full_join(gdp_ppp)

# Pasting country codes
dat <- codelist %>%
  select(iso3c, region) %>%
  rename(iso = iso3c) %>%
  right_join(dat) %>%
  filter(!is.na(region)) # Only including those that have a region

  

readr::write_csv(dat, "day3/reproducibility/worldbank.csv")
