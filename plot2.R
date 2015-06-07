# plot2.R
#2345678901234567890123456789012345678901234567890123456789012345678901234567890
#        1         2         3         4         5         6         7         |
# This script creates a line plot of the Global Active Power for 1 Jul and 2
# Jul, 2007.  The plot is saved to the file identified as outfile.  The input
# data is left in the workspace as a dataframe, hpc.

library(dplyr)

fn = "household_power_consumption.txt"
outFile = "plot2.png"

cc <- c( rep("character",2), rep("numeric", 7) )
hpc <- filter( read.table(fn, header=T, na.strings="?", colClasses=cc, sep=";"),
      Date=="1/2/2007" | Date=="2/2/2007" )
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc$Time <- strptime(hpc$Time, "%H:%M:%S")

png(outFile)
#day <- weekdays(hpc$Date, T)
plot(hpc$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xaxt="n")

xlab <- hpc[1,1]
xind <- 1

for (i in 1:nrow(hpc)) {
   if (hpc[i,1] != xlab[length(xlab)]) {

      xlab <- c(xlab, hpc[i,1])
      xind <- c(xind, i)
   }
}
if (xind[length(xind)] != nrow(hpc)) {
   xlab <- c( xlab, hpc[nrow(hpc),1]+1 )
   xind <- c( xind, nrow(hpc) )
}

xlab <- weekdays(xlab, T)

axis(1, xind, xlab)

dev.off()

#rm (fn, outFile, cc)