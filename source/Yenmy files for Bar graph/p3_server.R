#p3 server 

library(shiny)
library(plotly)
library(dplyr)

all_sum_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/all_sum_df.csv", stringsAsFactors = FALSE)

p3_df <- all_sum_df %>% 
  group_by(state) %>%
  summarise(total_killed = sum(n_killed))

poverty_rate_each_state <- all_sum_df %>% 
  group_by(state) %>% 
  summarise(percent_above_poverty = max(Percent.Above.Poverty.Rate))

p3_df <- left_join(p3_df, poverty_rate_each_state, by = "state") 
p3_df <- p3_df %>% 
  select(state, total_killed, percent_above_poverty)

tn_injured <- all_sum_df %>% 
  group_by(state) %>% 
  summarise(total_injured = sum(n_injured))

p3_df <- left_join(p3_df, tn_injured, by = "state")
p3_df <- p3_df[-9, ]

p3_server <- function(input, output) {
  output$p3 <- renderPlotly({
    p3plot <- ggplot(data = p3_df)+
      geom_col(mapping = aes(x= percent_above_poverty, y= .data[[input$d_or_i_choice]], fill = state)) +
      xlab("Percent Above Poverty") +
      labs(title = "Comparison of Gun Casualties and Poverty")
    return(p3plot)
  })
}


#p3_df1 <- p3_df %>%
#filter(state == input$state_choice)


