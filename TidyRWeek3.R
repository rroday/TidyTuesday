## ---------------------------
##
## Script name: TidyTuesday 2021-01-12 (Week 3)
##
## Author: Rachel Roday
##
## Date Created: 2021-01-12 
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: Tate Museum art
##        My first TidyTuesday submission!
##        Time to create script: 105 minutes
##
## ---------------------------

# Set wd
setwd("C:/Users/RER/Desktop/TidyTuesday")

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: 
install.packages("tidytuesdayR")
library(tidytuesdayR)
library(ggplot2)
library(ggmap)
library(maptools)
library(maps)
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-01-12')
# tuesdata <- tidytuesdayR::tt_load(2021, week = 3)

artwork <- tuesdata$artwork
artists<- tuesdata$artists

# Register Google Cloud Maps API with API key 
register_google(key = 'AIzaSyCY4B6Qw0zPCr2DuRQwUG_WCwlQ_hijweM')

# Omit NA from Birth Place column
artists<-artists[!is.na(artists$placeOfBirth), ]

# Use Geocode from google API to assign coordinates to each location
birthplaces<-geocode(artists$placeOfBirth)
BP.x<-birthplaces$lon
BP.y<-birthplaces$lat

# Bind latatude and longitude to the artist dataframe
DF<-cbind(artists, BP.x, BP.y)

# Using ggplot, plot the Base World Map 
# Add the birth place of Tate Art Museum artists
mapWorld <- borders("world", colour="gray", fill="white") 
ggplot()+ 
  mapWorld+
  geom_point(aes(x=BP.x, y=BP.y) ,color="red", size=2, alpha=.1)+
  theme_bw()+
  labs(x="", y="")+
  ggtitle("Tate Art Museum Birth Place of Artists")

# Omit NA from gender column
artists<-artists[!is.na(artists$gender), ]

# Usign ggplot, plot a histogram of the gender of the artists
ggplot(artists, aes(x=gender, color=gender)) +
  stat_count(fill="white", alpha=0.5, position="identity")+
  theme_minimal()
