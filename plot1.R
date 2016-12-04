# ----------------------------------------------------------------------------------- 
## Course     : Exploratory Data Analysis
## Assignment : Peer-graded Assignment: Course Project 2 - week 4
## Developer  : Jon Jagd Christensen (December 2016)
## Code       : plot1
## Question   : Have total emissions from PM2.5 decreased in the United States from 1999 
## to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission
## from all sources for each  of the years 1999, 2002, 2005, and 2008.
## -----------------------------------------------------------------------------------
## This program will load data from the following source:
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


## -----------------------------------------------------------------------------------
## Load data into the program
## -----------------------------------------------------------------------------------
NEI <- readRDS("data/summarySCC_PM25.rds")


## -----------------------------------------------------------------------------------
## Summing up total emissions by year and putting into a data frame
## -----------------------------------------------------------------------------------
total <-with(NEI, tapply(Emissions, year, sum, na.rm = T))
total <- as.data.frame(total, col.names = names(total))

## -----------------------------------------------------------------------------------
## Making the plot
## -----------------------------------------------------------------------------------

## Setting the graphical parameters
par(mfrow = c(1, 1))

## We create the plot and save it to a PNG-file
png("plot1.png", width = 480, height = 480, res = 72)

plot(row.names(total), total$total, xlim = c(1998, 2009), pch = 19, main = "Plot 1 - Total PM2.5 emissions per year", xlab = "Year", ylab = "PM2.5 in tons")

dev.off()