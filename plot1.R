#load in libraries that are used
library(data.table)
library(lubridate)
#read in data
energy <- fread(file = "household_power_consumption.txt", 
                sep = ';', 
                header = TRUE, 
                stringsAsFactors = FALSE,
                na.strings="?"
                )

#filter down the data
energy <- energy[(energy$Date=="1/2/2007" | energy$Date=="2/2/2007" ), ]

#use lubridate to change Date and Time columns to date/time objects
energy$Date <- lubridate::dmy(energy$Date)
energy$Time <- lubridate::hms(energy$Time)


#create histogram for Global Active Power
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(energy$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()

