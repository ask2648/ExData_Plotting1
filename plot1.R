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

str(df)
png("plot1.png", width = 480, height = 480, units = "px")
hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", ylab = "Frequency", col = "Red")
#png("plot1.png", width = 480, height = 480, units = "px")
dev.off()
