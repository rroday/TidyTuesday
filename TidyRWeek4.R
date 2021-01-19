## ---------------------------
##
## Script name: TidyTuesday 2021-01-19 (Week 4)
##
## Author: Rachel Roday
##
## Date Created: 2021-01-19 
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: left_join and merging datasets
##        Time to code: 3 hours
##
## ---------------------------

# Set wd
setwd("C:/Users/RER/Desktop/TidyTuesday")

# install.packages("remotes")
# ::install_github("Shelmith-Kariuki/rKenyaCensus")


# Libraries
library('remotes')
library("tidytuesdayR")
library('ggplot2')
library("tidyverse")
library('reshape2')

# Load data
tuesdata <- tidytuesdayR::tt_load('2021-01-19')
gender <- tuesdata$gender
crops <-tuesdata$crops
households <- tuesdata$households

# Clean up dataframes 
#rename crops column
colnames(crops)[1]<-"County"
# make County columns into characters
gender$County <- as.character(gender$County)
crops$County <- as.character(crops$County)
households$County <- as.character(households$County)
# Change "total" cell to "kenya"
gender[1, 1] <- "Kenya"
# All caps to Title case
crops$County<-str_to_title(crops$County)
# Trim County column values
households$County <- stringr::str_trim(households$County)
gender$County <- stringr::str_trim(gender$County)

# Merge datasets
df<- left_join(households, crops, by=c("County"="County"))
df2<- left_join(df, gender, by=c("County"="County"))


df2$malepp<- df2$Male/df2$Population
df2$femalepp<- df2$Female/df2$Population


# dfmelt<-melt(data = df2, id.vars = c("County", "malepp"), measure.vars = c("Tea", "Coffee","Avocado", "Citrus", "Mango","Coconut","Macadamia","Cashew Nut","Khat (Miraa)"), variable.name = "Crops", value.name= "Output")

df3<-df2[-1,]
df3$farmingpp<-df3$Farming/df3$Population

ggplot(df3, aes(femalepp, farmingpp, color=femalepp))+
  geom_point(aes(size=Population))+
  scale_color_gradient(low = "blue", high="pink")+
  theme_bw()+
  ylab("Proportion of Population that Farms")+
  xlab("Proportion of Females in the Population")+
  labs(color = 'Proportion of Females', title = "Proportion of Females vs Proportion of County Population that Farms in Kenya")
