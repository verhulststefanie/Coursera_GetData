# Getting and Cleaning Data Course Project
This README file explains how the script "run_analysis.R", found in this GitHub repository, works.
## Prerequisites
The requirements for running this file are as follows:
* You must have R installed.
* You must place the "run_analysis.R" script in your R working directory.
* The original dataset, which can be obtained [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), needs to be unpacked into the R working directory in the folder "UCI HAR Dataset". 
* Do not change the internal map structure of the "UCI HAR Dataset" folder.

In addition, your R installation needs to have the following packages installed,
as they are loaded in and used by the script:
* plyr
* dplyr
* qdap

## Running the Script
In your R console, type the following:
    source("run_analysis.R")
    createTidyDataset()

## Generated Output
A tidy dataset is written to a .txt file named "tidyData.txt" using write.table\(\). This dataset is generated using the following steps, as described in more detail in the "CodeBook.md" which can also be found in this repository.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.