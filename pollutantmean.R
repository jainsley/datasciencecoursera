pollutantmean <- function(directory, pollutant, id = 1:332) {
  allData <- data.frame()
  id.char <- sprintf("%03d", id)
  for (i in id.char) {
    filename <- paste0(directory,"/",i,".csv")
    data <- read.csv(filename)
    allData <- rbind(allData, data)
  }
  if (pollutant == "sulfate") {
    return(mean(allData$sulfate, na.rm = TRUE))
  } else if (pollutant == "nitrate") {
    return(mean(allData$nitrate, na.rm = TRUE))
  } else {
    return(NA)
  }
}