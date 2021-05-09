
train_init <- fread("volume/data/raw/train_data.csv")
train_emb <- fread("volume/data/raw/train_emb.csv")



train_init$label <- -1

train_init[train_init$subredditcars == 1,"label"] <- 0
train_init[train_init$subredditCooking == 1,"label"] <- 1
train_init[train_init$subredditMachineLearning == 1,"label"] <- 2
train_init[train_init$subredditmagicTCG == 1,"label"] <- 3
train_init[train_init$subredditpolitics == 1,"label"] <- 4
train_init[train_init$subredditReal_Estate == 1,"label"] <- 5
train_init[train_init$subredditscience == 1,"label"] <- 6
train_init[train_init$subredditStockMarket == 1,"label"] <- 7
train_init[train_init$subreddittravel == 1,"label"] <- 8
train_init[train_init$subredditvideogames == 1,"label"] <- 9

train<- train_emb
train$label <- train_init$label






#prep data for xgb
x.train <- train
y.train <- data.table(train$label)
x.train[,label:=NULL]

fwrite(x.train,"volume/data/interim/x-train.csv")
fwrite(y.train,"volume/data/interim/y-train.csv")

