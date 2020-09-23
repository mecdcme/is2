
checkAndInstall <- function(mypkg){
   if (! is.element(mypkg, installed.packages()[,1])) install.packages(mypkg)

  } 

options(repos = "http://cran.r-project.org")

print("Loading libraries...")

#checkAndInstall("validate")
#checkAndInstall("validatetools")
#checkAndInstall("errorlocate")
#checkAndInstall("univOutl")
#checkAndInstall("simputation")
#checkAndInstall("VIM")
#checkAndInstall("rspa")
#checkAndInstall("varhandle")
checkAndInstall("SeleMix")
library("SeleMix")
checkAndInstall("jsonlite")
library("jsonlite")

print("Loading libraries...ok ")