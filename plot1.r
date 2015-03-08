
setwd("/Users/zengqian/Dropbox/coursera/exploratory/ExData_Plotting1")

#This project creates four plots of energy usage over a two day period in February 2007
#Author: Qian Zeng Mar8,2015
#Data Source URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Data Input File(s): household_power_consumption.txt 
#R Packages: dplyr

##################### load libraries #################################
#load dplyr library for filtering and selecting data
library(dplyr)
##################### end load libraries #################################


##################### Get data ###########################################
#E header information inside data.frame 
dathead<-read.table("household_power_consumption.txt", sep=";", header=T, nrows=1)
#Load data frame
data<-read.table("household_power_consumption.txt", sep=";", header=T, nrows=10000, skip=66000)
#Assign NA values to missing data
data[data=="?"]<-NA
#omit rows having NAs and create new data.frame
data<-na.omit(data)
#Assign column names 
names(data)<- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#Create new formatted date columns (NDate).T
data$NDate<-as.Date(data$Date, "%d/%m/%Y")
#Filter by date range as put in ddat var
data<-filter(data, NDate=="2007-02-01" | NDate=="2007-02-02" )
#Create New Time stamp. (Note: this step was used for educational purposes only and not used anywhere in this code)
data$NTTime <- strptime(paste(data$NDate,  data$Time) , format="%Y-%m-%d%H:%M:%S") 
#add three character acronym for weekday as last column
data$Day<-strftime(data$NDate,"%a")
##################### Create Plot 1 #######################################
png("plot1.png") 
hist(data$Global_active_power, col="red", xlab="Global Active Power (Kilowatts)", main="Global Active Power")
dev.off() 
##################### Create Plot 2 #######################################
#create a var to indicate which day
data$wkday <- wkday