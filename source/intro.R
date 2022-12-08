library(shiny)

intro <- tabPanel(
  "Introduction Page",
                            
    mianPanel(
      h3("Introduction", style = "color: #1a4061"),
      p("Since there have been a number of recent shootings near the UW campus,
      some of which even have threatened the lives of UW students, this has drawn 
      our attention and concern. We were reminded of the gun violence cases that 
      have occurred throughout the United States. Our project collects statistical 
      data sets on gun violence and analyzes them. We also analyze datasets on 
      gun regulation and related laws. Through these aspects, we want to show the 
      problem that the frequency of gun violence in the United States is related 
      to the lack of relevant binding laws. Not only do we find that gun violence 
      also highlights social and economic problems in the U.S., but the frequency 
      of gun violence is also strongly correlated with poverty. We hope that through 
      our project, we can first draw attention among UW students on a small scale, 
      and later perhaps on a societal level."),
      br(),
      
      h3("Problem Domain", style = "color: #1a4061"),
      p(""),
      br(),
      
      h3("Research Questions", style = "color: #1a4061"),
      p("1. Has gun violence gotten worse over the years?"),
      br(),
      p("2. In states with greater gun control are there lower rates of gun violence?"),
      br(),
      p("3. Which groups of people get affected by gun violence the most?"),
      br(),
      
    )
                              
)