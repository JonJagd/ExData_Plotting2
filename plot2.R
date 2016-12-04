## ----------------------------------------------------------------------------------- 
## Course     : Exploratory Data Analysis
## Assignment : Peer-graded Assignment: Course Project 2 - week 4
## Developer  : Jon Jagd Christensen (December 2016)
## Code       : plot2
## Question   : Have total emissions from PM2.5 decreased in the  Baltimore City, Maryland 
## ( fips == 24510) from 1999 to 2008? Use the base plotting system to make a plot answering
## this question.
## -----------------------------------------------------------------------------------
## This program will load data from the source:
## 
## PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all 
## of the PM2.5 emissions data for 1999, 2002, 2005, and 2008
##
## -----------------------------------------------------------------------------------
## Prepare the environment
## -----------------------------------------------------------------------------------

# Clear the memory
rm(list=ls())

# Set working directory
setwd("C:/Git/R/ExData_Plotting2")

# Load required packages
require(stats)

## -----------------------------------------------------------------------------------
## Load data into the program
## -----------------------------------------------------------------------------------
NEI <- readRDS("data/summarySCC_PM25.rds")

## -----------------------------------------------------------------------------------
## Subsetting the data to Baltimore City
## -----------------------------------------------------------------------------------
bc <- subset.data.frame(NEI, NEI$fips == "24510")

## -----------------------------------------------------------------------------------
## Summing up total emissions by year and putting it into a data frame
## -----------------------------------------------------------------------------------
total <-with(bc, tapply(Emissions, year, sum, na.rm = T))
## Putting years and sums in seperate vectors to simplify plotting and adding trendline
sums <- as.vector(total)
years <- names(total)

## -----------------------------------------------------------------------------------
## Making the plot
## -----------------------------------------------------------------------------------

## Setting the graphical parameters
par(mfrow = c(1, 1))

## We create the plot and save it to a PNG-file
png("plot2.png", width = 480, height = 480, res = 72)

plot(years, sums, xlim = c(1998, 2009), pch = 19, main = "Plot 2 - Total PM2.5 emissions per year in Baltimore City", xlab = "Year", ylab = "PM2.5 in tons")

## We add a simple regression line to clearly show the trend
abline(lsfit(years, sums))

dev.off()

