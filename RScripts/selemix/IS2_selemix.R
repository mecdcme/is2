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
#

stdout <- vector('character')
params_in <- list() 
init_log <- function() {
  #stdout <<- vector('character')
  con <<- textConnection('stdout', 'wr', local = TRUE)
  #con <- file("log.txt")
  sink(con, append=TRUE)
  sink(con, append=TRUE, type="message")
}
close_log <- function() {
  # Restore output to console
  if(exists("con"))
  {
    
    sink() 
    sink(type="message")
  
    # And look at the log...
    if(exists("con")) close(con)
    #cat(readLines("test.log"), sep="\n")
    if(exists("stdout")) cat(stdout)
  }
}
#init_log()


#Load libraries and capabilities
check_package <- function(i)     
  #  require returns TRUE invisibly if it was able to load package
  if( ! require( i , character.only = TRUE ) ){
    #  If package was not able to be loaded then re-install
    install.packages( i , dependencies = TRUE )
    #  Load package after installing
    require( i , character.only = TRUE )
  }


parallel_init <- function()  
  if(.Platform$OS.type == "unix")
  {
    library(doParallel)
    numCores <- detectCores()
    cl <- parallel::makeCluster(numCores)
    doParallel::registerDoParallel(cl)
    print(paste("Parallal enabled. Numero di core: ",numCores))
    return(numCores)
  } else {
    print("Parallel trhread mode unavailable. Numero di core reset to 1")
    return(1)
  }



# Check load and then try/install packages
check_list <- c("SeleMix" , "jsonlite" , "dplyr", "data.table", "doParallel", "foreach") 
lapply(check_list, check_package)
#print('Packages loaded')

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
IS2_SELEMIX_PREDICTION <- "ypred"
IS2_SELEMIX_OUTPUT_VARIABLES <- "OUTVARS"
IS2_SELEMIX_OUTLIER    <- "OUTLIERS"
IS2_SELEMIX_MODEL      <- "MDLOUT"
IS2_SELEMIX_REPORT     <- "REP"
IS2_SELEMIX_ERROR      <- "INFLS"
IS2_SELEMIX_TARGET     <- "y"
IS2_SELEMIX_COVARIATE  <- "x"
IS2_SELEMIX_STRATA     <- "STRATA"
IS2_SELEMIX_CONVERGENCE <- "CONV"

#print('Bridge Set')

#########################
# Model and Prediction 
########################
is2_mlest <- function( workset, roles, wsparams=NULL, fname = "ml.est", ...) {
  
  if(length(workset)==0) stop("empty workset")
  
  stdout <- vector('character')
  # con <- textConnection('stdout', 'wr', local = TRUE)
  # sink(con, append=TRUE)
  # sink(con, append=TRUE, type="message")
  
  #set model
  n=length(get_role("y"))
  #preset out roles
  set_role("AGGREGATES", c("n.outlier","is.conv","n.iter","sing","bic.aic", "msg", "model") )
  set_role("c_model", c("B","sigma","lambda","w") )
  predname <-  ifelse(n>1 ,list(paste("ypred",seq(1:n),sep="")) , set_role("ypred","ypred"))
  set_role("OUTLIERS","OUTLIER")
  set_role("OUTVARS", c("TAU",get_role("OUTLIERS"),"PATTERN","layer","nrows") )
  set_role("MDLOUT","Contamination_Model")
  set_role("REP","Report")
  set_role("ypred",predname)
  set_role("CONV","conv")
  #init
  strata <- NULL
  result <- NULL
  #insert new columns
  workset$layer <- 0
  workset$nrows <- 0
  workset$conv <- FALSE
  set_param("NUM_CONV_LAYERS",0)
  #prepares layers if any
  nlayers <- 1
  workset <- stratify(workset,roles$STRATA)
  
  
  tryCatch ({
    #print('call generic executor')
    tree <- is2_exec(workset, roles, wsparams, "ml.est")
	print(paste("Recombine strata ",fname))  
	workset_out <- rbindlist( lapply(tree, function(p)  {  #per ogni strato
        t <- p$out
        if(is.list(t)) unlist(t)
        t <- as.data.frame(t)
         })  
      ,fill=TRUE
    )
    #print(str(workset_out))
	print("Binding model")
    model_out <- rbindlist( lapply(tree, function(p)  {  #per ogni strato
        #print(str(p))
        t <- p$model
        if(is.list(t)) unlist(t)
        t <- as.data.frame(t)
      })  
      ,fill=TRUE
    )
    #print(str(model_out))
	print("Binding report")
	par_out <- rbindlist( lapply(tree, function(p)  {  #per ogni strato
        #print(str(p))
        t <- p$par
        if(is.list(t)) unlist(t)
        t <- as.data.frame(t)
      })  
      ,fill=TRUE
    )
    #print(str(model_out))
	print("Formatting output")
  #formatting output
  params_out <- list("Contamination_Model" = toJSON(model_out, auto_unbox = TRUE, na = "string", pretty = TRUE))
  params_strata <- list("Strata INFO" = toJSON(par_out, auto_unbox = TRUE, na = "string", pretty = TRUE))
  n_outlier = sum(workset_out[workset_out$OUTLIER == 1, "OUTLIER"], na.rm=TRUE)
  n_layers = get_param("nlayers")
  n_layers_conv = get_param("NUM_CONV_LAYERS")
  report <- list(n.outlier = n_outlier, "Layers"=n_layers ,"Convergent_layers"=n_layers_conv)
  report_out <- list(Report = toJSON(report, auto_unbox = TRUE, na = "string", pretty = TRUE))  
  
  #roles out
  roles_out <- list()
  roles_out [[IS2_SELEMIX_OUTLIER]] <- get_role("OUTLIERS")
  roles_out [[IS2_SELEMIX_MODEL]]   <- c("Contamination_Model")
  roles_out [[IS2_SELEMIX_REPORT]]  <- c("Report")
  roles_out [["AGGREGATES"]]		<- c("Strata INFO")
  roles_out [[IS2_SELEMIX_COVARIATE]]       <- c(roles$x)
  roles_out [[IS2_SELEMIX_TARGET]]          <- c(roles$y)
  roles_out [[IS2_SELEMIX_STRATA]]          <- c(roles$STRATA)
  roles_out [[IS2_SELEMIX_PREDICTION]]      <- c(predname)
  roles_out [[IS2_SELEMIX_CONVERGENCE]]     <- c("conv")
  roles_out [[IS2_SELEMIX_OUTPUT_VARIABLES]]<- get_role("outvars")
  
  
  #rolesgroup
  rolesgroup_out <- list()
  rolesgroup_out [[IS2_SELEMIX_MODEL]]    <- c(IS2_SELEMIX_MODEL)
  rolesgroup_out [[IS2_SELEMIX_REPORT]]   <- c(IS2_SELEMIX_REPORT)
  rolesgroup_out [[IS2_SELEMIX_PREDICTION]] <- c(IS2_SELEMIX_COVARIATE,IS2_SELEMIX_TARGET,IS2_SELEMIX_STRATA,IS2_SELEMIX_PREDICTION,IS2_SELEMIX_CONVERGENCE,IS2_SELEMIX_OUTPUT_VARIABLES,IS2_SELEMIX_OUTLIER,IS2_SELEMIX_OUTPUT_VARIABLES)
  rolesgroup_out [["AGGREGATES"]]   <- c("AGGREGATES")
  
  #Output
  result[[IS2_WORKSET_OUT]]     <- workset_out
  result[[IS2_ROLES_OUT]]       <- roles_out
  result[[IS2_ROLES_GROUP_OUT]] <- rolesgroup_out
  result[[IS2_PARAMS_OUT]]      <- params_out
  result[[IS2_REPORT_OUT]]      <- report_out
  result[["AGGREGATES"]]        <- params_strata
  result[[IS2_LOG]]             <- stdout
  
  })
  print(paste(fname," execution ended successfully."))
  #print(str(result))
  # sink(con)
  # sink(con, type="message")
  # close(con)
  return(result)
}



#########################
# Selective Editing
########################
is2_seledit <- function( workset, roles, wsparams=NULL, fname = "sel.edit", ...) {
  
  if(length(workset)==0) stop("empty workset")
  
  #Check parameters
  tot <- get_param("tot")
  t.sel <- get_param("t.sel")
  
  stdout <- vector('character')
  # con <- textConnection('stdout', 'wr', local = TRUE)
  # sink(con, append=TRUE)
  # sink(con, append=TRUE, type="message")
  
  #set model
  n=length(get_role("y"))
  
  #preset out roles
  if(is.null(get_role("ypred"))) {
	print(paste("resetting prediction column dimension ",n))
    predname <-  ifelse(n>1 ,list(paste("ypred",seq(1:n),sep="")) , "ypred")
    set_role("ypred",predname)
  }
  np=length(get_role("ypred"))
  set_role("REP","Report")
  if(n!=np) {
#	  print(names(workset))
#	  print(str(roles))
#	  print(str(wsparams))
#	  print("-----------")
	  warning("Model mismatch")
	  #stop("Model mismatch")
  }
  #init
  result <- NULL
  #insert new columns
  workset$layer <- 0
  workset$nrows <- 0
  workset$conv <- FALSE
  #prepares layers if any
  workset <- stratify(workset,roles$STRATA)
  #print(paste("Strato: ",roles$STRATA," numerosit�: ",length(workset)," names: ",names(workset)))
  
  tryCatch ({
    #print('call generic executor')
    tree <- is2_exec(workset, roles, wsparams, "sel.edit")
  	#workset_out <- as.data.frame(rbindlist(lapply(tree, as.data.frame),use.names=TRUE, fill=TRUE))
  	workset_out <- rbindlist( 
  	  lapply(tree, function(p)  {  #per ogni strato
        t <- p$out
        if(is.list(t)) unlist(t)
        t <- as.data.frame(t)
      })  
      ,fill=TRUE
    )
  	#print(str(workset_out))
  }, 	error=function(cond) {
    print(cond)
  })#end tryCatch
  
    
    #formatting output
    n_error = 0
    #print(head(workset_out$sel))
    n_error = sum(workset_out[workset_out$sel == 1, "sel"], na.rm=TRUE)
    report <- list(n.error = n_error)
    report_out <- list(Report = toJSON(report, auto_unbox = TRUE))
    
    #Set output roles & rolesgroup
    roles_out      <- list (E = "sel", R = "rank",  F = "global.score")
    rolesgroup_out <- list (E = "E", G = "G")
    
    roles_out [[IS2_SELEMIX_ERROR]]      <-   c(roles$x,roles$y, roles$ypred, roles$STRATA, roles$CONV, "sel",  "rank", "global.score")
    rolesgroup_out [[IS2_SELEMIX_ERROR]] <- c("E", "R","F")
    
    #Output
    result[[IS2_WORKSET_OUT]]     <- workset_out
    result[[IS2_ROLES_OUT]]       <- roles_out
    result[[IS2_ROLES_GROUP_OUT]] <- rolesgroup_out
    result[[IS2_REPORT_OUT]]      <- report_out
    result[[IS2_LOG]]             <- stdout
    
  
  print(paste(fname," execution ended successfully."))
  #print(str(result))
  # sink(con)
  # sink(con, type="message")
  # close(con)
  return(result)
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

get_param <- function( a ) {
  out <- NULL
  try( out <- wsparams[[a]] )
  return(out)
  
}

get_role <- function( a ) { 
  
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


stratify <- function(dataset, r = get_role("STRATA")) { 
  strata <- NULL
  set_param("nlayers", 1)
  try(strata <- as.factor(dataset[,r]), silent = TRUE)
  if(is.data.frame(dataset)&&!is.null(strata)) {
    dataset <- split(dataset, strata)
    nlayers <- length(dataset)
    set_param("nlayers", nlayers)
	set_param("STRATA",levels(strata))
    print(paste("STRATA detected: ",r," with ",nlayers," layers"))
  } else { print(paste("STRATA NOT detected or dataset is already a list "))}
    
    return(dataset)
}


#esecuzione generica (esegue anche un solo strato o zero come se fosse stratificato)  
is2_exec <- function(ws, roles, params, fname="ml.est") { 
  
  print(paste("Esecuzione funzione generalizzata ",fname))
  
  nCores <- parallel_init()
  
  #i ruoli vanno ridefiniti per poter essere valutati a runtime all'interno della chiamata do.call
  #fac simile (istruzione di default per la formattazione dri ruoli di input)
  parlist <- list( y = substitute(t[, roles[["y"]]]), x = substitute(t[, roles[["x"]]]), ypred = substitute(t[, roles[["ypred"]]]))
  #controllo della lista dei parametri input
  parlist <- match_function_par(fname, append(params,parlist))
  
  conv_layers <- 0
  if(is.data.frame(ws)) {
    warning("Workset non in forma di lista")
    ws<-list(a=ws)
  } #permette di essere trattato come una lista intera
  
  wm <- list()
  wr <- list()
  out <- mclapply(seq_along(ws), function(p) {  
    
  t <- ws[[p]] #t non e' indice ma l'elemento effettivo
  t$nrows <- nr <- NROW(t)
  t$layer <- as.character(p)
  strata <- get_role("STRATA")
  strataval <- get_param("STRATA")[p]
  #try( strataval <- unique(t[,strata]), silent = TRUE)
  par <- lapply(parlist, function(item) {if(is.language(item)) as.numeric(eval(item)) else item } )
  print(paste("Layer: ",as.character(p)," nrows = ", nr))
	#print(paste("Strata: ",strata," strata :", strataval))
    tmp <- NULL
	tryCatch({
        tmp <- do.call(fname,par,quote = TRUE)
	}
	, 	error=function(cond) {
		if(fname=="ml.est") {
			t$ypred = NA
	        t$TAU = NA
	        t$PATTERN = NA
	        t$OUTLIER = NA			
		}
		
	print(paste("Error: layer ",p))
	print(cond)
	}
	)#end tryCatch
	
	#sistemazione out
        #il risultato � una matrice
        if(is.matrix(tmp)) {
			print(paste("Matrix out ",as.character(p)))
          #t <- merge(t, as.data.frame(tmp))
          t <- as.data.frame(tmp)
        }
        
        #il risultato � una lista
        if(is.list(tmp)) {
          t$conv <- tmp$is.conv 
          if(tmp$is.conv) {
          conv_layers <- 1+as.numeric(get_param("NUM_CONV_LAYERS"))
          set_param("NUM_CONV_LAYERS",conv_layers)
          #print(paste("layer ",strataval," #convergenti: ",conv_layers))
          
        }
        t$ypred <- tmp$ypred
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
        

	  #print(paste("Combining in a list ",fname,"'s output"))
       #produce un alberatura
		list(out=t, par=wr, model=wm)
  }) #end lapply
  
  if(nCores>1) stopImplicitCluster()
  #set_param("NUM_CONV_LAYERS", conv_layers)
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


#rewrites list for input
relist <- function( ...){
  lst <- list(...)
  ls <- lapply(lst,function(p) 
    tryCatch({
      fromJSON(p, flatten=TRUE)
    },
    error=function(cond) {
      p
    })#end tryCatch
  )
  print(ls)
  return(ls)
}


