##downloading zip file
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./hhpowerconsumption.zip")

##unzipping file
unzip("./hhpowerconsumption.zip")

##reading only rows of interest - 01/02/2007-00:00 to 02/02/2007-23:59
powercons<-read.table("./household_power_consumption.txt", skip=66637,nrows=2880, header=F,sep=";",na.string=c("?"), comment.char="")
##renaming variables with the original names
colnames(powercons)<-read.table("./household_power_consumption.txt",nrows=1,header=F,sep=";")

##turning Date variable from character class to Date class
str(powercons$Date)
library(lubridate)
powercons$Date<-dmy(powercons$Date)

##Joining Date and Time variables
powercons$completedate<-paste(powercons$Date,powercons$Time)
str(powercons$completedate)

##Transforming completedate variable from character class to POSIXct class
powercons$completedate<-as.POSIXct(strptime(powercons$completedate, "%Y-%m-%d %H:%M:%S"))

##Arranging 4 plots into the same window
par(mfcol=c(2,2),mar=c(4,4,2,1))

##Making plot2 again
with(powercons,plot(completedate,Global_active_power,type="l",ylab="Global Active Power",xlab=""))

##Making plot3 again
colnames(powercons)
with(powercons,plot(completedate,Sub_metering_1,type="l",ylab="Energy Sub Metering",xlab=""))
with(powercons, lines(completedate,Sub_metering_2,col="red"))
with(powercons, lines(completedate,Sub_metering_3,col="blue"))
#Annotating legends in plot3
legend(list(x=30,y=30),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c("solid","solid","solid"),col=c("black","red","blue"))

##Making plot4
with(powercons,plot(completedate,Voltage,type="l",ylab="Voltage",xlab="datetime"))

##Making plot5
with(powercons,plot(completedate,Global_reactive_power,type="l",ylab="Voltage",xlab="datetime"))

##Copying to graphic device - .png file device
dev.copy(png, file="plot4.png",width=480,height=480)
dev.off()
