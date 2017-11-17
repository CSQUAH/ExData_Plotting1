## Setting working directory to my local path

## Step 1: Download and unzip files if not exists
setwd("D:/001_DS/ExData_Plotting1")
if(!file.exists("household_power_consumption.txt"))
{
      ## i. Download data from data source
      url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url,destfile="./HousePwrConsump.zip",mode="wb") 
      ## ii. Unzip file
      unzip("HousePwrConsump.zip",overwrite=TRUE,unzip="internal",setTimes=FALSE)
}

## Step 2: Create subset dataset with data from only 1/2/2007 and 2/2/2007 if not exists
if(!(exists('epc') && is.data.frame(get('epc'))))
{
      ## i. Read file
      hhpwr <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings = "?",fill=T)
      
      ## ii.Subset data
      epc <- subset(hhpwr,Date %in% c("1/2/2007","2/2/2007")) 
}

## Step 3: create graph

# 1 create png file with 480*480 pixels
png(filename="plot4.png", width=480, height=480, units= "px")

# 2 Define parameter for datetime
datetime <- strptime(paste(epc$Date,epc$Time,sep=' '),'%d/%m/%Y %H:%M:%S')

# 3 Use par with the parameter mfrow set equal to the vector (2,2) to set up the plot window for graph
par(mfrow=c(2,2))
    
# 4 plot grahs
      # graph1
      plot(datetime,epc$Global_active_power,type='l',xlab='',ylab='Global Active Power')
      
      # graph2
      plot(datetime,epc$Voltage,type='l',xlab='datetime',ylab='Voltage')
      
      # graph3
      plot(datetime,epc$Sub_metering_1,type='l',xlab='',ylab='Energy sub metering')
      lines(datetime,epc$Sub_metering_2,type='l',col='red')
      lines(datetime,epc$Sub_metering_3,type='l',col='blue')
      legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")
      
      # graph4
      with (epc,plot(datetime,Global_reactive_power,type='l',xlab='datetime'))


# 5 close dev to save
dev.off()
