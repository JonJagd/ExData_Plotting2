## ----------------------------------------------------------------------------------- 
## Course     : Exploratory Data Analysis
## Assignment : Peer-graded Assignment: Course Project 2 - week 4
## Developer  : Jon Jagd Christensen (December 2016)
## Code       : plot4
## Question   : Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999-2008?
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

# Load required packages
require(stats)


## -----------------------------------------------------------------------------------
## Load data into the program
## -----------------------------------------------------------------------------------
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## -----------------------------------------------------------------------------------
## Subsetting the data to  coal combustion-related sources
## -----------------------------------------------------------------------------------

## First I find all the SCC-codes that have the word coal written in any of their columns 
## I do that by concatenating all the columns into one long text string
SCC$Concatenated <- do.call(paste0, SCC[c(1:15)])
## And then grep for "coal" in the concatenated column to identify the codes, that concern 
## coal combustion-related sources
coalSCC <- SCC[grep("coal", SCC$Concatenated, ignore.case=TRUE), ]

## Second the NEI dataset is subsetted using the identified coal combustion-related sources
coalEm <- subset.data.frame(NEI, NEI$SCC %in% coalSCC[,c(1)])

## -----------------------------------------------------------------------------------
## Summing up total emissions by year and type and putting it into a data frame
## -----------------------------------------------------------------------------------

total <-with(coalEm, tapply(Emissions, year, sum, na.rm = T))
## Putting years and sums in seperate vectors to simplify plotting and adding trendline
sums <- as.vector(total)
years <- names(total)

## -----------------------------------------------------------------------------------
## Making the plot
## -----------------------------------------------------------------------------------

## Setting the graphical parameters
par(mfrow = c(1, 1))

## We create the plot and save it to a PNG-file
png("plot4.png", width = 480, height = 480, res = 72)

plot(years, sums, xlim = c(1998, 2009), pch = 19, main = "Plot 4 - Emissions from coal combustion-related sources in US", xlab = "Year", ylab = "PM2.5 in tons")

## We add a simple regression line to clearly show the trend
abline(lsfit(years, sums))

dev.off()
