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

# Dummy variable
df = mtcars
summary(df)
df$cyl = factor(df$cyl)

# M1 = lm(mpg ~ wt + cyl + am, data=df) # am not significant so drop it from the model, so vehicle being automatic or not does not affect the mileage
M1 = lm(mpg ~ wt + cyl, data=df)
summary(M1)
summary(df$cyl)

# These (Below) are the different values that we are passing in the model to find the mileage for those corresponding values
data.frame(wt=c(2,3), cyl=factor(c(4,6)))
predict(M1, newdata = data.frame(wt=c(2,3), cyl=factor(c(4,6))))
predict(M1, newdata = data.frame(wt=c(3.5,5.2), cyl=factor(c(8,6))))
summary(df)

# first cyl4 is taken as reference model(so no emphasize on cyl4), then cyl 6 leads to lesser mileage and now going to cyl 8 much lesser would be the mileage, so higher is the negative coefficient for cyl8 as compared to cyl6

# The below equations are meant for understanding how R predicts the result at back end

# Now in this case seeking summary(M1) if it so happens that cyl 6 is not significant but cyl 8 is significant then also we have to keep the cylinder.
# But if none of the cylinder thing comes significant then we have to entirely remove it from our Model

# y4 = 33.99 + -3.2 * wt + 0
# y6 = 33.99 + -3.2 * wt + -4.2 * cyl6(=1)
# y8 = 33.99 + -3.2 * wt + -4.2 * cyl8(=1)

head(df)
