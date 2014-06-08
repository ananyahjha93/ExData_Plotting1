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
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## reset the default
par(mfrow = c(1, 1))

## plot
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)") 

## close file
dev.off()
