
## File Download Routine
temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, temp)

dateDownloaded <-date()
print(dateDownloaded)

cran <- unz(temp, "household_power_consumption.txt")
plotdata <- read.table(cran, sep=";", header= TRUE, skip = 66636, nrows = 2880)
unlink(temp)

addname <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(plotdata) <- addname
str(plotdata)


df <- plotdata
df$Date <- as.Date(as.character(df$Date), format="%d/%m/%Y")
library(lubridate)
df$DateTime <- ymd_hms(paste(df$Date, df$Time))
str(df)
png("plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))
with(df,{
  plot(df$DateTime, df$Global_active_power, xlab ="", ylab = "Global Active Power", type = "l")
  plot(df$DateTime, df$Voltage, xlab ="datetime", ylab = "Voltage", type = "l")
  plot(df$DateTime, df$Sub_metering_1, xlab ="", ylab = "Energy sub metering", type = "l", col = "black")
       with(subset(df), points(df$DateTime, df$Sub_metering_2 , xlab ="", ylab ="", col = "red", type = "l"))
       with(subset(df), points(df$DateTime, df$Sub_metering_3 , xlab ="", ylab ="", col = "blue", type = "l"))
       legend("topright", pch = "-", lty = 1, lwd =3, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(df$DateTime, df$Global_reactive_power, xlab ="datetime", ylab = "Global_reactive_power", type = "l")
  
})
  

dev.off()


