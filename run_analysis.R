# Setting the working directory
setwd("UCI HAR Dataset/")

## STEP 1 : Merge the training and test data sets to create one data set 

# Reading the required variables of features and activities
features <- read.table("features.txt", header = FALSE)
activity <- read.table("activity_labels.txt", header = FALSE)

# Giving names to columns of the activity dataset
colnames(activity) <- c("Activity_ID", "Activity_Type")

# Reading the Training set data
subjectTrain <- read.table("train/subject_train.txt", header = FALSE)
xTrain <- read.table("train/X_train.txt", header = FALSE)
yTrain <- read.table("train/y_train.txt", header = FALSE)

# Giving appropriate names to the columns of the Training set data
colnames(subjectTrain) <- "subject_ID"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "Activity_ID"

# Binding the various data into a single Training set data
trainData <- cbind(yTrain, subjectTrain, xTrain)

# Reading the Testing set data
subjectTest <- read.table("test/subject_test.txt", header = FALSE)
xTest <- read.table("test/X_test.txt", header = FALSE)
yTest <- read.table("test/y_test.txt", header = FALSE)

# Giving appropriate names to the columns of the Testing set data
colnames(subjectTest) <- "subject_ID"
colnames(xTest) <- features[,2]
colnames(yTest) <- "Activity_ID"

# Binding the various data into a single Testing set data
testData <- cbind(yTest, subjectTest, xTest)

# Merging and curating the Training and Testing datasets into a single data set
finalData <- rbind(trainData, testData)

# Creating a vector to store the column names of the merged data set
colNames <- colnames(finalData)
#-----------------------------------------------------------------------------------------#

## STEP 2 : Extract measurements on the mean and standard deviation for each measurement

# Creating a variable to store the logical values for the required variables of mean and standard deviations for each measurement
req_feat = (grepl("Activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Extracting the required values from the cumulative dataset to form the required dataset
finalData <- finalData[req_feat == TRUE]
#-----------------------------------------------------------------------------------------#

## STEP 3 : Use descriptive activity names to name the activites in the data set

# Merging the required data sorted by their respective Activity IDs and naming the activities accordingly
finalData <- merge(finalData, activity, by = "Activity_ID",all.x = TRUE)

# Updating the vector to store the newly included activity names
colNames <- colnames(finalData)
#-----------------------------------------------------------------------------------------#

## STEP 4 : Appropriately labels the data set with descriptive variable names

#  Substituting the variable names in the vector containing them (colNames), with more apt labels
for (i in 1:length(colNames)) 
{
    colNames[i] = gsub("\\()","",colNames[i])
    colNames[i] = gsub("-std$","StdDev",colNames[i])
    colNames[i] = gsub("-mean","Mean",colNames[i])
    colNames[i] = gsub("^(t)","time",colNames[i])
    colNames[i] = gsub("^(f)","freq",colNames[i])
    colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
    colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
    colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

# Using the new labels to name the various columns in the data set appropriately
colnames(finalData) <- colNames
#----------------------------------------------------------------------------------------#

## STEP 5 : Create a second, independent tidy data set with the average of each variable for each activity and each subject

# Refining the data set to exclude the factor variable 'Activity_Type' 
re_finalData  = finalData[, names(finalData) != 'Activity_Type']

# Creating a tidy data set by calculating the required averages by activity and subject, using the 'Activity_ID' & 'subject_ID' variables from the refined data set
tidyData = aggregate(re_finalData[, names(re_finalData) != c("Activity_ID","subject_ID")], by=list(Activity_ID=re_finalData$Activity_ID, subject_ID = re_finalData$subject_ID), mean)

# Adding the activity IDs to create the final tidy data set
tidyData = merge(tidyData, activity, by = 'Activity_ID', all.x = TRUE)

# Writing the tidy data set to a text file named 'tidyData'
write.table(tidyData, './tidyData.txt', row.names = FALSE, sep='\t')
