## source file
fname <- "./data/household_power_consumption.txt"

## Read data between 01/02/2007 and 02-02-2007 Dates 
pcdata <- read.table(text = grep("^[1,2]/2/2007", readLines(fname), value = TRUE), 
                     sep = ";", header = TRUE, na.strings = "?"
                     ,col.names = c("Date", "Time", "Global_active_power", 
                                    "Global_reactive_power", "Voltage", 
                                    "Global_intensity", "Sub_metering_1", 
                                    "Sub_metering_2", "Sub_metering_3"))

# formatting of the Date and Time
pcdata$Date <- as.Date(pcdata$Date, format="%d/%m/%Y")
pcdata$Time <- strptime(pcdata$Time, format="%H:%M:%S")
pcdata[1:1440,"Time"] <- format(pcdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
pcdata[1441:2880,"Time"] <- format(pcdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

View(pcdata)

## Device file
png("plot2.png", width=480, height=480)

## Generating Plot 2
plot(pcdata$Time, pcdata$Global_active_power, type="l"
     ,ylab = "Global Active Power (kilowatts)", xlab = "")

## close device
dev.off()
