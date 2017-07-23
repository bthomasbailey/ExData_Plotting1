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


# Plot 2
png("plot2.png")

with(data,
     plot(datetime, Global_active_power,
          type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()
