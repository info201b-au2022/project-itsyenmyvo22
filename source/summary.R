# summary

library(shiny)

summary <-tabPanel(
  "Summary Page",
  
  mainPanel(
    h4("In summary, our project contains three visual interactive graphs with data sets obtained from computational analysis.", style = "color: #1a4061"),
    br(),
    
    h4("1. Bar graph: Comparison between the number of gun deaths and injuries and poverty rates by state (2013-2018)."),
    h5("Users can choose to see the number of gun deaths and the number of gun injuries. Our finding is that states with higher poverty rates have a relatively higher number of gun casualties, which supports our proposed research question."),
    br(),
    
    h4("2. Boxplot: Amounts of Gun Deaths vs. Gun Control Law in effect."),
    h5("Users have the option to view the relationship between the number of gun deaths and the presence or absence of gun control laws.
This graph shows how the median number of deaths varies depending on the different gun laws and helps users understand the effectiveness of gun control laws. For example, 'keep your dignity laws' legally allow a person to use a gun to shoot and kill another person anywhere, at any time. In states without this law, the median number of deaths is lower. This illustrates the effectiveness of gun control laws."),
    br(),
    
    h4("3. Line Plot: The number of gun violence killed and injured (2013-2018)."),
    h5("Users have the option to view the trend of the number of gun deaths and the number of gun injuries from 2013 to 2018. We find an overall upward trend, which indicates that the death and injury of gun violence has become more and more serious since 2013. This chart shows the severity of gun violence and can give users a clearer understanding."),
    br(),
    
  ),
  
)

