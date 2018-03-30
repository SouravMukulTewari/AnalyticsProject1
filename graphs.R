# Playing with graphs
# Chapter 6 of Basic Graphs (R in Action)

attach(women)
women
barplot(height) # barplot has gaps, formed from discrete values.
# Histograms dont have gap

library(vcd)
counts = table(Arthritis$Improved)
counts

#vertical barplot
barplot(counts, main="Simple Bar PLot", xlab="Improvement", ylab="Frequency")

#Horozontal Barplot
barplot(counts, main="Simple Bar PLot", xlab="Frequency", ylab="Improvement", horiz=TRUE)

plot(Arthritis$Improved) # became so easy beacuse Improved is a ordered factor
str(Arthritis)

## barplot color and legend
barplot(counts,col=c('red','green', 'blue'), legend=rownames(counts))

#Pie chart
lbls=c('a', 'b', 'c','d')
slices=c(10,12,3,19)
pie(slices, labels=lbls)

(pct = round(slices/sum(slices)*100))

library(plotrix)
pie3D(slices, labels=lbls, explode=0.2, main='3D Pie Chart')

attach(mtcars)
