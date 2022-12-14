library("ggplot2")

poverty_rate_each_state <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/all_sum_df.csv", stringsAsFactors = FALSE) %>%
  group_by(state) %>%
  filter(date == max(date, na.rm = TRUE)) %>%
  mutate(state = tolower(state)) %>%
  select(state, Percent.Above.Poverty.Rate)

num_killed_each_state <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/all_sum_df.csv", stringsAsFactors = FALSE) %>%
  group_by(state) %>%
  summarise(tn_killed = sum(n_killed)) %>%
  mutate(state = tolower(state))

coordinates_50states <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-itsyenmyvo22/main/data/coordinates_50states2.csv", stringsAsFactors = FALSE) %>%
  select(location, lat, lon)

names(coordinates_50states)[names(coordinates_50states) == "location"] <- "state"
names(coordinates_50states)[names(coordinates_50states) == "lat"] <- "lat"
names(coordinates_50states)[names(coordinates_50states) == "lon"] <- "long"

coordinates_50states <- coordinates_50states %>%
  mutate(state = tolower(state)) 


coords_killed <- left_join(num_killed_each_state, coordinates_50states, by = "state") %>%
  add_row(state = "south dakota", tn_killed = 90, lat = 43.969515, long = -99.901813) %>%
  add_row(state = "west virginia", tn_killed = 335, lat = 38.597626, long = -80.454903)


coords_killed <- coords_killed[-c(42, 49), ]


killed_div <- coords_killed %>%
  summarise(killed_divided_by_350 = (tn_killed/350))


state_shape <- map_data("state")

ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group),
    color = "white",
    linewidth = .1
  ) +
  coord_map()

state_shape <- map_data("state") %>%
  rename(state = region) %>%
  left_join(poverty_rate_each_state, by = "state")

trial <- ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = Percent.Above.Poverty.Rate),
    color = "white",
    linewidth = .1
  ) +
  coord_map() +
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(fill = "% Above Poverty") +
  geom_point(
    data = coords_killed,
    mapping = aes(x = long, y = lat),
    color = "yellow",
    size = killed_div$killed_divided_by_350
  ) +
  labs(title = "Proportion of Gun Deaths in States")
  
  




#ggplot(state_shape) +
#  geom_polygon(mapping = aes(x = long, y = lat, group = group)) +
#  geom_point(
#    data = coords_killed,
#  mapping = aes(x = long, y = lat),
#  color = "red",
#  size = killed_div$killed_divided_by_300
#) + 
#  coord_map() 
  



