## ---------------------------
##
## Script name: TidyTuesday 2021-02-02 (Week 6)
##
## Author: Rachel Roday
##
## Date Created: 2021-02-02
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: 2.5 hours to code
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
library(extrafont)
loadfonts(device = "win")

# Get the Data

hbcu_all <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-02/hbcu_all.csv')

hbcu_black <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-02/hbcu_black.csv')

bach_students<-readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-02/bach_students.csv')


# Join hbcu (all students and black students) data by year 
hbcu<- left_join(hbcu_black, hbcu_all, by = c("Year" = "Year"))

# Find the proportion of students (total, male, and female) enrolled who are black
hbcu<-hbcu %>%
  rename(Total.Enrollment.Black= `Total enrollment.x`,Total.Enrollment.Total = `Total enrollment.y`) %>%
  mutate(Proportion = Total.Enrollment.Black/Total.Enrollment.Total,
         males = Males.x/Total.Enrollment.Total, females = Females.x/Total.Enrollment.Total) 


# Plot

hbcu_plot<-hbcu %>% 
  pivot_longer(c("Proportion", "males","females"),
                             names_to = "Enrollment.Type", 
                             values_to = "Enrollment.Prop") %>%
  ggplot(aes(x=Year, y=Enrollment.Prop, color= Enrollment.Type))+
  geom_line(size=1.3)+
  labs(title = "Enrollment of Black Students ", 
       subtitle = "Historically Black Colleges and Universities 1976-2015",
       caption = "Data source: Data.World")+
  theme(text = element_text(family = "Times New Roman"),
        panel.background = element_rect(fill = "#eee6dd",
                                        colour = "#eee6dd"),
        panel.grid.major = element_line(colour="#DFCFBE"), 
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        plot.background = element_rect(fill = "#eee6dd"),
        legend.position="bottom",
        plot.caption = element_text(face = "italic"),
        axis.text.y.left = element_text(size = 9, 
                                        family = "Times New Roman"),
        plot.title=element_text(family="Times New Roman", 
                                face="bold", size=15),
        plot.subtitle = element_text(vjust = 2, size = 12, 
                                     family = "Times New Roman"),
        axis.ticks = element_blank(),
        legend.title = element_blank(),
        legend.background = element_rect(fill = "#eee6dd"),
        legend.key = element_rect(fill = "#eee6dd", color = NA))+
  scale_x_continuous(breaks = seq(1976, 2020, by = 4), name='')+
  scale_y_continuous(name="Proportional Enrollment")+
  scale_color_manual(labels = c("Females", "Males", "Total"),
                     values = c("#f7abe4", "#abb8f7", "Black"))
