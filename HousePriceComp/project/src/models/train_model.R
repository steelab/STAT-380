
fit <- lm(SalePrice ~LotArea+OverallQual+OverallCond+FullBath+HalfBath+YearBuilt+TotalBsmtSF+BedroomAbvGr+GrLivArea+YrSold,data = train)


#Saves model
saveRDS(fit,"project/volume/models/HousePriceLM")

#Predicting SalePrice and writes this to the test data.table
test$SalePrice <- predict(fit,newdata = test)