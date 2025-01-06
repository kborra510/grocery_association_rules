rm(list = ls())
graphics.off()

# install.packages("arules")
library("arules")
setwd("~/Desktop/")

#dats0 <- read.delim("groceries.csv", sep = ",", header = TRUE)
dats <- read.transactions("groceries.csv", sep = ",")

dats
summary(dats)

# Look at what is "inside" by TID
head(toLongFormat(dats, decode = FALSE), n=10) #numeric assign. of item
head(toLongFormat(dats, decode = TRUE), n=10) #name assign. of item

# Look at data by name and visualization
inspect(dats[1:7])

# summary - 
itemFrequency(dats[,1:10]) #support of different items

#?itemFrequencyPlot
itemFrequencyPlot(dats, support = .05)

itemFrequencyPlot(dats, topN = 15)

# Generate some association rules
#?apriori
my_params <- list(support = .005, confidence = .01, minlen = 2, maxlen = 6)
my_rules <- apriori(dats, parameter = my_params)
my_rules

# lets look at some rules
inspect(my_rules[1:3])

# sort by lift (look at top rules)
inspect(sort(my_rules, by = "lift")[1:5])

inspect(sort(my_rules, by = "confidence")[1:5])

# ham rules (look at ham rules, and top ham rules)
hamrules <- subset(my_rules, items %in% "ham")
inspect(hamrules)
inspect(sort(hamrules, by = "lift"))

hamrules2 <- subset(my_rules, rhs %in% "ham")
inspect(hamrules2)
inspect(sort(hamrules2, by = "lift"))

# yogurt rules
yogrules <- subset(my_rules, lhs %in% "yogurt")
inspect(sort(yogrules, by = "confidence")[1:10])

# output the rules 
write(hamrules, file = "ham.csv", sep = ",", quote = TRUE, row.names = FALSE)

# we can convert our rules to a data.frame
my_rules_df <- as(my_rules, "data.frame")










