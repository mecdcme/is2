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

confront <- function(workset=workset, ruleset=ruleset,md=MD,rs=RS,...){

    data <-  as.data.frame(matrix(workset[,md],ncol=length(md),nrow=nrow(workset)))
    colnames(data)<- md
    print(data)
    rules <- as.data.frame(matrix(ruleset[,rs],ncol=length(rs),nrow=nrow(ruleset)))
    colnames(rules)<- rs
    print(data)
    print(rules)
    print('----------------------------------------------------------')
	#stdout <- vector('character')
	#con <- textConnection('stdout', 'wr', local = TRUE)
#	sink(con)
#    cf <- confront(data, rules)
#	summary(cf)
#	aggregate(cf)
#	head(aggregate(cf,by="record"))
#	sort(cf)
#	head(values(cf))
#	head(cbind(nations,values(cf)))
 #	sink()
 # 	close(con)
 # 	output <- list("cf" = cf, "log" = stdout)
 # 	return(output)
  return
}