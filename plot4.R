## Read data from file, replace "?" with NA 
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)))

## convert 1st column to Date class using as.Date
data[,1] <- as.Date(data[,1], format = "%d/%m/%Y")

## select rows from table according to the dates required by questions
## ie 2007-02-01 and 2007-02-02
set <- as.Date(c("2007-02-01", "2007-02-02"))
data <- data[data$Date %in% set,]

## attach date to the Time column, so that it does not take the current 
## date when we use strptime
dates <- gl(2, 1440, labels = c("2007/02/01", "2007/02/02"))
data[,2] <- paste(dates, data$Time)

## convert character string into Time class
data$Time <- strptime(data$Time, format = "%Y/%m/%d %H:%M:%S")

## open png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## set  a 2x2 grid
par(mfrow = c(2, 2))

## 1st plot
with(data, plot(Time ,data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

## 2nd plot
with(data, plot(Time ,data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

## 3rd plot
with(data, plot(Time, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
lines(data$Time, data$Sub_metering_2, type = "l", col = "red")
lines(data$Time, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n") ## bty = "n" removes the legend boundary

## 4th plot
with(data, plot(Time ,data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

## close file
dev.off()