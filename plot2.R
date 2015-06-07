# plot2.R
# This script creates a line plot of the Global Active Power for 1 Jul and 2
# Jul, 2007 from the data in the file identified by fn.  The plot is saved to
# the file identified as outfile.  The input data is left in the workspace as a
# dataframe, hpc.

library(dplyr)

### FILENAMES
fn = "household_power_consumption.txt"
outFile = "plot2.png"

### LOAD THE DATA
cc <- c( rep("character",2), rep("numeric", 7) )
hpc <- filter( read.table(fn, header=T, na.strings="?", colClasses=cc, sep=";"),
         Date=="1/2/2007" | Date=="2/2/2007" )
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

### CREATE THE PLOT
png(outFile)

# without tick marks on the x axis
plot(hpc$Global_active_power, type="l", ylab="Global Active Power (kilowatts)",
         xaxt="n")

# prepare x axis tick marks
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
xlab <- weekdays(xlab, T)
axis(1, xloc, xlab)

### CLEANUP
dev.off()
# Leave just hpc.
rm (fn, outFile, cc, xlab, xloc, i)