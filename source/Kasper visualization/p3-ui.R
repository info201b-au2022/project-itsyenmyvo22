library(shiny)
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
      plotOutput("plot"),
      p("This line graph shows the number of deaths and injuries caused by gun violence in the United States from January 2013 to March 2018.")
    )
  )
)

ui <- navbarPage(
  "line plot ",
  
  line_panel
)