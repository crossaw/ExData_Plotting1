# plot2.R
# This script creates a plot of ... 

#from the Global_active_power column of the
# file idetified below as fn.  The histogram is saved to the file identified
# as outFile.  The input data is left in the workspace as a dataframe, hpc.

library(dplyr)

fn = "household_power_consumption.txt"
outFile = "plot1.png"

cc <- c( rep("character",2), rep("numeric", 7) )
if(F){
hpc <- filter( read.table(fn, header=T, na.strings="?", colClasses=cc, sep=";"),
      Date=="1/2/2007" | Date=="2/2/2007" )
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc$Time <- strptime(hpc$Time, "%H:%M:%S")
}
#png(outFile)
day <- weekdays(hpc$Date, T)
plot(hpc[,7], type="l", ylab="Energy sub-metering", xaxt="n")
lines(x=1:nrow(hpc), y=hpc[,8], col="red")
lines(x=1:nrow(hpc), y=hpc[,9], col="blue")

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
#lines(x=1:nrow(hpc), y=hpc[,8])

axis(1, xind, xlab)

#dev.off()

#rm (fn, outFile, cc)