set.seed(9001)
train <- fread("project/volume/data/raw/Stat_380_train.csv")
test <- fread("project/volume/data/raw/Stat_380_test.csv")

dummies = dummyVars(BldgType ~.,data=train)
dummies1 = dummyVars(BldgType ~.,data=test)


train <- predict(dummies, newdata = train)
test <- predict(dummies1, newdata = test)

train <- data.table(train)
test <- data.table(test)

fwrite(train,"project/volume/data/interim/Stat_380_train.csv")
fwrite(test,"project/volume/data/interim/Stat_380_test.csv")
