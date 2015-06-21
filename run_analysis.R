setwd("UCI HAR Dataset/")

features <- read.table("features.txt", header = FALSE)
activity <- read.table("activity_labels.txt", header = FALSE)
colnames(activity) <- c("Activity_ID", "Activity_Type")

subjectTrain <- read.table("train/subject_train.txt", header = FALSE)
xTrain <- read.table("train/X_train.txt", header = FALSE)
yTrain <- read.table("train/y_train.txt", header = FALSE)

colnames(subjectTrain) <- "subject_ID"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "Activity_ID"

trainData <- cbind(yTrain, subjectTrain, xTrain)

subjectTest <- read.table("test/subject_test.txt", header = FALSE)
xTest <- read.table("test/X_test.txt", header = FALSE)
yTest <- read.table("test/y_test.txt", header = FALSE)

colnames(subjectTest) <- "subject_ID"
colnames(xTest) <- features[,2]
colnames(yTest) <- "Activity_ID"

testData <- cbind(yTest, subjectTest, xTest)

finalData <- rbind(trainData, testData)
colNames <- colnames(finalData)

req_feat = (grepl("Activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

finalData <- finalData[req_feat == TRUE]
finalData <- merge(finalData, activity, by = "Activity_ID",all.x = TRUE)
colNames <- colnames(finalData)

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

colnames(finalData) <- colNames

re_finalData  = finalData[, names(finalData) != 'Activity_Type']

tidyData = aggregate(re_finalData[, names(re_finalData) != c("Activity_ID","subject_ID")], by=list(Activity_ID=re_finalData$Activity_ID, subject_ID = re_finalData$subject_ID), mean)

tidyData = merge(tidyData, activity, by = 'Activity_ID', all.x = TRUE)

write.table(tidyData, './tidyData.txt', row.names = FALSE, sep='\t')
