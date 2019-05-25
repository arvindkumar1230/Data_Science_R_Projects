# Here is an overview what we are going to do:
# 1. Installing the R platform.
# 2. Loading the dataset.
# 3. Summarizing the dataset.
# 3. Visualizing the dataset.
# 4. Evaluating some algorithms.
# 5. Making some predictions. 

# Install Packages
#  "The caret package provides a consistent interface into hundreds of machine learning algorithms and provides useful convenience methods for data visualization, data resampling, model tuning and model comparison, among other features."

install.packages("caret")
install.packages("caret", dependencies=c("Depends", "Suggests"))

library(caret)

# attach the iris dataset to the environment
data(iris)
dataset <- iris
# OR, If you want to load the data on your own machine learning project, from a CSV file(https://archive.ics.uci.edu/ml/datasets/Iris).
filename <- "iris.csv"
dataset <- read.csv(filename, header=FALSE)

colnames(dataset) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")

validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE)
validation <- dataset[-validation_index,]

dataset <- dataset[validation_index,]

## Summarize Dataset
# Now it is time to take a look at the data.
# In this step we are going to take a look at the data a few different ways:
# 1. Dimensions of the dataset.
# 2. Types of the attributes.
# 3. Peek at the data itself.
# 4. Levels of the class attribute.
# 5. Breakdown of the instances in each class.
# 6. Statistical summary of all attributes.


dim(dataset)
sapply(dataset, class)
head(dataset)
levels(dataset$Species)
age <- prop.table(table(dataset$Species)) * 100
cbind(freq=table(dataset$Species), percentage=percentage)

summary(dataset)

## Visualize Dataset
# We are going to look at two types of plots:
# 1. Univariate plots to better understand each attribute.
# 2. Multivariate plots to better understand the relationships between attributes.

# split input and output
x <- dataset[,1:4]
y <- dataset[,5]

par(mfrow=c(1,4))
for(i in 1:4) {
  boxplot(x[,i], main=names(iris)[i])
}
plot(y)

# scatterplot matrix
install.packages('ellipse')
featurePlot(x=x, y=y, plot="ellipse")

# box and whisker plots for each attribute
featurePlot(x=x, y=y, plot="box")

# density plots for each attribute by class value
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)


## Evaluate Some Algorithms
# Now it is time to create some models of the data and estimate their accuracy on unseen data.
# 1. Set-up the test harness to use 10-fold cross validation.
# 2. Build 5 different models to predict species from flower measurements
# 3. Select the best model.

install.packages("e1071")
library(e1071)

control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

# Let's evaluate 5 different algorithms:
# 1. Linear Discriminant Analysis (LDA) - [linear algorithms]
# 2. Classification and Regression Trees (CART). - [nonlinear algorithms]
# 3. k-Nearest Neighbors (kNN). - [nonlinear algorithms]
# 4. Support Vector Machines (SVM) with a linear kernel. - [nonlinear algorithms]
# 5. Random Forest (RF)- [nonlinear algorithms]

# a) linear algorithms
set.seed(7)
fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)

# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(Species~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(Species~., data=dataset, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(Species~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(Species~., data=dataset, method="rf", metric=metric, trControl=control)

# summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)

# compare accuracy of models
dotplot(results)

# summarize Best Model
print(fit.lda)

##  Make Predictions
# estimate skill of LDA on the validation dataset
predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$Species)

# We can see that the accuracy is 100%. It was a small validation dataset (20%), but this result is within our expected margin of 97% +/-4% suggesting we may have an accurate and a reliably accurate model.
