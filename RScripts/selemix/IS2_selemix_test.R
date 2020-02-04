debugSource('G:/development/git/is2/RScripts/selemix/IS2_selemix.R')

worksetFile <- read.delim("G:/Istat/Mec/IS2/Statistical service/Selemix/data/fatt-short.csv", header=TRUE, sep=";")
rolesFile <- list(X="FEM_p_2016", Y="FEM_g_2017")

head(worksetFile)
rolesFile

out <- is2_mlest(worksetFile, rolesFile)
str(out)

