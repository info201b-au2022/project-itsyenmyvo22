#p3 ui

library(shiny)
library(plotly)

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


p3_sidebar_content <- sidebarPanel(
  selectInput(inputId = "d_or_i_choice",
              label = "Select Deaths or Injured",
              choices = list("Number of Deaths" = "total_killed", "Number of Injuries" = "total_injured"),
              selected = "total_killed")
)

p3_main_content <- mainPanel(
  plotlyOutput("p3"),
  p("This chart shows the comparison of states highest percent above poverty (as of 2018) and the combined gun cautalties of states from 2013 to 2018")
)

plot_panel <- tabPanel(title = "Bar",
                       sidebarLayout(
                         p3_sidebar_content,
                         p3_main_content
                       ))

p3_ui <- navbarPage(title = "Gun Violence",
                    plot_panel)




# selectInput(inputId = "state_choice",
#             label = "Select State",
#             choices = p3_df$state,
#             selected = "Alabama")


