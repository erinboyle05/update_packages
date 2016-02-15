#
# helper function to download datasets to the current working directory
# Inputs:
# url - url of dataset 
# filename - the filename that the data should be stored on disk
# datasetname - the name of the dataset.  This could be different to filename,
#               for example an unzipped file might have a different name to the download
# zipdelete - if true, then a downloaded zip is deleted after sucessfully unzipping
# gitignore - if true, then the downloaded files will be added to .gitignore for the 
#             current directory so they won't get included in the commits

library(tools)

download_dataset<-function(url, filename="data", datasetname="",
                           zipdelete=TRUE, gitignore=TRUE) {

  # Don't do anything if the dataset is already present in the working directory
  if ((file.exists(filename) | file.exists(datasetname))){
      return()
  } 
  zipfilecontents<-""
  
  # get the file and save it
  download.file(url = url, destfile = filename)
  
  # for zip files, attempt to extract and delete the original zip
  if (file_ext(filename)=="zip") {
      zipfilecontents<-unzip(filename, list=TRUE)[["Name"]]    
      unzipfile <- tryCatch(
                unzip(filename),
                warning=function(e) e
                )
      # remove the zip file if there are no unzip warnings and zipdelete is TRUE
      if(!inherits(unzipfile, "warning") & zipdelete) {
                unlink(filename)
      }
  }
  
  # add downloaded datafile names to gitignore
  if(gitignore)  add_to_gitignore(c(filename, zipfilecontents))
}


#
# A similar function to write a dataset in the current directory
# and add to .gitignore
#
create_dataset<-function(df, filename, gitignore=TRUE, ...){
        write.table(df, filename, ...)
        if(gitignore)  add_to_gitignore(filename)
}



add_to_gitignore<-function(new_files_to_ignore){
        gitignore<-".gitignore"
        ensure_file_exists(gitignore)
        # get current contents
        current_files_to_ignore<-readLines(gitignore)
        # make new contents, eliminating any duplicates
        new_contents<-unique(c(new_files_to_ignore, current_files_to_ignore))
        # write new gitignore file
        writeLines(new_contents, gitignore)
}

ensure_file_exists <-function(file){
        # if a filename doesn't exist, create a zero byte one
        if(!file.exists(file)){
                write.table(data.frame(), file=file, col.names=FALSE)
        }
}
