library(plotly)



# Create a variable `scatter_panel` that stores a `tabPanel()` for your 2nd page
# It should include the following:
scatter_panel <- tabPanel(
  "Scatter",
  
  # Add a titlePanel to your tab
  titlePanel("Amount of Gun Deaths vs. Gun Control Law in effect"),
  
  # Create a sidebar layout for this tab (page)
  sidebarLayout(
    
    sidebarPanel(
      selectInput("x_var", label = h3("Select type of gun control law"), 
                  choices = list("No Stand Your Ground Law " = "no_stand_ground", 
                                 "Universal Background Check " = "universal_check" ,
                                 "Assualt Rifle Ban" = "assault_ban"),
                  selected = "no_stand_your_ground"),
    ),
    
    
    scatter_main_content <- mainPanel(
      plotlyOutput("scatter"), 
      p(textOutput("caption"))
    ),
    
  )
)

ui <- navbarPage(
  "Scatter plot ",
  
  scatter_panel
)