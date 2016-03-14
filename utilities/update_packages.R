# Some simple functions to help transfer packages between R installations.
#
# This will run in whatever the current working directory is, so if you want
# to save the package information somewhere specific, then setwd() to that place.
#
# To save a list of currently installed packages, run:
#       save_package_info()
# 
# This will create a file called current_packages.rda by default (which you can overide
# if you want)
# 
# To see differences between a previous package configuration and the currently installed
# packages, run:
#       package_difference()
# This will read a file from disk with the previous packages on (again the default is 
# current_packages.rda, but you can specifiy another) and return a list of differences
#
# To reload the packages from a previous saved list, run:
#       reload_packages()
# specifying a filename where the previous package list can be found if it's not the 
# default.
#
# The script will try CRAN first and then if there are any packages it couldn't load
# it will try bioconductor.
#
# A typical use case:
#    If you install a new version of R, say 3.2.4 and you were previously running
#    R version 3.2.3, then the new version won't contain the packages you were using
#    before.
#    
#    The following steps will get you up to date:
#               1.  Start previous version of R
#               2.  Set working directory to where this script is
#               3.  Source the script
#               4.  Run save_package_info()
#               5.  Start the new version of R
#               6.  Set working directory to where this script is and source the script
#               7.  Run reload_packages

save_package_info <- function (package_file="./current_packages.rda") {
        
        # get list of currently installed packages and save current date and time
        current_packages = as.data.frame(installed.packages())
        current_packages$as_at<-rep(Sys.Date(), nrow(current_packages))
        
        # save the dataframe to disk
        saveRDS(current_packages, file=package_file)        
        
}

reload_packages <- function (...) {
        
        new_packages_to_install <- package_difference(...)
        # install standard packages
        lapply(new_packages_to_install, install.packages)
        # see if there are any remaining packages and try biocLite
        remaining_packages <- package_difference(...)
        source("https://bioconductor.org/biocLite.R")
        biocLite(remaining_packages)
}

package_difference <- function (package_file="./current_packages.rda") {
        
        packages_from_file=readRDS(package_file)
        current_packages = as.data.frame(installed.packages())
        
        installed <- current_packages$Package
        previous <- packages_from_file$Package
        
        # return a vector of packages installed previously not in current setup
        as.character(previous[!(previous %in% installed)])
}