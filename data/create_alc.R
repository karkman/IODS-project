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

# define the columns to be used for joining and join the two datasets
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", 
             "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

math_por <- inner_join(math, por, by=join_by, suffix = c(".math", ".por"))

# explore the joined data
str(math_por)
dim(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Average the weekday and weekend use to make a new column and define also the heavy users
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# take a glimpse
glimpse(alc)
# the data fram has 382 observations and 35 variable.

# we can save the data for the analysis part
write.table(alc, "data/alc_data.txt", sep="\t", col.names=TRUE, quote=FALSE)
