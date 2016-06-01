if(!file.exists("./data"))  {
  dir.create("./data")
  zip.file.url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  local.file.url <- "power.zip"
  download.file(zip.file.url,local.file.url, method="curl")
  unzip(local.file.url,exdir = "./data")
}

library(sqldf)

filecon <- file("./data/household_power_consumption.txt")
data <- sqldf("select * from filecon where Date ='1/2/2007' or Date = '2/2/2007'",file.format = list(header = TRUE, sep = ";"))
data <- transform(data, Date = as.Date(Date,"%d/%m/%Y"))
data <- transform(data, Datetime = as.POSIXct(paste(Date,Time)))

# plot3.png
png(filename = "plot3.png",width = 480, height=480)
with(data, {
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Global Active Power (kilowatts)")
  lines(Sub_metering_2 ~ Datetime, col="Red")
  lines(Sub_metering_3 ~ Datetime, col="Blue")
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

