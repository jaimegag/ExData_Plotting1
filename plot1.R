# plot1.R : Create Histogram on Global_active_power with color Red in plot1.png file
#
# Read data into R: Reading only observations from Feb 1st and 2nd 2007 
data <- read.csv.sql("household_power_consumption.txt",
                     sep=";", header=TRUE,
                     colClasses=c("character","character","numeric","numeric","numeric","numeric",
                                  "numeric","numeric","numeric"),
                     sql="select * from file where Date in ('1/2/2007','2/2/2007')")
# Parse Date and Time into new field to simplify access to datatime in the plots
data$DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# Create Histogram on Global_active_power with color Red on a png file
png(filename="plot1.png", width=480, height=480)
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()