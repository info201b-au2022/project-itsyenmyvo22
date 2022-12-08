library(shiny)
library(hrbrthemes)
library(viridisLite)
#install.packages("hrbrthemes")
library("dplyr")
library(lubridate)
library(reshape2)
#install.packages("reshape2")
source("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/source/Natalie%20Boxplot%20data%20maker/app_server3.R")

all_sum_df<-read.csv(url("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/all_sum_df.csv"))
nat_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/nat_data.csv")%>%
  mutate(state = tolower(state))
#View(nat_data)

guns <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/all_sum_df.csv", stringsAsFactors = F)%>%
  filter(date > '01-01-2017')%>%
  select(state, n_killed)

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


server <- function(input, output) {
  
  data_killed_injured<-all_sum_df %>%
    select(date, n_killed, n_injured)%>%
    mutate(year = year(date), month = month(date))%>%
    group_by(year, month) %>%
    summarise(sum_n_injured = sum(n_injured),sum_n_killed = sum(n_killed))
  data_killed_injured<-unite(data_killed_injured, col=date, c("year","month"), sep="/",remove=TRUE)
  long_df = melt(data_killed_injured, id.vars = ("date"))
  
  
  colors <- c("n_killed" = "blue", "n_injured" = "red")
  
  Check_box_plot = ggplot(long_df, aes(x = date, y = value, group = variable, color = variable)) + geom_line() +
    scale_x_discrete(breaks = c("2013/1","2014/1","2015/1","2016/1","2017/1","2018/1"))+ labs(x = "date",
                                                                                              y = "ppl",
                                                                                              color = "type")
  
  Killed_injured<- ggplot(data_killed_injured, aes(x = date)) +
    geom_line(aes(y = sum_n_killed, color = "n_killed", group=1)) +
    geom_line(aes(y = sum_n_injured, color = "n_injured",group=1)) +
    labs(x = "date",
         y = "ppl",
         color = "type") +
    scale_color_manual(values = colors)+
    scale_x_discrete(breaks = c("2013/1","2014/1","2015/1","2016/1","2017/1","2018/1"))
  
  df_filtered = reactive({long_df %>% filter(variable %in% input$type)})
  output$line <- renderPlot({
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
  
  output$checkbox_line <- renderPlot({
    #long_df %>% filter(variable %in% input$type)
    ggplot(df_filtered(), aes(x = date, y = value, group = variable, color = variable)) + geom_line(size = 1) +
      scale_x_discrete(breaks = c("2013/1","2014/1","2015/1","2016/1","2017/1","2018/1")) + labs(x = "date",
                                                                                                 y = "ppl",
                                                                                                 color = "type")
  })
  
  ## Define server logic
    output$line <- renderPlot({
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
    
    output$p3 <- renderPlotly({
      p3plot <- ggplot(data = p3_df)+
        geom_col(mapping = aes(x= percent_above_poverty, y= .data[[input$d_or_i_choice]], fill = state)) +
        xlab("Percent Above Poverty") +
        labs(title = "Comparison of Gun Casualties and Poverty")
      return(p3plot)
    })
    
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
      

      
      p  
      
    })
      
    
    output$caption <- renderText ({
      "The purpose of this chart is to show how different gun control laws affect the number of gun deaths differently. This has large impacts
    for the question of if gun control laws actually work, because it shows how the median amount of deaths changes based on the different gun laws. 
    This chart is important in seeing how effective gun control laws are. For instance, the Stand Your Groud laws legally allow a person to use a firearm to shoot and kill another person anywhere, at any time. In the states without this law, there is lower median amount of deaths. \
    Due to this, it shows how effective some gun control is. "
    })
    
}

