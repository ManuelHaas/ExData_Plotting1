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

png(filename="Plot2.png")
plot(subset$DateTime, subset$Global_active_power, xlab="",
     ylab="Global Active Power (kilowatts)", type="l", main="")
dev.off()
