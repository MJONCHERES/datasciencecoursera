# Download files in the working directory

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir = "dataset")

# Check files are in the working directory 

list.files(file.path("./dataset"))

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get total emissions par year 
totalemissions<- aggregate(Emissions ~ year, NEI, sum)

# Build the plot with totals on top of each bar and save it in a PNG file
png("plot1.png")
plot1<-barplot(totalemissions$Emissions/1000, names.arg = totalemissions$year,
            xlab = "years", ylab = "total emissions in kilotons", ylim=c(0,8000),
            main = "Yearly emissions in kilotons")
text(x = plot1, y = round(totalemissions$Emissions/1000,0), label = round(totalemissions$Emissions/1000,0), pos = 3, cex = 0.8, col = "black")
dev.off()
