rm(list=ls())
#install.packages("jsonlite")
debugSource('C:/Users/framato/git/is2/RScripts/selemix/IS2_selemix.R')
#debugSource('G:/development/git/is2/RScripts/selemix/IS2_selemix.R')

worksetFile <- read.delim("G:/fatt-short.csv", header=TRUE, sep=";")
#rolesFile <- list(X="FEM_p_2016", Y="FEM_g_2017")
rolesEst <- list(X="FEM_p_2016", Y="FEM_g_2017",S="MESE")
rolesEdit <- list(YPRED="YPRED", Y="FEM_g_2017",S="MESE")


out <- is2_mlest (worksetFile, rolesEst)
out1 <- is2_seledit_layer(out$workset_out, rolesEdit)
View(out1)



