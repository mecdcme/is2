#replica il comportamento del driver EngineR (JAVA)

#predizione 

rm(list=ls())
setwd("D:/Eclipse/git/is2/RScripts/selemix") #impostate la directory di lavoro
debugSource('is2_selemix.r')


set<-1
#simul azione input ruoli
if(set==0) {
  #simulazione input workset
  workset <- read.delim("dati1.csv", header=TRUE, sep=";")
  set_role("X","FN_p_9_2016")
  set_role("Y","FN_g_9_2017")
  set_role("STRATA","Gruppi")
} else  {
  #simulazione input workset
  workset <- read.delim("data.csv", header=TRUE, sep=";")
  set_role("Y","FNM_g_2017")
  set_role("X","FNM_p_2016")
  set_role("STRATA","MESE")
}
#simulazione input parametri
set_param("t.outl", 0.5)
set_param("model","LN")

#system.time( 
#  out1 <- is2_mlest_layer(workset, roles, wsparams)
#)
#272,8s

#esecuzione stratificazione
system.time(
  out <-is2_mlest(workset, roles, wsparams)
)
#output file dati
#write.csv2(out, "output.csv", row.names=FALSE)
#View(out)

#sum example (conta del numero di outlier totali)
workset <- out$workset_out
model <- out$params_out
parameters <- out$Strata_Info
#print(sum(workset[workset$outlier == 1, "outlier"], na.rm=TRUE)) #808 (senza NA)
#nrow(workset[workset$tau > get_param("t.outl"), ]) #809 (prende anche gli NA)
#print(sum(workset[, "outlier"], na.rm=FALSE)) 
#nrow(unique(workset[is.na(workset$layer), c("Gruppi","layer")]))
