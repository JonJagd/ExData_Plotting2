## ----------------------------------------------------------------------------------- 
## Course     : Exploratory Data Analysis
## Assignment : Peer-graded Assignment: Course Project 2 - week 4
## Developer  : Jon Jagd Christensen (December 2016)
## Code       : plot6
## Question   : Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California (fips == 06037).
## Which city has seen greater changes over time in motor vehicle emissions?
## -----------------------------------------------------------------------------------
## This program will load data from the following two sources:
## 
## PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all 
## of the PM2.5 emissions data for 1999, 2002, 2005, and 2008
## 
## Source Classification Code Table (Source_Classification_Code.rds): This table 
## provides a mapping from the SCC digit strings in the Emissions table to the actual 
## name of the PM2.5 source. 
##
## -----------------------------------------------------------------------------------
## Prepare the environment
## -----------------------------------------------------------------------------------

# Clear the memory
rm(list=ls())

# Set working directory
setwd("C:/Git/R/ExData_Plotting2")

# Load required packages
library(ggplot2) ## For creating ggplots
library(reshape) ## For manipulating data sets


## -----------------------------------------------------------------------------------
## Load data into the program
## -----------------------------------------------------------------------------------
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## -----------------------------------------------------------------------------------
## Subsetting the data to motor vehicle sources for Baltimore City and Los Angeles
## -----------------------------------------------------------------------------------

## First I find all the SCC-codes that have the word motor OR vehicle written in any of 
## their columns. I do that by concatenating all the columns into one long text string
SCC$Concatenated <- do.call(paste0, SCC[c(1:15)])
## And then grep for "motor OR vehicle" in the concatenated column to identify the codes, 
## that concern motor vehicle combustion-related sources
mvSCC <- SCC[grep("motor|vehicle", SCC$Concatenated, ignore.case=TRUE), ]

## Second the NEI dataset is subsetted to Baltimore City OR Los Angeles and identified
## motor vehicle related sources
mvEm <- subset.data.frame(NEI, NEI$fips %in% c("24510", "06037") & NEI$SCC %in% mvSCC[,c(1)])

## -----------------------------------------------------------------------------------
## Summing up total emissions by year and type and putting it into a data frame
## -----------------------------------------------------------------------------------

## Using tapply to calculate the total sum of PM2.5 per year and city
total <-with(mvEm, tapply(Emissions, INDEX = list(year, fips), sum, na.rm = T))
## Converting the matrix to a data frame
total <- as.data.frame(total)
## Adding year as a column to the data frame
total$Year <- row.names(total)
## Pivoting the columns for different types with PM2.5 data out to seperate rows
total <- melt(total, id=c("Year"))
## Renaming column names
names(total) <- c("Year", "Fips", "Emissions")

## Adding city names
total$CityName[total$Fips == "24510"] <- "Baltimore City"
total$CityName[total$Fips == "06037"] <- "Los Angeles"
  

## -----------------------------------------------------------------------------------
## Making the plot
## -----------------------------------------------------------------------------------

## Setup ggplot with the data frame
g <- ggplot(total, aes(Year, Emissions)) 

## Adding layers
g +
  geom_point() +
  facet_wrap(~CityName, ncol = 2) + 
  geom_smooth(method = "lm", color = "steelblue", aes(group = 1))+
  labs(y = "PM2.5 in tons") +
  labs(title="Changes in PM2.5 emissions from motor vehicle sources")

## Saving the plot to PNG
ggsave(file="plot6.png")