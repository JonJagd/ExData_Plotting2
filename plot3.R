## ----------------------------------------------------------------------------------- 
## Course     : Exploratory Data Analysis
## Assignment : Peer-graded Assignment: Course Project 2 - week 4
## Developer  : Jon Jagd Christensen (December 2016)
## Code       : plot3
## Question   : Of the four types of sources indicated by the type (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases in emissions
## from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.
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
##
## -----------------------------------------------------------------------------------
## Prepare the environment
## -----------------------------------------------------------------------------------

# Clear the memory
rm(list=ls())

# Set working directory
setwd("C:/Git/R/ExData_Plotting2")


## -----------------------------------------------------------------------------------
## Load data into the program
## -----------------------------------------------------------------------------------
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## -----------------------------------------------------------------------------------
## Subsetting the date to Baltimore City
## -----------------------------------------------------------------------------------
total <- subset.data.frame(NEI, NEI$fips == "24510")

## -----------------------------------------------------------------------------------
## Summing up total emissions by year and putting it into a data frame
## -----------------------------------------------------------------------------------
total <-with(total, tapply(Emissions, year, sum, na.rm = T))
total <- as.data.frame(total, col.names = names(total))

## -----------------------------------------------------------------------------------
## Making the plot
## -----------------------------------------------------------------------------------

## Setting the graphical parameters
par(mfrow = c(1, 1))

## We create the plot and save it to a PNG-file
png("plot2.png", width = 480, height = 480, res = 72)

plot(row.names(total), total$total, xlim = c(1998, 2009), pch = 19, main = "Plot 2 - Total PM2.5 emissions per year in Baltimore City", xlab = "Year", ylab = "PM2.5 in tons")

dev.off()

