# plot4.R : Create 4 Plots on a 2x2 layout in plot4.png file
#
# Read data into R: Reading all observations
#
# Alternatively we could run a Unix script on the dataset to trim out all the rows but the headers
# and the rows belonging to the 1st and 2nd of February 2007 to avoid waisting memory in R
# and to reduce reading time from 56secs to 0.05 secs (on my computer). Script :
#   prompt$> head -1 household_power_consumption.txt > household_power_consumption_1and2_feb_2007.txt
#   prompt$> grep -E "^[1|2]\/2\/2007" household_power_consumption.txt >> household_power_consumption_1and2_feb_2007.txt
# data <- read.table("household_power_consumption_1and2_feb_2007.txt",
data <- read.table("household_power_consumption.txt",
                   sep=";",
                   na.strings="?",
                   colClasses=c("character","character","numeric","numeric","numeric","numeric",
                                "numeric","numeric","numeric"),
                   header=TRUE)
# Parse Date and Time into new field to help subsetting after
data$DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
# Subset 1st and 2nd of Feb 2007 data only
datasubset <- data[which(format(data$DateTime, format="%d/%m/%Y")=="01/02/2007" | 
                             format(data$DateTime, format="%d/%m/%Y")=="02/02/2007"),]

# Create 4 plots to be stored in one png file
png(filename="plot4.png", width=480, height=480)
# Define layout for 4 plots: 2x2
par(mfrow=c(2,2))
with(datasubset, {
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