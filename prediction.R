# Scritp to predict a NextWord using stupid backoff algorithm
# Libraries used

library('dplyr')
library('quanteda')
library('wordcloud')
library('RColorBrewer')

# Code to transfer to quanteda package corpus format and segment it into senteces 
fun.corpus = function(x) {
  corpus(unlist(segment(x, 'sentences')))
}

# Code to tokenize the ngram

fun.tokenize = function(x, ngramSize = 1, simplify = T) {
  toLower(
    quanteda::tokenize(x,
                       removeNumbers = T,
                       removePunct = T,
                       removeSeparators = T,
                       removeTwitter = T,
                       ngrams = ngramSize,
                       concatenator = " ",
                       simplify = simplify
    )
  )
}

# Codes to parse tokens from input text
fun.input = function(x) {
  if(x=="") {
    input1 = data_frame(word == "")
    input2 = data_frame(word == "")
  }
  if(length(x)==1) {
    y = data_frame(word = fun.tokenize(corpus(x)))
  }
  if(nrow(y)==1) {
    input1 = data_frame(word = "")
    input2 = y
  }
  else if(nrow(y)>=1) {
    input1 = tail(y, 2)[1, ]
    input2 = tail(y, 1)
  }
  inputs = data_frame(words = unlist(rbind(input1, input2)))
  return(inputs)
}

# Codes to predict using Google's stupid backoff algorithm

fun.predict = function(x, y, n=100) {
  if(x == "" & y == "") {
    prediction = dfTrain1 %>%
      select(NextWord, freq)
  }
  else if(x %in% dfTrain3$word1 & y %in% dfTrain3$word2) {
    prediction = dfTrain3 %>%
      filter(word1 %in% x & word2 %in% y) %>%
      select(NextWord, freq)
  }
  else if(y %in% dfTrain2$word1) {
    prediction = dfTrain2 %>%
      filter(word1 %in% y) %>%
      select(NextWord, freq)
  }
  else{
    prediction = dfTrain1 %>%
      select(NextWord, freq)
  }
  return(prediction[1:n, ])
}
