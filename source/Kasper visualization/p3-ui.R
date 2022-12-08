library(shiny)
library(plotly)
## Define UI for application
line_panel<-tabPanel(
  "line plot",
  
  # Application title
  titlePanel("The number of gun violence killed and injured"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "type", "Types to display:",
        choices = c("Injured" = 'sum_n_injured', "Killed" = "sum_n_killed"), selected = 'sum_n_injured'
      )
    ),
    
    mainPanel(
      #plotOutput("line"),
      plotOutput("checkbox_line"),
      p("This line graph shows the number of deaths and injuries caused by gun violence in the United States from January 2013 to March 2018.")
    )
  )
)
ui <- navbarPage(
  "line plot ",
  
  line_panel
)

