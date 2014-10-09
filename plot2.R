if(!file.exists("plot")){
  dir.create("plot")
}
setwd("D:/BigData/RLWD/plot/")
getwd()
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
png("plot2.png", width = 480, height = 480, units = "px")
plot(df$DateTime, df$Global_active_power, xlab ="", ylab = "Global Active Power (Kilowatts)", type = "l")
dev.off()
