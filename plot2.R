# plot2.R : Create Plot with lines on Global_active_power in plot2.png file
#
# Read data into R: Reading only observations from Feb 1st and 2nd 2007 
data <- read.csv.sql("household_power_consumption.txt",
                     sep=";", header=TRUE,
                     colClasses=c("character","character","numeric","numeric","numeric","numeric",
                                  "numeric","numeric","numeric"),
                     sql="select * from file where Date in ('1/2/2007','2/2/2007')")
# Parse Date and Time into new field to simplify access to datatime in the plots
data$DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# Create Plot with lines on Global_active_power on a png file
png(filename="plot2.png", width=480, height=480)
with(data, plot(DateTime,Global_active_power,
                      xlab="", ylab="Global Active Power (kilowatts)",
                      type="n"))
with(data, lines(DateTime,Global_active_power))
dev.off()