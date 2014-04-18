complete <- function(directory, id = 1:332) {
  allData <- data.frame()
  id.char <- sprintf("%03d", id)
  for (i in id.char) {
    filename <- paste0(directory,"/",i,".csv")
    data <- read.csv(filename)
    data.count <- data.frame("id" = i, nobs = nrow(data[complete.cases(data),]))
    allData <- rbind(allData, data.count)
  }
  return(allData)
}