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




#Load libraries and capabilities
check_package <- function(i)     
  #  require returns TRUE invisibly if it was able to load package
  if( ! require( i , character.only = TRUE ) ){
    #  If package was not able to be loaded then re-install
    install.packages( i , dependencies = TRUE )
    #  Load package after installing
    require( i , character.only = TRUE )
  }


# Check load and then try/install packages
check_list <- c("SeleMix" , "jsonlite" , "dplyr", "data.table") 
lapply(check_list, check_package)
#print('Packages loaded')

#library("SeleMix")
#library("jsonlite")
#library("dplyr")
#library("data.table")


#[IS2 bridge] Global output variables
wsparams <- list()
roles <- list()
out <- NULL

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

#print('Bridge Set')

#########################
# Model and Prediction 
########################

#dummy function
is2_mlest_nolayer <- function( workset, roles, wsparams=NULL,...) {
  return (NULL)
}

#stima completa con layer
is2_mlest_layer <- function( workset, roles, wsparams=NULL,...) {

  
  #Output variables
  if(!exists("result"))          result <- list()
  if(!exists("workset_out"))     workset_out <- data.frame()
  if(!exists("roles_out"))       roles_out <- list() 
  if(!exists("rolesgroup_out"))  rolesgroup_out  <- list()
  if(!exists("params_out"))      params_out <- list()
  if(!exists("report_out"))      report_out <- list() 
  
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
  if( !is.null(get_role("STRATA"))) {
    print("strata found")
    s <- workset[[roles$STRATA]]
  }
  else{
    print("strata NOT found")
    s <- workset
  }
  layers <- sort(unique(s))
  n_layers <- length(layers)
  mod <- list()
  outvars<- data.frame()
  predname <- c()
  n_outlier <- 0
  n_layers_conv <- 0
  
  #print("checkpoint 1")
  
  for(index in 1:length(layers) ){
    if(exists("workset_layer")) rm(workset_layer)
    if(exists("est")) rm(est)
    if(exists("x")) rm(x)
    if(exists("y")) rm(y)
    if(exists("s1")) rm(s1)
    if(exists("outprediction")) rm(outprediction)
    if(exists("predname")) rm(predname)
    
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
    #print("running strata")
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
    if(length(run)==0 ){  #& is.na(run)
      print("n.a detected")
      outvars <- data.frame(matrix(NA, ncol = 3+NCOL(y), nrow = NROW(y)))
      outvars$conv <- rep(FALSE, NROW(y))
      colnames(outvars) <- c(predname,"conv","tau","outlier","pattern")
      outprediction <- as.data.frame(NA)
      colnames(outprediction) <- predname
      workset_out <- rbind(workset_out,cbind(x, y,s1, outvars))
      mod[[index]] <- list(layer=layer,N=NROW(x), is.conv = FALSE, B=NA, sigma=NA, lambda=NA, w=NA, bic_norm =NA, bic_mix=NA, aic_norm=NA,aic_mix=NA,n.iter=0)
      
    }
  }#for
  
  #print("output")
  params_out <- list("Contamination Model" = toJSON(mod, auto_unbox = TRUE))
  
  
  report <- list(n.outlier = n_outlier, "Layers"=n_layers ,"Convergent layers"=n_layers_conv)
  report_out <- list(Report = toJSON(report, auto_unbox = TRUE))
  
  #Set output roles & rolesgroup

  roles_out [[IS2_SELEMIX_OUTLIER]] <- c("outlier")
  roles_out [[IS2_SELEMIX_MODEL]]   <- c("Contamination Model")
  roles_out [[IS2_SELEMIX_REPORT]]  <- c("Report")
  
  
  roles_out [[IS2_SELEMIX_COVARIATE]]       <- c(roles$X)
  roles_out [[IS2_SELEMIX_TARGET]]          <- c(roles$Y)
  roles_out [[IS2_SELEMIX_STRATA]]          <- c(roles$STRATA)
  roles_out [[IS2_SELEMIX_PREDICTION]]      <- c(predname)
  roles_out [[IS2_SELEMIX_CONVERGENCE]]     <- c("conv")
  roles_out [[IS2_SELEMIX_OUTPUT_VARIABLES]]<- c(names(outvars))
  
  rolesgroup_out [[IS2_SELEMIX_MODEL]]    <- c(IS2_SELEMIX_MODEL)
  rolesgroup_out [[IS2_SELEMIX_REPORT]]   <- c(IS2_SELEMIX_REPORT)

  rolesgroup_out [[IS2_SELEMIX_PREDICTION]] <- c(IS2_SELEMIX_COVARIATE,IS2_SELEMIX_TARGET,IS2_SELEMIX_STRATA,IS2_SELEMIX_PREDICTION,IS2_SELEMIX_CONVERGENCE,IS2_SELEMIX_OUTPUT_VARIABLES,IS2_SELEMIX_OUTLIER)
  
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
ml_est <- function( workset, roles, wsparams=NULL,...) {
  
  #Create log
  stdout <- vector('character')
  #con <- textConnection('stdout', 'wr', local = TRUE)
  #sink(con)
  
  if(length(workset)==0) stop("empty workset")
  #imposta il modello
  n=length(get_role("Y"))
  set_role("OUT_PAR", c("n.outlier","is.conv","n.iter","sing","bic.aic", "msg", "model") )
  set_role("MODEL", c("B","sigma","lambda","w") )
  
  
  #impostazione dei ruoli di uscita
  predname <-  ifelse(n>1 ,list(paste("YPRED",seq(1:n),sep="")) , set_role("PRED","YPRED"))
  set_role("OUTLIERS","OUTLIER")
  set_role("OUTVARS", c("TAU",get_role("OUTLIERS"),"PATTERN") )
  set_role("MDLOUT","Contamination Model")
  set_role("REP","Report")
  set_role("PRED",predname)
  set_role("CONV","conv")
  rolesgroup_out <- list( MDLOUT ="MDLOUT", REP = "REP",   PRED = c ("X","Y","STRATA","PRED","CONV","OUTVARS","OUTLIERS"))
  
  
  #init
  strata <- NULL
  result <- NULL
  nlayers <- 1
  
  tryCatch ({
    #print('call generic executor')
    tree <- is2_ml_est(workset, roles, wsparams, "ml.est")
    #print(str(tree))
    workset_out <- rbindlist( lapply(tree, function(p)  {  #per ogni strato
       #print(str(p))
      t <- p$out
      if(is.list(t)) unlist(t)
      t <- as.data.frame(t)
       })  
    )
    #print(str(workset_out))
    model_out <- rbindlist( lapply(tree, function(p)  {  #per ogni strato
      #print(str(p))
      t <- p$model
      if(is.list(t)) unlist(t)
      t <- as.data.frame(t)
      
    })  
    )
    #print(str(model_out))
    report_out <- rbindlist( lapply(tree, function(p)  {  #per ogni strato
      #print(str(p))
      t <- p$par
      if(is.list(t)) unlist(t)
      t <- as.data.frame(t)
      
    })  
    )
    #print(str(model_out))
    
  result[[IS2_WORKSET_OUT]]     <- workset_out
  result[[IS2_ROLES_OUT]]       <- lapply(roles, function(item) {item} )
  result[[IS2_ROLES_GROUP_OUT]] <- rolesgroup_out
  result[[IS2_PARAMS_OUT]]      <- list("Contamination Model" = toJSON(model_out, auto_unbox = TRUE))
  #result[[IS2_PARAMS_OUT]]      <- model_out
  result[["Strata_Info"]] <- list("Output Parameters" = toJSON(report_out, auto_unbox = TRUE))
  #result[["Strata_Info"]] <- report_out
  result[[IS2_REPORT_OUT]]      <- list("Report" =  toJSON( list(
                                       n.outlier = print(sum(workset_out[workset_out$OUTLIER == 1, "OUTLIER"], na.rm=TRUE))
                                      ,Layers = get_param("nlayers")
                                      ,Covergent_layers = get_param("NUM_CONV_LAYERS")
                                      ) , auto_unbox = TRUE
                                    ) 
                                  )
  result[[IS2_LOG]]             <- stdout
  
  })
  print("Execution ended successfully. Result follows:")
  print(str(result))
  return(result)
}



#########################
# Selective Editing
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
  s <- workset[[roles$STRATA]]
  layers <- sort(unique(s))
  n_error <- 0
  predname <- c()
  workset_layer  <- data.frame()
  for (index in 1:length(layers)) {
    rm(workset_layer)
    run<-NA
    
    layer <- as.character(layers[index])
    workset_layer <-
      workset[workset[roles$STRATA] == layer , , drop = TRUE]
    y <- workset_layer[roles$Y]
    ypred <- workset_layer[roles$PRED]
    s1 <- workset_layer[roles$STRATA]
    out_layer<- workset_layer[roles$OUTLIERS]
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
  
  roles_out [[IS2_SELEMIX_ERROR]]      <-   c(roles$X,roles$Y, roles$PRED, roles$STRATA,roles$V, "sel",  "rank", "global.score")
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
  rolesgroup_out [[IS2_SELEMIX_ERROR]] <- c("PRED", "O")
  
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
  if(is.null(roles$STRATA)){
    return (is2_seledit_nolayer(workset, roles, wsparams))
  }
  else
  {	
    return (is2_seledit_layer(workset, roles, wsparams))
  }
}

#########################
# IS3 Utilities
########################


set_param <- function( a, b ) { 
  tryCatch( wsparams[[a]] <<- b ,
            
            error=function(cond) {
              
              print(cond)
              return(NA)
            })
}

set_role <- function( a, b ) { 
  tryCatch( roles[[a]] <<- b ,
            
            error=function(cond) {
              print("Set error: ")
              print(cond)
              return(NA)
            })
}

get_param <- function( a ) { # ... accepts any arguments
  out <- NULL
  try( out <- wsparams[[a]] )
  return(out)
  
}

get_role <- function( a ) { # ... accepts any arguments
  
  out <- NULL
  try( out <- roles[[as.character(a)]] )
  return(out)
  
}

#calcola la nunghezza dei tronconi di una lista di liste e/o data frame
len <- function(l) {  
  
  if(is.list(l)&&!is.data.frame(l)) lapply(l, function(t) {max(unlist(lapply (t, function(p) { length(p) }))) }) 
  else   length(l)
}


# Desume il numero di righe degli strati dalla lunghezza massima degli oggetti dello strato
# ATTE: puo' fallire in caso di strati esigui e presenza di altri parametri multidimensionali nello strato stesso
strata.len <- function( out) { 
  
  #lista di liste
  #lunghezza dei tronconi di dataset
  return( lapply(out, function(t) {max(unlist(lapply (t, function(p) { length(p) }))) })  )
  
  
}

#estrae la parte di dataset prevalente per tentare di ricostruire una lista di dataset
get_output <- function( out, lenws = strata.len(out)) { 
  
  outvars <-  lapply(seq_along(lenws), function(p)  {  out[[p]][sapply(out[[p]], function(t) {length(t) == lenws[[p]]  })]  })
  #outvars <-  as.data.frame(rbindlist(lapply(outvars, as.data.frame),fill=TRUE))
  return(outvars)
  
}

rebuild <- function( out, ws=NULL) { # se viene specificato il dataset di origine, tenta di unirlo al'output
  #riassembla il dataset completo riunendo prima gli strati in un unico data frame
  
  #matrice semplice
  if(is.matrix(out)) out <- as.data.frame(out)
  
  #lista di matrici
  if(is.list(out)&&(is.matrix(out[[1]]))) { 
    #print("Stratifierd Matricial output")
    out <- as.data.frame(rbindlist(lapply(out, as.data.frame),use.names=TRUE, fill=TRUE))
  }
  
  #lista di liste
  if(!is.data.frame(out))  {
    #print("List of list")
    out <- rbindlist(get_output(out) ,use.names=TRUE, fill = TRUE)
  } 
  
  # #E' possibile connettere l'input all'output con merge o rcbind
  # if(!is.null(ws)) tryCatch( {
  #   if(!is.data.frame(ws)) ws <- rbindlist(ws, fill=TRUE, use.names=TRUE)
  #   if(length(intersect(names(out),names(ws) ))) {
  #     #print("merging")
  #     out <- merge(ws,out, all.x=TRUE, all.y = TRUE, by=unique(names(ws)))} #tenta il merge se ci sono variabili in comune
  #   else {
  #     #print("binding")
  #     if(nrow(ws)==nrow(out)) out <- bind_cols(ws,out)
  #     #print("bound")
  #   }
  # }
  # #, 
  # #error=function(cond) {
  # #  print("escape route")
  # #  return(as.data.frame(out1))
  # #}
  # )#end tryCatch 
  
  #print("rebuilt")
  #print(str(out))
  return(as.data.frame(out))
}

get_output_par <- function( out, lenws = strata.len(out)) { 
  
  
  #lenws <- lapply(out, function(t) {length(t[[1]]) })  #lunghezza dei tronconi di dataset in base al primo elemento
  #outpars <-  lapply(seq_along(lenws), function(p)  {  out[[p]][sapply(out[[p]], function(t) {length(t) != lenws[[p]] })]  })
  outpars <-  lapply(seq_along(lenws), function(p)  {  out[[p]][sapply(out[[p]], function(t) {length(t) != out[[p]]$nrow })]  })
  
  return(outpars)
}

compact_par <- function(ls) { #combines list of lists with same structure
  #init
  if(length(ls)==0) { 
    stop("empty subset")
  }
  tmp <- ls[[1]]
  l = length(tmp)
  lapply(seq_along(ls), function(i) { 
    
    #combina i componenti per nome
    #if(i>1) tmp <<- Map(rbind, tmp, ls[[i]])
    
    #ATTENZIONE patch temporanea (devo scartare tutti gli elementi incompatibili o rbind non funzioner�)
    if(i>1&&l==length(ls[[i]])) tmp <<- Map(rbind, tmp, ls[[i]])  
  })
  
  tmp <- as.data.frame(tmp)
  return(tmp)
  
}


#parm <- formals(name) #get a list of function input parameters
#verifica della presenza dei parametri della funzione per evitare errori nel passaggio  
#rende la lista dei parametri di input compatibile con la signature della funzione fname
match_function_par <- function( fname, parlist) parlist[intersect(names(parlist), names(formals(fname)))]

#unisce due liste in base ai nomi. 
#NON TRANSITIVA: Se ci sono due nomi uguali prende quelli di a. 
union_list <- function( a, b) a[union(names(a), names(b))]

#cerca i nomi delle variabili (ad es tutte le ypred)
match_var_names <- function( x, what ) {
  
  y<-names(x)
  res <- y[startsWith(y,what)]
  
  if(!length(res)>0) 
    for(i in x) 
      if(is.list(i)) res <- match_var_names(i, what) 
  
  return(res)
}

cat_lst <- function( ... ) {
  l = args()
  keys <- unique(unlist(lapply(l, names)))
  setNames(do.call(mapply, c(FUN=c, lapply(l, `[`, keys))), keys)
}

#########################
# Rewriting SELEMIX functions
########################


#stima parallela con stratificazione
is2.ml.est <- function(workset, roles, params, fname=ml.est) { #temporaneamente inserieco ml.est di default
  
  #controllo della lista dei parametri input
  parlist <- append( list( y = substitute(t[, roles[["Y"]]]), x = substitute(t[, roles[["X"]]]), ypred = substitute(t[, roles[["PRED"]]]) ), params)
  
  #controllo della lista dei parametri input
  parlist <- match_function_par(fname, parlist)
  
  #print("Exec funcion ")
  #print(parlist)
  
  if(is.null(roles[["STRATA"]])) {
    
    #esecuzione non stratificata
    out <- do.call(fname, list( y=workset[, roles$Y],  x=workset[, roles$X],  unlist(parlist)))
  }
  else {
    
    #esecuzione stratificata
    #stratificazione dataset se non gia' eseguita  
    if(is.data.frame(workset))  workset <- split(workset, as.factor(workset[,roles[["STRATA"]]]))  
    #out <- lapply(workset, function(t) { fname(y=t[, roles$Y],  x=t[, roles$X], unlist(parlist)) })
    #out <- lapply(workset, function(t) { fname(y=t[, roles$Y],  x=t[, roles$X], t.outl=get_param("t.outl")  ) })
    out <- lapply(ws, function(t) {  
      par <- lapply(parlist, function(item) {if(is.language(item)) as.numeric(eval(item)) else item } )
      do.call(fname,par,quote = TRUE)
    })
    
  }
  
  return(out) #lascia il workset splittato
  
}


#stima con stratificazione
is2.sel.edit <- function(workset, roles, params, fname=sel.edit) { #temporaneamente inserieco ml.est di default
  
  #print(as.list( match.call() ) ) #lista dei parametri
  
  #controllo della lista dei parametri input
  parlist <- match_function_par(fname, params)
  
  if(is.null(roles[["STRATA"]])) {
    
    #esecuzione non stratificata
    print("Stima semplice")
    out <- do.call(fname, list( y=as.matrix(workset[, roles$Y]),  ypred=as.matrix(workset[, roles$PRED])))
  }
  else {
    
    #esecuzione stratificata
    print("Stima stratificata")
    if(is.data.frame(workset))  workset <- split(workset, as.factor(workset[,roles[["STRATA"]]]))  #stratificazione dataset se non già eseguita
    out <- lapply(workset, function(t) { fname(y=as.matrix(t[, roles$Y]),  ypred=as.matrix(t[, roles$PRED])) })
    
  }
  
  return(out) #lascia il workset splittato
  
}


stratify <- function(dataset, role = get_role("STRATA")) { 
  
  if(is.null(role)) {
    print(paste("STRATA NOT detected: "))
    return(list(a=dataset))
  }else {
    ws <- split(dataset, as.factor(dataset[,role]))
    set_param("nlayers", nlayers <- length(ws))
    print(paste("STRATA detected: ",role," with ",nlayers," layers"))
    return(ws)
  }
}



stratify_old <- function(dataset, role = NULL) { 

  if(!is.data.frame(dataset)) return (dataset)
  else {
    if(!is.null(role)) return (split(dataset, as.factor(dataset[,role])))
    else return(list(a=dataset))
  }
}

#esecuzione generica (differenzia tra caso stratificato e non)  
is2.exec.fname <- function(workset, roles, params, fname) { 
  
  #i ruoli vanno ridefiniti per poter essere valutati a runtime all'interno della chiamata do.call
  #fac simile (istruzione non utilizzata, valida solo per reference)
  parlist <- list( y = substitute(t[, roles[["Y"]]]), x = substitute(t[, roles[["X"]]]), ypred = substitute(t[, roles[["PRED"]]]))
  
  #controllo della lista dei parametri input
  parlist <- match_function_par(fname, params)
  
  if(is.null(roles[["STRATA"]])) {
    
    #esecuzione non stratificata
    print("Esecuzione senza strati")
    t<-workset
    parlist <- lapply(parlist3, function(item) {if(is.language(item)) as.numeric(eval(item)) else item } )
    out <- do.call(fname, parlist)
  }
  else {
    
    #esecuzione stratificata
    print("Esecuzione stratificata")
    
    if(is.data.frame(workset))  workset <- split(workset, as.factor(workset[,roles[["STRATA"]]]))  #stratificazione dataset se non gia' eseguita
    out <- lapply(ws, function(t) {  
      parlist <- lapply(parlist, function(item) {if(is.language(item)) as.numeric(eval(item)) else item } )
      do.call(fname,parlist,quote = TRUE)
    })
    
  }
  
  return(out) #lascia il workset splittato
  
}

#esecuzione generica (esegue anche un solo strato o zero come se fosse stratificato)  
is2.exec <- function(workset, roles, params, fname) { 
  
  #i ruoli vanno ridefiniti per poter essere valutati a runtime all'interno della chiamata do.call
  #fac simile (istruzione di default per la formattazione dri ruoli di input)
  parlist <- list( y = substitute(t[, roles[["Y"]]]), x = substitute(t[, roles[["X"]]]), ypred = substitute(t[, roles[["PRED"]]]))
  
  #controllo della lista dei parametri input
  parlist <- match_function_par(fname, append(params,parlist))
  
  
  #print("Esecuzione funzione generalizzata")
  #print(parlist)
  
  #stratificazione dataset se non gia' eseguita
  ws <- stratify(workset,roles[["STRATA"]])
  
  out <- lapply(seq_along(ws), function(p) {  
    
    t <- ws[[p]] #t non � pi� indice ma l'elemento effettivo
    n=NROW(t)
    
    #print("parameter discovery")
    par <- lapply(parlist, function(item) {if(is.language(item)) as.numeric(eval(item)) else item } )
    
    print(paste("Strata #",as.character(p)))
    outmp <- tryCatch( 
      {
        do.call(fname,par,quote = TRUE)
      }  
      , 
      error=function(cond) {
        print(paste("Error: layer ",p, " rows:" ,NROW(t) ))
        print(cond)
        
        #return(NULL)
      })#end tryCatch
    
    #print("Sistemazione out")
    
    #try(outmp<-as.data.frame(outmp), silent = TRUE)
    if(is.matrix(outmp)) outmp <- as.data.frame(outmp)
    parm = c(outmp[sapply(outmp, function(q) {length(q) != n  })], layer=p, nrow = n )
    wout = cbind(t,outmp[sapply(outmp, function(q) {length(q) == n  })] )
    #list(out=wout, par=parm) #produce un alberatura
    c(wout, parm) #produce una lista di liste
    
    #print("fine ciclo")
    
    
  }) #end lapply
  return(out) #lascia il workset splittato
  
}

#esecuzione generica (esegue anche un solo strato o zero come se fosse stratificato)  
is2_ml_est <- function(workset, roles, params, fname="ml.est") { 
  
  #i ruoli vanno ridefiniti per poter essere valutati a runtime all'interno della chiamata do.call
  #fac simile (istruzione di default per la formattazione dri ruoli di input)
  parlist <- list( y = substitute(t[, roles[["Y"]]]), x = substitute(t[, roles[["X"]]]), ypred = substitute(t[, roles[["PRED"]]]))
  #controllo della lista dei parametri input
  parlist <- match_function_par(fname, append(params,parlist))
  
  
  #print("Esecuzione funzione generalizzata")
  #print(parlist)
  
  #prapare new columns and counters
  workset$layer <- 0
  workset$nrows <- 0
  workset$conv <- FALSE
  
  conv_layers <- 0
  
  #stratificazione dataset se non gia' eseguita
  #print("Stratificazione")
  ws <- stratify(workset)
  wm <- list()
  wr <- list()
  
  print("Esecuzione funzione")
  out <- lapply(seq_along(ws), function(p) {  
    
    t <- ws[[p]] #t non � pi� indice ma l'elemento effettivo
    t$nrows <- nr <- NROW(t)
    t$layer <- as.character(p)
    strata <- get_role("STRATA")
    strataval <- ifelse(!is.null(strata), unique(t[,strata]), "" )
    #print("parameter discovery")
    par <- lapply(parlist, function(item) {if(is.language(item)) as.numeric(eval(item)) else item } )
    
    print(paste("Strata #",as.character(p)," nrows = ", nr))
    tryCatch( 
      {
        tmp <- do.call(fname,par,quote = TRUE)
        
        # print(names(tmp))
        # print(c(get_role("PRED"),get_role("OUTVARS")))
        t$conv <- tmp$is.conv 
        if(tmp$is.conv) conv_layers <- conv_layers+1
        t$YPRED <- tmp$ypred
        t$TAU <- tmp$tau
        t$PATTERN <- tmp$pattern
        t$OUTLIER <- tmp$outlier
        #sistemazione modello dati
        m <- list()
        m$B <- tmp$B      
        m$sigma <- tmp$sigma
        m$lambda <- tmp$lambda
        m$w <- tmp$w
        m$strata <- strataval
        wm <- c(wm,m)
        #sistemazione report
        r <- list()
        r$n.outlier <- tmp$n.outlier
        r$is.conv <-  tmp$is.conv
        r$n.iter <- tmp$n.iter
        r$sing <- tmp$sing
        r$bic.aic <- tmp$bic.aic
        r$msg <- tmp$msg
        r$model <- tmp$model
        r$strata <- strataval
        wr <- c(wr,r)
      }  
      , 
      error=function(cond) {
        t$YPRED = NA
        t$TAU = NA
        t$PATTERN = NA
        t$OUTLIER = NA
        
        # m <- list()
        # m$B <- tmp$B      
        # m$sigma <- tmp$sigma
        # m$lambda <- tmp$lambda
        # m$w <- tmp$w
        # r <- list()
        # r$outlier <- tmp$outlier 
        # r$n.outlier <- tmp$n.outlier
        # r$pattern <- tmp$pattern
        # r$is.conv <-  tmp$is.conv
        # r$n.iter <- tmp$n.iter
        # r$sing <- tmp$sing
        # r$bic.aic <- tmp$bic.aic
        # r$msg <- tmp$msg
        # r$model <- tmp$model
        # wm <- c(wm,m)
        # wr <- c(wr,r)
        
        #print(paste("Error: layer ",p, " rows:" ,NROW(t) ))
        print(cond)
      })#end tryCatch
    
    list(out=t, par=wr, model=wm) #produce un alberatura
  }) #end lapply
  set_param("NUM_CONV_LAYERS", conv_layers)
  return(out) #lascia il workset splittato
  
}


#estrae modello e parametri
get_subset <- function(ws, df=ws, ls=NULL, str=NULL, except = FALSE) {
  
  #print("Controllo data list")
  #se si tratta di una lista (di data frame), converte in data frame
  if(!is.data.frame(ws))   ws <- compact_par(get_output_par(ws, strata.len(df)))
  
  #print("Controllo ls")
  #se la lista del subset non � specificata restituisce tutto il data frame
  if(!is.null(ls)) {
    #Estrae il subset o la rimanenza secondo i nomi spefificati in ls
    if(except) ws<-unique(ws[, !names(ws) %in% ls ])
    else ws<-unique(ws[, names(ws) %in% ls ]) 
  }
  
  #print("unlist nested lists")
  #unlist residual nested lists
  ws <- lapply(ws, function(t) {
    if(is.list(t)) array(unlist(t), dim=length(t))
    else t
  })
  
  #print("Adding stratification info")
  ws <- as.data.frame(ws)
  
  #inserisce lo strato (se presente)
  if(!is.null(str)) {
    n <- c(names(ws), paste(get_role("STRATA")))
    ws <- cbind(ws, tmp=levels(str))
    names(ws) <- n
  }
  
  #print("Output formatted successfully")
  return(ws)
}

find_duplicates <- function (ws, x) {
  tryCatch( {
    n_occur <- data.frame(table(ws[[x]])) #conteggio frequenze
    n_occur[n_occur$Freq > 1,]                     #freq>1 -> sequenze ripetute
    return (ws[ws[[x]] %in% n_occur$Var1[n_occur$Freq > 1],]) #estrazione righe con id duplicato
  },
  error=function(cond) {
    print(cond)
    return(NULL)
  })#end tryCatch
  
}


#rewrites write.csv to account for missing columns
write_csv <- function(x, file, header, f = write.csv, ...){
  # create and open the file connection
  datafile <- file(file, open = 'wt')
  # close on exit 
  on.exit(close(datafile))
  # if a header is defined, write it to the file (@CarlWitthoft's suggestion)
  if(!missing(header)) {
    writeLines(header,con=datafile, sep='\t')
    writeLines('', con=datafile, sep='\n')
  }
  # write the file using the defined function and required addition arguments  
  f(x, datafile,...)
}

#print('End of File')