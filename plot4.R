#Load the Household Power Consumption Data
loadHouseholdPowerConsumptionData <- function(path) {
  data <- read.csv(path, sep=";", na.strings="?")
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  data <- subset(data, (Date >= "2007-02-01" & Date <= "2007-02-02"))
  data$Datetime <- as.POSIXct(datetime <- paste(as.Date(data$Date), data$Time))
  
  return(data)
}

#Plot4: Draw four plots for: Global Active Power, Voltage, Energy sub metering, Global Reactive Power
plot4 <- function(data, png.filename) {
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  
  with(data, {
    plot(Global_active_power~Datetime, type="l", ylab="Global Active Power", xlab="")
    plot(Voltage~Datetime, type="l", ylab="Voltage", xlab="")
    
    plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
    
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(Global_reactive_power~Datetime, type="l", ylab="Global Reactive Power", xlab="")
  })

  dev.copy(png, file=png.filename, height=480, width=480)
  dev.off()
}

plot4(loadHouseholdPowerConsumptionData("household_power_consumption.txt"), "plot4.png")