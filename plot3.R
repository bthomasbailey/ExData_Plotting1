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


# Plot 3
png("plot3.png")

with(data,
     plot(datetime, Sub_metering_1, type = "l",
          xlab = "", ylab = "Energy sub metering"))

with(data, lines(datetime, Sub_metering_2, col = "red"))

with(data, lines(datetime, Sub_metering_3, col = "blue"))

legend("topright", legend = c("Sub_metering_1",
                              "Sub_metering_2",
                              "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)


dev.off()
