# *Getting and Cleaning Data* Course Project

# __Code Book__

This __Code Book__ refers to the `tidy_data.txt` file that can be found in this repository.

## The Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ  
- tGravityAcc-XYZ  
- tBodyAccJerk-XYZ  
- tBodyGyro-XYZ  
- tBodyGyroJerk-XYZ  
- tBodyAccMag  
- tGravityAccMag  
- tBodyAccJerkMag  
- tBodyGyroMag  
- tBodyGyroJerkMag  
- fBodyAcc-XYZ  
- fBodyAccJerk-XYZ  
- fBodyGyro-XYZ  
- fBodyAccMag  
- fBodyAccJerkMag  
- fBodyGyroMag  
- fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

- mean(): Mean value  
- std(): Standard deviation

__The variable names were modified to make them more descriptive__

## The Data
`tidy_data.txt` contains 180 rows and 82 columns.

Each row contains information for each subject-activity combination.

The first column, __subject__, identifies the subject.

__ActName__ and __ActCode__ identifies the label and code of the activity.

The rest of the columns are numeric, and show the mean of each measurement.

## The Work

To get to `tidy_data.txt`I performed the following tasks:

- I downloaded the zip file.

- I created an R dataframe for each of these files:
  - `activity_labels.txt`  
  - `features.txt`  
  - `subject_train.txt`  
  - `X_train.txt`  
  - `y_train.txt`  
  - `subject_test.txt`  
  - `X_test.txt`  
  - `y_test.txt` 

- I changed the colname of `subject_train` and `subject_test` to __subject__.

- I used the values in `features.txt` to modify the colnames of `X_train.txt` and `X_test.txt`.

- I changed the colname of `y_train.txt` and `y_test.txt` to __ActCode__.

- I changed the colnames of `activity_labels.txt` to __ActCode__ and __ActName__.

- I created a `train` dataset by column-binding `subject_train`, `y_train` and `X_train`.

- I created a `test` dataset by column-binding `subject_test`, `y_test` and `X_test`.

- I row-binded `train` and `test` to create `data`, the __merged__ dataset.

- I extracted only the measurements on the mean and standard deviation for each measurement.

- I added the __ActName__ column to `data`, to describe the name the activities in __ActCode__.

- I appropriately labeled the dataset with descriptive variable names, by removing some characters, replacing abbreviations and renaming functions names.

- I created `tidy_data.txt` by grouping `data` by __subject__ and __ActName__, and computed the mean of each of the selected variables.
