## Merges the training and the test sets to create one data set.
## Appropriately labels the data set with descriptive variable names.
mergeTrainTest <- function() {
     pathTrain <- file.path("UCI HAR Dataset","train","X_train.txt")
     pathTest <- file.path("UCI HAR Dataset","test","X_test.txt")
     pathNames <- file.path("UCI HAR Dataset","features.txt")
     csvNames <- read.delim(pathNames, sep=" ", fill=TRUE, header=FALSE, as.is=TRUE)
     csvTrain <- read.csv(pathTrain, sep="",header=FALSE,col.names=csvNames$V2)
     csvTest <- read.csv(pathTest, sep="",header=FALSE,col.names=csvNames$V2)
     rbind(csvTrain,csvTest)
}

## Extracts only the measurements on the mean and standard deviation for each 
## measurement.
extractMeanStd <- function(dataset) {
     # dont match capitalized "Mean": those features are angles
     dataset[,grepl("mean|std",names(dataset))] 
}

## Uses descriptive activity names to name the activities in the data set
descriptiveNames <- function(data) {
     pathTrain <- file.path("UCI HAR Dataset","train","y_train.txt")
     pathTest <- file.path("UCI HAR Dataset","test","y_test.txt")
     pathActLabels <- file.path("UCI HAR Dataset","activity_labels.txt")
     csvLabels <- read.delim(pathActLabels, sep=" ", fill=TRUE, 
                             header=FALSE, as.is=TRUE)
     csvTrain <- read.csv(pathTrain, sep="\n",header=FALSE)
     csvTest <- read.csv(pathTest, sep="\n",header=FALSE)
     labels <- rbind(csvTrain,csvTest)
     library(plyr)
     labels <- sapply(mapvalues(labels$V1,
                                from = csvLabels$V1, 
                                to = csvLabels$V2),tolower)
     data <- cbind("Activity"=sapply(labels,
                                     FUN=function(x) {gsub("_", "", x)}), data)
     data$Activity = factor(data$Activity)
     data
}

## Appropriately labels the data set with descriptive variable names.
## This function has many formatting options commented out:
## this is because I did not like the aesthetics of the resulting variable names.
## Only the one I liked is active.
addLabels <- function(data) {
     ## make names more descriptive: this results in very long variable names..
     ## but is suggested by the TAs:
     ## https://class.coursera.org/getdata-033/forum/thread?thread_id=126
     library(qdap)
     rep <- list("Acc","std","Freq","^t","^f","Mag","Gyro",
                 "BodyBody")
     reps <- c("Acceleration","StandardDeviation","Frequency",
               "time","frequency","Magnitude","Gyroscope",
               "Body")
     names(data) <- sapply(X=names(data),
                           FUN=function(x) {
                                mgsub(rep,reps,x,fixed=FALSE)
                           },USE.NAMES = FALSE)
     ## removes dots, removes capitalization
     names(data) <- sapply(X=names(data),
                           FUN=function(x) {
                                tolower(gsub("[.]","",x))
                                },USE.NAMES = FALSE)
     ## replaces dots with spaces: not advised
#      names(data) <- sapply(X=names(data),
#                           FUN=function(x) {gsub("[.]"," ",x)},
#                           USE.NAMES = FALSE)
     ## removes dots and capitalizes next letter: not advised
#      names(data) <- sapply(X=names(data),
#                           FUN=function(x){
#                                gsub("([\\.]+)([[:alpha:]]|$)", 
#                                     "\\U\\2", x, perl=TRUE)},
#                           USE.NAMES = FALSE)
     data
}

## Creates a second, independent tidy data set with the average
## of each variable for each activity and each subject.
createTidyDataset <- function() {
     dataset <- mergeTrainTest()
     means <- extractMeanStd(dataset)
     labeledData <- descriptiveNames(means)
     labeledData <- addLabels(labeledData)
     subjectTrain <- file.path("UCI HAR Dataset","train","subject_train.txt")
     subjectTest <- file.path("UCI HAR Dataset","test","subject_test.txt")
     trainsubs <- read.delim(subjectTrain, sep=" ", fill=TRUE, header=FALSE, 
                             as.is=TRUE)
     testsubs <- read.delim(subjectTest, sep=" ", fill=TRUE, header=FALSE, 
                            as.is=TRUE)
     data <- cbind("SubjectID"=rbind(trainsubs,testsubs)$V1,labeledData)
     data$SubjectID <- factor(data$SubjectID)
     library(dplyr)
     # table <- with(data,tapply(data[,-(1:2)],c(activity,SubjectId),mean)
     table <- aggregate(data[,-(1:2)],by=
                    list("activity"=data$activity,
                         "subjectid"=data$SubjectID),mean)
     write.table(table,file="tidyData.txt",row.name=FALSE)
     table
}
