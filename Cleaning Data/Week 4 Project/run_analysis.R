# Getting and Cleaning Data
# Week 4 project
# Human Activity Recognition Using Smartphones Dataset

## clear the workspace and load relevant libraries
  rm(list=ls())
  library(plyr)
  library(dplyr)
  
## Download the dataset and unpack if it's not already in the current working directory
  
  if (!file.exists("UCI HAR Dataset")){
    url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url = url, destfile = "data.zip")
    unzip("data.zip")
    unlink("data.zip")
    rm(url)
  } 
  

## Initialise same variables to point to the data

  activity_labels<-".\\UCI HAR Dataset\\activity_labels.txt"
  feature_vector_labels<-".\\UCI HAR Dataset\\features.txt"
  
  training_subject_id<-".\\UCI HAR Dataset\\train\\subject_train.txt"
  training_activity_id<-".\\UCI HAR Dataset\\train\\y_train.txt"
  training_feature_vector<-".\\UCI HAR Dataset\\train\\X_train.txt"
  
  test_subject_id<-".\\UCI HAR Dataset\\test\\subject_test.txt"
  test_activity_id<-".\\UCI HAR Dataset\\test\\y_test.txt"
  test_feature_vector<-".\\UCI HAR Dataset\\test\\X_test.txt"

## First read in the label data to be added in to the training and test data sets
  activity_labels<-read.table(activity_labels, sep=" ",
                col.names = c("activity_id", "activity_type"))
  feature_vector_labels<-read.table(feature_vector_labels, sep=" ",
                              col.names = c("feature_id", "feature_name"))

## Read in the training data
  training_subject_id<-read.table(training_subject_id, sep="",
                                    col.names = c("subject_id"))
  training_activity_id<-read.table(training_activity_id, sep="",
                                  col.names = c("activity_id"))
  training_feature_vector<-read.table(training_feature_vector, sep="",
                                      col.names=as.character(feature_vector_labels[[2]]))

  # remove the ... from the names of the feature vector and make lower case
  names(training_feature_vector)<-gsub("\\.", "", tolower(names(training_feature_vector)))

  # include only columns from the feature vector that have mean or std in them
  training_feature_vector<- training_feature_vector %>%
                            select(matches("mean|std"))
  
  # replace the activity integer values with activity labels and convert to a factor column
  training_activity_id$activity_id<-as.factor(plyr::mapvalues(training_activity_id$activity_id, 
                                  from=activity_labels[[1]],
                                  to=as.character(activity_labels[[2]])))
  # make the subject_id a factor column
  training_subject_id$subject_id<-as.factor(training_subject_id$subject_id)
  # make a new column to indicate this is the training dataset
  training_subject_id$dataset<-rep("training", nrow(training_subject_id))
  
## put them all together in a single dataframe and remove unwanted objects
  
  training<-cbind(training_subject_id, training_activity_id, training_feature_vector)
  rm(training_subject_id, training_activity_id, training_feature_vector)

  
  
## Read in the test data
  test_subject_id<-read.table(test_subject_id, sep="",
                                  col.names = c("subject_id"))
  test_activity_id<-read.table(test_activity_id, sep="",
                                   col.names = c("activity_id"))
  test_feature_vector<-read.table(test_feature_vector, sep="",
                                      col.names=as.character(feature_vector_labels[[2]]))
  
  # remove the ... from the names of the feature vector and make lower case
  names(test_feature_vector)<-gsub("\\.", "", tolower(names(test_feature_vector)))
  
  # include only columns from the feature vector that have mean or std in them
  test_feature_vector<- test_feature_vector %>%
    select(matches("mean|std"))
  
  # replace the activity integer values with activity labels and convert to a factor column
  test_activity_id$activity_id<-as.factor(plyr::mapvalues(test_activity_id$activity_id, 
                                                              from=activity_labels[[1]],
                                                              to=as.character(activity_labels[[2]])))
  # make the subject_id a factor column
  test_subject_id$subject_id<-as.factor(test_subject_id$subject_id)
  # make a new column to indicate this is the test dataset
  test_subject_id$dataset<-rep("test", nrow(test_subject_id))
  
  ## put them all together in a single dataframe and remove unwanted objects
  test<-cbind(test_subject_id, test_activity_id, test_feature_vector)
  rm(test_subject_id, test_activity_id, test_feature_vector)
  
## Make a single dataframe called har_data from training and test and remove unwanted objects

  har_data<-rbind(training, test)
  har_data<-dplyr::arrange(har_data, subject_id)
  rm(training, test, activity_labels, feature_vector_labels)
  
## Create a second dataset which gives the mean of all columns grouped by subject and activity  
  har_average<-ddply(har_data, .(subject_id, activity_id), numcolwise(mean))
  
## Save the har_average dataset into a file for submission  
  write.table(har_average, "har_average.txt", row.name=FALSE) 