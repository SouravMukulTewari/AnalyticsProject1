# Data Manipulation : Academic Data

library(gsheet)
student1= "https://docs.google.com/spreadsheets/d/1qLHa5qFTyWacta8F-IGo6J3Zpf-BVR9OrlqONuJDqYc/edit#gid=2051155174"
student = as.data.frame(gsheet2tbl(student1))
str(student)
df1= student
(colnames = names(df1))
#attributes(df1) = NULL
#df1 = as.data.frame(df1)
attributes(df1)
attr(df1, which='spec') = NULL
#names(df1) = colnames
str(df1)

#class of each column
# apply commands used for for loop
class(df1$gender) # what type of atom is it
sapply(df1, class)  # what type of atom are all the column head

# convert character to factor in a lump and in one go
factorcols = c('gender', 'cat', 'class12', 'batch','batchyr', 'br', 'city', 'finalgrade', 'btechfinal')

# ? lapply, mapply, sapply
df1[factorcols] = lapply(df1[factorcols] ,factor) # lapply = list apply
sapply(df1, class)
str(df1)


# Now do summarisation
#attach(df1)
names(df1)
table(df1$gender) # total no. of males and females
#combine it in single command 
(l1=lapply(df1[factorcols],factor,ordered=TRUE)) # in a clumpsy manner, writing it the number of times it appears in the same order.
sapply(l1,table) # (sapply and table used together, here table is a function used with sapply) -It counts the number of occurences and shows that in a understandable manner

sapply(lapply(df1[factorcols],factor,ordered=TRUE), table)  #Method1

sapply(df1[factorcols], table)   #Method2 , in table format we can straightaway get the columns of the file that is being mentioned in the factorcols to COUNT in one go.
sapply(df1[c('gender', 'cat', 'class12')], table) # asking counts for gender, cat, and class12


str(df1)

# Numeric Cols
(numcols = sapply(df1, is.numeric))   # To ask which are numeric and which are not as TRUE and FALSE
(numcols = names(df1[numcols]))   # shows only those which are numeric
class(numcols)

#remove rollno
(numcols = numcols[-1]) # remove the roll no. as it has not to be something upon which I will perform numeric activities
df1[numcols]
colSums(df1[numcols],dims=1) # column sum, dim=1 means columns
colMeans(df1[numcols],dims=1)

colMeans(df1[c('age', 'java', 'cpp')])
# or
colMeans((df1[numcols[c(2,7,11)]]))


names(df1)
#Look for other summarisation and grouping
aggregate(df1[numcols], by=list(df1$br), FUN=mean)
aggregate(java + cbnst ~ br, data=df1, FUN=mean)  #sum of java & cbnst wrt branch
aggregate( cbnst ~ gender, data=df1, FUN=mean)
aggregate( cbnst ~ gender + br, data=df1, FUN=mean)



#using dplyr package
library(dplyr)

#Top 2 students from each Branch 
df1 %>% select(br, sname, btechmarks) %>% group_by(br) %>% arrange(desc(btechmarks)) %>% top_n(n=2)

# Average Fees Paid by Batch Yr
df1 %>% group_by(batchyr) %>% select(batchyr, feepaid) %>% summarize(mean_fees = mean(feepaid, na.rm = TRUE))

names(df1)
df1 %>% filter(finalgrade == 'A') %>% group_by(gender, br, finalgrade) %>% summarize(btechmks = mean(btechmarks, na.rm = TRUE), javamin = min(java, na.rm = TRUE))

#Count
df1 %>%   group_by(gender) %>%  tally()

#Filter
df1 %>% filter(finalgrade == 'B') %>% select(rollno, sname, finalgrade)

#sample
df1 %>% sample_frac(0.2, replace = TRUE)  %>% select(rollno, sname)
df1 %>% sample_frac(0.2, replace = F)  %>% select(rollno, sname)
df1 %>% sample_n(3, replace = F)  %>% select(rollno, sname)

#few rows
slice(df1, 10:15)

library(tidyr) #Reshape
df1long <- df1 %>% select(sname, java, cbnst) %>% tidyr::gather(key = subject, value = marks, java, cbnst) 
head(df1long)
distinct(df1long)

tidyr::unite(df1, 'rollnoname', c(rollno, sname), sep="-") %>% select(1:5)%>% head


# data
str(df1$dob)
as.Date("5-Apr-91", '%d-%b-%y')
df1$dob = as.Date(df1$dob, '%d-%b-%y')
df1 %>% select(sname, dob) %>% tidyr::separate(dob, c("y", "m", "d"))


# Rows
df1 %>% slice(1:n():5)
slice(df1, 1:5)

df1 %>% slice(1:n())
df1 %>% slice(1:10)
slice(df1, n()-10: n())  #different way

names(df1)
#defaults to the last variable in the tbl
df1 %>% group_by(gender) %>% top_n(2)  #Rank not data
# top_n(n = 5, wt = x)
df1 %>% group_by(gender) %>% top_n(2,wt=class10)  #Rank not data wrt class10 marks

df1 %>% top_n(-2, wt=class10) %>% select(rollno, sname, class10, cgpa) #bottom 2 ranks - see 3 values
df1 %>% group_by(gender) %>% tally(java)  #total count
df1 %>% select(finalgrade, btechmarks, sname) %>% top_n(1, btechmarks)

#Selecting Columns
df1 %>% select(1:5)
df1 %>% select(contains('java'))
df1 %>% select(starts_with('btech'))
df1 %>% select(ends_with('s'))
df1 %>% select(everything())
df1 %>% select(finalgrade, everything()) %>% select(1:5) %>% select(-2)
names(df1)


# Summarise
df1 %>% summarise(avgjava = mean(java))
df1 %>% group_by(gender) %>% summarise(avgjava = mean(java),sumcbnst = sum(cbnst))
df1 %>% group_by(br, batch) %>% select(numcols) %>% summarise_each( funs(mean))

df1 %>% group_by(cat, gender) %>% count(class12, finalgrade)




#Summary Functions
v1 = df1$btechmarks
v1
v1 %>% first
v1 %>% last
v1 %>% sd
v1 %>% mean
v1 %>% n_distinct()


# Combine Data Sets

(a=data.frame(x1=c('A','B','C'), x2=c(1,2,3)))
(b=data.frame(x1=c('A','B','D'), x2=c('T','F','T')))

dplyr::left_join(a, b, by = "x1")
#Join matching rows from b to a.

dplyr::right_join(a, b, by = "x1")
#Join matching rows from a to b.

dplyr::inner_join(a, b, by = "x1")
#Join data. Retain only rows in both sets.

dplyr::full_join(a, b, by = "x1")
#Join data. Retain all values, all rows.

dplyr::semi_join(a, b, by = "x1")
#All rows in a that have a match in b.

cbind(a,b)

dplyr::anti_join(a, b, by = "x1")
#All rows in a that do not have a match in b.

#-----
y = data.frame(x1=c('A','B','C'), x2=c(1,2,3))
z = data.frame(x1=c('B','C','D'), x2=c(2,3,4))
cbind(y,z)

dplyr::intersect(y, z)  # B&C
#Rows that appear in both y and z.

dplyr::union(y, z)
#Rows that appear in either or both y and z.

dplyr::setdiff(y, z)
#Rows that appear in y but not z.

#Bind
dplyr::bind_rows(y, z)
#Append z to y as new rows.
dplyr::bind_cols(y, z)
#Append z to y as new columns.
#Caution: matches rows by position