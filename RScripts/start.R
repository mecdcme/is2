
options(repos = "https://cran.mirror.garr.it/CRAN/")
#Install Rserve
#install.packages("Rserve", repos="http://cran.r-project.org")
 if (! is.element("Rserve", installed.packages()[,1])) install.packages('Rserve',,'http://www.rforge.net/',type="source")
#Include Rserve library
library(Rserve)
source ("libraries.R")
source ("./selemix/IS2_selemix.R")
#Start Rserve
run.Rserve(debug = TRUE, 6311, args = NULL, config.file = "Rserv.cfg") #Port can also be specified in the configuration file.
#run.Rserve(args="--no-save")
