#
# helper function to download datasets to the current working directory
# Inputs:
# url - url of dataset 
# filename - the filename that the data should be stored on disk
# datasetname - the name of the dataset.  This could be different to filename,
#               for example an unzipped file might have a different name to the download
# zipdelete - if true, then a downloaded zip is deleted after sucessfully unzipping

library(tools)

download_dataset<-function(url, filename="data", datasetname="", zipdelete=TRUE) {

  # Don't do anything if the dataset is already present in the working directory
  if ((file.exists(filename) | file.exists(datasetname))){
      return()
  } 

  download.file(url = url, destfile = filename)
  if (file_ext(filename)=="zip") {
    unzipfile <- tryCatch(
      unzip(filename),
      error=function(e) e
    )
    # remove the zip file if there are no unzip errors
    if(!inherits(unzipfile, "error")) {
      unlink(filename)
    }
  }
}