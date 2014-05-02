rankhospital <- function(state, outcome, num = "best") {
  # Read outcome data
  outcome.data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check that state is valid
  if (!(state %in% outcome.data$State)) {
    stop("invalid state")
  } else {
    state.outcome.data <- outcome.data[outcome.data$State == state,]
  }
  
  #Check that outcome is valid
  proper.outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!(outcome %in% proper.outcomes)) {
    stop("invalid outcome")
  }
  
  # Return hospital name in that state with the given rank
  if (outcome == "heart attack") {
    state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-
      as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    HA.hosp <- state.outcome.data[!(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)),]
    HA.hosp <- HA.hosp[order(HA.hosp[,11], HA.hosp[,2]),]
    if (num == "best") {
      num <- 1
      return(HA.hosp$Hospital.Name[num])
    } else if (num == "worst") {
      num <- nrow(HA.hosp)
      return(HA.hosp$Hospital.Name[num])
    } else if (num > nrow(HA.hosp)) {
      return(NA)
    } else {
      return(HA.hosp$Hospital.Name[num])
    }
  } else if (outcome == "heart failure") {
    state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <-
      as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    HF.hosp <- state.outcome.data[!(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),]
    HF.hosp <- HF.hosp[order(HF.hosp[,17], HF.hosp[,2]),]
    if (num == "best") {
      num <- 1
      return(HF.hosp$Hospital.Name[num])
    } else if (num == "worst") {
      num <- nrow(HF.hosp)
      return(HF.hosp$Hospital.Name[num])
    } else if (num > nrow(HF.hosp)) {
      return(NA)
    } else {
      return(HF.hosp$Hospital.Name[num])
    }
  } else if (outcome == "pneumonia") {
    state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <-
      as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    PN.hosp <- state.outcome.data[!(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)),]
    PN.hosp <- PN.hosp[order(PN.hosp[,23], PN.hosp[,2]),]
    if (num == "best") {
      num <- 1
      return(PN.hosp$Hospital.Name[num])
    } else if (num == "worst") {
      num <- nrow(PN.hosp)
      return(PN.hosp$Hospital.Name[num])
    } else if (num > nrow(PN.hosp)) {
      return(NA)
    } else {
      return(PN.hosp$Hospital.Name[num])
    }
  }
}
