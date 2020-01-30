library(tidyr)

# Project's data URL
zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


# Download the zip file
download.file(zip_url, destfile = "data.zip")


#####################################

# Read activity_labels
act_lab <- read.table(unz("data.zip", file.path("UCI HAR Dataset", "activity_labels.txt")))

# Read features
features <- read.table(unz("data.zip", file.path("UCI HAR Dataset", "features.txt")))


# Define a function to read train/test X/y
read_txt <- function(set, var) {
  if (!set %in% c("train", "test")) {
    stop("invalid set, try 'train' or 'test'")
  } else if (!var %in% c("X", "y")) {
    stop("invalid var, try 'X' or 'y'")
  } else {
    read.table(unz("data.zip", file.path("UCI HAR Dataset", set, paste0(var, "_", set, ".txt"))))
  }
}


# Read the data
subject_train <- read.table(unz("data.zip", file.path("UCI HAR Dataset", "train/subject_train.txt")))
train_X <- read_txt(set = "train", var = "X")
train_y <- read_txt(set = "train", var = "y")

subject_test <- read.table(unz("data.zip", file.path("UCI HAR Dataset", "test/subject_test.txt")))
test_X <- read_txt(set = "test", var = "X")
test_y <- read_txt(set = "test", var = "y")


# Modify colnames
  # From subject_*
  colnames(subject_train)[1] <- "subject"
  colnames(subject_test)[1] <- "subject"

  # From features
  colnames(train_X) <- features$V2
  colnames(test_X) <- features$V2  

  # From response
  colnames(train_y) <- "ActCode"
  colnames(test_y) <- "ActCode"
  
  colnames(act_lab) <- c("ActCode", "ActName")

#####################################################################
# 1 -  Merges the training and the test sets to create one data set.
##################################################################### 

  # Complete train data set (cbind)
  train <- cbind(subject_train, train_y, train_X)
  
  # Complete test data set (cbind)
  test <- cbind(subject_test, test_y, test_X)
  
  # Complete data set (rbind)
  data <- rbind(train, test)

#####################################################################
  
  
#####################################################################
# 2 - Extracts only the measurements on the mean and standard 
  #deviation for each measurement.
#####################################################################   
  
data <- data[,c(1, 2, grep("mean|std", names(data)))]

#####################################################################   

#####################################################################
# 3 -  Uses descriptive activity names to name the activities 
  #in the data set.
##################################################################### 
  
data <- merge(data, act_lab, by = "ActCode")  

##################################################################### 

# Clean environment
rm(list=setdiff(ls(), c("data"))) 
  
  
#####################################################################
# 4 -  Appropriately labels the data set with descriptive variable names
#####################################################################  

# Get colnames
colnames <- colnames(data)

# Remove some characters
colnames <- gsub("[\\(\\)]", "", colnames)

# Remove abbreviations
colnames <- gsub("^f", "freqDomain", colnames)
colnames <- gsub("^t", "timeDomain", colnames)
colnames <- gsub("Acc", "Accelerometer", colnames)
colnames <- gsub("Gyro", "Gyroscope", colnames)
colnames <- gsub("Mag", "Magnitude", colnames)

# Rename function name
colnames <- gsub("mean", "Mean", colnames)
colnames <- gsub("std", "StandardDeviation", colnames)

# Correct typo
colnames <- gsub("BodyBody", "Body", colnames)

# Change labels
colnames(data) <- colnames
  
  
#####################################################################
# 5 -  From the data set in step 4, creates a second, independent 
#tidy data set with the average of each variable for 
#each activity and each subject.
#####################################################################

result <- data %>%
  group_by(subject, ActName) %>%
  summarise_all(.funs = mean)

write.table(x = result, file = "tidy_data.txt", row.names = FALSE)
