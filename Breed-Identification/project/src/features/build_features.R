
library(data.table)
library(ggplot2)
library(caret)
library(ClusterR)

data <- fread("project/volume/data/raw/data.csv")

id <- data$id
data$id <- NULL

pca <- prcomp(data)

screeplot(pca)
summary(pca)
biplot(pca)

pca_dt <- data.table(unclass(pca)$x)

fwrite(pca_dt,"project/volume/data/interim/pca_dt.csv")
