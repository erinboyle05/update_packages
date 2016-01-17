complete<-function(directory="C:\\Users\\cs\\Dropbox\\Connected Blue\\Training\\data science\\git\\datascience\\R-Programming\\week 2\\rprog-data-specdata\\specdata", id=1:332) {
  # Prepare to read in files from directory
  library(readr)
  files=list()
  for (i in id) {
    fn<-paste(sprintf("%03d", i),".csv",sep="")
    files<-c(files,file.path(directory, fn, fsep = "\\"))
  } # creates a list of files to read
  filedata <- lapply(files, read_csv) # Puts all the files into filedata variable
  #
  result<-data.frame(id=integer(0), nobs=integer(0)) # result data frame to return
  for (d in filedata){       # go through each file
    d<-d[complete.cases(d),] # filter out observations with NA  
    nobs<-nrow(d)            # how many clean rows
    if (nobs>0){
      id=d[[1,4]]              # extract id of file
    }
    result[nrow(result)+1,]<-c(id,nobs)  # append to result data frame
    }
  # calculate and return the result variable
  result
}