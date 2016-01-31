best <- function(state, outcome) {
  ## Read outcome data
  hdata<-read.csv("outcome-of-care-measures.csv", colClasses="character")
  
  # Rename state column to make it easier to reference later
  colnames(hdata)[7]<-"State"
  
  ## Check that state and outcome are valid
  
  # Get a list of valid states from the data, remove duplicates
  states<-unique(hdata$State)
  
  # Mapping of correct outcome string to column number in hdata table
  outcomes<-data.frame(Cause=c("heart attack", "heart failure", "pneumonia"), Outcome_Col=c(11,17,23))
  
  # Check each input parameter for invalid values, stop with an error message if invalid
  if (!(state %in% states) ) {
    stop ("invalid state")
  }
  if (!(outcome %in% outcomes$Cause)) {
    stop ("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  # work out which column in the hdata corresponds to the requested outcome
  outcome_col<-outcomes[outcomes$Cause==outcome,]$Outcome_Col
  
  # select the subset of records from hdata for the state and set the column names
  state_outcomes<-subset(hdata, hdata$State==state, select=c(2,outcome_col))
  colnames(state_outcomes)<-c("Hospital", "Outcome")
  
  # Make outcome column numeric, remove NAs and sort by Outcome and Hospital name
  state_outcomes[,2]<-as.numeric(state_outcomes[,2])
  state_outcomes<-na.omit(state_outcomes)
  state_outcomes<-state_outcomes[order(state_outcomes$Outcome,state_outcomes$Hospital),]
  
  # First item is the hospital with the best outcomes
  state_outcomes[[1,1]]
}