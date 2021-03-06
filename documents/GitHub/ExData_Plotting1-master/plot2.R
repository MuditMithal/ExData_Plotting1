#set directory to that with household_power_consumption.txt
setwd("C:/Users/muditmithal/Documents")

# load libraries
library(data.table)
library(lubridate)


# read from source file limiting only 2 days
variable.class<-c(rep('character',2),rep('numeric',7))
power.consumption<-read.table('household_power_consumption.txt',header=TRUE,
                              sep=';',na.strings='?',colClasses=variable.class)
power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]

# tidy up data
cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
        'SubMetering1','SubMetering2','SubMetering3')
colnames(power.consumption)<-cols
power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
power.consumption<-power.consumption[,c(10,3:9)]

# write tidy data to file new_power_consumption.txt
write.table(power.consumption,file='new_power_consumption.txt',sep=';',row.names=FALSE)

dir.create('plot 2')

png(filename='plot 2/plot2.png',width=480,height=480,units='px')

plot(power.consumption$DateTime,power.consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

# Close off graphic device
x<-dev.off()