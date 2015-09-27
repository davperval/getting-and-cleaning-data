# Load needed libraries
library(data.table)
library(reshape2)

# Download & unzip data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = ".\\data.zip")
unzip(".\\data.zip")

# Load features & activities
features <- read.table(".\\UCI HAR Dataset\\features.txt", header=FALSE, col.names = c("id", "name"))
selectedFeatures <- c(grep("mean", features$name), grep("std", features$name))
activities <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", header=FALSE, col.names = c("id", "name"))

# Load train data
train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", col.names=features$name)
train <- train[, selectedFeatures]
trainSubjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", header=FALSE, col.names=c("id"))
train$subject <- trainSubjects$id
trainActivities <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", header=FALSE, col.names=c("id"))
train$activity <- trainActivities$id

# Load test data
test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", col.names=features$name)
test <- test[, selectedFeatures]
testSubjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", header=FALSE, col.names=c("id"))
test$subject <- testSubjects$id
testActivities <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", header=FALSE, col.names=c("id"))
test$activity <- testActivities$id

# Merge train & test data
mergedData <- rbind(train, test)

# Factorizing activity field
mergedData$activity <- factor(mergedData$activity, levels = activities$id, labels = activities$name)

# Generate independent tidy data set with the average of each variable for each activity and each subject
meltData <- melt(mergedData, id=c("subject", "activity"))
finalData <- dcast(meltData, subject + activity ~ variable, mean)
write.table(finalData, row.names = FALSE, file=".\\dataset.txt")
