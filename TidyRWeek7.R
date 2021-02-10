## ---------------------------
##
## Script name: TidyTuesday 2021-02-09 (Week 7)
##
## Author: Rachel Roday
##
## Date Created: 2021-02-09
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
library(extrafont)
loadfonts(device = "win")

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-02-09')

lifetime_earn <- tuesdata$lifetime_earn
student_debt <- tuesdata$student_debt
home_owner<- tuesdata$home_owner
income_aggregate <- tuesdata$income_aggregate
income_distribution <- tuesdata$income_distribution
income_limits<- tuesdata$income_limits
income_mean<- tuesdata$income_mean
income_time <- tuesdata$income_time
lifetime_weath <- tuesdata$lifetime_wealth
race_wealth <- tuesdata$race_wealth
retirement<- tuesdata$retirement

ggrachel <-   theme(text = element_text(),
      panel.background = element_rect(fill = "#eee6dd",
                                      colour = "#eee6dd"),
      panel.grid.major = element_line(colour="#DFCFBE"), 
      panel.grid.minor = element_blank(),
      panel.border = element_blank(),
      plot.background = element_rect(fill = "#eee6dd"),
      legend.position="right",
      plot.caption = element_text(face = "italic"),
      axis.text.y.left = element_text(size = 9),
      plot.title=element_text(face="bold", size=15,color = "black"),
      plot.subtitle = element_text(vjust = 2, size = 12),
      axis.ticks = element_blank(),
      legend.title = element_blank(),
      legend.background = element_rect(fill = "#eee6dd"),
      legend.key = element_rect(fill = "#eee6dd", color = NA))

ggplot(student_debt, aes(x= year, y= loan_debt, color=race))+
  geom_line(size=2)+
  ggrachel+
  labs(title= "Student Debt", 
       subtitle = "Average family student loan debt for ages 25-55, normalized to 2016 dollars",  
       caption = "Data source:  Urban Institute and US Census")+
  scale_color_manual(values = c("black", "grey", "white"))+
  scale_x_continuous(breaks = seq(1990, 2020, by = 5), name='')+
  scale_y_continuous(breaks = seq(0, 15000, by = 3000),name="Loan Debt (USD)")
