pollutantmean<-function(directory="C:\\Users\\cs\\Dropbox\\Connected Blue\\Training\\data science\\git\\datascience\\R-Programming\\week 2\\rprog-data-specdata\\specdata", pollutant, id=1:332) {
  # Prepare to read in files from directory
  library(readr)
  files=list()
  for (i in id) {
    fn<-paste(sprintf("%03d", i),".csv",sep="")
    files<-c(files,file.path(directory, fn, fsep = "\\"))
  } # creates a list of files to read
  filedata <- lapply(files, read_csv) # Puts all the files into filedata variable
  result<-filedata[[1]][[pollutant]] # extract the values for the pollutant column from the first file
  for (d in filedata[-1]){       
    result<-c(result, d[[pollutant]])  # append all the pollutant values from the remaining files onto the result variable
  }
  # calculate and return the mean of the result variable
  result<-as.numeric(result)
  #result
  mean(result, na.rm = TRUE)
}