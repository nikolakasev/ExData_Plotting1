#REMARK: running the script in a command line fails with "Error in eval(expr, envir, enclos) : could not find function "%between%" - run in RStudio instead

#read the complete household power consumption data
all <- read.csv("household_power_consumption.txt", colClasses="character", sep = ";")
#convert the Date column to a Date type
all$Date <- as.Date(all$Date, "%d/%m/%Y")
#extract the data for the 1-st and 2-nd of Feb, 2007
power <- subset(all, Date %between% c("2007-02-01", "2007-02-02"))
#convert the global active power values from char to a numeric type, the hist function requires it
power$Global_active_power <- as.numeric(power$Global_active_power)
#concatenate the Date and Time columns and create a single date/time value to plot on the x axis
power$fullTime <- strptime(paste(power$Date, power$Time), "%Y-%m-%d %H:%M:%S")
png(file = "plot3.png", width = 480, height = 480)
#I found this to be quite informative: http://www.harding.edu/fmccown/r/#linecharts
plot(power$fullTime, power$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(power$fullTime, power$Sub_metering_2, col="red", type="l")
lines(power$fullTime, power$Sub_metering_3, col="blue", type="l")
#draw the legend
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1)
dev.off()