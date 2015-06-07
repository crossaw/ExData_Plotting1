# plot4.R
# This script creates a set of four plots from data for 1 Jul and 2 Jul, 2007
# in the file identified by fn.  The plots are saved to the file identified as
# outfile.  The input data is left in the workspace as a dataframe, hpc.

library(dplyr)

### FILENAMES AND CONSTANTS
fn = "household_power_consumption.txt"
outFile = "plot4.png"
lc = c("black", "red", "blue")   # line colors

### LOAD THE DATA
cc <- c( rep("character",2), rep("numeric", 7) )
hpc <- filter( read.table(fn, header=T, na.strings="?", colClasses=cc, sep=";"),
      Date=="1/2/2007" | Date=="2/2/2007" )
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

# Tick Marks
xlab <- hpc[1,1]           # Initialize x labels.
xloc <- 1                  # Initialize x tick locations.

for (i in 1:nrow(hpc)) {   # Populate x tick locations and labels
   if (hpc[i,1] != xlab[length(xlab)]) {
      xlab <- c(xlab, hpc[i,1])
      xloc <- c(xloc, i)
   }
}
# Label the last point for the next day if it is not already a new day.
if (xloc[length(xloc)] != nrow(hpc)) {
   xlab <- c( xlab, hpc[nrow(hpc),1]+1 )
   xloc <- c( xloc, nrow(hpc) )
}
xlab <- weekdays(xlab, T)  # convert from Date class to char

# PLOTS
# Preparation
png(outFile)
par( mfcol = c(2,2) )

# Upper Left Plot
plot(hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power",
         xaxt="n")
axis(1, xloc, xlab)

# Lower Left Plot
plot(hpc[,7], type="l", xlab="", ylab="Energy sub metering", xaxt="n")
lines(x=1:nrow(hpc), y=hpc[,8], col=lc[2])
lines(x=1:nrow(hpc), y=hpc[,9], col=lc[3])
legend( "topright", names(hpc[7:9]), col=lc, lty=1, bty="n" )
#par(bty="o")
axis(1, xloc, xlab)

# Upper Right Plot
plot(hpc$Voltage, type="l", xlab="datetime", ylab="Voltage", xaxt="n")
axis(1, xloc, xlab)

# Lower Right Plot
plot(hpc$Global_reactive_power, type="l", xlab="datetime",
         ylab="Global_reactive_power", xaxt="n")
axis(1, xloc, xlab)

# COULDN'T GET THIS TO WORK RIGHT
# Apply marks and labels to each plot.
#for (i in 1:2) { for (j in 1:2) {
#   par( mfg=c(i,j) )
#   axis(1, xloc, xlab)
#}}

### CLEANUP
dev.off()
# Leave just hpc.
rm (fn, outFile, cc, xlab, xloc, i, lc)