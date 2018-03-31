#Using Logistic Regression Model
#Binary Classification
#Fiding the defaulters
# Finding the mileage of the car using this model. cyl and wt are being varied in within values from the data range and interprete the answer

# Balance and Income are CONTINUOUS Values and Student and Default as FACTORS
library(ISLR)
attach(Default)
str(Default)
summary(Default)
# check the percentage of people defaulted
# Check the percentage of students

# glm= general linear modeling (has logistic model), family = binomial- distribution, and it is a logistic modelling
(logit = glm(default~ income + balance + student, family='binomial', data=Default))
summary(logit)

library(dplyr)
(ndata = (slice(Default, seq(0,n(),500)))) # n() means that the total no. of rows
?slice
?seq

table(Default$default, Default$student)
prop.table(table(Default$default, Default$student)) # proportion in percentage ( # check notes in diary, page of 13th FeBruary)
addmargins(prop.table(table(Default$default, Default$student))) # check notes in diary, page of 13th FeBruary

(fitted.results = predict(logit, newdata=ndata, type = 'response')) # Artificially we are taking some sets of data to check if they will or will not default
cbind(ndata, fitted.results) # This shows in the form of probablity by putting them in our developed model to check if these students yes or no will default yes or no

ndata %>% mutate(predict = ifelse(fitted.results<0.5,0,1)) # This transforms the value  i.e if probability value is <0.5 then put it as 0 and if it is >0.5 then put that as 1
## OR
ndata %>% mutate(predict = ifelse(fitted.results<0.5,"NO","YES")) # same as abobe only NO in place of 0 and YES in place of 1



