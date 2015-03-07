# define data as a file with indicated format 
data = file("./exdata-data-household_power_consumption/household_power_consumption.txt") 
attr(data, "file.format") = list(sep = ";", header = TRUE) 

# use sqldf to read it in keeping only data from the dates 2007-02-01 and 2007-02-02. 
data.df = sqldf("select * from data where substr(Date, -4)|| '-' ||substr('0' || replace(substr(Date, instr(Date, '/') + 1, 2), '/', ''), -2)|| '-' || substr('0' || replace(substr(Date, 1, 2), '/', ''), -2)  between '2007-02-01'and '2007-02-02' ") 

#plot4
data.df$datetime = as.POSIXct(paste(as.Date(data.df$Date, "%d/%m/%Y"), data.df$Time))
png("plot4.png", width=480, height=480, bg="transparent")
par(mfrow = c(2,2))
#top left
plot(data.df$Global_active_power ~ data.df$datetime,type="l",xlab = "", ylab="Global Active Power")
#top right
plot(data.df$Voltage ~ data.df$datetime,type="l", xlab="datetime",ylab="Voltage")
#bottom left
plot(data.df$Sub_metering_1 ~ data.df$datetime,type="l", xlab="",ylab="Energy sub metering")
lines(data.df$Sub_metering_2 ~ data.df$datetime,type="l", xlab="",ylab="",col="red")
lines(data.df$Sub_metering_3 ~ data.df$datetime,type="l", xlab="",ylab="",col="blue")
legend("topright", lty=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),bty="n", cex=0.95)
#bottom right
plot(data.df$Global_reactive_power~ data.df$datetime, type="l", xlab="datetime",ylab="Global_reactive_power")

dev.off()

rm(list=ls())