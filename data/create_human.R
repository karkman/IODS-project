## 21.11.2018
## Antti Karkman
## Creation of human dataset from http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/

# libraries
library(dplyr)

# Read in the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# structure and dimensions of the data
str(hd)
dim(hd)
summary(hd)
str(gii)
dim(gii)
summary(gii)

# Rename and shorten the variables 
colnames(hd) <- c("HDI.Rank", "Country", "HDI", "LifeExp", "ExpEdu", "MeanEdu", "GNI", "GNI-HDI")
colnames(gii) <- c("GII.Rank", "Country", "GII", "MatMort", "AdolBirth", "PercInParl", "Pop2EduF", "Pop2EduM", "LabFRateF", "LabFRateM")

# Mutate gii data
gii <- mutate(gii, EduFperM = Pop2EduF/Pop2EduM)
gii <- mutate(gii, LabFperM = LabFRateF/LabFRateM)

# Join the two datasets by country
human <- inner_join(hd,gii , by="Country")

# check that it has the right dimensions and save the data
str(human)
write.table(human, file="Work/IODS-project/data/human.txt", sep="\t", col.names = TRUE)
# And that's it.

## Second part of the data wranling

# Read in the data
human <- read.table("Work/IODS-project/data/human.txt", sep="\t", header=TRUE)
str(human)

# mutate the data
library(stringr)
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()
keep_columns <- c("Country", "Pop2EduF", "LabFperM", "ExpEdu", "LifeExp", "GNI", "MatMort", "AdolBirth", "PercInParl")
human <- dplyr::select(human, one_of(keep_columns))
human <- filter(human, complete.cases(human)==TRUE)

# The last 7 rows relate to regions and need to be removed
human <- head(human, -7)
# Country as row name and remove the country column
row.names(human) <- human$Country
human <- dplyr::select(human, -Country)

# Save the data
write.table(human, file="Work/IODS-project/data/human.txt", row.names = TRUE, col.names = TRUE, sep="\t")
