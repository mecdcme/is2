# Copyright 2019 ISTAT
# 
#  Licensed under the EUPL, Version 1.1 or � as soon they will be approved by
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

library("SeleMix")
library("rjson")

#stima del modello
is2_mlest <- function( workset, roles, wsparams=NULL,...) {
  
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
    })
  
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
  for(layer in layers){
		rm(workset_layer)
		rm(x)
		rm(y)
		rm(s1)
		rm(outp)
		rm(out1)
		 
	    workset_layer <- workset[workset[roles$S]==layer, , drop = TRUE ]
	  
	    x <- workset_layer[roles$X]
		y <- workset_layer[roles$Y]
		s1 <- workset_layer[roles$S]
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
    })
   
    
   }#for
  
  #Create log
  sink()
  close(con)
  
  return(result)
}

is2_mlest_layer_old <- function( workset, roles, wsparams=NULL,...) {
 	
	stdout <- vector('character')
	con <- textConnection('stdout', 'wr', local = TRUE)
		
	#Default params
	model="LN"
	t.outl=0.5
	lambda=3
	w=0.05
	lambda.fix=FALSE
	w.fix=FALSE
	eps=1e-7
	max.iter=500	
	
	#Parameter check
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
	
	# get DATASET 
    
	s <- workset[[roles$S]]
	
 	layers <- sort(unique(s))

    r_out <-c()
    print(layers)
	 mod <-c()
	param_mod <-c()
	for(layer in layers){
		rm(workset_layer)
		rm(x)
		rm(y)
		rm(s1)
		rm(outp)
		rm(out1)
		 
	    workset_layer <- workset[workset[roles$S]==layer, , drop = TRUE ]
	  
	    x <- workset_layer[roles$X]
		y <- workset_layer[roles$Y]
		s1 <- workset_layer[roles$S]
		
		#Execute algorithm (mettere un try catch)
		
		est <-  try(ml.est(y=y, x=x, model = model, lambda= as.numeric(lambda),  w= as.numeric(w), lambda.fix=lambda.fix, w.fix=w.fix, eps=as.numeric(eps), max.iter=as.numeric(max.iter), t.outl= as.numeric(t.outl), graph=FALSE))
		predname = c()
		out1 = c()
		if(("est"%in%ls() & class(est)[1]!="try-error")){
		    if(length(workset_layer)>1) ypred <- matrix(est$ypred,nrow=nrow(workset_layer),ncol=length(roles$Y))
			else ypred <- as.matrix(est$ypred)
			
			#reimpostazione nomi delle variabili
			outp <- data.frame(tau=est$tau, outlier=est$outlier, pattern=est$pattern)
			
			for(i in 1:ncol(ypred)) {
				pred = ypred[,i]
				predname = c(predname, paste("YPRED",i,sep="_"))
				out1 <- cbind(out1,pred)
			}
			out1=data.frame(out1)
			colnames(out1) <- predname
		}
		else{
			 outp <- data.frame(tau=NA, outlier=NA, pattern=NA)
		}
			#output 
			r_out<- rbind(r_out, cbind(x,y,s1,outp,out1))
			
				 
			#output parameters
			mod <- rbind(mod, toJSON(list(layer=layer,B=est$B, sigma=est$sigma, lambda=est$lambda, w=est$w )))
			
			#Report output 
			report <- list(n.outlier = sum(est$outlier), missing = sum(as.numeric(est$pattern)),  is.conv = est$is.conv, sing = est$sing, bic.aic = est$bic.aic)
			param_report <- list( Report = toJSON(report))
		
	} 
  		param_mod <- list( Model = toJSON(mod))
		print(	param_mod)
	#setting output roles 
	roles <- list (P= c(roles$X,roles$Y,roles$S, predname,names(outp)), O="outlier", M="Model",G="Report")
	#setting output rolesgroup 
	rolesgroup <- list (P= c("P", "O"),  M="M",G="G")
		
	#result 
	result <-list( workset_out=r_out, roles_out=roles,rolesgroup_out=rolesgroup, params_out=param_mod, report_out=param_report, log=stdout)
	
	sink()
	close(con)
	return(result)
}