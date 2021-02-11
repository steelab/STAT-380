library(data.table)
library(caret)
library(Metrics)


set.seed(9001)
train <- fread("project/volume/data/raw/Stat_380_train.csv")
test <- fread("project/volume/data/raw/Stat_380_test.csv")

dummies = dummyVars(BldgType ~.,data=train)
dummies1 = dummyVars(BldgType ~.,data=test)


train <- predict(dummies, newdata = train)
test <- predict(dummies1, newdata = test)

train <- data.table(train)
test <- data.table(test)


fit <- lm(SalePrice ~LotArea+OverallQual+OverallCond+FullBath+HalfBath+YearBuilt+TotalBsmtSF+BedroomAbvGr+GrLivArea+YrSold,data = train)


#Saves model
saveRDS(fit,"project/volume/models/HousePriceLM")

#Predicting SalePrice and writes this to the test data.table
test$SalePrice <- predict(fit,newdata = test)

#reading in sample submission
submission <- fread("project/volume/data/raw/Stat_380_sample_submission.csv")

submission$SalePrice <- test$SalePrice  #writing our predicted sales price into the sample submission template
fwrite(submission,"project/volume/data/processed/submit-v6.csv") #Saves our submission data.table externally
