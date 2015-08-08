library(dplyr)

# load the dataset.
df = read.csv("./household_power_consumption.txt", sep=";", na.strings="?",
              colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
# convert Date column to date datatype
df$Date <- as.Date(df$Date , "%d/%m/%Y")

# restrict the data to dates between "2007-02-01" & "2007-02-02"
subset = filter(df, Date >= "2007-02-01" & Date <= "2007-02-02")

# create a "Date Time" column
subset$DateTime = paste(subset$Date, subset$Time)

# convert Date and Time a datatype value
subset$DateTime = strptime(subset$DateTime, "%Y-%m-%d %H:%M:%S")

png(filename="Plot4.png")
par(mfrow = c(2, 2), mar = c(5, 4, 3, 2))
plot(subset$DateTime, subset$Global_active_power, xlab="",
     ylab="Global Active Power", type="l", main="")
plot(subset$DateTime, subset$Voltage, xlab="datetime",
     ylab="Voltage", type="l", main="")
plot(subset$DateTime, subset$Sub_metering_1, xlab="",
     ylab="Energy sub metering", type="n", main="")
points(subset$DateTime, subset$Sub_metering_1, col="black", type="l")
points(subset$DateTime, subset$Sub_metering_2, col="red", type="l")
points(subset$DateTime, subset$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(subset$DateTime, subset$Global_reactive_power, xlab="datetime",
     ylab="Global_reactive_power", type="l", main="")
dev.off()