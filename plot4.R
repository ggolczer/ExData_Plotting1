################Download data################
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(file)) {
  download.file(url, file, mode = "wb")
}
#Unzip Data
dataPath <- "Electric power consumption"
if (!file.exists(dataPath)) {
  unzip(file)
}

################READ THE DATA################

#Data file is separated with ; characters
household_power <- read.table("household_power_consumption.txt",header=T,sep=";", stringsAsFactors=F)

#To save memory -> subset the dates that are needed according to the README.md and remove original
household_power_lite <- subset(household_power, Date == "1/2/2007"| Date == "2/2/2007")
rm(household_power)

#Convert the dates and times to the proper classes
#Since strptime needs a date for the time, its better to create a new variable
#called Date_Time and append it to the data set

household_power_lite$Date <- as.Date(household_power_lite$Date, format="%d/%m/%Y")
Date_Time <- paste(household_power_lite$Date, household_power_lite$Time)
household_power_lite$Date_Time <- as.POSIXct(Date_Time)

#Making Plot 4

#Create 4 panels
par(mfcol=c(2,2))

#1st plot
plot(as.numeric(household_power_lite$Global_active_power)~household_power_lite$Date_Time, 
type="l", ylab="Global Active Power",xlab=NA)

#2nd plot

plot(x=household_power_lite$Date_Time, y=as.numeric(household_power_lite$Sub_metering_1),type="l",
ylab="Energy sub metering",xlab=NA,col="black")
lines(household_power_lite$Date_Time, as.numeric(household_power_lite$Sub_metering_2), col="red")
lines(household_power_lite$Date_Time, as.numeric(household_power_lite$Sub_metering_3), col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#3rd plot
plot(as.numeric(household_power_lite$Voltage)~household_power_lite$Date_Time, 
type="l", ylab="Voltage",xlab="datetime")
#4th plot
plot(as.numeric(household_power_lite$Global_reactive_power)~household_power_lite$Date_Time, 
type="l", ylab="Global_reactive_power",xlab="datetime")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()