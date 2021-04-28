## ---------------------------
##
## Script name: TidyTuesday 2021-04-20 (Week 7)
##
## Author: Rachel Roday
##
## Date Created: 2021-04-23
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: Time to code- 
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
# library(extrafont)
# loadfonts(device = "win")


# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-04-20')
# tuesdata <- tidytuesdayR::tt_load(2021, week = 17)

netflix <- tuesdata$netflix
netflix$date_added <- parse_datetime(netflix$date_added, "%B %d, %Y")


ggrachel <-   theme(text = element_text(),
                    panel.background = element_rect(fill = "#fcf8f7",
                                                    colour ="#fcf8f7"),
                    panel.grid.major = element_line(colour="grey"), 
                    panel.grid.minor = element_blank(),
                    panel.border = element_blank(),
                    plot.background = element_rect(fill = "#fcf8f7"),
                    legend.position="right",
                    plot.caption = element_text(face = "italic"),
                    plot.title=element_text(face="bold", size=15,color = "black"),
                    plot.subtitle = element_text(vjust = 2, size = 12),
                    axis.ticks = element_blank(),
                    legend.title = element_blank(),
                    legend.background = element_rect(fill = "#fcf8f7"),
                    legend.key = element_rect(fill = "#fcf8f7", color = NA),
                    title= element_text(colour="black"))

#Plot 1

ggplot(netflix, aes(y=release_year, x=date_added))+
  geom_point(color="#E50914", alpha=.3)+
  ggrachel+
  scale_y_continuous(breaks=seq(1910, 2025,  10), name = "Release Year")+
  labs(caption = "Souce: Kaggle | @rachel_roday", 
       title = "Netflix Releases",
       subtitle = "Recent additions to Netlfix's collection are also recent releases")+
  xlab("Date Added")


#Zoomed in PLot2
ggplot(netflix, aes(y=release_year, x=date_added))+
  geom_point(color="#E50914", alpha=.3)+
  ggrachel+
  scale_y_continuous(breaks=seq(1910, 2025,  10), limits=c(2010,2025),name = "Release Year")+
  labs(caption = "Souce: Kaggle | @rachel_roday", 
       title = "Netflix Releases",
       subtitle = "Recent additions to Netlfix's collection are also recent releases")+
  xlab("Date Added")+
  geom_smooth(method = "lm", se=FALSE, color="black", formula = y ~ x)

