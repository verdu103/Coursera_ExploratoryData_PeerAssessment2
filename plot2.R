## Script Name: plot2.R
## Course Name: John Hopkins Univeristy Exploratory Data Analysis
## Student Name: Sherri Verdugo
## Date: July 25, 2014
## Version: 1.0_14

## Libraries needed: no special libraries needed for this part

### Question 2: 
## Have total emissions from PM_2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
## system to make a plot answering this question.

### Answer:
## The data indicate a sharp decline between 1999 and 2002. A sharp
## increase occurred from 2002 to 2005. Finally, another sharp decrease
## occurred from 2005 to 2008.

## Pre-Step One: Set working directory
setwd("~/Google Drive/Coursera_R_studio/exploratory_data/project2")

## Step 1: read in the data
NEI <- readRDS("expdata_prj2/summarySCC_PM25.rds")
SCC <- readRDS("expdata_prj2/Source_Classification_Code.rds")

## Step 2: obtain the subsets to plot
baltimore <- subset (NEI, fips == "24510")
total.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

## Step 3: plot
png("plot2.png")
plot(names(total.PM25yr), total.PM25yr, type = "l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"
     ), main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions 
     by Year"), col="blue")
dev.off()
     