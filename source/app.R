library(shiny)
library("dplyr")
source("app_ui.R")
source("server_app.R")

# Run the application
shinyApp(ui = ui, server = server)