best <- function(state, outcome) {
  outcome.data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  proper.outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!(state %in% outcome.data$State)) {
    stop("invalid state")
  } else {
    state.outcome.data <- outcome.data[outcome.data$State == state,]
  }
  if (!(outcome %in% proper.outcomes)) {
    stop("invalid outcome")
  } else if (outcome == "heart attack") {
    state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-
      as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    best.HA.hosp <- state.outcome.data[state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack ==
      min(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, na.rm=T) &
        !(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)),]
    best.HA.hosp <- best.HA.hosp[order(best.HA.hosp$Hospital.Name),]
    return(best.HA.hosp$Hospital.Name[1])
  } else if (outcome == "heart failure") {
    state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <-
      as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    best.HF.hosp <- state.outcome.data[state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure ==
      min(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, na.rm=T) &
        !(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),]
    best.HF.hosp <- best.HF.hosp[order(best.HF.hosp$Hospital.Name),]
    return(best.HF.hosp$Hospital.Name[1])
  } else if (outcome == "pneumonia") {
    state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <-
      as.numeric(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    best.PN.hosp <- state.outcome.data[state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia ==
      min(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, na.rm=T) &
        !(is.na(state.outcome.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)),]
    best.PN.hosp <- best.PN.hosp[order(best.PN.hosp$Hospital.Name),]
    return(best.PN.hosp$Hospital.Name[1])
  }
}
