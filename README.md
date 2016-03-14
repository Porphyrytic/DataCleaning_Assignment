## Getting and Cleaning Data Course Project

### Repository Contents:
* README.md - Description of the project
* CodeBook.txt - Description of the dataset created by run_analysis.R script
* run_analysis.R - A script that merges, cleans and re-organizes the files from the UCI HAR Dataset into a tidy summary dataset
* Analysis.txt - The tidy output of run_analysis.R script. 

### Data Source

Human Activity Recognition Dataset created by, and courtesy of:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data was downloaded: 13th March, 2016

## Running the script:

The run_analysis.R script assumes your working directory is the parent directory of the dataset (originally named 'UCI HAR Dataset' but this name is not necessary for the script to work) .

It can be run using the following command:

source('working_directory/run_analysis.R')

The script assumes that the original directory structure of the zipped dataset has been preserved following decompression.  In particular, the following files must be found:

In the parent directory:
* 'features.txt': List of all features/variables.
* 'activity_labels.txt': Links the class labels with their activity name.

In the train sub-directory:
* 'train/X_train.txt': Training data set.
* 'train/y_train.txt': Training activity labels.
* 'train/subject_train.txt: Identifies the Individual Subjects in the training group.

In the test sub-directory:
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test activity labels.
* 'test/subject_test.txt: Identifies the Individual Subjects in the test group.

The script will create two data frames (Table_1 and Table_2) and write out Table_2 as "Analysis.txt".  All other intermediate data is removed during processing.

## Outputs

### Table_1 - Data Frame in R
* Data from the Training (70% of test subjects) and Test (30% of test subjects) datasets were merged to create one Dataset with 30 test subjects.
* Each Row is an independent observation for one individual doing one activity. Multiple observations were taken per individual and per activity. (10299 Total Observations)
	* Activity index numbers were substituted with labels for clarity.
* Each Column is an independent measurement of a variable.
	* Variable names have been extended and edited to be more human-readable i.e. Time-Domain instead of 't'. Acceleration instead of 'acc' 
	* A subset of the total dataset has been taken: of the original 561 measurements only the 66 mean and standard deviation measurements were used for analysis
	* These variable were identified purely by mean() and std() labels in the original dataset. 
	* Other variables with "mean" values computed on windowed data or post-transformation (e.g. gravityMean) were ignored

### Table_2 - Data Frame in R
* Data from Table_1 were averaged for each individual and each activity.
* Each Row is the mean of all observations for one individual doing each of the six activities (180 combinations)
	* Activity index numbers were substituted with labels for clarity.
* Each Column is an independent measurement of a variable.
	* Variable names have been extended and edited to be more human-readable i.e. Time-Domain instead of 't'. Acceleration instead of 'acc' 
	* A subset of the total dataset has been taken: of the original 561 measurements only the 66 mean and standard deviation measurements were used for analysis
	* These variable were identified purely by mean() and std() labels in the original dataset. 
	* Other variables with "mean" values computed on windowed data or post-transformation (e.g. gravityMean) were ignored

### Analysis.TXT - Final Output (Text File)
* Variable (header) names are in the first row
* A description of the Variables can be found in the Code Book
* The output can be read using the following command run from the correct working directory:

	Test <- read.table("Analysis.txt",header = TRUE)