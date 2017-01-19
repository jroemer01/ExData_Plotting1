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

#opening a PNG file on the local file system
png(filename = "plot2.png", width=480, height=480)

plot(Global_active_power~DateTime,my_2day_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
#close the file
dev.off()

