# Decision Tree
# Data
# Student : Gender - (Male & Female) play sports

(gender = c('Female','Female','Male','Male'))
(play = c('Not Play', 'Not Play', 'Play', 'Play'))
d = data.frame(gender,play)
d
rownames(d) = c(paste('s', 1:4, sep=""))
#rownames(d) = c('s1', 's2', 's3', 's4')
d                   

#### BY SIR
rollno = paste('S', 1:30, sep='')
rollno
set.seed(155)
gender = sample(x=c('Male','Female'), size=30, replace=T, prob=c(0.6,0.4))
gender
table(gender)
set.seed(155)
play = sample(x=c('Play','Not Play'), size=30, replace=T, prob=c(0.5,0.5))
#play = sample(x=c('Play','Not Play', size = 30, replace=T, prob=c(15/30,15/30)))
play
table(play)  # in no.s how many male and female
prop.table(table(play))  # creates percentage
students1 = data.frame(gender,play)
rownames(students1) = rollno
students1
table(students1)
# table(students1$gender)
prop.table(table(students1))

#Model1
library(rpart)
?rpart
fit1 = rpart(play~gender, data=students1)   # Check 15th February Diary page(I)
fit1 = rpart(play~gender, data=students1, minsplit=4, minbucket=2)
fit1  # print(fit1) # on running this the n comes as 13 which is the mode and the Play/Not Play whatever is shown is the value at that point

table(students1$gender, students1$play)
prop.table(table(students1$gender, students1$play))
addmargins(prop.table(table(students1$gender, students1$play)))

library(rpart.plot)
rpart.plot(fit1, main='Classification Tree', nn=T)

predict(fit1, newdata = data.frame(gender='Female'))
predict(fit1, newdata = data.frame(gender=c('Female', 'Male', 'Female')))


#---- Part-2 Add Another Column
#set.seed(100)
#gender = sample(x=c('Male', 'Female'), size=100, replace=T, prob=c(0.4,0.6))
#table(gender)

#set.seed(101)
#married = sample(x=c('Married', 'Single'), size=100, replace=T, prob=c(0.3,0.7))
#table(married)

#set.seed(102)
#play = sample(x=c('Play','Not Play'), size=100, replace=T, prob=c(0.5,0.5))
#table(play)
#students2=data.frame(gender, married, play)
#rownames(students2) = rollno
#head(students2)
#str(students2)
#prop.table(ftable(students2))

students2=read.csv('dtdata.csv')

#Model2
#library(rpart)
fit2 = rpart(play~ gender + married, data=students2)
fit2 = rpart(play~gender, data=students1, minsplit=5, minbucket=3)
summary(fit2)
fit2
rpart.plot(fit2, type=2, extra=104, tweak=1.2, under=T, shadow=c('brown', 'green', 'red'), nn=T)

testdata2 = data.frame(gender=c('Male','Male','Female','Female'), married=c('Married','Single','Married','Single'))
testdata2
p2 = predict(fit2, newdata = testdata2) 
p2
# OR
# (p3 = predict(fit2, data.frame(gender=c('Male','Male','Female','Female'), married=c('Married','Single','Married','Single'))  ))


