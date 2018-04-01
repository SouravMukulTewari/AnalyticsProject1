#Ctree - Classification and Regression


## REGRESSION TREE (shows Numerical Value and not like PLay and not play i.e characters)

library(partykit) # use this to model, can also use party but that will give different output

head(airquality)
### regression----
airq <- subset(airquality, !is.na(Ozone))  # non missing values goes into the data frame
airct <- ctree(Ozone ~ ., data = airq)   # complete cases, ozone y axis and others as x axis
airct  
plot(airct)
plot(airct, type='simple')
plot(as.simpleparty(airct))   #when partykit is used to model

library("strucchange")
strucchange::sctest(airct, node = 1)  # finds the pvalue for all the colnames., No need for pruning, 
strucchange::sctest(airct, node = c(2,7,4,9))

## Ozone is in y zxis, whatever splitting is done on whatever thing maybe, temp, wind the avg value is always for Ozone

predict(airct)
mean((airq$Ozone - predict(airct))^2)  #error
nodeids(airct,2)
nodeids(airct)
nodeids(airct, terminal=T)
nodeids(airct, from=2, terminal=T)
nodeids(airct,1,5)

range(airq$Ozone)

## CLASSIFICATION TREE (These are not about Numerical Values but about Characters/ Binary)

#party
#party::ctree(Ozone ~ ., data = airq)
head(iris)
library(partykit)
### classification ---
irisct <- partykit::ctree(Species ~ .,data = iris)
irisct
plot(irisct, type='simple')
strucchange::sctest(irisct, node = 1)
strucchange::sctest(irisct, node = c(2,3,4))
#7 not significant
nodeapply(irisct, ids = nodeids(irisct), function(n) info_node(n)$p.value)


table(predict(irisct), iris$Species)
### estimated class probabilities, a list
(tr <- predict(irisct, newdata = iris[1:10,], type = "prob"))
(tr <- predict(irisct, newdata = iris, type = "prob"))

(tr2 <- predict(irisct, newdata = iris[1:10,], type = "response"))
head(iris)