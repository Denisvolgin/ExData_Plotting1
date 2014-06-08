#Load the Household Power Consumption Data
loadHouseholdPowerConsumptionData <- function(path) {
  data <- read.csv(path, sep=";", na.strings="?")
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  data <- subset(data, (Date >= "2007-02-01" & Date <= "2007-02-02"))
  data$Datetime <- as.POSIXct(datetime <- paste(as.Date(data$Date), data$Time))
  
  return(data)
}

#Plot2: Draw a plot for Global Active Power 
plot2 <- function(data, png.filename) {
  
  plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

  dev.copy(png, file=png.filename, height=480, width=480)
  dev.off()
}

plot2(loadData("household_power_consumption.txt"), "plot2.png")