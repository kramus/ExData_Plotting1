##Getting Data
if(!file.exists(".\\data")) {dir.create(".\\data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = ".\\data\\household_power_consumption.zip")
file <- unzip(".\\data\\household_power_consumption.zip")

#Read first 10 rows
df <- fread(file, sep = ";", na.strings = "?",nrows = 10)
#create a vector of the variable names
colnames <- names(df)
#create the beginning date
begin_date <- strptime("16/12/2006 17:24:00", "%d/%m/%Y %H:%M:%S")
#Create the beginning date of the data we want
end_date <- strptime("1/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")
#Calculate how many rows do we need to skip. Every row increase 1 min.
skip <- as.numeric((end_date - begin_date)*60*24 + 1)
#amount of mins in a day
rows <- 2*60*24
#Read file including skip and nrows arguments
df <- fread("household_power_consumption.txt", sep = ";", na.strings = "?", 
            skip = skip, nrows = rows, col.names = colnames)



#Creating date_time variable
#Load package
if(!require(lubridate)){
        install.packages("lubridate")
}
require(lubridate)

#Create variable
df$date_time <- dmy_hms(paste(df$Date, df$Time))



#Plot 3
with(df, plot(date_time, Sub_metering_1, type = "n", 
              ylab = "Energy sub metering",cex.lab = 0.8, 
              xlab = "", cex.axis = 0.8))
with(df, points(date_time, Sub_metering_1, type = "l"))
with(df, points(date_time, Sub_metering_2,  type = "l", col = "red"))
with(df, points(date_time, Sub_metering_3,  type = "l", col = "blue"))
legend("topright", col = c("black","red","blue"), lwd = 1, cex = 0.8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()


