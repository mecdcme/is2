
setwd("G:/DIRM_MEB/SINTESI - Team SM/SeleMix/Mese_corrente_tematici")

library(sqldf)
library(SeleMix)


#################################################################################
#  Applicazione della funzione sel.edit a livello ateco3cifre e divisione       #
#  solo SELEZIONE dei dati influenti in base alle stime predette ottenute       #                                     
#################################################################################

PATH.GRAFICI="G:/DIRM_MEB/SINTESI - Team SM/SeleMix/Mese_corrente_tematici/grafici"

tsel <- 0.01
ttsel <- '01'

# Modificare il valore tsel nelle tre istruzioni write.table!!!

#################################################################################
#  1.    individuazione influenti a livello di at3 su strati con convergenza    #
#################################################################################


dati_at3 <- subset(stima_fin, stima_fin$esito_est_at3== "est ok" & stima_fin$conv_at3 == "TRUE")

dati_est_error <- subset(stima_fin, stima_fin$esito_est_at3== "est error" )
dati_conv_error <- subset(stima_fin, stima_fin$conv_at3== "FALSE" )

ateco <- sort(unique(dati_at3$Gruppi))
ateco

at_1 <- ateco[1]
at_1

for(ate in ateco){
  
  rm(dati_ate)
  
  dati_ate <- dati_at3[dati_at3$Gruppi == ate, ]
  
  print(ate)
  print(unique(dati_ate$num_gruppi))
  
  sel_at3 <- sel.edit(dati_ate$y, dati_ate$ypred_at3, t.sel= tsel)
  inf <- sel_at3[, "sel"]
  score <- sel_at3[,c("rank","global.score")]
  
  # esportiamo in file esterno i risultati
  x <- cbind(dati_ate$x, dati_ate$y )
  nome.grafico=paste(paste(PATH.GRAFICI,"/Graf_selemix_AT3",sep=""), ate, ttsel,".jpeg",sep="_")
  bmp(nome.grafico)
  sel.pairs(x, outl=dati_ate$out_at3, sel=inf, log = TRUE)
  dev.off()
  
  dati_ate_inf <- cbind(dati_ate, inf, score)
  
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="inf"] <- paste("inf_at3",ttsel,sep="_")
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="rank"] <- paste("rank_at3",ttsel,sep="_")
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="global.score"] <- paste("globalscore_at3",ttsel,sep="_")
  
  if (ate == at_1) {sel_fin_at3 <- dati_ate_inf} else {sel_fin_at3 <- rbind(sel_fin_at3,dati_ate_inf)}
  
}

write.table(sel_fin_at3,'Influenti_AT3_T01_MESE.txt',sep = ";",row.names=FALSE)

#################################################################################
#  2.    individuazione influenti a livello di DIV su strati con convergenza    #
#################################################################################

dati_div <- subset(stima_fin, stima_fin$esito_est_div== "est ok" & stima_fin$conv_div == "TRUE")

dati_est_error <- subset(stima_fin, stima_fin$esito_est_div== "est error" )
dati_conv_error <- subset(stima_fin, stima_fin$conv_div== "FALSE" )

ateco <- sort(unique(dati_div$DIV))
ateco

at_1 <- ateco[1]
at_1

for(ate in ateco){
  
  rm(dati_ate)
  
  dati_ate <- dati_div[dati_div$DIV == ate, ]
  
  print(ate)
  print(unique(dati_ate$num_div))
  
  sel_div <- sel.edit(dati_ate$y, dati_ate$ypred_div, t.sel= tsel)
  inf <- sel_div[, "sel"]
  score <- sel_div[,c("rank","global.score")]
  
  # esportiamo in file esterno i risultati
  x <- cbind(dati_ate$x, dati_ate$y )
  nome.grafico=paste(paste(PATH.GRAFICI,"/Graf_selemix_DIV",sep=""), ate, ttsel,".jpeg",sep="_")
  bmp(nome.grafico)
  sel.pairs(x, outl=dati_ate$out_div, sel=inf, log = TRUE)
  dev.off()
  
  dati_ate_inf <- cbind(dati_ate, inf, score)
  
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="inf"] <- paste("inf_div",ttsel,sep="_")
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="rank"] <- paste("rank_div",ttsel,sep="_")
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="global.score"] <- paste("globalscore_div",ttsel,sep="_")
  
  if (ate == at_1) {sel_fin_div <- dati_ate_inf} else {sel_fin_div <- rbind(sel_fin_div,dati_ate_inf)}
  
}


write.table(sel_fin_div,'Influenti_DIV_T01_MESE.txt',sep = ";",row.names=FALSE)


###############################################################################################
#  3.    individuazione influenti a livello di AT3 con stime DIV su strati con convergenza    #
###############################################################################################

dati_div <- subset(stima_fin, stima_fin$esito_est_div== "est ok" & stima_fin$conv_div == "TRUE")

dati_est_error <- subset(stima_fin, stima_fin$esito_est_div== "est error")
dati_conv_error <- subset(stima_fin, stima_fin$conv_div== "FALSE" )

ateco <- sort(unique(dati_div$Gruppi))
ateco

at_1 <- ateco[1]
at_1

for(ate in ateco){
  
  rm(dati_ate)
  
  dati_ate <- dati_div[dati_div$Gruppi == ate, ]
  
  print(ate)
  print(unique(dati_ate$num_gruppi))
  
  sel_at3_div <- sel.edit(dati_ate$y, dati_ate$ypred_div, t.sel= tsel)
  inf <- sel_at3_div[, "sel"]
  score <- sel_at3_div[,c("rank","global.score")]
  
  # esportiamo in file esterno i risultati
  x <- cbind(dati_ate$x, dati_ate$y )
  nome.grafico=paste(paste(PATH.GRAFICI,"/Graf_selemix_DIV_AT3",sep=""), dati_ate$DIV, ate, ttsel,".jpeg",sep="_")
  bmp(nome.grafico)
  sel.pairs(x, outl=dati_ate$out_div, sel=inf, log = TRUE)
  dev.off()
  
  if (unique(dati_ate$num_gruppi)==1) {dati_ate_inf <- as.data.frame(c(dati_ate, inf, score))
  dati_ate_inf$COD_DITT <- as.character(dati_ate_inf$COD_DITT)
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="sel"] <- "inf"} else {dati_ate_inf <- cbind(dati_ate, inf, score)}
  
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="inf"] <- paste("inf_div_AT3",ttsel,sep="_")
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="rank"] <- paste("rank_div_AT3",ttsel,sep="_")
  colnames(dati_ate_inf)[colnames(dati_ate_inf)=="global.score"] <- paste("globalscore_div_AT3",ttsel,sep="_")
  
  
  if (ate == at_1) {sel_fin_div_at3 <- dati_ate_inf} else {sel_fin_div_at3 <- rbind(sel_fin_div_at3, dati_ate_inf)}
  
}

write.table(sel_fin_div_at3,'Influenti_DIV_AT3_T01_MESE.txt',sep = ";",row.names=FALSE)

#str(dati_ate_inf)
#str(sel_fin_div_at3)
