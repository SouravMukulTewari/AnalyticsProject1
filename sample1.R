# Sample Methods

#Base Package

(L1 = letters[1:26])
(L2 = LETTERS[1:26])
(M1 = month.abb[1:12])
(M2 = month.name[1:12])

sample(L1, 2)
sample(L1, 30)  #error
sample(L1, 30, replace=T)  # Replace is used when I am asking for more numbers than the size of the vector L1

sample(M1)
sample(M1, 5)
set.seed(100) # same random pattern is to be used, like 100 used here is fictitious, as 100 is used again when we ask for that code use the same value 100, the sam erandom sequence will be generated
sample(M1,5)
set.seed(100) # same value as got previous because same value of hundred is used 
sample(M1,5)
sample(M1,5)  # diff output w/o same seeding

(grades= LETTERS[1:5])
(sgrades = sample(grades, 20, replace=T, prob=c(0.4,0.2,0.2,0.1,0.1))) # 40%-A grade, 20%- Bgrade and so on
table(sgrades)
prop.table(table(sgrades)) # proportion.table
(sgrades = sample(grades, 20, replace=T, prob=c(0.4,0.2,0.2,0.1,0.1)))
table(sgrades)
prop.table(table(sgrades))


#Different Concept
sample(2, nrow(mtcars), replace=T, prob=c(0.8,0.2))

#Dplyr
library(dplyr)
dim(mtcars)
sample_frac(mtcars, 0.2) # 20 percent of the totakl rows as shown
sample_n(mtcars,5) # randomly shown 5 out of the total no. of row
