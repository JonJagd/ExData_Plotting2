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

# Load required packages
library(ggplot2)
##library(ggplot2movies)

## -----------------------------------------------------------------------------------
## Load data into the program
## -----------------------------------------------------------------------------------
NEI <- readRDS("data/summarySCC_PM25.rds")
##SCC <- readRDS("data/Source_Classification_Code.rds")

## -----------------------------------------------------------------------------------
## Subsetting the data to Baltimore City and the different types
## -----------------------------------------------------------------------------------
bcAll <- subset.data.frame(NEI, NEI$fips == "24510")
bcPoint <- subset.data.frame(NEI, NEI$fips == "24510" & NEI$type == "POINT")
bcNonPoint <- subset.data.frame(NEI, NEI$fips == "24510" & NEI$type == "NONPOINT")
bcOnRoad <- subset.data.frame(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
bcNonRoad <- subset.data.frame(NEI, NEI$fips == "24510" & NEI$type == "NON-ROAD")


## -----------------------------------------------------------------------------------
## Summing up total emissions by year and type and putting it into a data frame
## -----------------------------------------------------------------------------------

totalBcAll <-with(bcAll, tapply(Emissions, INDEX = list(year, type), sum, na.rm = T))
totalBcAll <- as.data.frame(totalBcAll)

## First we do it for type POINT
##totalBcPoint <-with(bcPoint, tapply(Emissions, year, sum, na.rm = T))
##totalBcPoint <- as.data.frame(totalBcPoint)


## -----------------------------------------------------------------------------------
## Making the plot
## -----------------------------------------------------------------------------------

## Setting the graphical parameters
##par(mfrow = c(1, 1))

## We create the plot and save it to a PNG-file
##png("plot2.png", width = 480, height = 480, res = 72)

##qplot(row.names(totalBcPoint), totalBcPoint, data=totalBcPoint, geom=c("point","smooth"), method="lm")

ggplot(totalBcAll, aes(factor(row.names(totalBcAll)), totalBcAll)) +
geom_point() +
facet_wrap(~names(totalBcAll), nrow = 2, ncol = 2) + ## Jeg mangler en header der hedder Type og en der hedder Sum og så skal det ligge i en tabel med 2 kolonner
geom_smooth(method = "lm", se = FALSE, color = "black", aes(group = 1))


dev.off()
