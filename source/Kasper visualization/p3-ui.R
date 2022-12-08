library(shiny)
library(plotly)
## Define UI for application
line_panel<-tabPanel(
  "line plot",
  
  # Application title
  titlePanel("The number of gun violence killed and injured"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider",
                  "Choose what to show",
                  min = 1,
                  max = 2,
                  value = c(1,2))
    ),
    mainPanel(
      plotOutput("line"),
      p(textOutput("summary"))
    )
  )
)
ui <- navbarPage(
  "line plot ",
  
  line_panel
)

