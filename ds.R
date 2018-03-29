# Data Structures in R

# Loads of data sets that we have in R
# data()

# Vectors ----
# Four hyphens means I can directly reach that part as that part gets created as VECTORS in bookmark section
# c means concantenate (written below)
(v1 = c('A', 'B', 'C'))
class(v1)
v1[c(2)]
or 
#v1 = c('A', 'B', 'C')
#v1

(v2 = c(1,2,3))
class(v2)
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

# To check if the vectors in v7 matches withe vectors in v1, the below reflects only A as D is not in v1
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
