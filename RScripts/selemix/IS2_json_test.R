library("jsonlite")

mod1 <- list(x = "c(1,2,3,4)", y = c(5,6,7,8), z = c("a", "b", "b", "c"))
mod2 <- list("x" = c(1,2,3,5), "y" = c(7,8), "z" = c("b", "b", "c"))
mod3 <- rbind(mod1, mod2)

modList <- list("x" = c(1,2,3,4), "y" = c(5,6,7,8), "z" = c("a", "b", "b", "c"))

mod <- rbind(modList)

modTry <- rbind(list("x" = c(1,2,3), "y" = c(5,6,7,8), "z" = c("a", "b", "b", "c")))

modJson <- toJSON(modTry)


mod1 <- toJSON(list(layer="all",B=c(5,6), sigma=c(5,6,7,8), lambda=c(5,6,7,8,9), w=c(5,6,7,8)))
mod2 <- toJSON(list(layer="all",B=c(5,6), sigma=c(5,6,7,8), lambda=c(5,6,7,8,9), w=c(5,6,7,8) ))
mod3 <- rbind(mod1, mod2)
modJson <- toJSON(mod3)


param_mod <- list( Model = toJSON(mod))


IS2_REPORT <- "Report"
param_report <- list()
param_report [[IS2_REPORT]] <- toJSON(list(a="a", b="b"))
