#gc(verbose = TRUE)

input <- "household_power_consumption.txt"
idx_date <- c("1/2/2007", "2/2/2007")

#estimation of memory needed:
#top.size <- object.size(read.csv(input, nrow=1000))
#print(top.size, units = "MB")
#size.estimate <- 2075259 / 1000 * top.size / 1000000
#print(paste(round(size.estimate,2), "MB", sep =""))

dat0 <- read.csv(input, na.strings = "?", sep = ";")
#dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
#dat$Time <- strptime(dat$Time, "%T")
dat <- dat0[which(dat0$Date %in% idx_date),]
dat$DateTime <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %T")

#first chart:
png(filename = "plot1.png", width = 480, height = 480, units = "px")
par(bg=NA)
hist(dat$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

#second chart:
png(filename = "plot2.png", width = 480, height = 480, units = "px")
par(bg=NA)
plot(dat$DateTime,dat$Global_active_power, type = "l", main = NA, xlab=NA, ylab = "Global Active Power (kilowatts)")
dev.off()

#third chart:
png(filename = "plot3.png", width = 480, height = 480, units = "px")
par(bg=NA)
plot(dat$DateTime,dat$Sub_metering_1, type = "l", main = NA, xlab=NA, ylab = "Energy sub metering")
lines(dat$DateTime,dat$Sub_metering_2, type = "l", col = "red")
lines(dat$DateTime,dat$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col = c("black","red","blue"))
dev.off()

#fourth chart:
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2),bg=NA)
plot(dat$DateTime,dat$Global_active_power, type = "l", main = NA, xlab=NA, ylab = "Global Active Power (kilowatts)")
plot(dat$DateTime,dat$Voltage, type = "l", main = NA, xlab="datetime", ylab = "Voltage")
plot(dat$DateTime,dat$Sub_metering_1, type = "l", main = NA, xlab=NA, ylab = "Energy sub metering")
lines(dat$DateTime,dat$Sub_metering_2, type = "l", col = "red")
lines(dat$DateTime,dat$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col = c("black","red","blue"))
plot(dat$DateTime,dat$Global_reactive_power, type = "l", main = NA, xlab="datetime", ylab = "Global_reactive_power")
dev.off()