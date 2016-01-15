#test_data<-read.table(file="C:\\Users\\cs\\Dropbox\\Connected Blue\\Training\\data science\\git\\datascience\\R-Programming\\week1\\bristol_spend.csv", sep=",",header=TRUE, nrows=21)

#coltypes=sapply(test_data, class)

#all_data<-read.table(file="C:\\Users\\cs\\Dropbox\\Connected Blue\\Training\\data science\\git\\datascience\\R-Programming\\week1\\bristol_spend.csv", colClasses=coltypes, sep=",",header=TRUE, fill=TRUE)

library(readr)
test_data<-read_csv(file="C:\\Users\\cs\\Dropbox\\Connected Blue\\Training\\data science\\git\\datascience\\R-Programming\\week1\\bristol_spend.csv")


