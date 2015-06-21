# Getting and Cleaning Data

## Description

This codebook contains additional information about the variables, data and transformations done to the data for the Johns Hopkins Getting and Cleaning data course project.

## Data Set Information

The data set contains information from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on their waist. Using its embedded accelerometer and gyroscope, the 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.

## Variables

The following files are read into tables/data frames :
* features.txt
* activity_labels.txt
* x_train.txt
* y_train.txt
* subject_train.txt
* x_test.txt
* y_test.txt
* subject_test.txt

## Code Walkthrough

- The '_train' and '_test' files are combined to form the respective training and testing data sets 
  with appropriate labels of subject and activity IDs from the features, activity and subject files.
- The two data sets are then merged along with suitable labels to form a single data set.
- The variables containing the mean and standard deviation values for each measurement are then identified
  and the merged data set is reorganized to contain only those values.
- This data set is merged with the necessary activity names to give descriptive names to the various activities.
- Appropriate labels are given to the data set with descriptive variable names through substitution as required.
- A second, independent tidy-data set is then created and written into a separate text file,
  which contains the average values for each activity and each subject.

