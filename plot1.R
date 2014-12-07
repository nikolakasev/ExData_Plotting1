#REMARK: running the script in a command line fails with "Error in eval(expr, envir, enclos) : could not find function "%between%" - run in RStudio instead

#read the complete household power consumption data
all <- read.csv("household_power_consumption.txt", colClasses="character", sep = ";")
#convert the Date column to a Date type
all$Date <- as.Date(all$Date, "%d/%m/%Y")
#extract the data for the 1-st and 2-nd of Feb, 2007
power <- subset(all, Date %between% c("2007-02-01", "2007-02-02"))
#convert the global active power values from char to a numeric type, the hist function requires it
power$Global_active_power <- as.numeric(power$Global_active_power)
png(file = "plot1.png", width = 480, height = 480)
hist(power$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()