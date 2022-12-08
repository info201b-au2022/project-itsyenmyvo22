# report

library(shiny)
library("markdown")

report <-tabPanel(
  "Report",
  
  fluidRow(
    column(
      6,
      includeMarkdown("docs/report.md")
    ),
    column(
      3,
      p("This is a paragraph.")
    ),
    column(
      3,
      p("Rightmost column.")
    )
  )
  
  
)