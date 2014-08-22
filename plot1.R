## Script Name: plot1.R
## Course Name: John Hopkins Univeristy Exploratory Data Analysis
## Student Name: Sherri Verdugo
## Date: July 25, 2014
## Version: 1.0_14

## Libraries needed: no special libraries needed for this part

### Question 1: 
## Have total emissions from PM2.5 decreased in the United States from
## 1999 to 2008? Using the base plotting system only, make a plot showing
## the toal PM2.5 emissions from all sources for each of the years
## 1999, 2002, 2005, and 2008.

## Answer: 
## Yes, they sharply declined from 1999 to 2002. Then a slower decline between 2002 and 2005. Finally, they sharply declined from 2005 to 2008.

## Pre-Step One: Set working directory
setwd("~/Google Drive/Coursera_R_studio/exploratory_data/project2")

## Step 1: read in the data
NEI <- readRDS("expdata_prj2/summarySCC_PM25.rds")
SCC <- readRDS("expdata_prj2/Source_Classification_Code.rds")

length(NEI$Emissions)
length(NEI$year)
tot.PM25yr <- tapply(NEI$Emissions, NEI$year, sum)

###Step 2: prepare to plot
png("plot1.png")
plot(names(tot.PM25yr), tot.PM25yr, type="l", 
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"), col="Purple")
dev.off()