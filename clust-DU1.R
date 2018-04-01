#Clustering - Simple dataset - Marks in 2 subjects


A=c(1,1.5,3,5,3.5,4.5,3.5)
B=c(1,2,4,7,5,5,4.5)
marks=data.frame(A,B)
marks
?kmeans

# 2 Point cluster
(c1 = kmeans(marks, 2))  # 2 means set 2 cluster

cbind(marks, c1$cluster)
plot(marks, pch=10,col = c1$cluster) # col = c1$cluster means the 2 clusters will have 2 diff colors
c1$centers  # Centroid coordinates of the Data set
points(c1$centers, col = 1:2, pch = 5, cex = 4)

c1$iter # Gives the No. of Iteration

# 3 point cluster
(c1 = kmeans(marks, 3))  # 3 means set 3 cluster

cbind(marks, c1$cluster)
plot(marks, pch=10,col = c1$cluster) # col = c1$cluster means the 3 clusters will have 3 diff colors
c1$centers  # Centroid coordinates of the Data set
points(c1$centers, col = 1:3, pch = 3, cex = 4)

c1$iter # Gives the No. of Iteration


# Next Task Below..
#C1- 1, 2 : (1.3, 1.5)
#C2- 3, 4, 5, 6, 7  : (3.9, 5.1)
#
#Specify Coordinates for Centers
mcenters = marks[c(1,5),]  #  specifying the coordinate of cluster point
mcenters
(c2a <- kmeans(marks, centers=mcenters))
c2a
cbind(marks, c2a$cluster)
matrix(c(1,1,5,7), ncol=2)
?matrix
(c2b <- kmeans(marks, centers=matrix(c(1,1,5,7), ncol=2)))

c2a
cbind(marks,c2a$cluster)
c2a$centers
aggregate(marks,by=list(c2a$cluster),FUN=mean)
c2a
c2a$iter

library(dplyr)
marks %>% group_by(c2a$cluster) %>% summarise_all(funs(sum, mean, median, n()))
marks  # This helps creating segregated information such that for the 1st cluster find the Sum, Mean, Median, Max, No. and similarly do for the 2nd cluster, and that too cluster Wise.

# go to ClusterR v01.R to see when there are 13 no. of columns other than 2 columns as we have here as A, B
###Done till this

# Distances
x1=marks[1,]; x2=marks[2,]
x1;x2
sqrt(sum((x1-x2)^2))
sqrt(1.25)
dist(rbind(x1,x2))
euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))
for (i in 1:7)
  print(paste(i, round(euc.dist(marks[i,], marks[1,]),2),sep='-'))

ref1 = marks[1,]; ref1
ref2 = marks[4,]; ref2

(d1= apply(marks,1,function(x)sqrt(sum((x-ref1)^2))))
(d2= apply(marks,1,function(x)sqrt(sum((x-ref2)^2))))
df=cbind(marks, d1,d2)
df

apply(df, 1, function(x) max(which(x == min(x, na.rm = TRUE))))
df
apply(df[,c(3,4)],1, min)
df3 <-transform(df, mind1d2=apply(df[,c(3,4)],1, min, na.rm = TRUE))
df3