#replica il comportamento del driver EngineR (JAVA)

#predizione 

rm(list=ls())
setwd("D:/Eclipse/git/is2/RScripts/selemix") #impostate la directory di lavoro
debugSource('is2_selemix.r')


set<-1
#simulazione input ruoli
print("SET RUOLI E DATASET")
if(set==0) {
  #simulazione input workset
  workset <- read.delim("dati1.csv", header=TRUE, sep=";")
  set_role("x","FN_p_9_2016")
  set_role("y","FN_g_9_2017")
  set_role("STRATA","Gruppi")
} else  {
  #simulazione input workset
  workset <- read.delim("data.csv", header=TRUE, sep=";")
  set_role("y","FNM_g_2017")
  set_role("x","FNM_p_2016")
  set_role("STRATA","MESE")
}
#simulazione input parametri
set_param("t.outl", 0.5)
set_param("model","LN")
#set_role("STRATA","ciao")

#system.time( 
#  out1 <- is2_mlest_layer(workset, roles, wsparams)
#)
#272,8s

#esecuzione ml.est
print("Esecuzione ML EST")
system.time(
  out <-is2_mlest(workset, roles, wsparams)
)

#sum example (conta del numero di outlier totali)
workset <-as.data.frame(out$workset_out)
#print(names(workset))
model <- fromJSON( as.character(out$params_out ))
parameters <- fromJSON(as.character(out$AGGREGATES))
#output file dati
write.csv2(workset, "output.mlest.csv", row.names=FALSE)
write.csv2(model, "output.model.csv", row.names=FALSE)
write.csv2(parameters, "output.parameters.csv", row.names=FALSE)

print("Esecuzione SEL EDIT")
#---- selezione
set_role("y","FNM_g_2017")
set_role("STRATA","MESE")
#set_role("ypred","predict")
#esecuzione ml.est
system.time(
  out <-is2_seledit(workset, roles, wsparams)
)
output <-as.data.frame(out$workset_out)
write.csv2(output, "output.seledit.csv", row.names=FALSE)

#--- Finalyze
close_log()