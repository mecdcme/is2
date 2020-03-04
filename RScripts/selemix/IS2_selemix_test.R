
rm(list=ls())
setwd("C:/Users/framato/git/is2")
#install.packages("jsonlite")
debugSource('RScripts/selemix/IS2_selemix.R')
#debugSource('G:/development/git/is2/RScripts/selemix/IS2_selemix.R')

worksetFile <- read.delim("data/selemix/data.csv", header=TRUE, sep=";")
#rolesFile <- list(X="FEM_p_2016", Y="FEM_g_2017")
rolesEst <- list(X="FN.p.9.2016", Y="FN.g.9.2017",STRATA="GRUPPI")
rolesEdit <- list(P="YPRED", Y="FEM_g_2017",S="ateco",V="conv")


out <- is2_mlest (worksetFile, rolesEst)
out

out1 <- is2_seledit(out$workset_out, rolesEdit)
View(out1)


library(base64enc)

setpwd("G:/")
enc <- base64encode("G:/Graf_selemix_AT3_81_0.01_.JPEG")
conn <- file("w.bin","wb")
 writeBin(enc, conn)
 close(conn)
 inconn <- file("w.bin","rb")
 outconn <- file("img2.jpg","wb")
 base64decode(what=inconn, output=outconn)
 close(inconn)
 close(outconn)

 