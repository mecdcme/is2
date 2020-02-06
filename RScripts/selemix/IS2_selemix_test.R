#debugSource('C:/Users/framato/git/is2/RScripts/selemix/IS2_selemix.R')
debugSource('G:/development/git/is2/RScripts/selemix/IS2_selemix.R')

worksetFile <- read.delim("G:/fatt-short.csv", header=TRUE, sep=";")
rolesFile <- list(X="FEM_p_2016", Y="FEM_g_2017",S="MESE")

head(worksetFile)
rolesFile

out <- is2_mlest(worksetFile, rolesFile)
View(out)

out$params_out
