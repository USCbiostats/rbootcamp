library(rtweet)
library(stringr)
library(magrittr)
library(igraph)
library(dplyr)
  
# create_token(
#   app = "my_twitter_research_app",
#   consumer_key = "XYznzPFOFZR2a39FwWKN1Jp41",
#   consumer_secret = "CtkGEWmSevZqJuKl6HHrBxbCybxI1xGLqrD5ynPd9jG0SoHZbD")
#
# source("projects/twitter/key.r")

# dat <- search_tweets(
#   "#hookah OR #vape OR #vapelife OR #vapenation OR #vapers",
#   n = 1000,
#   lang = "en"
#   )

# saveRDS(dat, "projects/twitter/vape.rds")
# dat <- readRDS("projects/twitter/vape.rds")

# Extracting hashtags
hashtags <- dat$text %>%
  stringr::str_to_lower() %>%
  stringr::str_extract_all("#[a-zA-Z0-9]+")

# Tokenizing
tokens <- unlist(hashtags) %>%
  unique %>%
  sort

n <- length(hashtags)

hashtags %<>%
  unlist %>%
  cbind(rep.int(1:n, sapply(hashtags, length))) %>%
  as_tibble %>%
  set_names(c("hashtag", "pos")) %>%
  mutate(
    hashtag = match(hashtag, tokens)
  )

edgelist <- hashtags %>%
  left_join(hashtags, by = "pos") %>%
  select(starts_with("hashtag")) %>%
  set_names(c("ego", "alter")) %>%
  group_by(ego, alter) %>%
  filter(ego != alter) %>%
  summarize(n = n()) %>%
  ungroup %>%
  group_by(ego) %>% mutate(n_ego = n()) %>% ungroup %>%
  group_by(alter) %>% mutate(n_alter = n()) %>% ungroup %>%
  filter(
    n/n_ego >= .5 | n/n_alter >= .5
  ) %>%
  select(ego, alter, n)
  
net <- graph_from_data_frame(
  edgelist, 
  directed = FALSE,
  vertices = data.frame(1:length(tokens), name = tokens)
)  

E(net)$weight <- E(net)$n


labsize <- function(x) {
  label_cex <- sqrt(degree(x))
  label_cex <- (label_cex - min(label_cex))/
    diff(range(label_cex))*2
  
  label_cex[rank(-label_cex, ties.method = "random") > 10] <- 0
  label_cex
}

induced_subgraph(net, which(rank(-degree(net)) <= 100)) %T>%
  {lab <<- labsize(.)} %T>%
  {nam <<- V(.)$name} %>%
  plot(
    layout = layout_nicely,
    vertex.size = sqrt(degree(.)),
    vertex.label = case_when(lab > .01 ~ nam, lab <= .1 ~ ""),
    vertex.label.cex = lab,
    edge.arrow.size=.25
    )
  


