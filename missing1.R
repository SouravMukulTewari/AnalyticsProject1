# Missing Values

v1 = c(1,2,NA,NA,5)
is.na(v1)
mean(v1) # cant give the value
mean(v1, na.rm=T) # na.rm = remove the NA values
v1a = na.omit(v1)  # omit the missing values
sum(v1a)
?na.omit
anyNA(v1) # are there any missing values in this vector

#all
v1[is.na(v1)] = mean(v1, na.rm=T) # replacing the space of the missing values with the mean of the vector leaving the NA's
v1


#denoted by NA
library(VIM)
data(sleep, package='VIM')
head(sleep)
dim(sleep)
complete.cases(sleep) # which are the ROWS where the entire rows are filled and there are no Missing values
sleep[complete.cases(sleep),] #It will show those ROWS that are complete (of the total dataframe)
sleep[!complete.cases(sleep),]  #It will show those ROWS that are NOT complete

is.na(sleep$Dream) # in this sleep column which all rows has NA show as true
sum(is.na(sleep$Dream))
mean(is.na(sleep$Dream))
12/62
sum(complete.cases(sleep))
mean(!complete.cases(sleep)) # mean is the percentage
sum(is.na(sleep))
colSums(is.na(sleep)) # finding No. of NA per COLUMN
rowSums(is.na(sleep))  # finding No. of NA in each ROW
is.na(sleep[1:3,])  # Showing the NA Values as true and flase for the rows I want


#Tabulate
library(mice)
mice::md.pattern(sleep) #42 rows without any missing values # 2 rows with 1 NA NonD

#Visualisation
VIM::aggr(sleep, prop=F, numbers=T)
#NonD max NA values 
VIM::aggr(sleep, prop=T)
VIM::matrixplot(sleep)
VIM::marginmatrix(sleep)
VIM::marginplot(sleep[c('Gest','Dream')], pch=c(20), col=c("darkgray", "red", "blue"))


#Exploration
x = as.data.frame(abs(is.na(sleep)))
head(sleep, na=5)
head(x, n=5)
y = x[which(apply(x, 2, sum) > 0)]
cor(y)  #Dream - NonD 0.9
cor(sleep, y, use="pairwise.complete.obs")
#ignore NA, 
#

#Listwise Deletion
options(digits=3)
na.omit(sleep)
cor(na.omit(sleep))
cor(sleep, use="complete.obs")

fit = lm(Dream ~ Span + Gest, data= na.omit(sleep))
summary(fit)


#imputations Packages - mice, Amelia, mi : mice, with, pool

imp = mice::mice(sleep, seed=1234)
?mice
