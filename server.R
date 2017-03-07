# Shiny server script
# Libraries and sources

source('prediction.R')

library('shiny')
library('wordcloud')

# Definitions to prediction statements when user input changes, to get input, predict and outputs

shinyServer(function(input, output) {
  prediction = reactive({
    inputText = input$text
    input1 = fun.input(inputText)[1, ]
    input2 = fun.input(inputText)[2, ]
    nSuggestion = input$slider
    
    prediction = fun.predict(input1, input2, n = nSuggestion)
  })
  
  output$table = renderDataTable(prediction(),
                                 options = list(pageLength = 5,
                                                lengthMenu = list(c(5, 10, 100), c('5', '10', '100')),
                                                columnDefs = list(list(visible = F, targets = 1))))
  
 wordcloud_rep = repeatable(wordcloud)
 output$wordcloud = renderPlot(
   wordcloud_rep(
     prediction()$NextWord,
     prediction()$freq,
     colors = brewer.pal(8, 'Dark2'),
     scale = c(4, 0.5),
     max.words = 300
   )
 )
})
