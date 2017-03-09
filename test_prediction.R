# Script to test the prediction model using stupid backoff algorithm
## Libraries and sources
source('prediction.R')
source('prepare_data.R')

# Code to input text sample
inputText = 'according to'

# Codes to get inputs as separate strings
input1 <- fun.input(inputText)[1, ]
input2 <- fun.input(inputText)[2, ]
input1
input2

# Codes to predict using the prediction function created
nSuggestions = 5
fun.predict(input1, input2)

# To predict without dplyr package, a second function was created
fun.predict2 <- function(x, y, z = nSuggestions) {
  if(x == "" & y == "") {
    prediction = dfTrain1$NextWord
  }
  else if(x %in% dfTrain3word1 & y %in% dfTrain3$word2) {
    prediction = subset(dfTrain3, dfTrain3$word1 %in% x & dfTrain3$word2 %in% y, NextWord)
  }
  else if(y %in% dfTrain2$word1) {
    prediction = subset(dfTrain2, dfTrain2$word1 %in% y, NextWord)
  }
  else{
    prediction <- dfTrain1$NextWord
  }
  return(prediction[1:z])
}
