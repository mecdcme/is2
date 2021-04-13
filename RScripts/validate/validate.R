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

is2_validate <- function(input, inputNames){
  print(input)
  #redirect stdout to a string
  stdout <- vector('character')
  con <- textConnection('stdout', 'wr', local = TRUE)
  sink(con)
  newrules <- data.frame(rule = input, name = inputNames,label =inputNames )
  #print(newrules)
   
  rules_inf <- vector('character')
  rules <- validator(.data=newrules)
  rules_validate <- vector('character')
  for(x in 1:length(rules$rules)) {rules_validate <- c(rules_validate, names(description(rules$rules[[x]]))) 	}
  #print(rules_validate)
  results_validate <- vector('character')
  for(x in 1:length(inputNames)) {results_validate <-   c(results_validate, is.element(inputNames[x], rules_validate)) 	}
  mapping <- data.frame(key=inputNames,value=results_validate,stringsAsFactors = FALSE)
   sink()
  close(con)
  output <- list("rules" = rules_inf, "validate"=mapping, "log" = stdout)
  return(output)
}


is2_infeasible <- function(input, inputNames){
  
  #redirect stdout to a string
  stdout <- vector('character')
  con <- textConnection('stdout', 'wr', local = TRUE)
  sink(con)
  newrules <- data.frame(rule = input, name = inputNames,label =inputNames )
  print(newrules)
   
  rules_inf <- vector('character')
  rules <- validator(.data=newrules)
  rules_validate <- vector('character')
  results_validate <- vector('character') 
  for(x in 1:length(rules$rules)) {rules_validate <- c(rules_validate, names(description(rules$rules[[x]]))) 	}
  for(x in 1:length(inputNames)) {results_validate <-   c(results_validate, is.element(inputNames[x], rules_validate)) 	}
  mapping_validate <- data.frame(key=inputNames,value=results_validate,stringsAsFactors = FALSE)
  
  #print(rules_validate)
  #print(head(rules, 10))
  #print(summary(rules))
  rule_infeasible <- is_infeasible(rules)
  print(rule_infeasible)
  if (rule_infeasible == TRUE){
	rules_inf <- detect_infeasible_rules(rules)
	print(rules_inf)
  }
  results_rules_inf <- vector('character') 
  for(x in 1:length(inputNames)) {results_rules_inf <-   c(results_rules_inf, !is.element(inputNames[x], rules_inf)) 	}
  mapping_infeasible <- data.frame(key=inputNames,value=results_rules_inf,stringsAsFactors = FALSE)
   
  
   sink()
  close(con)
  output <- list("infeasible" = mapping_infeasible, "validates"=mapping_validate, "log" = stdout)
  return(output)
}


is2_detect_infeasible <- function(input, inputNames){
  
  #redirect stdout to a string
  stdout <- vector('character')
  con <- textConnection('stdout', 'wr', local = TRUE)
  sink(con)
  newrules <- data.frame(rule = input, name = inputNames,label =inputNames )
  print(newrules)
   
  rules_inf <- vector('character')
  rules <- validator(.data=newrules)
  rules_validate <- vector('character')
   
  for(x in 1:length(rules$rules)) {rules_validate <- c(rules_validate, names(description(rules$rules[[x]]))) 	}
  #print(rules_validate)
  #print(head(rules, 10))
  #print(summary(rules))
  rule_infeasible <- is_infeasible(rules)
  print(rule_infeasible)
  if (rule_infeasible == TRUE){
	rules_inf <- detect_infeasible_rules(rules)
	print(rules_inf)
  }
  sink()
  close(con)
  output <- list("rules" = rules_inf, "validates"=rules_validate, "log" = stdout)
  return(output)
}

is2_validate_confront <- function(workset=Workset, roles=roles,rules=RS,...){
    stdout <- vector('character')
    con <- textConnection('stdout', 'wr', local = TRUE)
    # print( workset )
    # print(rules)
    # print(roles)
    colnames(rules)<- tolower(colnames(rules))
	colnames(workset)<- tolower(colnames(workset))
    print(rules)
    v <- validator(.data=rules)
    print(v)
	
    cf <- confront(workset, v)
	res<-cbind(workset,as.data.frame(values(cf)))
	print(head(res))
	roles_out <- list (MD=names(res))
	rolesgroup<-list (MD= c("MD"))
	
	print('--------------- summary(cf) ------')
    print(summary(cf))
    print('--------------- aggregate(cf) ------')
	print(aggregate(cf))
	head(aggregate(cf,by="record"))
	sort(cf)
	head(values(cf))
	
	print('----head(cf)---')
	print(head(cf))
	print('----values(cf)---')
	print(values(cf))
	 sink()
   	close(con)
	
	result <- list(workset_out = res, roles_out= roles_out, rolesgroup_out= rolesgroup, log = stdout)
	
  	return(result)
}
