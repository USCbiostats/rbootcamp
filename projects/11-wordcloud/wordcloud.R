ans <- drive_download(
  as_id("https://docs.google.com/spreadsheets/d/1fkLOUK6nCQ4ysGYkOi44RRufJWntnHtjxlMFPckPOC8/edit#gid=1844273505"),
  path = tempfile(),
  type = "csv"
  )

dat <- readr::read_csv(ans$local_path)

library(magrittr)

# Processing words
wrds <- dat$`Tell us about your work with R` %>%
  stringr::str_to_lower() %>%
  stringr::str_replace_all("[:punct:]", " ") %>%
  stringr::str_split("\\s") %>%
  unlist

# Removing stopwords
wrds <- wrds[!(wrds %in% tm::stopwords())]

# Creating a word cloud
wordcloud2::wordcloud2(table(wrds))
