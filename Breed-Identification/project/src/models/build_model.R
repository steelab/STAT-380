
pca_dt <- fread("project/volume/data/interim/pca_dt.csv")

opt_num_clus <- 3
gmm_data <- GMM(pca_dt[,1:3], opt_num_clus)
prob_cluster <- predict_GMM(pca_dt[,1:3],gmm_data$centroids,
                            gmm_data$covariance_matrices,
                            gmm_data$weights)

pred <- data.table(prob_cluster$cluster_proba)

pred$id <- id

names(pred)[names(pred)=='V1'] <- "breed.3"
names(pred)[names(pred)=='V2'] <- "breed.1"
names(pred)[names(pred)=='V3'] <- "breed.2"

pred <- pred[, c(4, 2, 3, 1)]

saveRDS(prob_cluster,"project/volume/models/GMModel")


fwrite(pred,"project/volume/data/processed/sub_breed_test.csv")
