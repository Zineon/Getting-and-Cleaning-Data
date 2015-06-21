# Getting-and-Cleaning-Data

## Overview

This repository contains the necessary files for the submission of Johns Hopkins' Getting and Cleaning Data course project.

The purpose of this project is to collect, work with, clean and curate a data set. The goal is to prepare a tidy data set that can be used for further analysis. The data used for this project represents the data collected from the accelerometers from Samsung Galaxy S smartphone. A full description is available at  [The UCI Machine Learning Repository] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Files

This repository contains the following files:
* run_analysis.R : script containing the code for cleaning the data and creating the required tidy data set.
* README.md : markdown file describing the files contained in the repo, how they are related and how they function.
* codebook.md : markdown file describing the variables, the data, and the transformations / work performed to clean up the data.
* tidyData.txt : the output tidy data set as a text file.

## Project Summary

The R script run_analysis.R, when run in the directory containing the required data, performs the following functions:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set.
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
