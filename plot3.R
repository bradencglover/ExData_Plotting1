#load in libraries that are used
library(data.table)
library(lubridate)
#read in data
energy <- fread(file = "household_power_consumption.txt", 
                sep = ';', 
                header = TRUE, 
                stringsAsFactors = FALSE,
                na.strings = '?'
)

energy <- energy[(energy$Date=="1/2/2007" | energy$Date=="2/2/2007" ), ]

#format date and time
energy$Date <- as.Date(energy$Date, format="%d/%m/%Y")
datetime <- paste(energy$Date, energy$Time)
energy$datetime <- as.POSIXct(datetime)

#save the graph out to a PNG
png(file = "plot3.png", width = 480, height = 480, units = "px")
with(energy, {
  plot(Sub_metering_1~datetime,
       type = 'l', 
       ylab = "Global Active Power (kilowatts)",
       xlab = ""
       )
  lines(Sub_metering_2~datetime, 
        col = 'red')
  lines(Sub_metering_3~datetime, 
        col = 'blue')
})
legend(
  "topright", 
  col = c('black', 'red', 'blue'), 
  legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
)
dev.off()