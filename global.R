# Script to load data into global environment for the shiny app.
# Libraries used

library('shiny')

# Codes to load data
dfTrain1 <- readRDS(file = './data/dfTrain1.rds')
dfTrain2 <- readRDS(file = './data/dfTrain2.rds')
dfTrain3 <- readRDS(file = './data/dfTrain3.rds')
