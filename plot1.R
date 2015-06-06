# plot1.R
# This script creates a histogram from the Global_active_power column of the
# file idetified below as fn.  The histogram is saved to the file identified
# as outFile.  The input data is left in the workspace as a dataframe, hpc.

library(dplyr)

fn = "household_power_consumption.txt"
outFile = "plot1.png"

cc <- c( rep("character",2), rep("numeric", 7) )
hpc <- filter( read.table(fn, header=T, na.strings="?", colClasses=cc, sep=";"),
      Date=="1/2/2007" | Date=="2/2/2007" )
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc$Time <- strptime(hpc$Time, "%H:%M:%S")

png(outFile)

brks = 0 : ceiling( 2 * max(hpc$Global_active_power) ) / 2
hist(hpc$Global_active_power, breaks = brks, freq=T, col="red",
      main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()

rm (fn, outFile, cc, brks)