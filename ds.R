# Data Structures in R

# Loads of data sets that we have in R
# data()

# Vectors ----
# Four hyphens means I can directly reach that part as that part gets created as VECTORS in bookmark section
# c means concantenate (written below)
(v1 = c('A', 'B', 'C'))
class(v1)
str(v1)
v1[c(2)]
or 
#v1 = c('A', 'B', 'C')
#v1

(v2 = c(1,2,3))
class(v2)

# Logicals
(v3 = c(TRUE, FALSE, TRUE))
class(v3)

v3a = c(T, F, T)
class(v3a)

v4 = 100:200
v4

v5 = seq(1,10,2)
v5

# c means that show only the values index or position of which are mentioned
v4[c(1,3,4)]

# -c means that remove these values
v4[-c(1,3,4)]

# Below is what is the value at the address 150
v4[v4 == 150]

# Show values that are greater than 150
v4[v4 > 150]

# To check if the vectors in v7 matches with the vectors in v1, the below reflects only A as D is not in v1
v7 = c('A', 'D')
v1[v1 %in% v7]

# To check if the vectors in v7 matches withe vectors in v1, the below reflects only A and C as L is not in v1
v7 = c('A', 'C', 'L')
v1[v1 %in% v7]

# Square bracket means give the position value and not the value of the address, so this reflects NA
v1['A']

# This is correct as it asks the positions
v1[1]

# First allocating the address values for v8 and then allocating the contect for those mentioned address
(v8 = 11:15)
v8[2:4]
# Normally we can call via address but after the below mentioned line we can also call via NAMES
names(v8) = c('E', 'F', 'G', 'H', 'I')
v8
# below both line yields same value
v8['G']
v8[3]

v8[2:4]
# results in output corresponding to G and I
v8[c('G','I')]
#Defining the entire contents of the structure of v8
str(v8)
class(v8)

#Creating a Dataframe
# The standard normal distribution is a normal distribution with a: mean of 0, standard deviation of 1
# runif - randomly uniform distribution of numbers (No. of values, minimum marks to be alotted, maximum marks to be alotted)
# floor and ceil same as Matlab
# to seek greater information for a particular synatx means write - (?runif)
# on writing so we get Uniform{stats}, this curly brackets tells the LIBRARY from where it is extracted.
df = data.frame(rollno=c(1,2,3), name=c('Rohit','Lalit','Hitesh'), course=c('MBA','BBA','MCA'), dept=c('Dept1','Dept1','Dept2'), marks=floor(runif(3,50,100)))
df
# it opens a EXCEL SHEET sort of thing where from we can directly change things
df=fix(df)
df

# identifying the structure of df
# tells 'x' observation means no of rows, tells 'y' variables meaning columns
# characters are put as input in this are termed as 'Factors' , normally 'strings' are termed as 'Factors' by Default
# 1st Quantile - first 25% of the data has this value in average
# 2nd Quantile - First 75% of the data has this value in average
# How many of a particular thing is there, like how many are from Dept1 and how many are from Dept2 and so on
str(df)
class(df)
summary(df)

#What all variables that has been created in the program
ls()

# To remove all the variables that has been created, the below commented line if executed does what told here
# rm(list=ls())

# It can contain All data objects, viz. character, numeric, vector, dataframe, matrix, array etc, unlike data type 'vector' which has only one data type.
(mylist1 = list(1,df,v4))

#create Matrix, 1:24 is the data to be alotted, ncol=4 means 4 columns
# to filll the values column wise
(mymatrix = matrix(1:24, ncol=4))
# or
(mymatrix = matrix(1:24, ncol=4, byrow=FALSE))

# And if the matrix is to be filled by ro wise then do this
(mymatrix = matrix(1:24, ncol=4, byrow=TRUE))

# to retrieve 1st column
# mymatrix[,1]

# to retireve 2nd to 4th column
# mymatrix[,2:4]

# to retrieve 2nd to 4th row and 3rd to 4th column
# mymatrix[2:3,3:4]

# To retrieve the data of the 4th row and 5th column
# mymatrix[4,5]

# To give the Names of the dimensions in the mymatrix, Both of the Ros and Column are named in different style. By heart them.
# The seperator given is actually blank and underscore in the following cases
dimnames(mymatrix) = list(c(paste('R', 1:6, sep='_')), c(paste('C', 1:4, sep='')))
#or
dimnames(mymatrix) = list(c('R1', 'R2', 'R3', 'R4', 'R5', 'R6'), c(paste('C', 1:4, sep='')))
mymatrix

# To create character Matrix
# do..

# To concatenate the to vectors/ values and adding a seperator between them if we require
# paste('C', 'D', sep='-')

# Arrays
# dim=c(m,n,o)
# m=rows, n=columns, o= no. of matix, and m*n*o = no. of total values
(myarray = array(101:124, dim=c(4,3,2)))

df
df=fix(df)
# to see the courses
df$course
df$name
# trying to output the 1st and 2nd column for all rows
df[,1:2]
df[3:4,1:3]

# Incorporating another columnin the data.frame
df$gender = c('M', 'F', 'M', 'M')
df
str(df)

# converting the character thing of gender to Factor.
# In factor it adds a numeric value alotted to the characters in that column of Gender
df$gender = factor(df$gender)
str(df)

df$grades = c('A', 'B', 'A', 'C')
df
df$grades = factor(df$grades,ordered=T)
df
str(df)
# wrong order as it puts C as a superior order than A

# So below we told that A is superior order than C.
df$grades = factor(df$grades,ordered=T, levels= c('C', 'B', 'A'))
str(df)

table(df$course, df$dept)
table(df$course, df$gender)


mymatrix
# 1 applies to Row, i.e adding as per rows or row wise
# 2 applies to column i.e adding as per column or column wise
apply(mymatrix, 1, sum)
apply(mymatrix, 2, sum)

# Throws error as there are 2 dimensions in Matrix, but in Array we have 3 dimensions
apply(mymatrix, 3, sum)

apply(mymatrix, 2, sd)
apply(mymatrix, 1, sd)
apply(mymatrix, 2, mean)

myarray
apply(myarray, 3, sum) # 2 values 1 for 1st matrix and 2nd for the 2nd matrix
apply(myarray, 2, sum) # column wise adding the 2 array so 3 values
apply(myarray, 1, sum) # row wise adding. so 4 values

# ?apply
df
tapply(df$marks, df$gender, mean) # summing marks categorically as per gender

tapply(df$marks, df$course, mean) # summing marks categorically as per course

# Deleting gender from df
df
df$gender = NULL

#Find names for only a particular department
df[df$dept == 'Dept2',]

# filter those whose marks less than 80
df[df$marks<=80,]


