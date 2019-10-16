#eliminazione di ogni precedente elaborazione (pulizia memoria)
rm(list=ls())

print("Loading script Validate.R")

knitr::opts_chunk$set(comment = NA, warning = FALSE)
options(warn=-1)
library(validate)
library(validatetools)
library(errorlocate)
library(univOutl)
library(simputation)
library(VIM)
library(rspa)


print("End Loading script Validate.R")

is2_detect_infeasible <- function(input, inputNames){
  
  #redirect stdout to a string
  stdout <- vector('character')
  con <- textConnection('stdout', 'wr', local = TRUE)
  sink(con)
  
  rules_inf <- vector('character')
  rules <- validator(.data=input)
  names(rules) <- inputNames
  print(head(rules, 10))
  print(summary(rules))
  rule_infeasible <- is_infeasible(rules)
  print(rule_infeasible)
  if (rule_infeasible == TRUE){
	rules_inf <- detect_infeasible_rules(rules)
	print(rules_inf)
  }
  
  sink()
  close(con)
  
  output <- list("rules" = rules_inf, "log" = stdout)
  
  return(output)
}

is2_validate_confront <- function(workset=Workset, rules=Ruleset,md=MD,rs=RS,...){
 
    #print(str(workset))
    #print(str(rules))
    #   print(rules)
    colnames(rules)<- tolower(rs)
    rules$rule<-toupper(rules$rule)
	stdout <- vector('character')
	con <- textConnection('stdout', 'wr', local = TRUE)
	sink(con)
    #print(rules)
    v <- validator(.data=rules)
    # print('---------------v ------')
     print(v)
    # print(str(workset))
    cf <- confront(workset, v)
    print('--------------- summary(cf) ------')
    print(summary(cf))
    print('--------------- aggregate(cf) ------')
	 print(aggregate(cf))
	head(aggregate(cf,by="record"))
	sort(cf)
	head(values(cf))
	head(cbind(data,values(cf)))
	print('----head(cf)---')
	print(head(cf))
	
		
	# pdf("checks.pdf")
	#barplot(cf)
	# dev.off()
	
	#------------------------
	# Error localisation
	#------------------------
	le <- locate_errors(nations, v)
	# le <- locate_errors(nations, v, weight=c(1,1,1,1000,1))
	summary(le)
	
	nations_to_impute <- replace_errors(nations, v)
	# nations_to_impute <- replace_errors(nations, v, weight=c(1,1,1,1000,1))
	
	
	summary(nations_to_impute)
	#-----------------------------
	# Imputation with many methods
	#-----------------------------
	# Imputation with classification tree from simputation package
	nations_imputed <- impute_cart(nations_to_impute, region ~ GDP + TFR )
	nations_imputed$region[c(2,3,12)]
	row.names(nations[c(2,11,12),])
	# Imputation with classification tree from VIM package
	nations_imputed <- hotdeck(data=nations_to_impute, 
	                           variable=c("region"),
	                           ord_var=c("GDP","TFR","contr","infmort")
	                           )
	nations_imputed$region[c(2,3,12)]
	row.names(nations[c(2,11,12),])# Imputation with classificatio tree from VIM package
	# Imputation with kNN from VIM package
	nations_imputed <- kNN(data=nations_to_impute, 
	                           dist_var=c("GDP","TFR","contr","infmort"),
	                           k = 5)
	nations_imputed$region[c(2,3,12)]
	row.names(nations[c(2,11,12),])
	
	# Imputation with a sequence of single imputation steps
	library(magrittr)
	nations_imputed_1 <- nations_to_impute %>% 
	  impute_shd(GDP ~ .) %>%
	  impute_cart(region ~ .) %>%
	  impute_proxy(contr ~ median(contr,na.rm=TRUE)/
	                        median(GDP, na.rm=TRUE) * GDP | region) %>%
	  impute_shd(infmort ~ .) %>%
	  impute_lm(TFR ~ .) 
	  
	summary(nations_imputed_1)
	#-------------------------
	# Validation control
	#-------------------------
	
	cf <- confront(nations_imputed_1, v)
	summary(cf)
	
	
	#---------------------------------------------------------------
	# Imputation by Iterative Robust Model-based Imputation (IRMI)
	#---------------------------------------------------------------
	# library(VIMGUI)
	# VIMGUI()
	nations_imputed_2 <- irmi(nations_to_impute) 
	summary(nations_imputed_2)
	
	# check_that(nations_imputed,
	#            TFR > 0,
	#            GDP > 0,
	#            contr > 0,
	#            infmort > 0)
	# v_pos <- validator(
	#   TFR > 0,
	#   GDP > 0,
	#   contr > 0,
	#   infmort > 0
	# )
	# nations_imputed <- replace_errors(nations_imputed, v_pos)
	# summary(nations_imputed)
	# nations_imputed <- impute_shd(nations_imputed, contr ~ GDP, backend="VIM" )
	# nations_imputed <- impute_shd(nations_imputed, infmort ~ GDP, backend="VIM" )
	# nations_imputed <- impute_shd(nations_imputed, GDP ~ TFR , backend="VIM" )
	# 
	# summary(nations_imputed)
	
	
	#-------------------------
	# Final validation control
	#-------------------------
	
	cf <- confront(nations_imputed_2, v)
	summary(cf)
	le <- locate_errors(nations_imputed, v)
	# le <- locate_errors(nations_imputed, v, weight=c(1,1,1,1000,1))
	summary(le)
	
	nations_to_impute <- replace_errors(nations_imputed_2, v)
	summary(nations_to_impute)
	
	# nations_imputed_2 <- irmi(nations_to_impute)
	# summary(nations_imputed_2)
	# cf <- confront(nations_imputed_2, v, lin.eq.eps=0.001)
	# summary(cf)
	#---------------------------------
	# ... and adjust with package rspa
	#---------------------------------
	A <- is.na(nations_to_impute)
	nations_imputed_3 <- match_restrictions(nations_imputed_2,
	                                        v,
	                                        adjust=A,
	                                        maxiter=50000)
	
	summary(nations_imputed_3)
	cf <- confront(nations_imputed_3, v, lin.eq.eps=0.001)
	summary(cf)





	
	
	
 	sink()
  	close(con)
	output <- list(out = cf, "log" = stdout)
  	return(output)
}