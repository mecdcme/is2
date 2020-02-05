debugSource('C:/Users/framato/git/is2/RScripts/selemix/IS2_selemix.R')

worksetFile <- read.delim("C:/Users/framato/Desktop/fatt-short.csv", header=TRUE, sep=";")
rolesFile <- list(X="FEM_p_2016", Y="FEM_g_2017",S="MESE")

head(worksetFile)
rolesFile

out <- is2_mlest_layer_old(worksetFile, rolesFile)
out1 <- is2_mlest_layer(worksetFile, rolesFile)
outf<-cbind(out$workset_out,out1$workset_out)

