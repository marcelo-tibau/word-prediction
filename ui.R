# Libraries used

library('shiny')
library('shinythemes')

# App definitions such as theme and layouts

shinyUI(fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Word Predictor App"),
  sidebarLayout(
    sidebarPanel(
      textInput("text", label = ("Enter your text here"), value = ''),
      sliderInput("slider", "Maximum number of words", min = 0, max = 1000, value = 10),
      dataTableOutput('table')
    ),
    mainPanel(
      wellPanel(
        helpText(a('More information', href='https://rpubs.com/marcelo_tibau/252490', target='_blank')),
        
        helpText(a('Code repository', href='https://github.com/marcelo-tibau/word-prediction', target='_blank')),
        plotOutput('wordcloud')
      )
    )
    
  )
))
