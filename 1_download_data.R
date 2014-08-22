## Script Name: 1_download_data.R
## Course Name: John Hopkins Univeristy Exploratory Data Analysis
## Student Name: Sherri Verdugo
## Date: July 25, 2014
## Version: 1.0_14

## Libraries needed
library(utils)

## Pre-Step One: Set working directory
setwd("~/Google Drive/Coursera_R_studio/exploratory_data/project2")

## Step One: download the data

my.file = "expdata_prj2.zip"
if (!file.exists(my.file)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
                         ",
                         destfile = my.file,
                         method = "curl")
}

