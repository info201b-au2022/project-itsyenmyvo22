library(ggplot2)
library(dplyr)
library(tidyverse)
library(lubridate)
all_sum_df<-read.csv(url("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/all_sum_df.csv"))

#Since data has so many variables, I simplified it to data on a monthly basis.
data_killed_injured<-all_sum_df %>%
  select(date, n_killed, n_injured)%>%
  mutate(year = year(date), month = month(date))%>%
  group_by(year, month) %>%
  summarise(sum_n_injured = sum(n_injured),sum_n_killed = sum(n_killed))
data_killed_injured<-unite(data_killed_injured, col=date, c("year","month"), sep="/",remove=TRUE)



colors <- c("n_killed" = "blue", "n_injured" = "red")

Killed_injured<- ggplot(data_killed_injured, aes(x = date)) +
  geom_line(aes(y = sum_n_killed, color = "n_killed", group=1)) +
  geom_line(aes(y = sum_n_injured, color = "n_injured",group=1)) +
  labs(x = "date",
       y = "ppl",
       color = "type") +
  scale_color_manual(values = colors)+
  scale_x_discrete(breaks = c("2013/1","2014/1","2015/1","2016/1","2017/1","2018/1"))+
  labs(title="The number of gun violence killed and injured")

library(shiny)
## Define UI for application
ui <- fluidPage(
  
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

## Define server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    p <- ggplot(data_killed_injured, aes(x = date)) +
      theme_bw()+
      scale_x_discrete(breaks = c("2013/1","2014/1","2015/1","2016/1","2017/1","2018/1"))
    if (input$slider[1] == 1) {
      p <- p + geom_line(aes(y = sum_n_killed, color = "n_killed", group=1)) 
    }
    if (input$slider[2] == 2) {
      p <- p + geom_line(aes(y = sum_n_injured, color = "n_injured", group=1))
    }
    p <- p + labs(x = "date",
                  y = "ppl",
                  color = "type") +
      scale_color_manual(values = colors)
    print(p)
  })
}

## Run the application 
shinyApp(ui = ui, server = server)