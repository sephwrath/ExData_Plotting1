library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip")
unzip("power.zip")
file.remove("power.zip")

data<-read.table("household_power_consumption.txt", header=T, sep =";", na.strings="?")

febData<-filter(data, Date =="1/2/2007" | Date == "2/2/2007")
febData$Date.Time <- as.POSIXct(strptime(paste(febData$Date, febData$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

dev.off()

png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2), mar=c(4,4,2,2))

## 1,1
plot( febData$Date.Time, febData$Global_active_power, type="l"
      , ylab="Global Active Power"
      , xlab="")

## 1,2
plot( febData$Date.Time, febData$Voltage, type="l"
      , ylab="Voltage"
      , xlab="datetime")

## 2,1
plot( febData$Date.Time, febData$Sub_metering_1, type="l"
     , ylab="Energy sub metering"
     , xlab="")
lines(febData$Date.Time, febData$Sub_metering_2, col="red")
lines(febData$Date.Time, febData$Sub_metering_3, col="blue")

legend("topright", lty="solid", col=c("black", "red", "blue")
       , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

## 2,2
plot( febData$Date.Time, febData$Global_active_power, type="l"
      , ylab="Global_reactive_power"
      , xlab="datetime")

dev.off()