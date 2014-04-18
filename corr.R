corr <- function(directory, threshold = 0) {
  cor.vec <- numeric()
  allData <- complete(directory)
  thresholdData <- allData[allData$nobs > threshold,]
  for (i in thresholdData$id) {
    filename <- paste0(directory,"/",i,".csv")
    data <- read.csv(filename)
    complete.data <- data[complete.cases(data),]
    cor.atomic <- cor(complete.data$sulfate, complete.data$nitrate)
    cor.vec <- c(cor.vec, cor.atomic)
  }
  return(cor.vec)
}