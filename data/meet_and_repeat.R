# Data wrangling for exercise 6
# Antti Karkman
# 4.12.2018

# Load tidyverse that inludes most packages needed
library(tidyverse)

# Load the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header=TRUE, sep=" ")
names(BPRS)
str(BPRS)
dim(BPRS)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header=TRUE, sep="\t")
names(RATS)
str(RATS)
dim(RATS)

# Categorial variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert data to long form and add variables for time 
BPRSL <- BPRS %>% gather(key=weeks, value=bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))

RATSL <- RATS %>% gather(key=WD, value=Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3,4))) 

# Check the differences between the long and wide forms
names(BPRS)
names(BPRSL)
str(BPRS)
str(BPRSL)
dim(BPRS)
dim(BPRSL)
summary(BPRS)
summary(BPRSL)

names(RATS)
names(RATSL)
str(RATS)
str(RATSL)
dim(RATS)
dim(RATSL)
summary(RATS)
summary(RATSL)

# I think I have understood the fundamental differences between the long and wide formats

# write out the data
write.table(BPRSL, "Work/IODS-project/data/BPRSL.txt", sep="\t", col.names = TRUE)
write.table(RATSL, "Work/IODS-project/data/RATSL.txt", sep="\t", col.names = TRUE)

