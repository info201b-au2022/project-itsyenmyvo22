library(shiny)
library(plotly)
library(dplyr)

source("p3_ui.R")
source("p3_server.R")

# Run the application 
shinyApp(ui = p3_ui, server = p3_server)
#test