# report

library(shiny)
library("markdown")

report <-tabPanel(
  "Report",
  
  fluidPage(
      includeMarkdown("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/docs/report.md")
    )
  
  
)

