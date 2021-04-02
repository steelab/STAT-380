train <- fread("project/volume/data/interim/Stat_380_train.csv")
test <- fread("project/volume/data/interim/Stat_380_test.csv")


train <- data.table(train)
test <- data.table(test)




x.train <- train
y.train <- data.table(train$SalePrice)
x.train[,SalePrice:=NULL]

dtrain <- xgb.DMatrix(as.matrix(x.train),label = as.matrix(y.train),missing = NA)

dtest <- xgb.DMatrix(as.matrix(test),missing=NA)


#use cv
myparam <- list (objective = "reg:squarederror",
                 gamma=0.02,booster="gbtree",eval_metric="rmse",
                 eta=0.02,max_depth=5,min_child_weight = 1,subsample=1.0,
                 colsample_bytree=1.0,tree_method="hist")

XGBfit <- xgb.cv(params = myparam,nfold=5,nrounds=10000,missing=NA,
                 data=dtrain,print_every_n = 1,early_stopping_rounds = 100)

best_tree <- unclass(XGBfit)$best_iteration



XGBfit <- xgb.train(params=myparam,nrounds = 618,data = dtrain)
saveRDS(XGBfit,"project/volume/models/XGBfit")


pred <- predict(XGBfit,newdata = dtest)

pred <- data.frame(pred)
submission <- fread("project/volume/data/raw/Stat_380_sample_submission.csv")
submission$SalePrice <- pred  #writing our predicted sales price into the sample submission template
fwrite(submission,"project/volume/data/processed/submit-v6.csv") #Saves our submission data.table externally


