## ---------------------------
##
## Script name: TidyTuesday 2021-07-13 (Week 29)
##
## Author: Rachel Roday
##
## Date Created: 2021-07-13
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: Time to code- 40 min
##        
##
## ---------------------------

# Set wd
setwd("C:/Users/RER/Desktop/TidyTuesday")

# Libraries

library(tidytuesdayR)
library(ggplot2)
library(tidyverse)
library(dplyr)

# Get the Data
tuesdata <- tidytuesdayR::tt_load('2021-07-13')
scoobydoo <- tuesdata$scoobydoo

colors <- c("#128a84","#79af30","#bb5c37","#4b0055","#8e6345","#D0D61B", "#A091C6", "#6352A3", "#F47920","#C70C47","#7BC74C",
  "#F9E014", "#6A3400")

ggplot(scoobydoo, aes(x=date_aired, y=imdb, color=network))+
  geom_point(alpha= .5,size = 2)+
  scale_y_discrete(breaks = c(5,6,7,8,9))+
  labs(y="IMDb Rating",
       x="Date Aired", 
       color= "Network", 
       title= "Scooby-Doo IMDb Ratings (1969-2021)", 
       caption = "Data source: Kaggle | @rachel_roday")+
  theme_bw()+
  scale_color_manual(values= colors)+
  theme(
    axis.ticks = element_blank(),
    axis.text = element_text(color="darkgrey"),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    plot.caption = element_text(face = "italic", colour= "darkgrey")
    )


  

