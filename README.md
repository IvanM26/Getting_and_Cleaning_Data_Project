# Getting and Cleaning Data Course Project

This repository contains the following files:

- `README.md`, which provides an overview of the dataset and how it was created.  
- `CodeBook.md`, which describes the variables, the data, and the work I performed to clean up the data.  
- `run_analysis.R`, the R script used to create `tidy_data.txt`.  
- `tidy_data.txt`, the tidy dataset that had to be submitted.

## The Dataset
`tidy_data.txt` is created from [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), a dataset that contains data collected from the accelerometers from the Samsung Galaxy S smartphone.

To obtain `tidy_data.txt`, I followed these steps:

- Merged train and test data to create one dataset (I had to perform column and row binds).  
- Extracted measurements on the mean and standard deviation for each measurement.  
- Averaged the measurements for each subject and activity.  

