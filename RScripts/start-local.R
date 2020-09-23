
#Install Rserve
install.packages("Rserve", repos="http://cran.r-project.org",type="source")
#install.packages('Rserve',,"http://rforge.net/",type="source")
#Include Rserve library
library(Rserve)

#Start Rserve
run.Rserve(debug = TRUE, 6311, args = NULL, config.file = "Rserv.cfg") #Port can also be specified in the configuration file.
source ("libraries.R")
