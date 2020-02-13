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


#[IS2 bridge] Global output variables
IS2_WORKSET_OUT     <- "workset_out"
IS2_ROLES_OUT       <- "roles_out"
IS2_ROLES_GROUP_OUT <- "rolesgroup_out"
IS2_PARAMS_OUT      <- "params_out"
IS2_REPORT_OUT      <- "report_out"
IS2_LOG             <- "log"


#IS2 Selemix roles
IS2_SELEMIX_PREDIZIONE <- "P"
IS2_SELEMIX_OUTLIER    <- "O"
IS2_SELEMIX_MODEL      <- "M"
IS2_SELEMIX_REPORT     <- "G"
IS2_SELEMIX_ERROR      <- "E"

library("SeleMix")
library("jsonlite")

#stima del modello
is2_mlest_nolayer <- function( workset, roles, wsparams=NULL,...) {
  
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
  
  #Set variables
  x <- workset[roles$X]
  y <- workset[roles$Y]
  
  #Execute ml.est
  run <- tryCatch(
    {
      est <- ml.est(y=y, x=x, model = model, lambda= as.numeric(lambda), w = as.numeric(w), lambda.fix=lambda.fix, w.fix=w.fix, eps=as.numeric(eps), max.iter=as.numeric(max.iter), t.outl= as.numeric(t.outl), graph=FALSE)
      
      print("ml.est execution completed!")
      
      #Prepare output
      outparams <- data.frame(tau=est$tau, outlier=est$outlier, pattern=est$pattern)
      
      predname = c()
      
      if(ncol(est$ypred) ==1){
        predname = c("YPRED")
      } 
      else{
        for(i in 1:ncol(est$ypred)) {
          predname = c(predname, paste("YPRED",i,sep="_"))
        }
      }
      
      outprediction <- as.data.frame(est$ypred)
      colnames(outprediction) <- predname
      
      #Set output parameters
      report <- list(n.outlier = sum(est$outlier), missing = sum(as.numeric(est$pattern)), is.conv = est$is.conv, sing = est$sing, bic.aic = est$bic.aic)
      mod<- toJSON(list(layer="all",B=est$B, sigma=est$sigma, lambda=est$lambda, w=est$w ))
      
      report_out <- list(Report = toJSON(report))
      params_out <- list(Model = toJSON(mod))
      
      #Set output variables
      workset_out <- cbind(x, y, outprediction, outparams)
      
      #Set output roles & rolesgroup
      roles_out      <- list (O="outlier", M="Model",G="Report")
      rolesgroup_out <- list (M="M",G="G")
      
      
      roles_out [[IS2_SELEMIX_PREDIZIONE]]      <- c(roles$X,roles$Y,predname,names(outparams))
      rolesgroup_out [[IS2_SELEMIX_PREDIZIONE]] <- c("P", "O")
      
      #Output
      result[[IS2_WORKSET_OUT]]     <- workset_out
      result[[IS2_ROLES_OUT]]       <- roles_out
      result[[IS2_ROLES_GROUP_OUT]] <- rolesgroup_out
      result[[IS2_PARAMS_OUT]]      <- params_out
      result[[IS2_REPORT_OUT]]      <- report_out
      result[[IS2_LOG]]             <- stdout
      
    },
    error=function(cond) {
      
      print("ml.est did not converge")
      print(cond)
      #Output
      result <-list( IS2_WORKSET_OUT=c(), IS2_ROLES_OUT=c(), IS2_ROLES_GROUP_OUT=c(), IS2_PARAMS_OUT=c(), IS2_REPORT_OUT=c(), IS2_LOG=stdout)
      return(NA)
    },
    warning=function(cond) {
      print("warning")
      print("ml.est did not converge")
      print(cond)
      #Output
      result <-list( IS2_WORKSET_OUT=c(), IS2_ROLES_OUT=c(), IS2_ROLES_GROUP_OUT=c(), IS2_PARAMS_OUT=c(), IS2_REPORT_OUT=c(), IS2_LOG=stdout)
      return(NA)
      
    }
    
    
  )
  
  #Create log
  sink()
  close(con)
  
  return(result)
}



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
  
  #Set variables
  s <- workset[[roles$S]]
  layers <- sort(unique(s))
  mod <- list()
  outparams <- data.frame()
  predname <- c()
  n_outlier <- 0
  n_missing <- 0
  
  for(index in 1:length(layers) ){
    rm(workset_layer)
    rm(est)
    rm(x)
    rm(y)
    rm(s1)
    rm(outprediction)
    rm(predname)
    
    layer<- as.character(layers[index])
    workset_layer <- workset[workset[roles$S]==layer, , drop = TRUE ]
    
    
    x <- workset_layer[roles$X]
    y <- workset_layer[roles$Y]
    s1 <- workset_layer[roles$S]
    
    if(NCOL(y) ==1){
      predname = c("YPRED")
    } 
    else{
      for(i in 1:NCOL(y)) {
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
        outparams <- data.frame(tau=est$tau, outlier=est$outlier, pattern=est$pattern)
        
        outprediction <- as.data.frame(est$ypred)
        colnames(outprediction) <- predname
        
        #Set output parameters layer
        mod[[index]] <- list(layer=layer,N=NROW(x), B=est$B, sigma=est$sigma, lambda=est$lambda, w=est$w, is.conv = est$is.conv, sing = est$sing, bic.aic = est$bic.aic)
        #mod <- list(mod, layer=list(layer=layer,N=nrow(x), B=est$B, sigma=est$sigma, lambda=est$lambda, w=est$w, is.conv = est$is.conv, sing = est$sing, bic.aic = est$bic.aic))
        
        #Set output variables
        workset_out <- rbind(workset_out,cbind(x, y,s1, outprediction, outparams))
        
        n_outlier <- n_outlier + sum(est$outlier)
        n_missing <- n_missing + sum(as.numeric(est$pattern))
        
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
     
     outparams <- data.frame(matrix(NA, ncol = 3+NCOL(y), nrow = NROW(y)))
     colnames(outparams) <- c(predname,"tau","outlier","pattern")
     outprediction <- as.data.frame(NA)
     colnames(outprediction) <- predname
     workset_out <- rbind(workset_out,cbind(x, y,s1, outparams))
     mod[[index]] <- list(layer=layer,N=NROW(x),B=NA, sigma=NA, lambda=NA, w=NA, is.conv = FALSE, sing = NA, bic.aic = NA )

   }
  }#for

  params_out <- list(Model = toJSON(mod, auto_unbox = TRUE))
   
  
  report <- list(n.outlier = n_outlier, missing =n_missing )
  report_out <- list(Report = toJSON(report))
  
  #Set output roles & rolesgroup
  roles_out      <- list (O="outlier", M="Model",G="Report")
  rolesgroup_out <- list (M="M",G="G")
  
  roles_out [[IS2_SELEMIX_PREDIZIONE]]      <- c(roles$X,roles$Y,roles$S,predname,names(outparams))
  rolesgroup_out [[IS2_SELEMIX_PREDIZIONE]] <- c("P", "O")
  
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
  
  
  t.sel = 0.01
  
  #Check parameters
  if (!is.null(wsparams)) {
    if (exists("wsparams$tot"))
      tot = wsparams$tot
    if (exists("wsparams$t.sel"))
      t.sel = wsparams$t.sel
  }
  
  
  #Set variables
  s <- workset[[roles$S]]
  layers <- sort(unique(s))
  n_error <- 0
  predname <- c()
  workset_layer  <- data.frame()
  for (index in 1:length(layers)) {
    rm(workset_layer)
    layer <- as.character(layers[index])
    workset_layer <-
      workset[workset[roles$S] == layer, , drop = TRUE]
    
    wgt = rep(1, NROW(workset_layer))
    if (exists("wsparams$wgt"))
      wgt = wsparams$wgt
    
    y <- workset_layer[roles$Y]
    ypred <- workset_layer[roles$P]
    s1 <- workset_layer[roles$S]
    
    # tot=colSums(ypred * wgt)
    if (exists("wsparams$tot"))
      tot = wsparams$tot
    
    #Execute sel.edit
    #  sel_out <- sel.edit (y=y, ypred=ypred, wgt, tot, t.sel= as.numeric(t.sel))
    sel_out <- NA
    #Execute ml.est
    run <- tryCatch({
      sel_out <- sel.edit (y = y,
                           ypred = ypred,
                           t.sel = as.numeric(t.sel))
      inf <- sel_out[, "sel"]
      
      score <- sel_out[, c("rank", "global.score")]
      n_error = n_error + sum(out$sel)
      predname <- c("sel", "rank", "global.score")
      #Set output variables
      workset_out <-
        rbind(workset_out, cbind(workset_layer, inf, score))
      
    }
    #  ,
    #  warning=function(cond) {
    #    print(est)
    #    print(paste("Warning: layer ",layer, " ml.est did not converge! rows:" ,NROW(x)))
    #    return(NA)
    #     }
    ,
    error = function(cond) {
      print(paste("Error: layer ", layer, " rows:" , NROW(x)))
      print(cond)
      return(NA)
    })
    if (is.na(run)) {
      
    }
  }#for
  
  
  report <- list(n.error = n_error)
  report_out <- list(Report = toJSON(report))
  
  #Set output roles & rolesgroup
  roles_out      <-
    list (
      E = "sel",
      R = "rank",
      F = "global.score",
      G = names(report)
    )
  rolesgroup_out <- list (E = "E", G = "G")
  
  roles_out [[IS2_SELEMIX_ERROR]]      <-
    c(roles$X, roles$Y, predname)
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
  
  wgt=rep(1,nrow(workset))
  t.sel=0.01
  
  #Check parameters
  if(!is.null(wsparams)){
    if(exists("wsparams$wgt")) wgt=wsparams$wgt
    if(exists("wsparams$tot")) tot=wsparams$tot
    if(exists("wsparams$t.sel")) t.sel=wsparams$t.sel
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

