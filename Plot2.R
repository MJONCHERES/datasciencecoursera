# Download files in the working directory

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir = "dataset")

# Check files are in the working directory 

list.files(file.path("./dataset"))

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get total emissions per year in Baltimore 
baltimore <- subset(NEI, fips=="24510")
emissionsbaltimore<- aggregate(Emissions ~ year, baltimore, sum)

# Build the plot with totals on top of each bar and save it in a PNG file
png("plot2.png")
plot2<-barplot(emissionsbaltimore$Emissions, names.arg = emissionsbaltimore$year,
               xlab = "years", ylab = "total emissions in tons", ylim=c(0,4000),
               main = "Yearly emissions in Baltimore")
text(x = plot2, y = round(emissionsbaltimore$Emissions,0), label = round(emissionsbaltimore$Emissions,0), pos = 3, cex = 0.8, col = "black")
dev.off()