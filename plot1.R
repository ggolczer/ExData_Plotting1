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

#Making Plot 1

hist(as.numeric(household_power_lite$Global_active_power), xlab = "Global Active Power (kilowatts)",
main= "Global Actie Power", col="red")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()