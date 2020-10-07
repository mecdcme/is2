#replica il comportamento del driver EngineR (JAVA)

#predizione 

rm(list=ls())
setwd("D:/Eclipse/git/is2/RScripts/selemix") #impostate la directory di lavoro
debugSource('is2_selemix.r')

#simulazione input workset
workset <- read.delim("dati1.csv", header=TRUE, sep=";")

#simulazione input ruoli
set_role("X","FN_p_9_2016")
set_role("Y","FN_g_9_2017")
set_role("S","Gruppi")

#simulazione input parametri
set_param("t.outl", 0.5)
set_param("model","LN")


#esecuzione stratificazione
system.time(
  out <- ml_est(workset, roles, wsparams)
)m
#output file dati
#write.csv2(out, "output.csv", row.names=FALSE)
#View(out)

#sum example (conta del numero di outlier totali)
workset <- out$workset_out
print(sum(workset[workset$outlier == 1, "outlier"], na.rm=TRUE)) #808 (senza NA)
#nrow(workset[workset$tau > get_param("t.outl"), ]) #809 (prende anche gli NA)