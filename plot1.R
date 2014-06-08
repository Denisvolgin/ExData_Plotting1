#Load the Household Power Consumption Data
loadHouseholdPowerConsumptionData <- function(path) {
  data <- read.csv(path, sep=";", na.strings="?")
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  data <- subset(data, (Date >= "2007-02-01" & Date <= "2007-02-02"))
  data$Datetime <- as.POSIXct(datetime <- paste(as.Date(data$Date), data$Time))
  
  return(data)
}

#Plot1: Draw a histogram for Global Active Power 
plot1 <- function(data, png.filename) {
  hist(data$Global_active_power, main="Global Active Power",
       xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
  
  dev.copy(png, file=png.filename, height=480, width=480)
  dev.off()
}

plot1(loadData("household_power_consumption.txt"), "plot1.png")