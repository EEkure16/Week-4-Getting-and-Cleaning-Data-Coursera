library(plyr)

# ONE
# Merges the training and the test sets to create one data set.
#
data_x_test <- read.table("test/X_test.txt")
data_y_test <- read.table("test/y_test.txt")
data_subject_test <- read.table("test/subject_test.txt")


data_x_train <- read.table("train/X_train.txt")
data_y_train <- read.table("train/y_train.txt")
data_subject_train <- read.table("train/subject_train.txt")


# Merges  X train and X test data to create an 'x' data set
test_train_x_data <- rbind(x_train, x_test)

# Merges y train and y test data to create a 'y' data set
test_train_y_data <- rbind(y_train, y_test)

# Merges subject train data and subject test data to create 'subject' data set
test_train_subject_data <- rbind(subject_train, subject_test)

# TWO
# Extract only the measurements on the mean and standard deviation for each measurement
##

features_data <- read.table("features.txt")

# This code extracts only columns with mean or standard deviation in their names
features_data_mean_SD <- grep("-(mean|std)\\(\\)", features_data[, 2])

# This code will subset those columns with mean and SD
test_train_x_data <- test_train_x_data[, features_data_mean_SD]

# correct the column names
names(test_train_x_data) <- features[features_data_mean_SD, 2]

# THREE
# Use descriptive activity names to name the activities in the data set
#

activities <- read.table("activity_labels.txt")

# update values with correct activity names
test_train_y_data[, 1] <- activities[test_train_y_data[, 1], 2]

# correct column name
names(test_train_y_data) <- "activity"

# FOUR
# Appropriately label the data set with descriptive variable names
#

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(test_train_x_data, test_train_y_data, subject_data)

# FIVE
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# 66 <- 68 columns but last two (activity & subject)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)