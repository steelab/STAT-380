
train <- fread("project/volume/data/raw/train_file.csv")
test <- fread("project/volume/data/raw/test_file.csv")

train <- train[,-c(1)]
test <- test[,-c(1)]

train$total = (train$V1+ train$V2+train$V3+train$V4+train$V5+train$V6+train$V7+train$V8+train$V9+train$V10)
test$total = (test$V1+ test$V2+test$V3+test$V4+test$V5+test$V6+test$V7+test$V8+test$V9+test$V10)

fwrite(train,"project/volume/data/interim/train.csv")
fwrite(test,"project/volume/data/interim/test.csv")

test$predResult <- predict(glm_fit,newdata = test,type="response")
