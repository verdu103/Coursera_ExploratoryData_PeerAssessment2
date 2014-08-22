## Script Name: plot4.R
## Course Name: John Hopkins Univeristy Exploratory Data Analysis
## Student Name: Sherri Verdugo
## Date: July 25, 2014
## Version: 1.0_14

## Libraries needed: no special libraries needed for this part
library(plyr)
library(ggplot2)

### Question 4:
##Across the United States, how have emissions from coal 
##combustion-related sources changed from 1999 to 2008?

### Answer:
##**Total: Purple Line**<br>
#From the plot, we see that the purple line for total slightly declines from 1999 to 2002. From 2002 to 2005 the line has a marginal increase. Finally, from 2005 to 2008, the overall trend has a sharp decrease.<br>
  
## **Point: Blue Line**<br>
#From the plot, we see that the blue line for point is slightly similar in shape to the total purple line. From 1999 to 2002 the point blue line has a steeper decrease. From 2002 to 2005, the point blue line increases only slightly. Finally, from 2005 to 2008, the overall trend has a sharp decrease.<br>
  
##**Nonpoint: Red Line**<br>
#This line is remarkably different from the other two lines. From 1999 to 2002 it has an increase (although it starts from a much lower level than the other two lines at just above zero). From 2002 to 2005 it remains nearly level and does not appear to increase or decrease much. Finally, from 2005 to 2008, another symmetrical decrease occurs to end just below the initial levels for the 1999 values. <br>

## Step 1: read in the data
NEI <- readRDS("expdata_prj2/summarySCC_PM25.rds")
SCC <- readRDS("expdata_prj2/Source_Classification_Code.rds")

## Step 2: subset our data for only coal-combustion
coalcomb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutiona
                                             l - Coal", "Fuel Comb - 
                                             Electric Generation - Coal", 
                                             "Fuel Comb - Industrial 
                                             Boilers, ICEs - Coal"))

## Step 3: comparisons so that we didn't ommit anything weird
coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", 
                                                               Short.Name
                                                               ))

nrow(coalcomb.scc) #evaluate: rows 0
nrow(coalcomb.scc1) #evaluate: rows 91

## Step 4: set the differences 
dif1 <- setdiff(coalcomb.scc$SCC, coalcomb.scc1$SCC)
dif2 <- setdiff(coalcomb.scc1$SCC, coalcomb.scc$SCC)

length(dif1)#0
length(dif2)#91

##Based on other coursera courses and previous history...
###it's time to look at the union of these sets
coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)
length(coalcomb.codes) #91

## Step 5: subset again for what we want
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

##Step 6: get the PM25 values as well
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

#rename the col
colnames(coalcomb.pm25year)[3] <- "Emissions"



##Step 7: finally plot4.png
png("plot4.png")
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") +
  stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
               color = "purple", aes(shape="total"), geom="line") +
  geom_line(aes(size="total", shape = NA)) +
  ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

##plot
png("plot4a.png", width = 490, height = 490, units="px",pointsize = 12, bg = "white")

##Step 8: plot of combined coal values using smooth
plot.new <- ggplot(coalcomb.pm25year, aes(x = year, y = Emissions)) + 
  geom_point(alpha = .3, aes(colour=Emissions), size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (thousands of tons)") +
  geom_smooth(alpha = .2, size=2, pch=2, aes(colour=Emissions)) +
  ggtitle("Total PM2.5 Coal Combustion Emissions in the United States")

print(plot.new)
#close devise
dev.off()
