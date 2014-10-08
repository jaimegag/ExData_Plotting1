# plot3.R : Create Plot with lines on on 3 energy sub meterings, with 3 different colors and labels, in plot3.png file
#
# Read data into R: Reading only observations from Feb 1st and 2nd 2007 
data <- read.csv.sql("household_power_consumption.txt",
                     sep=";", header=TRUE,
                     colClasses=c("character","character","numeric","numeric","numeric","numeric",
                                  "numeric","numeric","numeric"),
                     sql="select * from file where Date in ('1/2/2007','2/2/2007')")
# Parse Date and Time into new field to simplify access to datatime in the plots
data$DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# Create Plot with lines on on 3 energy sub meterings, with 3 different colors, and labels, on a png file
png(filename="plot3.png", width=480, height=480)
with(data, plot(DateTime,Sub_metering_1,
                      xlab="", ylab="Energy sub metering",
                      type="n"))
with(data, lines(DateTime,Sub_metering_1))
with(data, lines(DateTime,Sub_metering_2, col="red"))
with(data, lines(DateTime,Sub_metering_3, col="blue"))
legend("topright", pch=c(NA,NA,NA), lty=c(1,1,1), col = c("black", "blue", "red"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()