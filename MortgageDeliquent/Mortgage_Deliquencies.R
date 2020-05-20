##The goal of this exercise is to predict 90-day mortgage delinquencies in the first five years after loanorigination.
rm(list=ls())
install.packages("h2o")
install.packages("pROC")

library(dplyr)
library(pROC)
library(h2o)
library(psych)

load(file = "~/FIN 372/HW8/training_10.rda")
load(file = "~/FIN 372/HW8/testing_11.rda")

data1 <- describeBy(training_10, training_10$Delq.90.days, mat = TRUE)
print("The summaries of the deliquent payments' components is as follows")
data1["CSCORE_B2",]
data1["OLTV2",]
data1["OCLTV2",]
data1["DTI2",]

print("The summaries of the non deliquent payments components is as follows")
data1["CSCORE_B1",]
data1["OLTV1",]
data1["OCLTV1",]
data1["DTI1",]

print("It appears that CSCORE_B is highly correlated w high deliquency, the lower the score the higher the likihood of deliquency.")

data7 <- describeBy(training_10$Delq.90.days,training_10$STATE, mat = TRUE)
print("Based on the summary of the data output in the matrix data 7, the state with the lowest Deliquency is North Dakota --ND-- , while the state with the highest delquency rate is the virgin islands --VI-- continental 50:Mississippi")

data8 <- describeBy(training_10$Delq.90.days, training_10$ORIG_DTE, mat = TRUE)
print("The origination month w the highest Deliquency rates is January, while the lowest Deliquency rate is November. This is based on the matrix data8.")

# problem 3
reg1 <- glm(Delq.90.days ~ ORIG_RT, data = training_10)
reg1$coefficients
summary(reg1)
print("The formula for predcting deliquency rate is Deli.90.days = Intercept_coef + Orig_rt_coef * ORIG_RT")
predict(reg1)
print("The previous output shows the 90 day deliquency rate  with that samples Interest rate as the Y variable. ")
#problem 4
reg2 <- glm(Delq.90.days ~ CSCORE_B + OLTV + OCLTV + DTI + OCC_STAT + STATE , data = training_10)
reg2$coefficients
summary(reg2)
predict(reg2)
#If you want to see all the predictions enter getOption("max.print")

#problem 5

h2o.init()

h2o1 <- as.h2o(training_10, destination_frame = "h2o1")
h2o1[,17:18] <- as.factor(h2o1[17:18])
h2o1<- h2o1[,c(8:9,11:12,17:18,26,3)]


#predict1 <- h2o.(x = 8, y = 7, trainging_frame = h2o1)
#predict2<- h2o.glm(x = 1:6, y = 7, trainging_frame = h2o1)

predictinfo <-h2o.randomForest(x = 1:6, y = 7, training_frame = h2o1, ntrees = 250)

##summary(predictinfo)

testdata <- as.h2o(testing_11, destination_frame = "testdata")

###problem6 predict deliquency rate using the test sample   reg1 reg2 predictinfo are three models

h2o.predict(predictinfo, newdata = testdata)

