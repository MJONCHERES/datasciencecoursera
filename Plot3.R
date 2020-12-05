# upload data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip")

# read the dataset and change formats to Date and to Numeric
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Extract only 2 days from the dataset
data1 <- subset(data, (Date >= "2007-02-01") & (Date <= "2007-02-02"))

# merge the Date and Time columns to have a "full date" 
datetime <- paste(data1$Date, data1$Time)
data1$Datetime <- as.POSIXct(datetime)

# Build the plot and save itin a PNG file
png("plot3.png", width=480, height=480)
plot(x=data1$Datetime, y=data1$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(x=data1$Datetime, y=data1$Sub_metering_2, col="red")
lines(x=data1$Datetime, y=data1$Sub_metering_3, col="blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()