#THis program assume the household power consumption file is in the working directory of the program
#and is already downloaded
#Loading the data
my_power_data<-read.csv("household_power_consumption.txt", sep = ";",na.strings = "?")


# Converting the date to Date as the data set class is factor
my_power_data$Date <- as.Date(my_power_data$Date, "%d/%m/%Y")
#my_power_data$Time <-strptime(as.character(my_power_data[,2]), format = "%H:%M:%S")

#subsetting the dataset to only incldude the first two days of February
my_2day_power<-subset(my_power_data,my_power_data$Date == as.Date("2007-02-01","%Y-%m-%d")  | my_power_data$Date == as.Date("2007-02-02","%Y-%m-%d"))

#Converting to a numeric for Hist to work
my_2day_power$Global_active_power <-as.numeric(my_2day_power$Global_active_power)
my_2day_power$Sub_metering_1 <-as.numeric(my_2day_power$Sub_metering_1)
my_2day_power$Sub_metering_2 <-as.numeric(my_2day_power$Sub_metering_2)
my_2day_power$Sub_metering_3 <-as.numeric(my_2day_power$Sub_metering_3)
#my_2day_power$Global_active_power <-as.numeric(my_2day_power$Global_active_power)
#my_2day_power$Time <-strptime(as.character(my_2day_power[,2]), format = "%H:%M:%S")

#Creating a DateTime field for plot 2,3, and 4
my_2day_power$DateTime<- with(my_2day_power,as.POSIXct(paste(Date, Time), format="%Y-%m-%d%H:%M:%s"))

#Plot 3 START
png(filename = "plot3.png",width=480, height=480)
plot(range(my_2day_power$DateTime),c(0,35),xlab="",ylab="Energy sub metering",type="n",yaxt="n")
axis(2,at=c(0,10,20,30))
lines(Sub_metering_1~DateTime,data = my_2day_power,col="black")
lines(Sub_metering_2~DateTime,data = my_2day_power,col="red")
lines(Sub_metering_3~DateTime,data = my_2day_power,col="blue")

#setting the legend text variable from the names of the data frame
leg_text<-names(my_2day_power)[7:9]
legend("topright",leg_text, lty=c(1,1,1),col=c("black","blue","red"),lwd=c(2.5,2.5,2.5))
dev.off()
