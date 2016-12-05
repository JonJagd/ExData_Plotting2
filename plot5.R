## ----------------------------------------------------------------------------------- 
## Course     : Exploratory Data Analysis
## Assignment : Peer-graded Assignment: Course Project 2 - week 4
## Developer  : Jon Jagd Christensen (December 2016)
## Code       : plot5
## Question   : How have emissions from motor vehicle sources changed from 1999-2008 
## in Baltimore City?
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
## Subsetting the data to motor vehicle sources for Baltimore City
## -----------------------------------------------------------------------------------

## First I find all the SCC-codes that have the word motor OR vehicle written in any of 
## their columns. I do that by concatenating all the columns into one long text string
SCC$Concatenated <- do.call(paste0, SCC[c(1:15)])
## And then grep for "motor OR vehicle" in the concatenated column to identify the codes, 
## that concern motor vehicle combustion-related sources
mvSCC <- SCC[grep("motor|vehicle", SCC$Concatenated, ignore.case=TRUE), ]

## Second the NEI dataset is subsetted to Baltimore City and  identified
## motor vehicle related sources
mvEmBc <- subset.data.frame(NEI, NEI$fips == "24510" & NEI$SCC %in% mvSCC[,c(1)])

## -----------------------------------------------------------------------------------
## Summing up total emissions by year and type and putting it into a data frame
## -----------------------------------------------------------------------------------

total <-with(mvEmBc, tapply(Emissions, year, sum, na.rm = T))
## Putting years and sums in seperate vectors to simplify plotting and adding trendline
sums <- as.vector(total)
years <- names(total)

## -----------------------------------------------------------------------------------
## Making the plot
## -----------------------------------------------------------------------------------

## Setting the graphical parameters
par(mfrow = c(1, 1))

## We create the plot and save it to a PNG-file
png("plot5.png", width = 480, height = 480, res = 72)

plot(years, sums, xlim = c(1998, 2009), pch = 19, main = "Plot 5 - Emissions from motor vehicles in Baltimore City", xlab = "Year", ylab = "PM2.5 in tons")

## We add a simple regression line to clearly show the trend
abline(lsfit(years, sums))

dev.off()
