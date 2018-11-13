# Antti Karkman, 13.11.2018. 
# Creating the data for analysing students alcohol consumption. 
# Data from here: https://archive.ics.uci.edu/ml/datasets/Student+Performance


# read in the data 
math = read.table("data/student-mat.csv", sep=";", header=TRUE)
por = read.table("data/student-por.csv", sep=";", header=TRUE)

# explore the data
str(math)
dim(math)
str(por)
dim(por)
