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
  key <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
  state.outcome.data[,key[[outcome]]] <- as.numeric(state.outcome.data[,key[[outcome]]])
  HA.hosp <- state.outcome.data[!(is.na(state.outcome.data[,key[[outcome]]])),]
  HA.hosp <- HA.hosp[order(HA.hosp[,key[[outcome]]], HA.hosp[,2]),]
  if (num == "best") {
    return(HA.hosp$Hospital.Name[1])
  } else if (num == "worst") {
    return(HA.hosp$Hospital.Name[nrow(HA.hosp)])
  } else if (num > nrow(HA.hosp)) {
    return(NA)
  } else {
    return(HA.hosp$Hospital.Name[num])
  }
}
