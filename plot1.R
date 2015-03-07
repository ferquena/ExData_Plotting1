library(sqldf) 

# define data as a file with indicated format 
data = file("./exdata-data-household_power_consumption/household_power_consumption.txt") 
attr(data, "file.format") = list(sep = ";", header = TRUE) 

# use sqldf to read it in keeping only data from the dates 2007-02-01 and 2007-02-02. 
data.df = sqldf("select * from data where substr(Date, -4)|| '-' ||substr('0' || replace(substr(Date, instr(Date, '/') + 1, 2), '/', ''), -2)|| '-' || substr('0' || replace(substr(Date, 1, 2), '/', ''), -2)  between '2007-02-01'and '2007-02-02' ") 

#plot1
png("plot1.png", width=480, height=480, bg="transparent")
hist(data.df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", ylab = "Frequency" , col = "red")
dev.off()


rm(list=ls())
