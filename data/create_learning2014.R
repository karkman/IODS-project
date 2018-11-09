# 6.11.2018 
# Antti Karkman
# The R script file for exercise 2, data taken from: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

# load the libraries
library(dplyr)

# read in the data
learning2014 <- read.table(file="http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# the structure of the data
str(learning2014)

# dimensions of the data
dim(learning2014)

# add age, gender, attitude and points to a new data frame
analysis2014 <- learning2014[, c("Age", "Attitude", "Points", "gender")]

# the combinations
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# the analysis dataset 
deep_columns <- select(learning2014, one_of(deep_questions))
analysis2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(learning2014, one_of(surface_questions))
analysis2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(learning2014, one_of(strategic_questions))
analysis2014$stra <- rowMeans(strategic_columns)

# remove all observations with zero points
analysis2014 <- filter(analysis2014, Points>0)

# check that the dimensions match 166 x 7
dim(analysis2014)
# GREAT!!!

# now set the working directory to the IODS folder and write the analysis2014 as a tab separated file to the data folder
setwd("~/Work/IODS-project")
write.table(analysis2014, file="data/analysis2014.txt", sep="\t", quote = FALSE, col.names = TRUE, row.names=FALSE)

# read the file back to R
TMP <- read.table("data/analysis2014.txt", header=TRUE)
dim(TMP)

# all good!
