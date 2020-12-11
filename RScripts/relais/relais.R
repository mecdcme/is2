#library(varhandle)
#eliminazione di ogni precedente elaborazione (pulizia memoria)
rm(list=ls())
#Programma valido per una variabile latente dicotomica e k variabili manifeste dicotomiche
#vincolo sul numero di variabili: numero variabili >= 3
#lettura del file contenente i parametri di input:
#nvar= numero variabili manifeste
#contingencyTableName= nome della tabella che contiente la matrice di contingenza
#muTableName=nome della tabella che contenente i parametri stimati, nel caso di stima **affidabile** del modello
#percorso_fail=path del file contenete le condizionate alla variabile latente, nel caso di stima ** non affidabile** del modello
#eps,iter parametri del modello EM con valori di default

#percorso_fail="FSFail.Rout"
#percorso_allert="FSAllert.Rout"

fellegisunter <- function(workset, roles, wsparams=NULL, ...) {

workset_ct=workset$CT
	
ct <- roles$CT


 nvar=length(ct)-1
 #yy <-  as.data.frame(matrix(as.numeric(workset_ct[,ct]),ncol=length(ct),nrow=nrow(workset_ct)))
 yy <- workset_ct

 colnames(yy)<- ct
 #print(yy)	 
	muTableName="muTable"
	varmuTableName="varmuTable"
	r_out <- vector()
	var_est<-c()
	result<-c()
 
	eps=0.0000001
	iter=1500
	interazioni=vector("list", nvar)
	for (i in (1:nvar))
	interazioni[[i]]=c(nvar+1,i)
	
	#inizializzazioni delle variabili per le iterazioni del metdodo EM
	i=1
	stop=0
	ynew=0
	
	#Crea alcune variabili stringa utili per la parametrizzazione del programma
	variabili<-paste('Freq',paste(paste('V',nvar:1,sep=''),collapse='+'),sep='~')
	#print(variabili)
	
	nomimatvar = names(yy)[1:nvar]
	
	 
	#aggiorno i valori di frequency a o
	if(nrow(yy[yy$FREQUENCY==0,])>0)
	  yy[yy$FREQUENCY==0,]$FREQUENCY<-0.0001
	 
	#legge i dati come data frame
	names(yy) [nvar+1] = 'Freq'
	for(i in 1:nvar) names(yy)[i] = paste('V',i,sep='')
	#crea la matrice yy1 con la variabile latente
	yy1=rbind(yy,yy)
	x<-as.integer(gl(2,2^nvar,2^(nvar+1)))-1
	yy1=cbind(x,yy1)
	
	#assegna i valori iniziali alla matrice yy1
	yy2=as.matrix(log(yy1[,2:(nvar+1)]*ifelse(x>0.9,0.8,0.2)+((1-yy1[,2:(nvar+1)])*ifelse(x>0.9,0.2,0.8))))%*%matrix(rep(1,nvar),nvar)
	yy1[,nvar+2]=((yy1[,1]*0.1+(1-yy1[,1])*0.9)*exp(yy2))*sum(yy1[,nvar+2])/2
	
	#passo M - modello loglineare sulla tabella completa
	while (stop == 0) {
	   y<-xtabs(as.formula(paste(variabili,'x',sep='+')), data=yy1);
	   stepm=loglin(y,interazioni,fit=T,print=F);
	   diff=abs(max(ynew-stepm$fit));
	   ynew=stepm$fit;
	   ycond=xtabs(as.formula(variabili), data=yy)/xtabs(as.formula(variabili), data=ynew); 
	   Freq=rbind(as.matrix(ynew[1:(2^nvar)]*ycond),as.matrix(ynew[((2^nvar)+1):(2^(nvar+1))]*ycond));
	   yy1=cbind(yy1[,1:(nvar+1)],Freq);
	   i=i+1;
	   stop=ifelse(diff>eps,0,1)+ifelse(i<=iter,0,1)
	}
	
	#probabilità condizionate alla variabile latente
	#xtabs(Freq~x, data=yy1)/ sum(yy1[,(nvar+2)])
	l=list()
	vett=vector("numeric")
	mvar <- vector("numeric")
	uvar <- vector("numeric")
	
	for(i in 1:nvar) {
		tabella=paste('Freq~V',i,sep='');
		tabella=paste(tabella,'+x',sep='');
		tab=xtabs(as.formula(tabella), data=yy1)/ rbind(xtabs(Freq~x, data=yy1),xtabs(Freq~x, data=yy1));
		l[[i]]=tab
		vett=c(vett,tab)
		mvar <- c(mvar,tab[2,2],tab[1,2])
		uvar <- c(uvar,tab[2,1],tab[1,1])
	}
	
	## salvataggio della tabella delle marginali spostata sotto
	
	#Verifica condizione di stima inaffidabile dei parametri
	
	#1 check su stime v1-vn e var latente x (vedi blocco laura)
	check = 0;
	
	for(i in 1:nvar){
	if((l[[i]][1,1]>=l[[i]][2,1] && l[[i]][1,2]>=l[[i]][2,2]) || (l[[i]][1,1]<l[[i]][2,1] && l[[i]][1,2]<l[[i]][2,2]))
	 check = 1;
	}
	if(check==1){

		#Error message and stop elab
		 msg = "ERROR: one or more variables give inconsistent estimates. Please, check the variables in the model or try to reduce the search space.";
		 msg2 = paste("See MARGINAL_PROBABILITIES output for more details."); 
		 
		 print(msg)
		 print(msg2)
		
		 
		 #default value to p for the marginal prob table
		 p <- 0
	}else{
		
		vett_cond=vett[vett>0.99999]
		if (length(vett_cond)>=1)
		{
		# warning message continue elab
			msg = paste("WARNING: one or more nearly boundary parameters.");
			msg2 = paste("See MARGINAL_PROBABILITIES output for more details.");
			print(msg);
		}
		#produce la matrice in output
		#per la stima di m e u utilizziamo le frequenze attese dal modello
		# mentre nella tabella mu appaiono le frequenza f_m f_u riproporzionate sui valori osservati
		# f_u_att e f_u_obs differiscono tanto più quanto più é scarso il fit del modello
		f_u_att=as.matrix(ynew[1:2^nvar])
		f_m_att=as.matrix(ynew[((2^nvar)+1):(2^(nvar+1))])
		u=f_u_att/sum(f_u_att)
		m=f_m_att/sum(f_m_att)
		p=sum(f_m_att)/sum(yy1[,(nvar+2)])
		r=m/u
		p_post=m*p/(m*p+u*(1-p))
		u=round(u, digits=5)
		m=round(m, digits=5)
		r=round(r, digits=5)
		p_post=round(p_post, digits=5)
		f_u_obs=as.matrix(ynew[1:2^nvar]*ycond)
		f_m_obs=as.matrix(ynew[((2^nvar)+1):(2^(nvar+1))]*ycond)
		f_m_obs=round(f_m_obs, digits=5)
		f_u_obs=round(f_u_obs, digits=5)
		r_out=cbind(yy[,1:nvar],f_m_obs,f_u_obs,m,u,r,p_post)
		
		r_out =r_out [order(r_out$r , decreasing = FALSE ),]
		
		prec_oss <- rep(0,2^nvar)
		recl_oss <- rep(0,2^nvar)
		for (j in 1:2^nvar) {
		   prec_oss[j] <- sum(r_out$f_m_obs[j:2^nvar])/(sum(r_out$f_m_obs[j:2^nvar])+sum(r_out$f_u_obs[j:2^nvar]))
		   recl_oss[j] <- sum(r_out$f_m_obs[j:2^nvar])/sum(r_out$f_m_obs)
		}
		
		prec_oss=round(prec_oss, digits=5)
		recl_oss=round(recl_oss, digits=5)
		
		r_out <- cbind(r_out,prec_oss,recl_oss)
		names(r_out)[-(1:nvar)] <- c("F_M","F_U","M","U","R","P_POST","PRECISION","RECALL")
		
		msgP = paste("The match frequency estimated from EM algorithm is p = ",round(p, digits=6));
		print(msgP);
		
		# inserisco i nomi delle matvar per creare la tabella
		names(r_out)[1:nvar]=nomimatvar
		
		
	}


	
			# creo la tabella delle marginali
	var_est <- data.frame(rep(nomimatvar, rep(2,length(nomimatvar))),rep(c("1","0"),length(nomimatvar)),mvar,uvar,rep(p,2*length(nomimatvar)),stringsAsFactors=FALSE)
	names(var_est)=c("variable","comparison","m","u","p")
	

 roles <- list (FS=names(r_out),MP=names(var_est))
 rolesgroup <- list (FS= c("FS"), MP= c("MP"))
 
 fs_out<-list(FS=r_out,MP = var_est)

 result <-list( workset_out=fs_out, roles_out= roles, rolesgroup_out= rolesgroup,  log = '')

}


##################################################
### function: lpreduction
### phase: Matching consraint - apply a contraint to reduce the match pairs
### parameter: ReducType ('1to1','1toN','Nto1')
### input: Math_table  output: Match_table_reduced
### packages required: lpSolve + slam
##################################################


lpreduction <- function(workset, roles, wsparams=NULL, ...) {

 print("read input");
 workset_mt=workset$MT
 mt <- roles$MT
 ReducType <- '1to1'

 print("start procedure");
# command1: apply preliminary filter to input data
filtered=workset_mt[,c("ROW_A","ROW_B","P_POST","R")] 

# log
dim(filtered)

# command2: pre-processing input
# count of unique dataset ID records
n= length(unique(filtered[,1]))
m= length(unique(filtered[,2])) 
# add sequential keys for dataset records
A=cbind(ROW_A=unique(filtered[,1]),A=1:n) 
B=cbind(ROW_B=unique(filtered[,2]),B=1:m)
filtered =merge(B, filtered)
filtered =merge(A, filtered)
dat=t(filtered)

# command3: preparing constraint parameter
if (ReducType=='1toN') {
   constr <- matrix(c(as.numeric(dat[2,]),rep(1:ncol(dat)),rep(1,ncol(dat))),ncol=3)
   #constr <- simple_triplet_matrix(as.numeric(dat[2,]), rep(1:ncol(dat)), rep(1,ncol(dat)), nrow=n, ncol=ncol(dat))     
   diseq=rep('<=',n)  
   ones=rep(1,n)  
} else if (ReducType=='Nto1') {
   constr <- matrix(c(as.numeric(dat[4,]),rep(1:ncol(dat)),rep(1,ncol(dat))),ncol=3)
   #constr <- simple_triplet_matrix(as.numeric(dat[4,]), rep(1:ncol(dat)), rep(1,ncol(dat)), nrow=m, ncol=ncol(dat))     
   diseq=rep('<=',m)  
   ones=rep(1,m)
} else {
   constr <- matrix(c(as.numeric(dat[2,]),as.numeric(dat[4,])+n,rep(1:ncol(dat),2),rep(1,(2*ncol(dat)))),ncol=3)
   #constr <- simple_triplet_matrix(c(as.numeric(dat[2,]),as.numeric(dat[4,])+n), rep(1:ncol(dat),2), rep(1,(2*ncol(dat))), nrow=(n+m), ncol=ncol(dat))     
   diseq=rep('<=',m+n)  
   ones=rep(1,m+n)
}

# command4: coefficients for target function 
coeff=dat[6,]    

 print("lp execution");
# command5: LP execution  -- note: ROI.plugin.clp not available in renjin -- use: lpSolve
# LP <- ROI::OP(as.numeric(coeff),
#                         ROI::L_constraint(L = constr,  dir = diseq,  rhs = ones), max = TRUE)   
#ret <- ROI::ROI_solve(x = LP, solver = "clp")

ret=lp ("max", coeff, , diseq, ones, dense.const=constr)  

# solution is primal infeasible
# solving of ambiguous cases 
if (ret$status$code==1) {
  posit <- sum(ret$solution>1)
  if (posit>0) {
     coeff[which(ret$solution>1)] <- as.numeric(coeff[which(ret$solution>1)]) * 2^(posit:1)
	 
	 # command5bis: new LP execution -- use: lpSolve
	 #LP <- ROI::OP(as.numeric(coeff),
     #                    ROI::L_constraint(L = constr,  dir = diseq,  rhs = ones), max = TRUE)   
     #ret <- ROI::ROI_solve(x = LP, solver = "clp")
	 ret=lp ("max", coeff, , diseq, ones, dense.const=constr)  
  }
}

# log
ret$status

# prepare the reduced set of pairs
#if (ret$status$code==0) {
#    reduc <- t(dat[c(1,3,5,6),solution(ret)>0.9])
#} else {
#    # if solution is infeasible still
#    reduc <- t(dat[c(1,3,5,6),FALSE])
#}

# save the reduce table
#reducPairs <- as.data.frame(reduc)

#write.table(reducPairs , file = ReducedFile, sep = ";", row.names = FALSE, quote = FALSE, col.names = TRUE)

 ###################################
 
 # prepare the reduced set of pairs
 if (ret$status$code==0) {
     reduc <- workset_mt[solution(ret)>0.9,]
 } else {
     # if solution is infeasible still
     reduc <- workset_mt[FALSE,]
 }
 
 roles <- list (MTR=names(reduc))
 rolesgroup <- list (MTR= c("MTR"))
 
 fs_out<-list(MTR=reduc)

 result <-list( workset_out=fs_out, roles_out= roles, rolesgroup_out= rolesgroup,  log = '')

}

mufrommarginals <- function(workset, roles, wsparams=NULL, ...) {

 mp_var=workset$MPV
 mp_comp <- workset$MPC
 mp_m <- workset$MPM
 mp_u <- workset$MPU
 conting <- workset$CT
 
 mfreq <- as.numeric(wsparams$P)
 print(c("P=",mfreq))
 
 var_mp <- sort(unique(mp_var[,1]))
 nomimatvar <- names(conting)[-ncol(conting)]
 var_ct <- sort(nomimatvar)
 
 if (!all(var_mp==var_ct)) {

		#Error message and stop elab
		 print("ERROR: the variables in Contingency Table do not match the variables in Marginal Probabilities")
		 
		 print(var_ct)
		 print(var_mp)

	} else {
 
 nvar=length(var_ct)

 margins <- data.frame(mp_var,mp_comp,mp_m,mp_u)
 names(margins)<-c("VARIABLE","COMPARISON","M","U")
 
 m_att <- rep(1,2^nvar)
 u_att <- rep(1,2^nvar)
 #mfreq <- rep(mfreq,2^nvar)
 
 for (j in 1:2^nvar)
   for (i in 1:nvar) {
       m_att[j]<- m_att[j] * (margins[margins$VARIABLE==nomimatvar[i] & margins$COMPARISON==conting[j,i],3])
       u_att[j]<- u_att[j] * (margins[margins$VARIABLE==nomimatvar[i] & margins$COMPARISON==conting[j,i],4])
   }
   
 r_att <- m_att/u_att
 p_post <- m_att*mfreq/(m_att*mfreq+u_att*(1-mfreq))
 fm_obs <- conting$FREQUENCY*p_post
 fu_obs <- conting$FREQUENCY*(1-p_post)
 
 fm_obs=round(fm_obs, digits=5)
 fu_obs=round(fu_obs, digits=5)
 m_att=round(m_att, digits=5)
 u_att=round(u_att, digits=5)
 r_att=round(r_att, digits=5)
 p_post=round(p_post, digits=5)
   
 r_out <- cbind(conting[,1:nvar],fm_obs,fu_obs,m_att,u_att,r_att,p_post)
 
 r_out <- r_out [order(r_out$r_att , decreasing = FALSE ),]

 prec_oss <- rep(0,2^nvar)
 recl_oss <- rep(0,2^nvar)
 for (j in 1:2^nvar) {
   prec_oss[j] <- sum(r_out$fm_obs[j:2^nvar])/(sum(r_out$fm_obs[j:2^nvar])+sum(r_out$fu_obs[j:2^nvar]))
   recl_oss[j] <- sum(r_out$fm_obs[j:2^nvar])/sum(r_out$fm_obs)
 }
 prec_oss=round(prec_oss, digits=5)
 recl_oss=round(recl_oss, digits=5)

 r_out <- cbind(r_out,prec_oss,recl_oss)
 names(r_out)[-(1:nvar)] <- c("F_M","F_U","M","U","R","P_POST","PRECISION","RECALL")
 
 outroles <- list (FS=names(r_out), MP=names(margins))
 outrolesgroup <- list (FS= c("FS"), MP=c("MP"))
 
 outworksets<-list(FS=r_out, MP=margins)

 result <-list( workset_out=outworksets, roles_out= outroles, rolesgroup_out= outrolesgroup,  log = '')

 }
}
