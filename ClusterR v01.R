# HH MA example 
#setwd("")
#install.packages("amap")
library(amap)
##Read the data in the file
url = 'https://docs.google.com/spreadsheets/d/1PWWoMqE5o3ChwJbpexeeYkW6p4BHL9hubVb1fkKSBgA/edit#gid=2073914016'
library(gsheet)
data = as.data.frame(gsheet2tbl(url))
str(data)
names(data)
summary(data)
##
##
##
##
#cust_data<-read.csv("./data/Segmentation_Data v01.csv")
cust_data = data  # created a copy of data
###Verify the data
colnames(cust_data)
class(cust_data$Age)
apply(cust_data, 2, FUN= class)  # For every column it is specifying the class

dim(cust_data)
head(cust_data)
summary(cust_data)
str(cust_data)
###Run the kmeans algorithm to generate the clusters
?amap::Kmeans
names(cust_data)
k1<-amap::Kmeans(cust_data[,-c(1)],centers=3, iter.max = 200,nstart = 1, method = c("euclidean"))     # 3 clusters to be created, start from 1 cluster and increase accordingly, cust_data[,-c(1)] done to remove the customer ID, Eucledian and Manhattan,distance calculator # Kmeans = finding mean
# This cant be visualized, because we have 13-1=12 columns and so we will have 11 mean values corresponding to their Cluster. But how to Plot this 11 dimensions. We neeed to understand from the Data only

k1$centers  # group means
###Fetch size/n of obs for the groups
k1$size   # check that Cluster 2 has maximum people, then cluster 3 and then 1
###Fetch sum of squared  for the groups
k1$withinss  # The lesser the value the more the group is cohesive and packed closely, to see if packed loosely or tightly
###Fetch the cluster for each obs
#k1$cluster
k1$cluster # means Particular row/ observation has gone to which cluster
k1$cluster[9000:9800]  # means Particular row/ observation has gone to which cluster
k1$size
data_clus_2 <- cust_data[ k1$cluster == 2,] # finds which all are in cluster 2
data_clus_2$Cust_id  # Prints those customer ID that are in cluster2
# Write CSV
# write.csv(data_clus_2[,1], file = "./data/data_clus_2.csv") # for storing the above result in a csv file

# names and colnames are same -> gives the same result
# Example
# names(mtcars) == colnames(mtcars)