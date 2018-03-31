# Multiple Linear Regression using more than 2 variables
# Using mtcars
# stepAIC approach


## STEP 1

attach(mtcars)
dim(mtcars)
names(mtcars)
head(mtcars)
?mtcars

#M1 = model1
#M2=model2
# Below is the syntax that models the mpg in terms of the other varible that mtcars is posessed with
(M1 = lm(mpg ~ disp + cyl + hp + + drat + wt + qsec + carb, data=mtcars ))
summary(M1)
# weight is the only significant

(M2 = lm(mpg~ disp + cyl + wt, data=mtcars))
summary(M2)
# now both cylinder and wt are both significant

# now we are comparing the 2 models with the help of anova
# degree of free is negative so wrong
# so when we rite anova make sure the first entry should have less no. of parameters and the 2nd must have more no. of parameters
# that too the 2nd model must have the variables that is present in the first model and some extra models

anova(M1,M2) # wrong

anova(M2, M1) # right # model 2 comes better than model 1

(M3= lm(mpg~ cyl + wt, data=mtcars))
summary(M3)

anova(M3, M2) # Model 3 comes greater tan Model 2



## STEP 2

# Using AIC of the library MASS

library(MASS)
(model1a = lm(mpg ~ disp + cyl + hp + drat + wt + qsec + carb, data=mtcars ))
step = stepAIC(model1a, direction='both')
?stepAIC
# dirction both means both forward and backward.
# Backward means chossing no variable and only intercept
# Forward varying the no. of variables to take



## STEP 3

#https://cran.r-project.org/web/packages/olsrr/olsrr.pdf
#install.packages('olsrr')
# olsrr - ordinary least square method
library(olsrr)
model <- lm(mpg ~ disp + hp + wt + qsec, data = mtcars)
k <- ols_step_all_possible(model)
plot(k)
k

# install.packages("CHAID",repos="http://R-Forge.R-project.org")