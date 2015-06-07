# plot1.R
# This script creates a histogram of Global Active Power for 1 Jul and 2 Jul
# from the data in the file idetified by fn.  The histogram is saved to the file
# identified as outFile.  The input data is left in the workspace as
# a dataframe, hpc.

library(dplyr)

### FILENAMES
fn = "household_power_consumption.txt"
outFile = "plot1.png"

### LOAD THE DATA
cc <- c( rep("character",2), rep("numeric", 7) )
hpc <- filter( read.table(fn, header=T, na.strings="?", colClasses=cc, sep=";"),
         Date=="1/2/2007" | Date=="2/2/2007" )

### CREATE THE PLOT
png(outFile)

brks = 0 : ceiling( 2 * max(hpc$Global_active_power) ) / 2
hist(hpc$Global_active_power, breaks = brks, freq=T, col="red",
      main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()

### CLEANUP
# Leave just hpc.
rm (fn, outFile, cc, brks)