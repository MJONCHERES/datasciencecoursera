# Download files in the working directory

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir = "dataset")

# Check files are in the working directory 

list.files(file.path("./dataset"))

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get yearly emissions from motor vehicles in Baltimore first, LA second, then merge

motorbaltimore <- NEI[(NEI$fips=="24510") & (NEI$type =="ON-ROAD"),]
mbalt <- aggregate(Emissions ~ year+fips, motorbaltimore, sum)
mbalt$fips[mbalt$fips=="24510"] <- "Baltimore City"

motorLA <- NEI[(NEI$fips=="06037") & (NEI$type =="ON-ROAD"),]
mLA <- aggregate(Emissions ~ year+fips, motorLA, sum)
mLA$fips[mLA$fips=="06037"] <- "Los Angeles"
motorBaltLA <- rbind(mbalt, mLA)

# Build the plot with totals on top of each bar and save it in a PNG file
png("plot6.png")
ggplot(motorBaltLA, aes(x=factor(year),  y=Emissions, fill = year, label = round(Emissions,0))) +
  geom_bar(stat = "identity") + facet_grid(.~fips) +      
  labs(x = "years", y = "total emissions in kilotons", title = "Yearly emissions from motor vehicle sources in Baltimore vs. Los Angeles") +
  geom_label(aes(fill = year),colour = "white", fontface = "bold")
dev.off()