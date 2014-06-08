#Load the Household Power Consumption Data
loadHouseholdPowerConsumptionData <- function(path) {
  data <- read.csv(path, sep=";", na.strings="?")
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  data <- subset(data, (Date >= "2007-02-01" & Date <= "2007-02-02"))
  data$Datetime <- as.POSIXct(datetime <- paste(as.Date(data$Date), data$Time))
  
  return(data)
}

#Plot3: Draw a plot for Energy sub metering
plot3 <- function(data, png.filename) {
  with(data, {
    plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
  })
  
  legend("topright", col=c("black", "red", "blue"), 
         lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  dev.copy(png, file=png.filename, height=480, width=480)
  dev.off()
}

plot3(data <- loadHouseholdPowerConsumptionData("household_power_consumption.txt"), "plot3.png")