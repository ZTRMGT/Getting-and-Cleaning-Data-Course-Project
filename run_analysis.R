# Load the library

library(data.table)
library(dplyr)

# Check if the UCI HAR Dataset folder exist or not

dataset_folder <- "UCI HAR Dataset"
if(!file.exists(dataset_folder)) {
  stop(paste(dataset_folder, "folder not found ! Please download and extract the data into UCI HAR Dataset folder"))
}

# 1. Merges the training and the test sets to create one data set.

train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")

test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
  
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(labels) <- c("activity_id", "activity")
  
features <- read.table("./UCI HAR Dataset/features.txt", as.is = TRUE)

train <- cbind(train_subject, train_x, train_y)
test <- cbind(test_subject, test_x, test_y)
dataset <- rbind(train, test)
  
# Remove objects to save memory
rm(train_subject, train_x, train_y, test_subject, test_x, test_y, train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

colnames(dataset) <- c("Subject", features[[2]], "Activity")
col <- grepl("Subject|Activity|mean|std", colnames(dataset))
dataset <- dataset[, col]

# 3. Uses descriptive activity names to name the activities in the data set
  
dataset$Activity <- factor(dataset$Activity, levels = labels[[1]], labels = labels[[2]])

# 4. Appropriately labels the data set with descriptive variable names.

colnames(dataset) <- gsub("^t", "Time", colnames(dataset))
colnames(dataset) <- gsub("^f", "Frequency", colnames(dataset))
colnames(dataset) <- gsub("BodyBody", "Body", colnames(dataset))
colnames(dataset) <- gsub("Acc", "Accelerometer", colnames(dataset))
colnames(dataset) <- gsub("Gyro", "Gyroscope", colnames(dataset))
colnames(dataset) <- gsub("Mag", "Magnitude", colnames(dataset))
colnames(dataset) <- gsub("-meanFreq\\(\\)", " (MeanFrequency)", colnames(dataset))
colnames(dataset) <- gsub("-mean\\(\\)", " (Mean)", colnames(dataset))
colnames(dataset) <- gsub("-std\\(\\)", " (STD)", colnames(dataset))

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the averageof each variable for each activity and each subject.

dataset <- data.table(dataset)

# Create the tidy data

tidy <- dataset %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))

# Output the tidy data into tidy_data.txt file

write.table(tidy, file = "tidy_data.txt", row.names=FALSE, na="", sep=",")
