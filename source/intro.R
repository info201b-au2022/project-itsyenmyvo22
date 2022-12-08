library(shiny)

intro <- tabPanel(
  "Introduction Page",
                            
    mainPanel(
      h3("Introduction", style = "color: #1a4061"),
      p("Since there have been a number of recent shootings near the UW campus, some of which even have threatened the lives of UW students, this has drawn our attention and concern. We were reminded of the gun violence cases that have occurred throughout the United States. Our project collects statistical data sets on gun violence and analyzes them. We also analyze datasets on gun regulation and related laws. Through these aspects, we want to show the problem that the frequency of gun violence in the United States is related to the lack of relevant binding laws. Not only do we find that gun violence also highlights social and economic problems in the U.S., but the frequency of gun violence is also strongly correlated with poverty. We hope that through our project, we can first draw attention among UW students on a small scale, and later perhaps on a societal level."),
      br(),
      
      h3("Problem Domain", style = "color: #1a4061"),
      p("Gun violence addresses governmental issues. For instance, the national government has limited control over how guns can be regulated, therefore gun control laws are up to state leaders. Another social issue the problem domain brings up is the fact that a lot of gun violence stems from poverty. Another governmental issue is the fact that many politicians are funded by the National Rifle Association."),
      br(),
      
      h3("Research Questions", style = "color: #1a4061"),
      p("1. Has gun violence gotten worse over the years?"),
      br(),
      p("2. In states with greater gun control are there lower rates of gun violence?"),
      br(),
      p("3. Which groups of people get affected by gun violence the most?"),
      br(),
      
      h3("Key Findings", style = "color: #1a4061"),
      p("Using the graphs from Universal Background Checks and Gun Deaths and the boxplot analysis from Number of Gun Deaths and Gun Control Laws in Effect, we find that states that lack gun control do have different rates of gun violence than states that have gun control. Most states with gun control have lower rates of gun violence deaths. We also find a relationship between gun violence and poverty levels. Through data visualization and interactive graphs, we find that states with higher poverty levels tend to have more gun deaths. As seen in the third visualization, the number of deaths and injuries from shootings across the U.S. has been trending upward every month since 2014, and these data suggest that gun violence is a problem that cannot be taken lightly."),
      br(),
      
    ),
                              
)