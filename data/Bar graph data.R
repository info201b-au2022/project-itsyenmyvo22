
library(dplyr)
library(tidyverse)
library(ggplot2)

data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/firearms_provisions.csv")
nat_data <- data%>%
  filter(year == 2017) %>%
  select(state, year, universal, nosyg, assault)
View(nat_data)
write.csv(nat_data)
