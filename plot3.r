library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip")
unzip("power.zip")
file.remove("power.zip")

data<-read.table("household_power_consumption.txt", header=T, sep =";", na.strings="?")

febData<-filter(data, Date =="1/2/2007" | Date == "2/2/2007")
febData$Date.Time <- as.POSIXct(strptime(paste(febData$Date, febData$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

dev.off()

png("plot3.png", width = 480, height = 480)

plot( febData$Date.Time, febData$Sub_metering_1, type="l"
     , ylab="Energy sub metering"
     , xlab="")
lines(febData$Date.Time, febData$Sub_metering_2, col="red")
lines(febData$Date.Time, febData$Sub_metering_3, col="blue")

legend("topright", lty="solid", col=c("black", "red", "blue")
       , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()