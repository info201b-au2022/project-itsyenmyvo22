# report

library(shiny)
library("markdown")

report <-tabPanel(
  "Report",
  
  fluidPage(
      includeMarkdown("docs/report.md")
    )
  
  
)

