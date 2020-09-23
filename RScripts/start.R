
#Install Rserve
#install.packages("Rserve", repos="http://cran.r-project.org")
install.packages('Rserve',,"http://rforge.net/",type="source")
#Include Rserve library
library(Rserve)

#Start Rserve
run.Rserve(debug = TRUE, 6311, args = NULL, config.file = "Rserv.conf") #Port can also be specified in the configuration file.
source ("libraries.R")
