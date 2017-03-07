# Script to validate and fine tuning the word prediction model
# Libraries and sources

source('prepare_data.R')
source('shiny_app/prediction.R')

# Codes to prepare the validation sets.
# To transform the validation set to quanteda format
valid <- fun.corpus(valid)

# To get 2-gram tokens
valid2 <- fun.tokenize(valid, 2, T)
valid2 <- data_frame(NextWord = valid2) %>%
  separate(NextWord, c('word2', 'NextWord'), " ")

# To put empty string as word1
valid2 <- mutate(valid2, word1 = rep("", nrow(valid2))) %>%
  select(word1, word2, NextWord)

# To get 3-gram tokens
valid3 <- fun.tokenize(valid, 3, T)
valid3 <- data_frame(NextWord = valid3) %>%
  separate(NextWord, c('word1', 'word2', 'NextWord'), " ")

# Codes to create a function to get the accuracy (percentage of cases where the correct word is predicted within a defined number of suggested words)
fun.accu = function(x) {
  y = mapply(fun.predict, x$word1, x$word2)
  accuracy = sum(ifelse(x$NextWord %in% unlist(y), 1, 0) / length(y))
  return(accuracy)
}

# Check the results
# To round precision
accuRound = 2

# Accuracy: 1 previous word and 5 suggestions
nSuggestions = 5
accuOneFive <- round(fun.accu(valid2), accuRound)

# Accuracy: 1 previous word and 3 suggestions
nSuggestions = 3
accuOneThree <- round(fun.accu(valid2), accuRound)

# Accuracy: 1 previous word and 1 suggestion
nSuggestions = 1
accuOneOne <- round(fun.accu(valid2), accuRound)

# Accuracy: 2 previous words and 5 suggestions
nSuggestions = 5
accuTwoFive <- round(fun.accu(valid3), accuRound)

# Accuracy: 2 previous words and 3 suggestions
nSuggestions = 3
accuTwoThree <- round(fun.accu(valid3), accuRound)

# Accuracy: 2 previous words and 3 suggestions
nSuggestions = 1
accuTwoOne <- round(fun.accu(valid3), accuRound)

# Code to print the Summary Table
accuSummary <- data.frame(Suggest5 = c(accuTwoFive, accuOneFive),
                          Suggest3 = c(accuTwoThree, accuOneThree),
                          Suggest1 = c(accuTwoOne, accuOneOne),
                          row.names = c('Previous2', 'Previous1'))

print(accuSummary)

