# Prepare the data for analysis and modeling
# Libraries and sources
source('prediction.R')

library('tidyr')
library('readr')
library('caTools')

# Codes to read the data
blogsRaw <- read_lines('./data/en_US.blogs.txt')
newsRaw <- read_lines('./data/en_US.news.txt')
twitterRaw <- read_lines('./data/en_US.twitter.txt')
combinedRaw <- c(blogsRaw, newsRaw, twitterRaw)

# Codes to sample the combined data
set.seed(1220)
n = 1/1000
combined <- sample(combinedRaw, length(combinedRaw)*n) 

# Codes to split into train and validation sets
split <- sample.split(combined, 0.8)
train <- subset(combined, split==T)
valid <- subset(combined, split==F)

# Tokenization process

# Codes to quanteda corpus format and segment into sentences to use on prediction.R
train <- fun.corpus(train)

# Code to tokenize
train1 <- fun.tokenize(train)
train2 <- fun.tokenize(train, 2)
train3 <- fun.tokenize(train, 3)

# Frequency tables process

# Codes to create a function to generate frequency tables
fun.frequency = function(x, minCount = 1) {
  x = x %>%
    group_by(NextWord) %>%
    summarize(count = n()) %>%
    filter(count >= minCount)
  x = x %>%
    mutate(freq = count / sum(x$count)) %>%
    select(-count) %>%
    arrange(desc(freq))
}

dfTrain1 <- data_frame(NextWord = train1)
dfTrain1 <- fun.frequency(dfTrain1)

dfTrain2 <- data_frame(NextWord = train2)
dfTrain2 <- fun.frequency(dfTrain2) %>%
  separate(NextWord, c('word1', 'NextWord'), " ")

dfTrain3 <- data_frame(NextWord = train3)
dfTrain3 <- fun.frequency(dfTrain3) %>%
  separate(NextWord, c('word1', 'word2', 'NextWord'), " ")

# Codes to filter profanity. I decided to use less words, so I stuck to the George Carlin's seven dirty words.
# These are seven English-language words that American comedian George Carlin first listed in 1972 in his monologue "Seven Words You Can Never Say on Television".
dirtySeven <- c('shit', 'piss', 'fuck', 'cunt', 'cocksucker', 'motherfucker', 'tits')
dfTrain1 <- filter(dfTrain1, !NextWord %in% dirtySeven)
dfTrain2 <- filter(dfTrain2, !word1 %in% dirtySeven & !NextWord %in% dirtySeven)
dfTrain3 <- filter(dfTrain3, !word1 %in% dirtySeven & !word2 %in% dirtySeven & !NextWord %in% dirtySeven)

# Codes to save the data
saveRDS(dfTrain1, file = 'dfTrain1.rds')
saveRDS(dfTrain2, file = 'dfTrain2.rds')
saveRDS(dfTrain3, file = 'dfTrain3.rds')

