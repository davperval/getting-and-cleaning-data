### run_analysis.R
This script does the following:

1. Download and unzip the raw data file from this url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  * Skip this step if the raw data file is already in the working directory
2. Load the list of the features and activities
  * The list of features are used after for the columns names of the train and test data
  * The list of activities are used after for the levels and labels of the factor column activity
3. Load train data, select only "mean" and "std" features and add the subject and activity columns
4. Load test data, select only "mean" and "std" features and add the subject and activity columns
5. Merge train and test data
6. Factorize the activity field
7. Generate independent tidy data set with the average of each variable for each activity and each subject
 
### CodeBook.md
This file contents the description of each variable in the tidy data set obtained after running the script run_analysis.R
