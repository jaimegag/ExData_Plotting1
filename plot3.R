# Read data into R
# Reading all records ... but we could filter 2007-02-01/2 by reading rows 66638 through 69517,
# both inclusive before accessing the file from R, to save time.
#
# Alternatively we could read a txt file previously processed with a Unix script to avoid waisting memory in R
# and to reduce reading time from 56secs to 0.05 secs (on my computer):
#   prompt$> head -1 household_power_consumption.txt > household_power_consumption_1and2_feb_2007.txt
#   prompt$> grep -E "^[1|2]\/2\/2007" household_power_consumption.txt >> household_power_consumption_1and2_feb_2007.txt
#   data <- read.table("household_power_consumption_1and2_feb_2007.txt",
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
# Create Plot with lines on on 3 energy sub meterings, with 3 different colors, and labels, on a png file
png(filename="plot3.png", width=480, height=480)
with(datasubset, plot(DateTime,Sub_metering_1,
                      xlab="", ylab="Energy sub metering",
                      type="n"))
with(datasubset, lines(DateTime,Sub_metering_1))
with(datasubset, lines(DateTime,Sub_metering_2, col="red"))
with(datasubset, lines(DateTime,Sub_metering_3, col="blue"))
legend("topright", pch=c(NA,NA,NA), lty=c(1,1,1), col = c("black", "blue", "red"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()