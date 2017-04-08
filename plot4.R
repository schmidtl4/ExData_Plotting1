#download file, unzip and load data 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "hh_power.zip")
hhpower <- read.csv(unzip("hh_power.zip"),
                    na.strings="?",
                    header = TRUE,sep=";",
                    stringsAsFactors = FALSE)

#add column with character date converted to POSIXlt
    hhpower$dtm = strptime(hhpower$Date,format="%d/%m/%Y")

#subset the values needed for plotting, omitting na rows
    pvals = subset(hhpower,dtm == '2007-02-01' | dtm == "2007-02-02")
    pvals <- na.omit(pvals)

#prepare to plot; set to single plot
par(mfrow=c(2,2),mai=c(0.7,0.8,0.4,0.2))

#plot the data - upper left
    plot(1:2880,
         pvals$Global_active_power,
         type="l",
         ylab="Global Active Power (kilowatts)",
         pty="s",
         xaxt="n",
         xlab="",
         cex.lab = 1.0,
         las=1)
    axis(side=1,
         at=c(1,1440,2880),
         labels=c("Thu","Fri","Sat"))

#plot the data - upper right
    plot(1:2880,
         pvals$Voltage,
         type="l",
         ylab="Voltage",
         pty="s",
         xaxt="n",
         xlab="datetime",
         cex.lab = 0.9,
         mgp=c(2.2,0.6,0),
         las=1)
    axis(side=1,
         at=c(1,1440,2880),
         labels=c("Thu","Fri","Sat"),
         cex.axis = 0.8)

#plot the data - lower left
    plot(1:2880,
         pvals$Sub_metering_1,
         type="S",
         xaxt="n",
         xlab="",
         ylab="Energy sub metering",
         cex.lab = 1.0,
         las=1)
    
    points(1:2880,pvals$Sub_metering_2,type="S",col="red")
    
    points(1:2880,pvals$Sub_metering_3,type="S",col="blue")
    
    legend("topright",
           lty=c(1,1,1),
           col=c("black","red","blue"),
           c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           pt.cex = 1,
           cex = 0.8,
           bty="n")
    
    axis(side=1,
         at=c(1,1440,2880),
         labels=c("Thu","Fri","Sat"))

#plot the data - lower right
    plot(1:2880,
         pvals$Global_reactive_power,
         type="l",
         pty="s",
         xaxt="n",
         ylab="Global_reactive_power",
         xlab="datetime",
         cex.lab = 0.9,
         mgp=c(2.2,0.6,0),
         las=1)
    axis(side=1,
         at=c(1,1440,2880),
         labels=c("Thu","Fri","Sat"),
         cex.axis = 0.8)

#copy plots to file
    dev.copy(png,"plot4.png",width=480, height=480)
    
#close device
dev.off()
