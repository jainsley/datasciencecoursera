library(datasets)
data(iris)

head(iris)
summary(subset(iris, iris$Species == "virginica"))
apply(iris[,1:4], 2, mean)

data(mtcars)

head(mtcars)
with(mtcars, tapply(mpg, cyl, mean))
mean_hp_by_cyl <- with(mtcars, tapply(hp, cyl, mean))
mean_hp_by_cyl[3] - mean_hp_by_cyl[1]