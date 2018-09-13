---
title: "Getting and Cleaning Data Course Project Assignment"
output: html_document
---

## About this repository

This repository contains the following files:

1. ```README.md```: this readme file
2. ```CodeBook.md```: the code book which describes each column of the data set
3. ```run_analysis.R```: R script used to create tidy data set

## What does the run_analysis.R script do

* Locates ```UCI HAR Dataset``` folder and loads the data inside it
* Merges the data into one data set
* Extracts only the mean and standard deviation data
* Process the data with descriptive labels
* Process the data with the average of each variable for each activity and each subject
* Generate ```tidy_data.txt```

## Instruction

1. Download https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract the zip file to folder where ```run_analysis.R``` script is located
3. Make sure ```UCI HAR Dataset``` is located in the same folder as ```run_analysis.R``` script
4. Run ```run_analysis.R``` script
5. ```tidy_data.txt``` will be generated in the same folder as the ```run_analysis.R``` script 