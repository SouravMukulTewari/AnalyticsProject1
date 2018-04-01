# Groceries Example 2 ####

library(arules)  #install first
library(arulesViz) #install first
library(datasets)  # no need to install, just load it
data('Groceries')

str(Groceries)
Groceries
inspect(Groceries[1:5])  #view the 1st 5 bills contents
LIST(Groceries[1:5])  #another view same as above but different presentation (from 1 to 5)
LIST(Groceries[4:7]) # List view as above but from 4th to 7th 

#Lets Apply Apriori Algorithm # to identify the Frequently purchased items
frequentItems <- eclat (Groceries, parameter = list(supp = 0.005, minlen= 3, maxlen = 5)) # eclat = frequently purchased item identifier
# supp = 50/10000 for 0.005 || 500/10000 for 0.05, minlen 1 to maxlen 15 i.e from 1 item to max 15 no. of items
# supp = percentage that item was bought
# support(A&B) = n(A&B)/ No. of Times
# Given confidence is that I need results for those whose confidence is greater than what I mentioned

# Now varying the minlen and maxlen
frequentItems <- eclat (Groceries, parameter = list(supp = 0.005, minlen= 1, maxlen = 15))

frequentItems
inspect(frequentItems[1:5])
# inspect(frequentItems[990:1001])
inspect(sort (frequentItems, by="count", decreasing=TRUE)[1:10]) # Sorting it from max count to decreasing below i.e in Descending order

?eclat
itemFrequencyPlot (Groceries,topN = 10,type="absolute") # Plots showing the top 10 max bought items in vertical plot
itemFrequencyPlot(Groceries, topN = 10, type='relative')
abline(h=0.2) # To mark which item crosses a particular threshhold value

rules <- arules::apriori(Groceries, parameter = list(supp = 0.005, conf = 0.5))
rules
write.csv(inspect(rules), 'rules.csv') # Writing and Storing the output of R into *.csv format
# (Use (File-> New File -> Markdown) to have the program as well as the result and Plot all in one go)
# From result observe that --> support* [Total no. of entries(9835 here)] = Count

inspect(rules[1:5])
quality(rules)  # If we only need the Numerical Portion / Value then use quality(rules)

head(quality(rules))
options (digits=2)
inspect (rules[1:5])

rulesc <- sort (rules, by="confidence", decreasing=TRUE) # Sorting in Decreasing order of Confidence
inspect(rulesc[1:5])

rulesl <- sort (rules, by="lift", decreasing=TRUE) # Sorting in Decreasing order of Lift
inspect (rulesl[1:5]) # Outfit of the sorted thing for Lift

#How To Control The Number Of Rules in Output ?
rules <- apriori (Groceries, parameter = list (supp = 0.001, conf = 0.5, maxlen=3)) # maxlen = 3 limits the elements in a rule to 3

#How To Remove Redundant Rules ?
sum(is.redundant(rules))  # Are any Rules redundant?
(redundant = which(is.redundant(rules)))  # If yes which rule is redundant
#colSums(is.subset(rules, rules))
rulesNR <- rules[-redundant] # removing the Redundant
is.redundant(rulesNR)  # Cross verifying that is is the redundant removed?
sum(is.redundant(rulesNR))  #ok now, Now no redundant rules are there

#Another method
#redundant <- which (colSums (is.subset (rules, rules)) > 1) 
#redundant


#Find what factors influenced an event ‘X’
rules <- apriori (data=Groceries, parameter=list (supp=0.001,conf = 0.08), appearance = list (default="lhs",rhs="whole milk"), control = list (verbose=F))# Finding on which all Items trigerred the SAles of Milk. Therefore fix the RHS as 'whole Milk'
# Verbose(F) means dont show me the time taken for calculation and so on..
inspect(rules[1:15])

#Find out what events were influenced by a given event

rules <- apriori (data=Groceries, parameter=list (supp=0.001,conf = 0.15,minlen=2), appearance = list (default="rhs",lhs="whole milk"), control = list (verbose=F))  
inspect(rules[1:5])
rules <- apriori (data=Groceries, parameter=list (supp=0.001,conf = 0.05,minlen=2), appearance = list (default="rhs",lhs="whole milk"), control = list (verbose=F))  
inspect(rules)

#Visualizing The Rules -----

plot (rules[1:5], measure=c("support", "lift"), shading="confidence")
plot (rules, measure=c("support", "lift"), shading="confidence")

plot(rules[1:5],method="graph",engine='interactive', shading="confidence") 