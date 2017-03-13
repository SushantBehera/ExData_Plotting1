## source file
fname <- "./data/household_power_consumption.txt"

## Read data between 01/02/2007 and 02-02-2007 Dates 
pcdata <- read.table(text = grep("^[1,2]/2/2007", readLines(fname), value = TRUE), 
                     sep = ";", header = TRUE, na.strings = "?"
                     ,col.names = c("Date", "Time", "Global_active_power", 
                                    "Global_reactive_power", "Voltage", 
                                    "Global_intensity", "Sub_metering_1", 
                                    "Sub_metering_2", "Sub_metering_3"))

## formatting of the Date and Time
pcdata$Date <- as.Date(pcdata$Date, format="%d/%m/%Y")
pcdata$Time <- strptime(pcdata$Time, format="%H:%M:%S")
pcdata[1:1440,"Time"] <- format(pcdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
pcdata[1441:2880,"Time"] <- format(pcdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

## Device file
png("plot4.png", width=480, height=480)

# plot layout design
par(mfrow=c(2,2))

# basic plot function that calls different plot functions to build the 4 plots 
with(pcdata,{
    # plot1
    plot(pcdata$Time,pcdata$Global_active_power,type="l",  xlab="",ylab="Global Active Power")  
    
    # plot2
    plot(pcdata$Time,pcdata$Voltage, type="l",xlab="datetime",ylab="Voltage")
    
    # plot 3
    plot(pcdata$Time,pcdata$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
    lines(Time,Sub_metering_2,col="red")
    lines(Time,Sub_metering_3,col="blue")
    legend("topright", lty=1, col=c("black","red","blue"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    
    # plot 4
    plot(pcdata$Time,pcdata$Global_reactive_power,type="l",xlab="datetime"
         ,ylab="Global_reactive_power")
})

## close device
dev.off()
