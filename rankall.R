rankall <- function(outcome, num = "best") {
  # Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  #Check that outcome is valid
  proper.outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!(outcome %in% proper.outcomes)) {
    stop("invalid outcome")
  }
  
  get_outcome <- function(input) {
    if (input == "heart attack") {
      state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-
        as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
      outcome.rank <- state.outcome.data[!(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)),]
      outcome.rank <- outcome.rank[order(outcome.rank[,11], outcome.rank[,2]),]
    } else if (input == "heart failure") {
      state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <-
        as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
      outcome.rank <- state.outcome.data[!(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),]
      outcome.rank <- outcome.rank[order(outcome.rank[,17], outcome.rank[,2]),]
    } else if (input == "pneumonia") {
      state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <-
        as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
      outcome.rank <- state.outcome.data[!(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)),]
      outcome.rank <- outcome.rank[order(outcome.rank[,23], outcome.rank[,2]),]
    }
    return(outcome.rank)
  }
  
  get_rank <- function(input, rank) {
    if (rank == "best") {
      rank <- 1
      output <- data.frame(hospital = input[rank,2], state = input[rank,7], stringsAsFactors = FALSE)
    } else if (rank == "worst") {
      rank <- nrow(input)
      output <- data.frame(hospital = input[rank,2], state = input[rank,7], stringsAsFactors = FALSE)
    } else if (rank > nrow(input)) {
      output <- data.frame(hospital = NA, state = input[1,7], stringsAsFactors = FALSE)
    } else {
      output <- data.frame(hospital = input[rank,2], state = input[rank,7], stringsAsFactors = FALSE)
    }
    return(output)
  }
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  allData <- data.frame(hospital = character(0), state = character(0))
  
  for (state in unique(outcome.data$State)) {
    state.outcome.data <- outcome.data[outcome.data$State == state,]
    state.outcome.specific <- get_outcome(outcome)
    state.output <- get_rank(state.outcome.specific, num)
    allData <- rbind(allData, state.output)
  }
  allData <- allData[order(allData[,2]),]
  return(allData)
}