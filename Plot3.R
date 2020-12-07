# Download files in the working directory

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir = "dataset")

# Check files are in the working directory 

list.files(file.path("./dataset"))

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get total emissions per year per type of pollution in Baltimore 
baltimore <- subset(NEI, fips=="24510")
baltimorepertype<- aggregate(Emissions ~ year+type, baltimore, sum)

# Build the plot and save it in a PNG file
png("plot3.png")
ggplot(data=baltimorepertype, aes(x=factor(year),  y=Emissions, fill = type)) +
              geom_bar(stat = "identity") + facet_grid(. ~ type) +             
              labs(x = "years", y = "total emissions in tons", title = "Yearly emissions in Baltimore per source type")
dev.off()