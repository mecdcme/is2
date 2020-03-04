# Copyright 2019 ISTAT
# 
#  Licensed under the EUPL, Version 1.1 or ??? as soon they will be approved by
#  the European Commission - subsequent versions of the EUPL (the "Licence");
#  You may not use this work except in compliance with the Licence. You may
#  obtain a copy of the Licence at:
# 
#  http://ec.europa.eu/idabc/eupl5
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
#  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#  Licence for the specific language governing permissions and limitations under
#  the Licence.
# 
#  @author Francesco Amato <framato @ istat.it>
#  @author Mauro Bruno <mbruno @ istat.it>
#  @author Paolo Francescangeli  <pafrance @ istat.it>
#  @author Renzo Iannacone <iannacone @ istat.it>
#  @author Stefano Macone <macone @ istat.it>
#   
#  @version 1.0.0
#

#   Lista Ruoli
#1	IDENTIFICATIVO	I	CHIAVE OSSERVAZIONE
#2	TARGET			    Y	VARIABILE DI OGGETTO DI ANALISI
#3	COVARIATA		    X	VARIABILE INDIPENDENTE
#4	PREDIZIONE			P	VARIABILE DI PREDIZIONE
#5	OUTLIER			    O	FLAG OUTLIER
#7	ERRORE			    E	ERRORE INFLUENTE
#9	OUTPUT			    T	VARIABILE DI OUTPUT
#10	STRATO			    S	PARTIZIONAMENTO DEL DATASET
#11	PARAMETRI		    Z	PARAMETRI DI ESERCIZIO
#12	MODELLO			    M	MODELLO DATI
#14	REPORT			    G	REPORT
#15	CONVERGENZA	    V	FLAG CONVERGENZA


#[IS2 bridge] Global output variables
IS2_WORKSET_OUT     <- "workset_out"
IS2_ROLES_OUT       <- "roles_out"
IS2_ROLES_GROUP_OUT <- "rolesgroup_out"
IS2_PARAMS_OUT      <- "params_out"
IS2_REPORT_OUT      <- "report_out"
IS2_LOG             <- "log"


#IS2 Selemix roles
IS2_SELEMIX_PREDICTION <- "PRED"
IS2_SELEMIX_OUTPUT_VARIABLES <- "OUTVARS"
IS2_SELEMIX_OUTLIER    <- "OUTLIERS"
IS2_SELEMIX_MODEL      <- "MDLOUT"
IS2_SELEMIX_REPORT     <- "REP"
IS2_SELEMIX_ERROR      <- "INFLS"
IS2_SELEMIX_TARGET     <- "Y"
IS2_SELEMIX_COVARIATE  <- "X"
IS2_SELEMIX_STRATA     <- "STRATA"
IS2_SELEMIX_CONVERGENCE <- "CONV"


library("SeleMix")
library("jsonlite")


#stima completa con layer
is2_mlest_layer <- function( workset, roles, wsparams=NULL,...) {

  
  #Output variables
  result          <- list()
  workset_out     <- data.frame()
  roles_out       <- list() 
  rolesgroup_out  <- list()
  params_out      <- list()
  report_out      <- list() 
  
  #Create log
  stdout <- vector('character')
  con <- textConnection('stdout', 'wr', local = TRUE)
  #sink(con)
  
  #Set default parameters
  model="LN"
  t.outl=0.5
  lambda=3
  w=0.05
  lambda.fix=FALSE
  w.fix=FALSE
  eps=1e-7
  max.iter=500	
  
  #Check parameters
  if(!is.null(wsparams)){
    if(exists("wsparams$model")) model=wsparams$model
    if(exists("wsparams$t.outl")) t.outl=wsparams$t.outl
    if(exists("wsparams$lambda")) lambda=wsparams$lambda
    if(exists("wsparams$w")) w=wsparams$w
    if(exists("wsparams$lambda.fix")) lambda.fix=wsparams$lambda.fix
    if(exists("wsparams$w.fix")) w.fix=wsparams$w.fix
    if(exists("wsparams$eps")) eps=wsparams$eps
    if(exists("wsparams$max.iter")) max.iter=wsparams$max.iter
  }
  
  #Set input variables
  s <- workset[[roles$STRATA]]
  layers <- sort(unique(s))
  mod <- list()
  outvars<- data.frame()
  predname <- c()
  n_outlier <- 0
  n_layers_conv <- 0
  n_layers <- length(layers)
  
  for(index in 1:length(layers) ){
    rm(workset_layer)
    rm(est)
    rm(x)
    rm(y)
    rm(s1)
    rm(outprediction)
    rm(predname)
    
    layer<- as.character(layers[index])
    workset_layer <- workset[workset[roles$STRATA]==layer, , drop = TRUE ]
    
    
    x <- workset_layer[roles$X]
    y <- workset_layer[roles$Y]
    s1 <- workset_layer[roles$STRATA]
    
    if(NCOL(y) ==1){ #  UNIVARIATE
      predname = c("YPRED")
    } 
    else{
      for(i in 1:NCOL(y)) { # MULTIVARIATE
        predname = c(predname, paste("YPRED",i,sep="_"))
      }
    }
    est<-NA
    #Execute ml.est
    run <- tryCatch(
      {
        est <- ml.est(y=y, x=x, model = model, lambda= as.numeric(lambda), w = as.numeric(w), lambda.fix=lambda.fix, w.fix=w.fix, eps=as.numeric(eps), max.iter=as.numeric(max.iter), t.outl= as.numeric(t.outl), graph=FALSE)
        print(paste("layer ",layer, " ml.est execution completed! rows:" ,nrow(x)))
        #Prepare output
        
        outprediction <- as.data.frame(est$ypred)
        colnames(outprediction) <- predname
        
        conv  <- data.frame(conv = est$is.conv)
        
        outvars <- data.frame(tau=est$tau, outlier=est$outlier, pattern=est$pattern)
        
        bic <- as.matrix(est$bic.aic)
        bic_norm <- bic[1,]    
        bic_mix  <- bic[2,] 
        
        aic <- as.matrix(est$bic.aic)
        aic_norm <- aic[3,]    
        aic_mix  <- aic[4,] 
   
        #Set output parameters layer
        mod[[index]] <- list(layer=layer,N=NROW(x), is.conv = est$is.conv, B=est$B, sigma=est$sigma, lambda=est$lambda, w=est$w, bic_norm = bic_norm, bic_mix=bic_mix, aic_norm=aic_norm,aic_mix=aic_mix,n.iter=est$n.iter)
         
        #Set output variables layer
        workset_out <- rbind(workset_out,cbind(x, y,s1, outprediction, conv, outvars))
        
        n_outlier <- n_outlier + sum(est$outlier)
        if( length(conv[conv==TRUE])>0){ n_layers_conv= n_layers_conv+1}
        
      }
      #  ,
      #  warning=function(cond) {
      #    print(est)
      #    print(paste("Warning: layer ",layer, " ml.est did not converge! rows:" ,NROW(x)))
      #    return(NA)
      #     }     
      ,
      error=function(cond) {
        print(paste("Error: layer ",layer, " rows:" ,NROW(x) ))
        print(cond)
        return(NA)
      })
    if(is.na(run)){
      
      outvars <- data.frame(matrix(NA, ncol = 3+NCOL(y), nrow = NROW(y)))
      outvars$conv <- rep(FALSE, NROW(y))
      colnames(outvars) <- c(predname,"conv","tau","outlier","pattern")
      outprediction <- as.data.frame(NA)
      colnames(outprediction) <- predname
      workset_out <- rbind(workset_out,cbind(x, y,s1, outvars))
      mod[[index]] <- list(layer=layer,N=NROW(x), is.conv = FALSE, B=NA, sigma=NA, lambda=NA, w=NA, bic_norm =NA, bic_mix=NA, aic_norm=NA,aic_mix=NA,n.iter=0)
      
    }
  }#for
  
  params_out <- list("Contamination Model" = toJSON(mod, auto_unbox = TRUE))
  
  
  report <- list(n.outlier = n_outlier, "Layers"=n_layers ,"Convergent layers"=n_layers_conv)
  report_out <- list(Report = toJSON(report, auto_unbox = TRUE))
  
  #Set output roles & rolesgroup

  roles_out [[IS2_SELEMIX_OUTLIER]] <- c("outlier")
  roles_out [[IS2_SELEMIX_MODEL]]   <- c("Contamination Model")
  roles_out [[IS2_SELEMIX_REPORT]]  <- c("Report")
  
  
  roles_out [[IS2_SELEMIX_COVARIATA]]       <- c(roles$X)
  roles_out [[IS2_SELEMIX_TARGET]]          <- c(roles$Y)
  roles_out [[IS2_SELEMIX_STRATO]]          <- c(roles$STRATA)
  roles_out [[IS2_SELEMIX_PREDIZIONE]]      <- c(predname)
  roles_out [[IS2_SELEMIX_CONVERGENZA]]     <- c("conv")
  roles_out [[IS2_SELEMIX_OUTPUT_VARIABLES]]<- c(names(outvars))
  
  rolesgroup_out [[IS2_SELEMIX_MODEL]]    <- c(IS2_SELEMIX_MODEL)
  rolesgroup_out [[IS2_SELEMIX_REPORT]]   <- c(IS2_SELEMIX_REPORT)

  rolesgroup_out [[IS2_SELEMIX_PREDIZIONE]] <- c(IS2_SELEMIX_COVARIATA,IS2_SELEMIX_TARGET,IS2_SELEMIX_STRATO,IS2_SELEMIX_PREDIZIONE,IS2_SELEMIX_CONVERGENZA,IS2_SELEMIX_OUTPUT_VARIABLES,IS2_SELEMIX_OUTLIER)
  
  #Output
  result[[IS2_WORKSET_OUT]]     <- workset_out
  result[[IS2_ROLES_OUT]]       <- roles_out
  result[[IS2_ROLES_GROUP_OUT]] <- rolesgroup_out
  result[[IS2_PARAMS_OUT]]      <- params_out
  result[[IS2_REPORT_OUT]]      <- report_out
  result[[IS2_LOG]]             <- stdout
  
  print("Execution mlest completed!!")
  
  #Create log
  sink()
  close(con)
  
  return(result)
}

#funzione stima generica 
is2_mlest <- function( workset, roles, wsparams=NULL,...) {
  if(is.null(roles$S)){
    print('call is2_mlest_nolayer')
    return (is2_mlest_nolayer(workset, roles, wsparams))
  }
  else
  {	  print('call is2_mlest_layer')
    return (is2_mlest_layer(workset, roles, wsparams))
  }
}



#########################
#editing selettivo 
########################

#stima completa con layer
is2_seledit_layer <- function(workset, roles, wsparams = NULL, ...) {
  
  
  #Output variables
  result          <- list()
  workset_out     <- data.frame()
  roles_out       <- list()
  rolesgroup_out  <- list()
  params_out      <- list()
  report_out      <- list()
  
  #Create log
  stdout <- vector('character')
  con <- textConnection('stdout', 'wr', local = TRUE)
  sink(con)
  
  t_sel = 0.01
  
  #Check parameters
  if (!is.null(wsparams)) {
    if (exists("wsparams$tot"))
      tot = wsparams$tot
    if (exists("wsparams$t_sel"))
      t_sel = wsparams$t_sel
  }
  
  
  #Set variables
  s <- workset[[roles$S]]
  layers <- sort(unique(s))
  n_error <- 0
  predname <- c()
  workset_layer  <- data.frame()
  for (index in 1:length(layers)) {
    rm(workset_layer)
    run<-NA
    
    layer <- as.character(layers[index])
    workset_layer <-
      workset[workset[roles$S] == layer , , drop = TRUE]
    y <- workset_layer[roles$Y]
    ypred <- workset_layer[roles$P]
    s1 <- workset_layer[roles$S]
    out_layer<- workset_layer[roles$O]
    workset_layer_conv <- workset_layer[roles$V]
    nr<-0
    if(NROW(workset_layer_conv)>1) 
      nr<- NROW(workset_layer_conv[workset_layer_conv[roles$V]==TRUE , , drop = TRUE])
    else 
      if(!is.na(workset_layer_conv[roles$V]) && workset_layer_conv[roles$V]==TRUE) nr<-1
    
    if(nr>0){
      wgt = rep(1, NROW(workset_layer))
      if (exists("wsparams$wgt"))
        wgt = wsparams$wgt
      # tot=colSums(ypred * wgt)
      if (exists("wsparams$tot"))
        tot = wsparams$tot
      
      #Execute sel.edit
      #  sel_out <- sel.edit (y=y, ypred=ypred, wgt, tot, t_sel= as.numeric(t_sel))
      sel_out <- NA
      #Execute ml.est
      run <- tryCatch({
        sel_out <- sel.edit (y = y,
                             ypred = ypred,
                             t.sel = as.numeric(t_sel))
        sel <- sel_out[, "sel"]
        
        score <- sel_out[, c("rank", "global.score")]
        n_error = n_error + sum(sel)
        
        #Set output variables
        workset_out <-
          rbind(workset_out, cbind(workset_layer, sel, score))
        
        # esportiamo in file esterno i risultati
        x <- cbind(workset_layer$X, workset_layer$Y )
        nome.grafico=paste(paste("G:","/Graf_selemix_AT3",sep=""), layer, t_sel,".jpeg",sep="_")
        bmp(nome.grafico)
        sel.pairs(x, outl=out_layer, sel=sel, log = TRUE)
        dev.off()
        
      }
      #  ,
      #  warning=function(cond) {
      #    print(est)
      #    print(paste("Warning: layer ",layer, " ml.est did not converge! rows:" ,NROW(x)))
      #    return(NA)
      #     }
      ,
      error = function(cond) {
      #  print(paste("Error: layer ", layer, " rows:" , NROW(y)))
      #  print(cond)
        return(NA)
      })
    }
    
    if (is.null(run) ||is.na(run)) {
      outvars <- data.frame(matrix(NA, ncol = 3, nrow = NROW(y)))
      colnames(outvars) <- c("sel", "rank", "global.score")
      workset_out <- rbind(workset_out,cbind(workset_layer, outvars))
      
    }
  }#for
  
  workset_out<- workset_out[order(workset_out$global.score,decreasing = TRUE),]
  
  
  report <- list(n.error = n_error)
  report_out <- list(Report = toJSON(report, auto_unbox = TRUE))
  
  #Set output roles & rolesgroup
  roles_out      <- list (E = "sel", R = "rank",  F = "global.score")
  rolesgroup_out <- list (E = "E", G = "G")
  
  roles_out [[IS2_SELEMIX_ERROR]]      <-   c(roles$X,roles$Y, roles$P, roles$S,roles$V, "sel",  "rank", "global.score")
  rolesgroup_out [[IS2_SELEMIX_ERROR]] <- c("E", "R","F")
  
  
  
  #Output
  result[[IS2_WORKSET_OUT]]     <- workset_out
  result[[IS2_ROLES_OUT]]       <- roles_out
  result[[IS2_ROLES_GROUP_OUT]] <- rolesgroup_out
  result[[IS2_PARAMS_OUT]]      <- params_out
  result[[IS2_REPORT_OUT]]      <- report_out
  result[[IS2_LOG]]             <- stdout
  
  print("Execution sl.edit completed!!")
  
  #Create log
  sink()
  close(con)
  
  return(result)
}


#stima completa con layer
is2_seledit_nolayer <- function( workset, roles, wsparams=NULL,...) {
  
  #Output variables
  result          <- list()
  workset_out     <- data.frame()
  roles_out       <- list() 
  rolesgroup_out  <- list()
  params_out      <- list()
  report_out      <- list() 
  
  #Create log
  stdout <- vector('character')
  con <- textConnection('stdout', 'wr', local = TRUE)
  sink(con)
  
  wgt=rep(1,nrow(workset))
  t_sel=0.01
  
  #Check parameters
  if(!is.null(wsparams)){
    if(exists("wsparams$wgt")) wgt=wsparams$wgt
    if(exists("wsparams$tot")) tot=wsparams$tot
    if(exists("wsparams$t_sel")) t_sel=wsparams$t_sel
  }
  
  
  #Set variables
  
  
  n_error <- 0
  predname<- c() 
  workset_layer  <- data.frame()
  
  ###
  #to do .......
  ###
  
  report <- list(n.error = n_error )
  report_out <- list(Report = toJSON(report))
  
  #Set output roles & rolesgroup
  roles_out      <- list (E="sel", R= "rank", F="global.score", G=names(report))
  rolesgroup_out <- list (E="E",G="G")
  
  roles_out [[IS2_SELEMIX_ERROR]]      <- c(roles$X,roles$Y,predname)
  rolesgroup_out [[IS2_SELEMIX_ERROR]] <- c("P", "O")
  
  #Output
  result[[IS2_WORKSET_OUT]]     <- workset_out
  result[[IS2_ROLES_OUT]]       <- roles_out
  result[[IS2_ROLES_GROUP_OUT]] <- rolesgroup_out
  result[[IS2_PARAMS_OUT]]      <- params_out
  result[[IS2_REPORT_OUT]]      <- report_out
  result[[IS2_LOG]]             <- stdout
  
  #Create log
  sink()
  close(con)
  
  return(result)
}


#editing selettivo generica 
is2_seledit <- function( workset, roles, wsparams=NULL,...) {
  if(is.null(roles$S)){
    return (is2_seledit_nolayer(workset, roles, wsparams))
  }
  else
  {	
    return (is2_seledit_layer(workset, roles, wsparams))
  }
}

