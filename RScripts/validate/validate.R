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
    # print('--------------- summary(cf) ------')
    print(summary(cf))
     
#	aggregate(cf)
#	head(aggregate(cf,by="record"))
#	sort(cf)
#	head(values(cf))
#	head(cbind(data,values(cf)))
#	print(head(cf))
 	sink()
  	close(con)
	output <- list("cf" = cf, "log" = stdout)
  	return(output)
}