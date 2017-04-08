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
png(file="plot2.png",width=480,height=480)

#plot the data
plot(1:2880,
     pvals[,"Global_active_power"],
     type="l",
     ylab="Global Active Power (kilowatts)",
     pty="s",
     xaxt="n",
     xlab="")
axis(side=1,
     at=c(1,1440,2880),
     labels=c("Thu","Fri","Sat"))

#close device
dev.off()
