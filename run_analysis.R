## ============================================================================
## Getting and Cleaning Data
## ============================================================================
## Course Project
## ----------------------------------------------------------------------------
## 2015-01-23, Shibdas Roy
## ============================================================================

## Get the training data
trainData <- read.table(file="./UCI HAR Dataset/train/X_train.txt")

## Get the features as a character vector
ftrs <- read.table(file="./UCI HAR Dataset/features.txt")
features <- as.character(ftrs$V2)

## Label the columns of the training data with the corresponding features
names(trainData) <- features

## Get the subjects for every measurement in training data
sbjt1 <- read.table(file="./UCI HAR Dataset/train/subject_train.txt")

## Add a subject column in training dataset
trainData$subject <- as.factor(sbjt1$V1)

## Get the activities for every measurement in training data
actv1 <- read.table(file="./UCI HAR Dataset/train/y_train.txt")

## Add an activity id column in training dataset
trainData$actv_id <- actv1$V1


## Get the test data
testData <- read.table(file="./UCI HAR Dataset/test/X_test.txt")

## Label the columns of the test data with the corresponding features
names(testData) <- features

## Get the subjects for every measurement in test data
sbjt2 <- read.table(file="./UCI HAR Dataset/test/subject_test.txt")

## Add a subject column in test dataset
testData$subject <- as.factor(sbjt2$V1)

## Get the activities for every measurement in test data
actv2 <- read.table(file="./UCI HAR Dataset/test/y_test.txt")

## Add an activity id column in test dataset
testData$actv_id <- actv2$V1


## Merge the training and test data into a single dataset
mergedData <- trainData
mergedData <- rbind(mergedData,testData)

## Get the activity labels
activity_labels <- read.table(file="./UCI HAR Dataset/activity_labels.txt")

## Get the complete dataset for the raw data
completeData <- merge(mergedData,activity_labels,by.x="actv_id",by.y="V1")

## Name the column with descriptive activity appropriately
names(completeData)[length(names(completeData))] = "activity"

## Get a logical vector corresponding to the required columns
reqdColumns <- grepl("[Mm]ean|[Ss]td|^activity$|^subject$",names(completeData))

## Get the tidy dataset
tidyData <- completeData[,reqdColumns]

## Write the tidy dataset into a text file
write.table(tidyData,file="./tidy_data.txt",row.names=FALSE)