library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
#install.packages("hrbrthemes")
library(hrbrthemes)
library(shiny)
#install.packages("viridis")
library(viridis)
library(plotly)

nat_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/nat_data.csv")%>%
  mutate(state = tolower(state))
#View(nat_data)

guns <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/all_sum_df.csv", stringsAsFactors = F)%>%
  filter(date > '01-01-2017')%>%
  select(state, n_killed)




people_killed_state <- guns %>%
  group_by(state)%>%
  summarize (deaths = sum(n_killed))%>%
  mutate(state= tolower(state))
people_killed_state <- people_killed_state[-c(9),]
#View(people_killed_state)

final_data <- left_join(nat_data, people_killed_state, by= "state")
#View(final_data)

final_data <- final_data %>% 
  rename("no_stand_ground" = "nosyg",
         "universal_check" = "universal",
         "assault_ban" = "assault"
         )
#view(final_data)

universal_df <- final_data%>%
  select(state, universal_check, no_stand_ground, assault_ban, deaths)%>%
  gather( key= gunlaws, value = exist, -deaths, -state)
#View(universal_df)

# syg <- final_data %>%
#   group_by(nosyg)%>%
#   summarise(mean_deaths = mean(deaths))
# #View(syg)
# 
# syg_1 <- final_data %>%
#   filter(nosyg == 1)
# #View(syg_1)
# 
# syg_0 <- final_data %>%
#   filter(nosyg == 0)
# 
# universal_df <- final_data%>%
#   select(state, universal, nosyg, assault, deaths)%>%
#   gather( key= gunlaws, value = exist, -deaths, -state)


#View(universal_df)
universal_df$exist<- as.logical(universal_df$exist)

#universal_df$exist <- as.integer(as.logical(universal_df$exist))




server <- function(input,output){
  
  # 
  # reactive(universal_df <- universal_df %>%
  #            filter(input$x_var %in%  gunlaws))
  # data_plot <- reactive({
  #   universal_df <- data_input()
  #   req(universal_df, input$x_var)
  #   df<- data_input()[as.numeric(data_input()[[input$x_var]]) %in% input$gunlaws, ]
  #   df
  # })
  
  
  output$scatter <-  renderPlotly ({
    
    plot_data <- universal_df %>%
      filter(gunlaws %in% input$x_var)%>%
      select(gunlaws, deaths, exist)
    
    p <- ggplot(plot_data, aes(x= gunlaws, y = deaths)) + 
      geom_boxplot(aes(fill = exist), position = position_dodge(1.0)) +
      scale_fill_manual(values = c("red", "blue"))+
      labs (title = "Gun laws vs. Deaths",
            x = input$x_var,
            y= "deaths",
            fill = "Does the Gun Control Law Exist?")+
      facet_grid(cols = vars(exist))
    
      
      # scale_fill_discrete(name = "Exist", labels = c("Does not exist", "exists"))
    # + facet_grid(cols = vars(exist))
    #   scale_x_discrete(limits=c("0", "1")) +
    # 
    # # Edit legend title and labels
    # scale_fill_discrete(name = "exist", labels = c("True", "False"))
    
    
    
    
    # p<- ggplot( new_data
    #             )+
    #   geom_col(mapping= aes(x= year, y= .data[[input$y_var]]), fill=input$color_select)
    #   
    
    # p <- plot_ly(
    #   data = new_data,
    #   x = ~get(input$x_var),
    #   y = ~get(input$y_var),
    #   type = "scatter",
    #   mode = "markers", 
    #   hovertext = ~country)%>%
    #   layout(
    #     title = paste0(input$x_var,  "v.s." , input$y_var),
    #     xaxis = list(title = input$x_var),
    #     yaxis = list(title =  input$y_var)
    #   )
    
    p  
    
  })
  
  
  output$caption <- renderText ({
    "The purpose of this chart is to show how different gun control laws affect the number of gun deaths differently. This has large impacts
    for the question of if gun control laws actually work, because it shows how the median amount of deaths changes based on the different gun laws. 
    This chart is important in seeing how effective gun control laws are. For instance, the Stand Your Groud laws legally allow a person to use a firearm to shoot and kill another person anywhere, at any time. In the states without this law, there is lower median amount of deaths. \
    Due to this, it shows how effective some gun control is. "
  })
  
}

# Box plot
# p <- ggplot(universal_df, aes(x = gunlaws, y = deaths)) + 
#   geom_boxplot(aes(fill = exist), position = position_dodge(0.9)) +
#   scale_fill_manual(values = c("#00AFBB", "#E7B800"))
# p  