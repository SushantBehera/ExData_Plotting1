## source file
fname <- "./data/household_power_consumption.txt"

## Read data between 01/02/2007 and 02-02-2007 Dates 
pcdata <- read.table(text = grep("^[1,2]/2/2007", readLines(fname), value = TRUE), 
                     sep = ";", header = TRUE, na.strings = "?"
                     ,col.names = c("Date", "Time", "Global_active_power", 
                                    "Global_reactive_power", "Voltage", 
                                    "Global_intensity", "Sub_metering_1", 
                                    "Sub_metering_2", "Sub_metering_3"))

## Device file
png("plot1.png", width=480, height=480)

## basic plot function with main
hist(as.numeric(as.character(pcdata$Global_active_power)),col="red",
     main="Global Active Power",xlab="Global Active Power(kilowatts)")

## close device
dev.off()