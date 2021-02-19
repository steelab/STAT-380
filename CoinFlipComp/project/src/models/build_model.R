
train <- fread("project/volume/data/interim/train.csv")
test <- fread("project/volume/data/interim/test.csv")

glm_fit <- glm(result ~ total,family="binomial",data=train )

test$predResult <- predict(glm_fit,newdata = test,type="response")

summary(glm_fit)

saveRDS(glm_fit,"project/volume/models/GLM_fitModel")




submission <- fread("project/volume/data/raw/samp_sub.csv")
submission$result <- test$predResult

fwrite(submission,"project/volume/data/processed/submission.csv")