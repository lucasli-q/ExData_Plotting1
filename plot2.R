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

##Making plot2
windows()
with(powercons,plot(completedate,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))

##Copying to graphic device - .png file device
dev.copy(png, file="plot2.png",width=480,height=480)
dev.off()
