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

# plot1.png
png(filename = "plot1.png",width = 480, height=480)
hist(data$Global_active_power,col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
