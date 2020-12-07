# Download files in the working directory

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir = "dataset")

# Check files are in the working directory 

list.files(file.path("./dataset"))

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get total US emissions per year coming from coal combustion
coal <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector, ignore.case = T),]
coalemissions <- NEI[NEI$SCC %in% coal$SCC,]
totalCoal <- aggregate(Emissions ~ year, coalemissions, sum)


# Build the plot with totals on top of each bar and save it in a PNG file
png("plot4.png")
ggplot(totalCoal, aes(x=factor(year),  y=Emissions/1000, fill = year, label = round(Emissions/1000,0))) +
  geom_bar(stat = "identity") +              
  labs(x = "years", y = "Emissions in kilotons", title = "US yearly emissions from coal combustion-related sources") +
  geom_label(aes(fill = year),colour = "white", fontface = "bold")
  dev.off()