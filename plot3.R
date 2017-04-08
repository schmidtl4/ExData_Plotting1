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
par(mfrow=c(1,1))

#set output file
png(file="plot3.png",width=480,height=480)

#plot the data
plot(1:2880,
     pvals$Sub_metering_1,
     type="S",
     xaxt="n",
     xlab="",
     ylab="Energy sub metering")

points(1:2880,pvals$Sub_metering_2,type="S",col="red")

points(1:2880,pvals$Sub_metering_3,type="S",col="blue")
legend("topright",
       lty=c(1,1,1),
       col=c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       pt.cex = 1,
       cex = 0.9)


axis(side=1,
     at=c(1,1440,2880),
     labels=c("Thu","Fri","Sat"))

#close device
dev.off()