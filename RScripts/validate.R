#eliminazione di ogni precedente elaborazione (pulizia memoria)
rm(list=ls())

print("Loading script...")

library(validate)
library(validatetools)
library(errorlocate)

detect_infeasible <- function(input, inputNames){
  print("Ready to parse rules...")
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
  return(rules_inc)
}