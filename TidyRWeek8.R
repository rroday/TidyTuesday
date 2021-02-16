## ---------------------------
##
## Script name: TidyTuesday 2021-02-16 (Week 8)
##
## Author: Rachel Roday
##
## Date Created: 2021-02-16
##
## Copyright (c) Rachel Roday, 2021
## Email: rroday@udel.edu
##
## ---------------------------
##
## Notes: Challenge 01
##        #DuBoisChallenge
##        Time to code: 2 hr
##
## ---------------------------

# Set wd
setwd("C:/Users/RER/Desktop/TidyTuesday")

# Libraries
library(tidytuesdayR)
library(ggplot2)
library(grid)
library(pBrackets)
#library(extrafont)
library(showtext)

## Loading Google fonts (https://fonts.google.com/)
##  font-family: 'Teko', sans-serif;
font_add_google("Teko", "teko")

## Automatically use showtext to render text
showtext_auto()

# Get the Data
tuesdata <- tidytuesdayR::tt_load('2021-02-16')
georgia_pop <- tuesdata$georgia_pop

# Graph
ggplot(georgia_pop, aes(y=White, x=Year))+
  geom_line(aes(colour="White",linetype= "White"))+
  geom_line(aes(y=Colored,x=Year, colour="Colored",linetype="Colored"))+
  coord_flip()+
  labs(title = "COMPARATIVE INCREASE OF WHITE AND COLORED \n POPULATION OF GEORGIA.")+
  theme(text = element_text(family="teko"),
        panel.background = element_rect(fill = "#e7ccb0",
                                        colour = "#e7ccb0"),
        panel.grid.major = element_line(colour="#dda58c"), 
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "#e7ccb0"),
        panel.border = element_rect(colour="black", fill=NA),
        legend.position="bottom",
        plot.title=element_text(size=25, hjust = .5, vjust=5),
        axis.ticks = element_blank(),
        legend.title = element_blank(),
        legend.background = element_rect(fill = "#e7ccb0"),
        legend.margin=margin(0, 0, 0, 0),
        axis.text.x = element_text(size=8),
        axis.text.y = element_text(size=13),
        axis.title.x = element_text(vjust=-5, margin=margin(20,20,20,20)),
        plot.margin = margin(2.3,.8,2.3,.8, "cm"),
        legend.key = element_rect(fill = "#e7ccb0", color = NA))+
  scale_x_continuous(breaks = seq(1790, 1890, by = 10), name='', expand = c(0, 0))+
  scale_y_continuous(breaks = seq(0, 100, by = 5),name="Percents", trans="reverse", expand = c(0, 0))+
  scale_color_manual(values=c("black","black"))+
  scale_linetype_manual(values=c("Colored"=1,"White"=2))+
  guides(color = FALSE)


#Run grid.locator a few times to get coordinates for the outer
#most points of the bracket, making sure the 
#bottom_y coordinate is just at the bottom of the gray area.
# to exit grid.locator hit esc; after setting coordinates
# in grid.bracket comment out grid.locator() line
# grid.locator(unit="native") 
bottom_y <- 680
grid.brackets(572, bottom_y,   78, bottom_y, lwd=1, col="black")

