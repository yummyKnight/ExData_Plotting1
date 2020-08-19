library(dplyr)
setClass("myTime")
setClass("myDate")
setAs("character","myTime", function(from) as.POSIXct(strptime(from, format = "%H:%M:%S")) )
setAs("character","myDate", function(from) as.Date(from, format = "%d/%m/%Y") )
col_classes = c("myDate", "myTime",rep("numeric", 7))
dataset <- read.csv("household_power_consumption.txt", sep = ";", colClasses = col_classes, na.strings = "?")
two_days_data <-  filter(dataset, Date == "2007-02-01" | Date == "2007-02-02")
# plot 1
with(two_days_data, hist(Global_active_power, col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
# save
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()