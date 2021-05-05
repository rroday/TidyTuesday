## ---------------------------
##
## Script name: TidyTuesday 2021-05-04 (Week 19)
##
## Author: Rachel Roday
##
## Date Created: 2021-05-03
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: Time to code- 32 min
##        
##
## ---------------------------

# Set wd
setwd("C:/Users/RER/Desktop/TidyTuesday")

# Libraries

library(tidytuesdayR)
library(ggplot2)
library(tidyverse)
library(viridis)
library(dplyr)
library(lubridate)
library(readr)
library(data.table)
library(ggtext)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggspatial)
library(sf)
## Get data

water <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-05-04/water.csv')
summary(water)

water2 <- water %>% 
  drop_na(water_tech) %>%
  mutate(water_tech = replace(water_tech, str_detect(water_tech, "Hand Pump"), "Hand Pump")) %>%
  mutate(water_tech = replace(water_tech, str_detect(water_tech, "Mechanized Pump"), "Mechanized Pump"))

africa <- ne_countries(scale = "medium", returnclass = "sf", continent = "Africa")

ggplot(africa)+
  geom_sf(fill = "white")+
  geom_point(data = water2, aes(x = lon_deg, y = lat_deg, color=water_tech),alpha=.5)+
  theme(axis.line = element_blank(),
        plot.title = element_text(face="bold"),
      plot.subtitle = element_text(face="bold", size=15),
      plot.caption = element_text(face = "italic", size = 6, color = "grey"),
      axis.text = element_blank(),
      panel.grid = element_blank(),
      legend.title = element_blank())+
  scale_x_continuous("", limits = c(-50,50))+
  scale_y_continuous("", limits = c(-50,50))+
  labs(title = "Water tech in Africa", 
       subtitle = "System being used to transport the water from the source to the point of collection", 
       caption = "Data source: Water Point Data Exchange | @rachel_roday")

    