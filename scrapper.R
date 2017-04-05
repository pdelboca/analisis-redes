library(twitteR)
library(graphTweets)

#consumer_key <- "keys.R"
#consumer_secret <- "keys.R"
#access_token <- "keys.R"
#access_secret <- "keys.R"
source("keys.R")

searchTerm <- "#YoNoParo"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tweets <- searchTwitter(searchTerm, n=20)
tweets <- twListToDF(tweets)
edges <- getEdges(data = tweets, tweets = "text", source = "screenName")

# Names required for Gephi
colnames(edges) <- c("Source", "Target")
edges <- edges[!(edges$Target == ""), ]

# Write to a folder
dir.create(searchTerm)
readr::write_csv(tweets, path = paste0("./", searchTerm, "/tweets.csv"))
readr::write_csv(edges,path = paste0("./", searchTerm, "/edges.csv"))
