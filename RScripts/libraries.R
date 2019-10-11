
checkAndInstall <- function(mypkg){
   if (! is.element(mypkg, installed.packages()[,1])) install.packages(mypkg)
  } 

options(repos = "https://cran.stat.unipd.it/")

print("Loading libraries...")
checkAndInstall("validate")
checkAndInstall("validatetools")
checkAndInstall("errorlocate")

print("Loading libraries...ok ")