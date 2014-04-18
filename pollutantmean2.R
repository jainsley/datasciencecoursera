pollutantmean <- function(directory, pollutant, id = 1:332) {
  allData <- numeric()
  id.char <- sprintf("%03d", id)
  for (i in id.char) {
    filename <- paste0(directory,"/",i,".csv")
    data <- read.csv(filename)
    if (pollutant == "sulfate") {
      allData <- c(allData, data$sulfate)
    } else if (pollutant == "nitrate") {
      allData <- c(allData, data$nitrate)
    } else {
      print("Not a listed pollutant.")
      return(NA)
    }
  }
  return(mean(allData, na.rm = TRUE))
}