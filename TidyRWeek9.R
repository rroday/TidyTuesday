## ---------------------------
##
## Script name: TidyTuesday 2021-02-23 (Week 9)
##
## Author: Rachel Roday
##
## Date Created: 2021-02-23
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: Time to code: 2.5 hours
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
library(ggrepel)

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-02-23')

earn <- tuesdata$earn

#Personal theme for this graph
ggrachel <-   theme(text = element_text(),
                    panel.background = element_rect(fill = "white",
                                                    colour = "white"),
                    panel.grid.major = element_blank(), 
                    panel.grid.minor = element_blank(),
                    panel.border = element_blank(),
                    plot.background = element_rect(fill = "white"),
                    legend.position= "none",
                    plot.caption = element_text(face = "italic", colour= "darkgrey"),
                    axis.text.y.left = element_blank(),
                    plot.title=element_text(hjust = .5, face="bold"),
                    plot.subtitle = element_text(hjust=.5),
                    axis.ticks = element_blank(),
                    axis.text.x = element_text(color="darkgrey"),
                    aspect.ratio=1/2,
                    plot.margin = margin(2,.8,2,.8, "cm"))

#Filter and summarise 
earn2<-
  earn %>%
  filter(age == "25 to 54 years", year == c(2010, 2020)) %>%
  filter(race != "All Races", sex != "Both Sexes") %>%
  group_by(year,sex,race,age) %>%
  summarise(means = mean(median_weekly_earn)) %>%
  mutate(`race.sex` = paste(as.character(race), as.character(sex)))

#Graph
ggplot(data=earn2, aes(y=means, x=year, shape= sex, colour= race))+
  geom_point(size = 3, alpha=.5)+
  geom_line(size = 2, alpha = .5)+
  scale_x_continuous(breaks = seq(2010, 2020, by = 10), name='', position = "top")+
  scale_y_continuous(breaks = seq(400, 1600, by = 200), name="")+
  scale_color_manual(values=c("#50A3A4","#F95335", "#FCAF38"))+
  ggrachel+
  labs(title= "Median Weekly Earn (in USD)", 
       subtitle = "Average median weekly earn for ages 25-55 from 2010 to 2020",  
       caption = "Data source:  U.S. Bureau of Labor Statistics | @rachel_roday")+
  geom_text_repel(data=earn2 %>% filter(year == 2010), 
                  aes(label = means) , 
                  hjust = "left", 
                  fontface = "bold", 
                  size = 3, 
                  nudge_x = -.45) +
  geom_text_repel(data=earn2 %>% filter(year == 2020), 
                  aes(label = means) , 
                  hjust = "right", 
                  fontface = "bold", 
                  size = 3, 
                  nudge_x = .5) +
#is there a better way to do the following?
  annotate("text", label = "Asian Men", x = 2018, y = 1450, size = 3, colour = "#50A3A4",angle = 17)+
  annotate("text", label = "Asian Women", x = 2018, y = 1150, size = 3, colour = "#50A3A4",angle = 11)+
  annotate("text", label = "White Men", x = 2015, y = 1050, size = 3, colour = "#FCAF38",angle = 5.8)+
  annotate("text", label = "White Women", x = 2015, y = 867, size = 3, colour = "#FCAF38",angle = 6.5)+
  annotate("text", label = "Black Men", x = 2012, y = 725, size = 3, colour = "#F95335",angle = 5.8)+
  annotate("text", label = "Black Women", x = 2012, y = 673, size = 3, colour = "#F95335",angle = 5.8)
