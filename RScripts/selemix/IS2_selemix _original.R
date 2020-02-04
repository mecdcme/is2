# Copyright 2019 ISTAT
# 
#  Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
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
rm(list=ls())
library("SeleMix")
library("rjson")

#   Lista Ruoli
#0	SKIP				N	VARIABILE NON UTILIZZATA
#1	IDENTIFICATIVO		I	CHIAVE OSSERVAZIONE
#2	TARGET			  Y	VARIABILE DI OGGETTO DI ANALISI
#3	COVARIATA		  X	VARIABILE INDIPENDENTE
#4	PREDIZIONE			P	VARIABILE DI PREDIZIONE
#5	OUTLIER			  O	FLAG OUTLIER
#6	PESO				W	PESO CAMPIONARIO
#7	ERRORE			  E	ERRORE INFLUENTE
#8	RANKING			  R	INFLUENCE RANKING
#9	OUTPUT			  T	VARIABILE DI OUTPUT
#10	STRATO			  S	PARTIZIONAMENTO DEL DATASET
#11	PARAMETRI		  Z	PARAMETRI DI ESERCIZIO
#12	MODELLO			  M	MODELLO DATI
#13	SCORE			  F	INFLUENCE SCORE
#14	REPORT			  G	PARAMETRO DI OUTPUT / REPORT


# Lista oggetti Bridge Java - R
# SELEMIX_RESULTSET = "sel_out";
# SELEMIX_WORKSET =   "workset";
# SELEMIX_RUOLI_VAR = "role_var";
# SELEMIX_RUOLI_VAR_OUTPUT = "role_var_out";
# SELEMIX_RUOLI_INPUT = "role_in";
# SELEMIX_RUOLI_OUTPUT = "ruol_out";
# SELEMIX_PARAMETRI = "array_par";
# SELEMIX_MODELLO = "array_mod";


### ESEMPI DI MODELLI MONO E MULTIVARIATI

#MODELLO MULTIVARIATO 2 VAR TARGET
#B <- c(1.78840493, -0.065592887, 0.74442347, -0.009121287, -0.04293598,  1.048079464)
#sigma <- c(0.17068817, 0.03489681, 0.03489681, 0.49760310)
#lambda <- 19.96269
#w <- 0.2122271

#MODELLO MULTIVARIATO CON 2 VAR TARGET SENZA COVAR
#B <- c(5.973958, 5.112587)
#sigma <- c(0.3867086, -0.2527695, -0.2527695,  1.2920025)
#lambda <- 11.205
#w <- 0.332

#MODELLO MONOVARIATO	
#B <- c(-0.152, 1.215)
#sigma <- c(1.25)
#lambda <- 15.5
#w <- 0.0479

#MODELLO MONOVARIATO SENZA COVAR	
#B <- c(-0.152)
#sigma <- c(1.25)
#lambda <- 15.5
#w <- 0.0479

# Impostazione manuale dataset 
#workset <- read.csv2('C:/Users/pafrance/photon-workspace/Rscripts/input.strata.csv', dec=".", sep=";")

# imposta variabili di ruolo (specifica manualmente chi è target, covar ecc ecc)
#Y <- "Y1"
#X <- "X1"
#S <- "S1"

#prova passaggio parametri in json
ml_est_json = function(original_request) {
    request = fromJSON(original_request)
    
    final_result <- is2_mlest(request$workset, request$roles, request$wsparams)
    
    JSON_result = toJSON(final_result)
    return(JSON_result)
}




#stima completa
is2_mlest_ori <- function( workset, roles, wsparams=NULL,...) {
 	
	stdout <- vector('character')
	con <- textConnection('stdout', 'wr', local = TRUE)
	
    x <- workset[roles$X]
	y <- workset[roles$Y]
	
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
	print(wsparams)
	if(!is.null(wsparams)){
	
	print("asdfffffffffffffffffffffffffffffffffffffffffffff")
	print(wsparams$model)
		if(exists("wsparams$model")) model=wsparams$model
		if(exists("wsparams$t.outl")) t.outl=wsparams$t.outl
		if(exists("wsparams$lambda")) lambda=wsparams$lambda
		if(exists("wsparams$w")) w=wsparams$w
		if(exists("wsparams$lambda.fix")) lambda.fix=wsparams$lambda.fix
		if(exists("wsparams$w.fix")) w.fix=wsparams$w.fix
		if(exists("wsparams$eps")) eps=wsparams$eps
		if(exists("wsparams$max.iter")) max.iter=wsparams$max.iter
 	}
	
	#Execute algorithm (mettere un try catch)
	
	est <- ml.est(y=y, x=x, model = model, lambda= as.numeric(lambda),  w= as.numeric(w), lambda.fix=lambda.fix, w.fix=w.fix, eps=as.numeric(eps), max.iter=as.numeric(max.iter), t.outl= as.numeric(t.outl), graph=FALSE)
	if(length(workset)>1) ypred <- matrix(est$ypred,nrow=nrow(workset),ncol=length(roles$Y))
	else ypred <- as.matrix(est$ypred)
	
	#reimpostazione nomi delle variabili
	outp <- data.frame(tau=est$tau, outlier=est$outlier, pattern=est$pattern)
	predname = c()
	out1 = c()
	for(i in 1:ncol(ypred)) {
		pred = ypred[,i]
		predname = c(predname, paste("YPRED",i,sep="_"))
		out1 <- cbind(out1,pred)
	}
	out1=data.frame(out1)
	colnames(out1) <- predname
	#output parameters
	report <- list(n.outlier = sum(est$outlier), missing = sum(as.numeric(est$pattern)),  is.conv = est$is.conv, sing = est$sing, bic.aic = est$bic.aic)
	mod <- list(B=est$B, sigma=est$sigma, lambda=est$lambda, w=est$w )
	param_mod <- list( Model = toJSON(mod))
    #param_mod <- mod	
	
	param_report <- list( Report = toJSON(report))
	#param_report <-  report
	#setting output roles 
	 
	#roles <- list (P= c(roles$X,roles$Y, predname,names(outp)), O="outlier", M=names(mod), G=names(report))
	roles <- list (P= c(roles$X,roles$Y, predname,names(outp)), O="outlier", M="Model",G="Report")
	r_out<-cbind(x,y,outp,out1)
	rolesgroup <- list (P= c("P", "O"),  M="M",G="G")
	print(rolesgroup)
	#result <-list( workset_out=r_out, roles_out=roles,rolesgroup_out=rolesgroup, params_out=mod, report=report, log=stdout)
	result <-list( workset_out=r_out, roles_out=roles,rolesgroup_out=rolesgroup, params_out=param_mod, report_out=param_report, log=stdout)
	
	sink()
	close(con)
	return(result)
}




#stima completa con layer
is2_mlest <- function( workset, roles, wsparams=NULL,...) {
 	
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

#esecuzione strato
strata.mlest <- function(workset, y, x=NULL, s, ...) {
  #sistemazione dell'input
  strata <- as.factor(workset[,S])
  workset[,Y] <- as.numeric(workset[,Y])
  workset[,X] <- as.numeric(workset[,X])
  #init data
  df <- data.frame()
  mod <- data.frame()
  report <- data.frame()
  #esegue MLEST sullo strato
  for (i in levels(strata)) {
    w <- workset[workset[,S]==i, , drop = TRUE ]
  	est1<- mlest(w, Y, X)
    df <- rbind(df,  cbind(w, est1$out)) #ricreazione del dataset 
  }
  #costruisce la lista di ritorno
  result <-list( out= df, roles= est1$roles, mod = est1$mod, report = est1$report)
  return(result)
}

#Predizione da modello
is2_ypred <- function(workset, y, x=NULL, ... ) {
	if(!exists("model"))  model="LN"
	if(!exists("t.outl"))  t.outl=0.5
	
	#environment check
	if(missing(y)) stop('iSS Error: Missing TARGET Variable(s)')
	y <- matrix(as.numeric(workset[,Y]),ncol=length(Y),nrow=nrow(workset))
	if(!missing(x)) x <- matrix(as.numeric(workset[,X]),ncol=length(X),nrow=nrow(workset))
	
	if((exists('B')& exists('sigma')& exists('lambda')& exists('w'))) {
		sizex = ifelse(exists("X"), length(X), 0)
		beta <- matrix(as.numeric(B), nrow=1+sizex, ncol=length(Y), byrow=TRUE)
		s <- matrix(as.numeric(sigma), nrow=length(Y),  ncol=length(Y), byrow=TRUE)
		l <- as.numeric(lambda)
		v <- as.numeric(w)
	}
	else {
		stop('iSS Error: Missing model')
	}
	est <- pred.y(y=y, x=x, sigma = s, B = beta, model = model, lambda= l,  w= v, t.outl= as.numeric(t.outl))
	out <- data.frame(est) 

	#setting output roles
	report <- list(n.outlier = sum(est$outlier), missing = sum(as.numeric(est$pattern)) )
	roles <- list (P=colnames(out)[1:length(Y)], O= "outlier", G=names(report))
	result <- list( out=out, roles= roles, report = report)
	return(result)
}

#esecuzione strato
strata.ypred <- function(workset, y, x=NULL, s, ...) {
  #sistemazione dell'input
  strata <- as.factor(workset[,S])
  #workset[,S] <- as.factor(workset[,S])
  workset[,Y] <- as.numeric(workset[,Y])
  workset[,X] <- as.numeric(workset[,X])
  
  #esempio di selezione per strato
  df <- data.frame()
  report <- data.frame()
  #esegue YPRED sullo strato
  for (i in levels(strata)) {
  	w <- workset[workset[,S]==i, , drop = TRUE ]
  	est1<- ypred(w, Y, X) #ypred(w, y=y, x=x, sigma = s, B = beta, model = model, lambda= l,  w= v, t.outl= as.numeric(t.outl))
    df <- rbind(df,  cbind(w, est1$out)) #ricreazione del dataset 
  }
  result <-list( out=df, roles= est1$roles, report = est1$report)
  return(result)
}

#editing selettivo
is2_seledit <- function(workset, y, p, ...) {
    #controllo environment
	if(missing(y)|missing(p)) {
		stop('iSS Error: Missing TARGET or PREDICTION Variable(s)')
	}
	if(length(y)!=length(p)) {
		stop('iSS Error: Input dimension mismatch')
	}
	
	data <- matrix(as.numeric(workset[,Y]),ncol=length(Y),nrow=nrow(workset))
	ypred <- matrix(as.numeric(workset[,P]),ncol=length(P),nrow=nrow(workset))
	if(!exists("wgt"))  wgt=rep(1,nrow(workset))
	if(!exists("tot"))  tot=colSums(ypred * wgt) 
	if(!exists("t.sel"))  t.sel=0.01
	
	what <- sel.edit (y=data, ypred=ypred, wgt, tot, t.sel= as.numeric(t.sel))
	out= data.frame(what)
	
	#setting output roles
	report <- list(n.error = sum(out$sel))
	roles <- list (E="sel", R= "rank", F="global.score", G=names(report))
	result <-list( out= out, roles= roles, report = report)
	return(result)
}

#esecuzione strato
strata.seledit <- function(workset, y, p, s, ...) {
  #sistemazione dell'input
  strata <- as.factor(workset[,S])
  workset[,Y] <- as.numeric(workset[,Y])
  workset[,P] <- as.numeric(workset[,P])

  #esempio di selezione per strato
  df <- data.frame()
  #report <- data.frame()
  #esegue SELEDIT sullo strato
  for (i in levels(strata)) {
  	w <- workset[workset[,S]==i, , drop = TRUE ]
  	est1<- seledit(w, Y, P) 
    df <- rbind(df,  cbind(w, est1$out)) #ricreazione del dataset 
  }
  result <-list( out=df, roles= est1$roles, report = est1$report )
  return(result)
}

#esecuzione di prova in ambiente R
#est2 <- strata.mlest(workset, Y, X, S)