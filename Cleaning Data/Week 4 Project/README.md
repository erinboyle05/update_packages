# Getting and Cleaning Data
# Week 4 project
# Human Activity Recognition Using Smartphones Dataset

This project contains a number of files to simplify and tidy the HAR dataset

* CodeBook.md describes the cleaning process and all the variable names used in the resulting file.
* run_analysis.R runs the cleaning process on the dataset.  Note that if the data set isn't already present in the current working directory, it will be downloaded.

After running the script, two additional files appear in the working directory:

* UCI HAR Dataset directory containing all the raw data
* har_average.txt with the tidy mean values for each subject and activity

The R environment will also contain two tidy dataframes that can be used for further analysis:

* har_data which is the combined training and test data
* har_average which is the grouped means of the subjects by activity
