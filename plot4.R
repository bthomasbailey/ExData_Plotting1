library(dplyr)

data <- read.csv("household_power_consumption.txt",
                 sep = ";", colClasses = "character")

data <- data %>%
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
  mutate(datetime = as.POSIXct(paste(Date, Time))) %>%
  mutate(Date = NULL) %>%
  mutate(Time = NULL) %>%
  mutate_if(names(.) != "datetime", funs(as.numeric)) %>%
  mutate(weekday = weekdays(datetime, abbreviate = T))

png("plot4.png")

par(mfrow = c(2,2))

# top left
with(data,
     plot(datetime, Global_active_power,
          type = "l", xlab = "", ylab = "Global Active Power"))

# top right
with(data, plot(datetime, Voltage, type = "l"))

# bottom left
with(data,
     plot(datetime, Sub_metering_1, type = "l",
          xlab = "", ylab = "Energy sub metering"))

with(data, lines(datetime, Sub_metering_2, col = "red"))

with(data, lines(datetime, Sub_metering_3, col = "blue"))

legend(x = "topright", legend = c("Sub_metering_1",
                              "Sub_metering_2",
                              "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1, bty = "n")

#bottom right
with(data, plot(datetime, Global_reactive_power, type = "l"))

dev.off()
