## ---------------------------
##
## Script name: TidyTuesday 2021-04-27 (Week 18)
##
## Author: Rachel Roday
##
## Date Created: 2021-04-27
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: Time to code- 20 minutes
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


# Get the Data
departures <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-27/departures.csv')


ggrachel <-   theme(text = element_text(),
                    panel.background = element_rect(fill = "#F9F1F0",
                                                    colour = "#F9F1F0"),
                    panel.grid.major = element_line(colour="#FADCD9"), 
                    panel.grid.minor = element_blank(),
                    panel.border = element_blank(),
                    plot.background = element_rect(fill = "#F9F1F0"),
                    legend.position="right",
                    plot.caption = element_text(face = "italic"),
                    axis.text.y.left = element_text(size = 9),
                    plot.title=element_text(face="bold", size=15,color = "black"),
                    plot.subtitle = element_text(vjust = 2, size = 12),
                    axis.ticks = element_blank(),
                    legend.title = element_blank(),
                    legend.background = element_rect(fill = "#F9F1F0"),
                    legend.key = element_rect(fill = "#F9F1F0", color = NA))



departures %>% filter(departure_code==1) %>%
  ggplot(aes(x=fyear_gone, y=exec_fullname))+
  geom_point(color="#F79489")+
  geom_point(aes(x=fyear, y=exec_fullname),color="#F79489")+
  geom_segment(aes(x = fyear, xend = fyear_gone, y = exec_fullname,
                   yend = exec_fullname), color='grey') +
  labs(title= "Death to Captialism", 
       subtitle = "S%P 1500 Firms CEOs who have left their position due to death",  
       caption = "Data source:  Gentry et al. (2020) | @rachel_roday")+
  xlab("")+
  ylab("")+
  ggrachel+
  scale_x_continuous(breaks=seq(1985, 2025, by = 5))
