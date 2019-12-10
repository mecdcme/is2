
####################################################################
#                 Applicazione SELEMIX                             #
#                   STIMA DEL MODELLO                              #
####################################################################



setwd("G:/DIRM_MEB/SINTESI - Team SM/SeleMix/Mese_corrente_tematici")

library(sqldf)
library(SeleMix)

####################################
#   dataset di input               #
####################################


# dati grezzi
dati.sper <- read.table("Input/dati_per_sperimentazione_selemix.txt",header=TRUE,sep = ";")
dati_g_7 <- dati.sper[dati.sper$MESE==7,]
dati_g_8 <- dati.sper[dati.sper$MESE==8,]
dati_g_9 <- dati.sper[dati.sper$MESE==9,]
dati_g_12 <- dati.sper[dati.sper$MESE==12,]

colnames(dati_g_7)[7] <- "FN_g_7_2017"
colnames(dati_g_8)[7] <- "FN_g_8_2017"
colnames(dati_g_9)[7] <- "FN_g_9_2017"
colnames(dati_g_12)[7] <- "FN_g_12_2017"

dati_g_78 <- sqldf("select a.*, b.FN_g_8_2017 
                   from dati_g_7 as a, dati_g_8 as b 
                   where a.COD_DITT=b.COD_DITT and a.UNI_FUNZ=b.UNI_FUNZ") 

dati_g_789 <- sqldf("select a.*, b.FN_g_9_2017
                    from dati_g_78 as a, dati_g_9 as b 
                    where a.COD_DITT=b.COD_DITT and a.UNI_FUNZ=b.UNI_FUNZ") 

dati_g_789 <- dati_g_789[,-c(3,4,5,6,8,9)]
dati_g_789$TRIM_g_789_2017 <- round((dati_g_789$FN_g_7_2017 + dati_g_789$FN_g_8_2017 + dati_g_789$FN_g_9_2017)/3, digits = 0.1)


# dati puliti
datiFATT <- read.delim("G:/DIRM_MEB/SINTESI - Team SM/SeleMix/Dati/datiFATT.txt", header=TRUE)
datiFATT <- subset.data.frame(datiFATT, select = c(COD_DITT, UNI_FUNZ, ateco_p_2017, ATE_rid, MESE, FNM_p_2017, FNM_p_2016))

dati_p_7 <- datiFATT[datiFATT$MESE==7,]
dati_p_8 <- datiFATT[datiFATT$MESE==8,]
dati_p_9 <- datiFATT[datiFATT$MESE==9,]
dati_p_12 <- datiFATT[datiFATT$MESE==12,]

colnames(dati_p_7)[6]  <- "FN_p_7_2017"
colnames(dati_p_8)[6]  <- "FN_p_8_2017"
colnames(dati_p_9)[6]  <- "FN_p_9_2017"
colnames(dati_p_12)[6] <- "FN_p_12_2017"

colnames(dati_p_7)[7]  <- "FN_p_7_2016"
colnames(dati_p_8)[7]  <- "FN_p_8_2016"
colnames(dati_p_9)[7]  <- "FN_p_9_2016"
colnames(dati_p_12)[7] <- "FN_p_12_2016"

dati_p_78 <- sqldf("select a.*, b.FN_p_8_2017, b.FN_p_8_2016
                   from dati_p_7 as a, dati_p_8 as b 
                   where a.COD_DITT=b.COD_DITT and a.UNI_FUNZ=b.UNI_FUNZ") 

dati_p_789 <- sqldf("select a.*, b.FN_p_9_2017, b.FN_p_9_2016
                    from dati_p_78 as a, dati_p_9 as b 
                    where a.COD_DITT=b.COD_DITT and a.UNI_FUNZ=b.UNI_FUNZ") 

dati_p_789 <- dati_p_789[ , -c(5)]

dati_p_789$TRIM_p_789_2016 <- round((dati_p_789$FN_p_7_2016 + dati_p_789$FN_p_8_2016 + dati_p_789$FN_p_9_2016)/3, digits = 0.1)
dati_p_789$TRIM_p_789_2017 <- round((dati_p_789$FN_p_7_2017 + dati_p_789$FN_p_8_2017 + dati_p_789$FN_p_9_2017)/3, digits = 0.1)


# dati merge
dati.merge <- sqldf("select a.*, b.FN_g_7_2017, b.FN_g_8_2017, b.FN_g_9_2017, b.TRIM_g_789_2017
                    from dati_p_789 as a, dati_g_789 as b 
                    where a.COD_DITT=b.COD_DITT and a.UNI_FUNZ=b.UNI_FUNZ") 
dati <- dati.merge

iniziali <- as.data.frame(table(dati$ateco_p_2017))
iniziali

dati_00 <- subset(dati, dati$TRIM_g_789_2017 == 0 & dati$TRIM_p_789_2016 == 0)
dati_neg <- subset(dati, dati$TRIM_g_789_2017 < 0 | dati$TRIM_p_789_2016 < 0)

# dati_elim <- rbind(dati_elim, dati_00)
dati_elim <- dati_00
dati_elim <- rbind(dati_elim, dati_neg)

dati_1 <- subset(dati, dati$TRIM_g_789_2017  >= 0 & dati$TRIM_p_789_2016 >= 0)
dati_1 <- subset(dati_1, !(dati_1$TRIM_g_789_2017  == 0 & dati_1$TRIM_p_789_2016 == 0))

# dati_00 e dati_neg: verifica effettuata anche su FN_p_9_2016 e FN_g_9_2017. Nessun valore nullo.

esclusi <- as.data.frame(table(dati_elim$ateco_))
esclusi

#######################################################
#               Definisco il modello                  #
#######################################################

dati_1$y <- dati_1$FN_g_9_2017
dati_1$x <- dati_1$FN_p_9_2016

dati_1$Gruppi <- dati_1$ateco_p_2017
dati_1$DIV <- dati_1$ATE_rid

num_gruppi <- sqldf("select Gruppi, count(*) as num_gruppi from dati_1 group by Gruppi")
num_div <- sqldf("select div, count(*) as num_div from dati_1 group by div")

dati_1 <- sqldf("select a.*, b.num_gruppi from dati_1 as a, num_gruppi as b where a.gruppi=b.gruppi") 
dati_1 <- sqldf("select a.*, b.num_div from dati_1    as a, num_div    as b where a.div=b.div")


#############################################################################################
#                 stima dei valori predetti a livello di Gruppo (ateco 3 cifre)             #
#############################################################################################

ateco <- sort(unique(dati_1$Gruppi))
ateco

at_1 <- ateco[1]
at_1

for(ate in ateco){
  
  rm(dati_ate)
  
  dati_ate <- dati_1[dati_1$Gruppi == ate, ]
  print(ate)
  print(unique(dati_ate$num_gruppi))
  
  rm(est)
  
  est <- try(ml.est (dati_ate$y, dati_ate$x, model = "LN", 
                     lambda=3, w=0.05,lambda.fix=FALSE, w.fix=FALSE, eps=1e-7,
                     max.iter=500, t.outl=0.5, graph=FALSE))
  
  if(("est"%in%ls() & class(est)[1]!="try-error")){
    
    
    lambda_at3 <- est$lambda  #fattore di inflazione della normale dei dati contaminati  
    w_at3 <- est$w            #percentuale di dati contaminati  
    sigma_at3 <- est$sigma    #varianza della dist .....quale?
    
    conv_at3 <- est$is.conv
    
    bic <- as.matrix(est$bic.aic)
    bic_norm_at3 <- bic[1,]    
    bic_mix_at3  <- bic[2,] 
    
    aic <- as.matrix(est$bic.aic)
    aic_norm_at3 <- aic[3,]    
    aic_mix_at3  <- aic[4,] 
    
    ypred_at3 <- est$ypred
    out_at3   <- est$outlier
    
    alpha_at3 <-est$B[1,1]
    beta_at3  <-est$B[2,1]
    
    esito_est_at3 <- "est ok"
    
  } else { lambda_at3 <- NA    
  w_at3 <- NA            
  sigma_at3 <- NA 
  conv_at3 <- NA
  bic_norm_at3 <- NA   
  bic_mix_at3 <- NA
  aic_norm_at3 <- NA    
  aic_mix_at3 <- NA
  ypred_at3 <- NA
  out_at3 <- NA
  alpha_at3 <- NA
  beta_at3 <- NA
  esito_est_at3 <- "est error" }
  
  rm(dati_fin)
  
  dati_fin <- cbind(dati_ate, esito_est_at3, conv_at3, ypred_at3, out_at3, alpha_at3, beta_at3, bic_norm_at3, bic_mix_at3, aic_norm_at3, aic_mix_at3, lambda_at3, sigma_at3, w_at3) 
  
  if (ate == at_1) {stima_fin_at3 <- dati_fin} else {stima_fin_at3 <- rbind(stima_fin_at3,dati_fin)}
  
} #end for(ate in ateco)


#############################################################################################
#                stima dei valori predetti a livello di Divisione                           #
#############################################################################################

ateco <- sort(unique(dati_1$DIV))
ateco

at_1 <- ateco[1]
at_1


for(ate in ateco){
  
  rm(dati_ate)
  
  dati_ate <- dati_1[dati_1$DIV == ate, ]
  print(ate)
  print(unique(dati_ate$num_div))
  
  rm(dati_div)
  rm(est)
  
  est <- try(ml.est (dati_ate$y, dati_ate$x, model = "LN", 
                     lambda=3, w=0.05,lambda.fix=FALSE, w.fix=FALSE, eps=1e-7,
                     max.iter=500, t.outl=0.5, graph=FALSE))
  
  if(("est"%in%ls() & class(est)[1]!="try-error")){
    
    lambda_div <- est$lambda
    w_div <- est$w
    sigma_div <- est$sigma
    
    conv_div <- est$is.conv
    
    bic <- as.matrix(est$bic.aic)
    bic_norm_div <- bic[1,]    
    bic_mix_div <- bic[2,] 
    
    aic <- as.matrix(est$bic.aic)
    aic_norm_div <- aic[3,]    
    aic_mix_div <- aic[4,] 
    
    ypred_div <- est$ypred
    out_div <- est$outlier
    
    alpha_div <- est$B[1,1]
    beta_div <- est$B[2,1]
    
    esito_est_div <- "est ok"
    
  } else { lambda_div <- NA    
  w_div <- NA            
  sigma_div <- NA 
  conv_div <- NA
  bic_norm_div <- NA   
  bic_mix_div <- NA
  aic_norm_div <- NA    
  aic_mix_div <- NA
  ypred_div <- NA
  out_div <- NA
  alpha_div <- NA
  beta_div <- NA
  esito_est_div <- "est error"}
  
  dati_div <- dati_ate[, 1:2]
  dati_fin <- cbind(dati_div, esito_est_div, conv_div, ypred_div, out_div, alpha_div, beta_div, bic_norm_div, bic_mix_div, aic_norm_div, aic_mix_div, lambda_div, sigma_div, w_div) 
  
  if (ate == at_1) {stima_fin_div <- dati_fin} else {stima_fin_div <- rbind(stima_fin_div, dati_fin)}
  
}

stima_fin <- sqldf("select a.*, b.* from stima_fin_at3 as a, stima_fin_div as b where a.COD_DITT = b.COD_DITT and a.UNI_FUNZ = b.UNI_FUNZ") 

write.table(stima_fin,'stima_MESE.txt',sep = ";",row.names=FALSE)



