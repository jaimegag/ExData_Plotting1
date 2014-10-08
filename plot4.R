# plot4.R : Create 4 Plots on a 2x2 layout in plot4.png file
#
# Read data into R: Reading only observations from Feb 1st and 2nd 2007 
data <- read.csv.sql("household_power_consumption.txt",
                        sep=";", header=TRUE,
                        colClasses=c("character","character","numeric","numeric","numeric","numeric",
                                    "numeric","numeric","numeric"),
                        sql="select * from file where Date in ('1/2/2007','2/2/2007')")
# Parse Date and Time into new field to simplify access to datatime in the plots
data$DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# Create 4 plots to be stored in one png file
png(filename="plot4.png", width=480, height=480)
# Define layout for 4 plots: 2x2
par(mfrow=c(2,2))
with(data, {
    # Create Plot with lines on Global_Active_Power
    plot(DateTime,Global_active_power, xlab="", ylab="Global Active Power", type="n")
    lines(DateTime,Global_active_power)
    # Create Plot with lines on Voltage
    plot(DateTime,Voltage, xlab="datetime", ylab="Voltage", type="n")
    lines(DateTime,Voltage)
    # Create Plot with lines on on 3 energy sub meterings, with 3 different colors, and labels and no box border
    plot(DateTime,Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
    lines(DateTime,Sub_metering_1)
    lines(DateTime,Sub_metering_2, col="red")
    lines(DateTime,Sub_metering_3, col="blue")
    legend("topright", pch=c(NA,NA,NA), lty=c(1,1,1), bty="n", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    # Create Plot with lines on Global_reactive_power
    plot(DateTime,Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="n")
    lines(DateTime,Global_reactive_power)
# Close png file
})
dev.off()