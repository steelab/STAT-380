

test<-fread("volume/data/raw/test_file.csv")
test_emb <- fread("volume/data/raw/test_emb.csv")

x.train <- fread("volume/data/interim/x-train.csv")
y.train <- fread("volume/data/interim/y-train.csv")

dtrain <- xgb.DMatrix(as.matrix(x.train),label = as.matrix(y.train),missing = NA)
dtest <- xgb.DMatrix(as.matrix(test_emb),missing=NA)


#use cv
myparam <- list (objective = "multi:softprob",
                 gamma=0.02,booster="gbtree",eval_metric="mlogloss",num_class = 10,
                 eta=0.005,max_depth=15,min_child_weight = 1,subsample=1.0,
                 colsample_bytree=1.0,tree_method="hist")

XGBfit <- xgb.cv(params = myparam,nfold=7,nrounds=20000,missing=NA,
                 data=dtrain,print_every_n = 1,early_stopping_rounds = 100)

best_tree <- unclass(XGBfit)$best_iteration



XGBfit <- xgb.train(params=myparam,nrounds = 1000,data = dtrain)

saveRDS(XGBfit,"project/volume/models/XGBfit")


pred <- predict(XGBfit,newdata = dtest)

pred <- data.frame(pred)
sub <- fread("volume/data/raw/example_sub.csv")
sub$subredditcars <- pred[c(seq(1,205550,10)),]
sub$subredditCooking <- pred[c(seq(2,205550,10)),]
sub$subredditMachineLearning <- pred[c(seq(3,205550,10)),]
sub$subredditmagicTCG <- pred[c(seq(4,205550,10)),]
sub$subredditpolitics <- pred[c(seq(5,205550,10)),]
sub$subredditReal_Estate <- pred[c(seq(6,205550,10)),]
sub$subredditscience <- pred[c(seq(7,205550,10)),]
sub$subredditStockMarket <- pred[c(seq(8,205550,10)),]
sub$subreddittravel <- pred[c(seq(9,205550,10)),]
sub$subredditvideogames <- pred[c(seq(10,205550,10)),]

fwrite(sub,"volume/data/processed/final-sub.csv")