## source file
fname <- "./data/household_power_consumption.txt"

## Read data between 01/02/2007 and 02-02-2007 Dates 
pcdata <- read.table(text = grep("^[1,2]/2/2007", readLines(fname), value = TRUE), 
                     sep = ";", header = TRUE, na.strings = "?"
                     ,col.names = c("Date", "Time", "Global_active_power", 
                                    "Global_reactive_power", "Voltage", 
                                    "Global_intensity", "Sub_metering_1", 
                                    "Sub_metering_2", "Sub_metering_3"))

View(pcdata)

## formatting of the Date and Time
pcdata$Date <- as.Date(pcdata$Date, format="%d/%m/%Y")
pcdata$Time <- strptime(pcdata$Time, format="%H:%M:%S")
pcdata[1:1440,"Time"] <- format(pcdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
pcdata[1441:2880,"Time"] <- format(pcdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

## Device file
png("plot3.png", width=480, height=480)


# calling the basic plot functions
plot(pcdata$Time,pcdata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(pcdata,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(pcdata,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(pcdata,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# annotating graph
title(main="Energy sub-metering")

## close device
dev.off()
