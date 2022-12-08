library(shiny)

source("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/source/Kasper%20visualization/p3-ui.R")
source("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/source/Yenmy%20files%20for%20Bar%20graph/p3_ui.R")
source("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/source/Natalie%20Boxplot%20data%20maker/app_ui2.R")
source("~/Documents/info201/projects/project-itsyenmyvo22/source/intro.R")
source("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/docs/report.md")
source("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/source/report.R")

ui <- navbarPage(
  title = "Gun Violence in the US",
  position = "fixed-top",
  
  # A simple header
  header = list(
    tags$style(type = "text/css", "body {padding-top: 70px;}"),
    hr(),
    HTML("INFO Final Project: Katherine Zhang, Yenmy Vo, Natalie Hinds, Kasper Li"),
    hr()
  ),
  
  # A simple footer
  footer = list(
    tags$style(type = "text/css", "body {padding-top: 70px;}"),
    hr(),
    HTML("INFO 201B Au 22: Final Project: Gun Violence in the US"),
    hr()
  ),
  
  # The project introduction
  intro,
  
  # The three charts
  plot_panel,
  scatter_panel,
  #plot,
  
  # The project summary
  #tab_panel_summary,
  
  # The project report
  report
)
