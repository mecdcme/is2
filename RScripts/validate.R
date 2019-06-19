#eliminazione di ogni precedente elaborazione (pulizia memoria)
rm(list=ls())

print("Loading script...")

library(validate)
library(validatetools)
library(errorlocate)

print("...script validate loaded!")

validate <- function(input){
  print("Ready to parse rules...")
  rules <- validator(.data=input)
  print(summary(rules))
  rule_infeasible <- is_infeasible(rules)
  print(rule_infeasible)
  if (rule_infeasible == TRUE){
	rules_inc <- detect_infeasible_rules(rules)
	print(rules_inc)
  }
}