# Getting and Cleaning Data
# Week 4 project
# Human Activity Recognition Using Smartphones Dataset

## Initial analysis of available data

The study samples 30 volunteers, divided into two groups:  train and test (70%/30% respectivley).  There are 7352 observations in the train set and 2947 in the test set.  Each observation has a number of variables as follows:

* Subject id:  between 1 and 30.  This is found in the subject_[train|test].txt file
* Activity id: between 1 and 6.  This is found in the y_[train|test].txt file
    * The activity names are mapped in the file activity_labels.txt
* Feature vector:  This has 561 different measurements, each described in the features.txt file

## Objective #1:  Merge the data sets test and train into one, and clean the column names

The strategy here is to read in all the data for subject, activity and the feature vector into individual data frames.  The following transformations are made across both training and test datasets:

* subject is named subject_id and turned into a factor.  An additional column is added to indicate whether it is from the test or training set originally.
* activity is replaced with the text values and also converted into a factor
* the columns of the feature vector are derived as follows:
    * the names in features.txt have the () and - removed and converted to lowercase
    * any column with mean or std in the name is retained and all others are discarded
    * This results in 86 columns being retained

The three dataframes above are concatenated column-wise to form a single training and test dataset.

Finally, training and test are concatenated row-wise into a single dataset named har_data.

## Objective #2:  Create a tidy subset summarising the mean values of each measurement for each subject

Once the har_data set is created, the ddply command can be used to make groupings of the data by subject and activity.

The numcolwise function is a handy way to apply a summary function over numeric columns in a dataframe.

## Codebook for variables

The variables used in the har_data are as follows:

* _subject_id_.  This is a range between 1 and 30 and identifies which partipant the observation refers to
* _dataset_.  This determines whether the participant is part of the training set or the test set
* _activity_id_.  This is a character string that indicates the activity undertaken.  It is one of "WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
*  fields 4 - 89 are derived from the feature vector in the original dataset as described above.  They are always lower case and indicate either a mean or standard deviation value of a number of different measurements from the equipment.


