# Case Study - Denco  

#sales1 = read.csv("./data/denco.csv")
#sales1 = read.csv(file.choose())

#using gsheet
library(gsheet)
url = 'https://docs.google.com/spreadsheets/d/1PWWoMqE5o3ChwJbpexeeYkW6p4BHL9hubVb1fkKSBgA/edit#gid=216113907'

# functionality that retrieves information from googles sheet to my Data variables
denco2 = as.data.frame(gsheet2tbl(url))
str(denco2)

# head(sales1,n=7)
# names(sales1)

# sales = sales1  # keeping a backup
sales = denco2
class(sales)
str(sales)
?summary
summary(sales)

#region and partnum should be factors

str(sales)
sales$revenue= as.numeric(sales$revenue)
dim(sales)
# How many unique customers are there in this data frame
unique(sales$custname)
length(unique(sales$custname))
length(unique(sales$region ))

# summarization of revenue and grouping it with customer names, and operating for finding the maximum out of the items
# for every customes it gives the most costly item it bought 
aggregate(sales$revenue , by=list(sales$custname), FUN=max)
df1 = aggregate(sales$revenue , by=list(sales$custname), FUN=sum)
head(df1) # displays first 6 customers
str(df1)

df1=df1[order(df1$x, decreasing=TRUE),] # Descending order
head(df1,5) ## displays first 5 customers
# or
head(df1[order(df1$x, decreasing=TRUE),], 5)

#Aggregate Formula
# data=sales means taken from the sales table
(df2 = aggregate(revenue ~ custname + region, data=sales, FUN=sum))
head(df2[order(df2$revenue,decreasing=T),],10)

#List
list1= tapply(sales$revenue, sales$custname, FUN=sum)
head(list1)
list1
head(sort(list1, decreasing=T))
summary(df3)
str(df3)

#dplyr
names(sales)

# deployer library
library(dplyr)

# filtering based on margin 
# %-piping
sales %>% filter(margin > 1000000)
sales %>% filter(margin > 1000000) %>% arrange(region,revenue)
sales %>% filter(margin > 1000000) %>% arrange(region,desc(revenue))
# or
filter(sales, margin > 1000000)
# replace = True means I pick them from the smple and can again pick them.(see data.transformationcheatseet)

sales %>% filter(region == '01-East')
sales %>% filter(region == '01-East') %>% select(partnum, region) %>% head
sales %>% filter(region == '01-East' & revenue > 400000) %>% select(partnum, region, revenue) %>% head

sales %>% filter(region == '01-East' | revenue > 400000) %>% select(partnum, region, revenue) %>% head

names(sales)
sales %>% group_by(custname) %>% 
  summarize(Revenue = sum(revenue)) %>% arrange(desc(Revenue))


library(data.table)
dt1 = as.data.table(sales)
dt2 = dt1[, sum(revenue), by=custname]
names(dt2)
dt1[, dt1[, sum(revenue), by=custname]]

dt1[, order(, decreasing = T)]

# Select
library(sqldf)
df5 =sqldf("Select custname, sum(revenue) from sales Group By custname order by sum(revenue) desc ")
head(df5)

# Freqency --------
names(sales)
head(sort(table(sales$custname), decreasing=T))

#xtab
#
head(sort(xtabs(~ custname, sales), decreasing=T))
#
#
library(dplyr)
sales %>% dplyr::count(custname, sort=TRUE)

sales %>% dplyr::group_by(custname) %>% dplyr::summarise(n = n()) %>% dplyr::arrange(desc(n))



#plyr
df2a= plyr::count(sales, c('custname'))
str(df2a); names(df2a)
head(df2a[order(-df2a$freq),])



# Summarise by Part Num

df3a= aggregate(sales$revenue, by=list(sales$partnum), FUN=sum)
df3a[order(-df3a$x),][1:5,]

df3b = aggregate(revenue ~ partnum, data=sales, FUN=sum)
head(df3b)
head(df3b[order(df3b$revenue, decreasing=T),])

sales %>% dplyr::group_by(partnum) %>% dplyr::summarise(n = n()) %>% dplyr::arrange(desc(n))


# which parts have highest Profit : partno - sum(profit)
names(sales)
df4a = aggregate(margin ~ partnum, data=sales, FUN=sum)
head(df4a)