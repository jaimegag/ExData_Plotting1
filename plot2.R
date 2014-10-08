# plot2.R : Create Plot with lines on Global_active_power in plot2.png file
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
# Create Plot with lines on Global_active_power on a png file
png(filename="plot2.png", width=480, height=480)
with(datasubset, plot(DateTime,Global_active_power,
                      xlab="", ylab="Global Active Power (kilowatts)",
                      type="n"))
with(datasubset, lines(DateTime,Global_active_power))
dev.off()