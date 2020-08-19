library(dplyr)
library(lubridate)
setClass("myTime")
setClass("myDate")
setAs("character","myTime", function(from) as.POSIXct(strptime(from, format = "%H:%M:%S")) )
setAs("character","myDate", function(from) as.Date(from, format = "%d/%m/%Y") )
col_classes = c("myDate", "myTime",rep("numeric", 7))
#dataset <- read.csv("household_power_consumption.txt", sep = ";", colClasses = col_classes, na.strings = "?")
two_days_data <-  filter(dataset, Date == "2007-02-01" | Date == "2007-02-02")
par(mfrow = c(2, 2))
time_dates <- with(two_days_data, as.POSIXct(paste(Date, hms::as.hms(Time)), format = "%Y-%m-%d %H:%M:%S"))
# upper left
plot(two_days_data$Global_active_power ~ time_dates, type = "l", lty = 1, xlab = "", ylab = "Global Active Power (kilowatts)")
# upper right
plot(two_days_data$Voltage ~ time_dates, type = "l", lty = 1, xlab = "datetime", ylab = "Voltage")
# lower left
plot(two_days_data$Sub_metering_1 ~ time_dates, type = "l", lty = 1, col = "black", ylab = "Energy sub metering", xlab = "")
lines(two_days_data$Sub_metering_2 ~ time_dates, type = "l", lty = 1, col = "red")
lines(two_days_data$Sub_metering_3 ~ time_dates, type = "l", lty = 1, col = "blue")
legend("topright",inset = 0.01, col = c("black", "red", "blue"), legend = tail(colnames(two_days_data), n = 3), lty = 1, box.lty = 0)
# lower right
plot(two_days_data$Global_reactive_power ~ time_dates, type = "l", lty = 1, xlab = "datetime", ylab = "Global_reactive_power")
# save
dev.copy(png, file = "plot4.png", width = 480, height = 480, res = 95)
dev.off()