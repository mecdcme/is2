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

  

 ct <- roles$CT

 nvar=length(ct)-1
 #yy <-  as.data.frame(matrix(as.numeric(workset[,ct]),ncol=length(ct),nrow=nrow(workset)))
 yy <- workset
 #print(workset)
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
		#Messaggio di warning non blocante
		# msg = "WARNING: one or more variables give inconsistent estimates."
		#Messaggio di errore blocante
		 msg = "ERROR: one or more variables give inconsistent estimates. Please, check the variables in the model or try to reduce the search space.";
		 msg2 = paste("See table ",varmuTableName," for more details."); 
		 
		  print(msg)
		 print(msg2)
		 print(l)
		 #write.table(l, file = percorso_fail,row.names=FALSE,sep=":",quote=F)
		 #default value to p for the marginal prob table
		 p <- 0
	}else{
		#2 check su stime sulla frontiera
		#Messaggio di warning non blocante
		
		vett_cond=vett[vett>0.99999]
		if (length(vett_cond)>=1)
		{
		# messaggio di warning non bloccante, si salvano i parametri nella tabella, e si va avanti con la mutable
			msg3 = paste("WARNING: one or more nearly boundary parameters. See ",percorso_allert," for more details.");
			print(msg3);
			print(l);
		   #  write.table(l, file = percorso_allert,row.names=FALSE,sep=":",quote=F)
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
	
	
 roles <- list (FS=names(r_out))
 rolesgroup <- list (FS= c("FS"))


 result <-list( workset_out=r_out, roles_out= roles,rolesgroup_out= rolesgroup, var_est = var_est, log = stdout)


 return(result)
 
}