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