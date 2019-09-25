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

detect_infeasible <- function(input, inputNames){
  
  stdout <- vector('character')
  con <- textConnection('stdout', 'wr', local = TRUE)
  sink(con)
  
  rules_inc <- vector('character')
  rules <- validator(.data=input)
  names(rules) <- inputNames
  print(head(rules, 10))
  print(summary(rules))
  rule_infeasible <- is_infeasible(rules)
  print(rule_infeasible)
  if (rule_infeasible == TRUE){
	rules_inc <- detect_infeasible_rules(rules)
	print(rules_inc)
  }
  
  sink()
  close(con)
  
  output <- list("rules" = rules_inc, "log" = stdout)
  
  return(output)
}

validate_confront <- function(workset=workset, ruleset=ruleset,md=MD,rs=RS,...){
 
    print('---------------validate_confront ------')
      print(ruleset)
    #data <-  as.data.frame(workset[,md])
    data <-  workset[,md,drop = FALSE]
    print(class(data))
    rules <- ruleset[,rs,drop = FALSE]
    print(class(rules)) 
 	colnames(data)<- toupper(md)
   # rules <- as.data.frame(matrix(ruleset[,rs],ncol=length(rs),nrow=nrow(ruleset)))
    colnames(rules)<- tolower(rs)
    rules$rule<-toupper(rules$rule)

	#stdout <- vector('character')
	#con <- textConnection('stdout', 'wr', local = TRUE)
	#sink(con)
 print(str(data))
         print(rules)
    v <- validator(.data=rules)
    print(v)
    
    cf <- confront(data, v)
    print(summary(cf))
#	aggregate(cf)
#	head(aggregate(cf,by="record"))
#	sort(cf)
#	head(values(cf))
#	head(cbind(data,values(cf)))
#	print(head(cf))
 	#sink()
  	#close(con)

	output <- list("cf" = cf, "log" = "stdout")
	 print("aaaaaaaaaaaaaaa")
  	return(output)
}