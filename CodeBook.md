#CodeBook: Getting and Cleaning Data Course Project
### Created by Stefanie Verhulst on October 15, 2015
This code book describes the variables, the data, and the transformations performed to clean up the data for the **Getting and Cleaning Data** course project.
The original dataset used in this assignment is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
## Contents of Original Dataset
Constructing the tidy dataset directly uses the following files from the original dataset, which can be described as follows:

* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

##Steps Performed to Obtain Tidy Dataset
1. Download the original dataset [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
2. Extract the files from the downloaded .zip-file in the same folder that contains the R script "run_analysis.R", which transforms the raw data into a tidy dataset.
     * Ensure all files are contained in a folder named "UCI HAR Dataset".
     * Do not change the internal map structure of the "UCI HAR Dataset" folder.
The R script called "run\_analysis.R" performs the following steps on the original dataset to obtain a tidy dataset: 
3. Merges the training and the test sets to create one data set.
     * The files "X\_train.txt" and "X\_test.txt" are merged horizontally.
     * Column names are extracted from "features.txt" and added to the dataset.
4. Extracts only the measurements on the mean and standard deviation for each measurement. 
     * The means and standard deviation are extracted using the regular expression "mean|std", meaning those features with a capitalized "Mean" are not extracted. This is intended, as those features are angles and differ from the other features, and were thus chosen to be left out.
5. Uses descriptive activity names to name the activities in the dataset.
     * The activity labels are extracted from the files "y\_test.txt" and "y\_train.txt".
     * The extracted labels are merged horizontally to the dataset in a column named "Activity".
     * The numerical labels are replaced by factor labels as described in "activity\_labels.txt".
     * The factor labels are transformed to lower case and underscores are removed.
6. Appropriately labels the data set with descriptive variable names. 
     * An error in the feature names of the original dataset where "Body" appeared twice as "BodyBody" was fixed by replacing "BodyBody" with "Body".
     * The column names added in step 3 are now parsed to make them more descriptive as suggested in the course lectures and in [this](https://class.coursera.org/getdata-033/forum/thread?thread_id=126) course discussion forum thread.
     * This parsing involves replacing abbreviations such as "std" into their full form "StandardDeviation", etc. In addition, dots and capitalization of the column names is removed, resulting in variable names such as "timebodyaccelerationmeanx" and "activity" (now lower case), as suggested in the course lectures.
7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
     * To the dataset resulting from the steps above, the subjects from which the data were collected are added as a column named "subjectid".
     * The above dataset is then aggregated using the mean function, grouped by the activity and subjectid.
     * The dataset is written to a .txt file named "tidyData.txt" using write.table\(\).
     
##Tidy Data
The tidy data is stored in a .txt file named "tidyData.txt". Its structure is as follows:
* "activity": The action performed by the subject during measurement. Factor variable consisting of the possible values: "laying", "sitting", "standing", "walking", "walkingdownstairs" and "walkingupstairs".
* "subjectid": The numerical identifier for the subject studied. Factor variable consisting of all values between "1" and "30".
* 79 Features, averaged for each combination of activity and subject:
	* "timebodyaccelerationmeanx"
	* "timebodyaccelerationmeany"
	* "timebodyaccelerationmeanz"
	* "timebodyaccelerationstandarddeviationx"
	* "timebodyaccelerationstandarddeviationy"
	* "timebodyaccelerationstandarddeviationz"
	* "timegravityaccelerationmeanx"
	* "timegravityaccelerationmeany"
	* "timegravityaccelerationmeanz"
	* "timegravityaccelerationstandarddeviationx"   
	* "timegravityaccelerationstandarddeviationy"   
	* "timegravityaccelerationstandarddeviationz"   
	* "timebodyaccelerationjerkmeanx"    
	* "timebodyaccelerationjerkmeany"    
	* "timebodyaccelerationjerkmeanz"    
	* "timebodyaccelerationjerkstandarddeviationx"  
	* "timebodyaccelerationjerkstandarddeviationy"  
	* "timebodyaccelerationjerkstandarddeviationz"  
	* "timebodygyroscopemeanx"
	* "timebodygyroscopemeany"
	* "timebodygyroscopemeanz"
	* "timebodygyroscopestandarddeviationx" 
	* "timebodygyroscopestandarddeviationy" 
	* "timebodygyroscopestandarddeviationz" 
	* "timebodygyroscopejerkmeanx"       
	* "timebodygyroscopejerkmeany"       
	* "timebodygyroscopejerkmeanz"       
	* "timebodygyroscopejerkstandarddeviationx"     
	* "timebodygyroscopejerkstandarddeviationy"     
	* "timebodygyroscopejerkstandarddeviationz"     
	* "timebodyaccelerationmagnitudemean"
	* "timebodyaccelerationmagnitudestandarddeviation" 
	* "timegravityaccelerationmagnitudemean"
	* "timegravityaccelerationmagnitudestandarddeviation"      
	* "timebodyaccelerationjerkmagnitudemean"       
	* "timebodyaccelerationjerkmagnitudestandarddeviation"     
	* "timebodygyroscopemagnitudemean"   
	* "timebodygyroscopemagnitudestandarddeviation" 
	* "timebodygyroscopejerkmagnitudemean"  
	* "timebodygyroscopejerkmagnitudestandarddeviation"
	* "frequencybodyaccelerationmeanx"   
	* "frequencybodyaccelerationmeany"   
	* "frequencybodyaccelerationmeanz"   
	* "frequencybodyaccelerationstandarddeviationx" 
	* "frequencybodyaccelerationstandarddeviationy" 
	* "frequencybodyaccelerationstandarddeviationz" 
	* "frequencybodyaccelerationmeanfrequencyx"     
	* "frequencybodyaccelerationmeanfrequencyy"     
	* "frequencybodyaccelerationmeanfrequencyz"     
	* "frequencybodyaccelerationjerkmeanx"  
	* "frequencybodyaccelerationjerkmeany"
	* "frequencybodyaccelerationjerkmeanz"
	* "frequencybodyaccelerationjerkstandarddeviationx"
	* "frequencybodyaccelerationjerkstandarddeviationy"
	* "frequencybodyaccelerationjerkstandarddeviationz"
	* "frequencybodyaccelerationjerkmeanfrequencyx" 
	* "frequencybodyaccelerationjerkmeanfrequencyy" 
	* "frequencybodyaccelerationjerkmeanfrequencyz" 
	* "frequencybodygyroscopemeanx"
	* "frequencybodygyroscopemeany"
	* "frequencybodygyroscopemeanz"
	* "frequencybodygyroscopestandarddeviationx"
	* "frequencybodygyroscopestandarddeviationy"
	* "frequencybodygyroscopestandarddeviationz"
	* "frequencybodygyroscopemeanfrequencyx"
	* "frequencybodygyroscopemeanfrequencyy"
	* "frequencybodygyroscopemeanfrequencyz"
	* "frequencybodyaccelerationmagnitudemean"
	* "frequencybodyaccelerationmagnitudestandarddeviation"
	* "frequencybodyaccelerationmagnitudemeanfrequency"
	* "frequencybodyaccelerationjerkmagnitudemean"
	* "frequencybodyaccelerationjerkmagnitudestandarddeviation"
	* "frequencybodyaccelerationjerkmagnitudemeanfrequency"
	* "frequencybodygyroscopemagnitudemean"
	* "frequencybodygyroscopemagnitudestandarddeviation"
	* "frequencybodygyroscopemagnitudemeanfrequency"
	* "frequencybodygyroscopejerkmagnitudemean"
	* "frequencybodygyroscopejerkmagnitudestandarddeviation"
	* "frequencybodygyroscopejerkmagnitudemeanfrequency"
	