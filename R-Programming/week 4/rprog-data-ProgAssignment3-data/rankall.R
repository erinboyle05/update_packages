rankall <- function(outcome, num = "best") {
  ## Read outcome data
  hdata<-read.csv("outcome-of-care-measures.csv", colClasses="character")

  # Mapping of correct outcome string to column number in hdata table
  outcomes<-data.frame(Cause=c("heart attack", "heart failure", "pneumonia"), Outcome_Col=c(11,17,23))
  
  ## Check that state and outcome are valid
  if (!(outcome %in% outcomes$Cause)) {
    stop ("invalid outcome")
  }

  ## For each state, find the hospital of the given rank

  # work out which column in the hdata corresponds to the requested outcome
  outcome_col<-outcomes[outcomes$Cause==outcome,]$Outcome_Col
  
  # select the subset of records from hdata and set the column names
  all_outcomes<-subset(hdata, select=c(2,7, outcome_col))
  colnames(all_outcomes)<-c("hospital", "state", "outcome")
  
  # Make outcome column numeric, remove NAs and sort by state, Outcome and Hospital name
  all_outcomes[,3]<-as.numeric(all_outcomes[,3])
  all_outcomes<-na.omit(all_outcomes)
  all_outcomes<-all_outcomes[order(all_outcomes$state, all_outcomes$outcome,all_outcomes$hospital),]
  
  # split into seperate state dataframes
  all_outcomes<-split(all_outcomes, all_outcomes$state)
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  # Create an empty dataframe to store the result in for each state
  result<-data.frame(hospital=character(), state=character(), stringsAsFactors = FALSE)
  states<-names(all_outcomes)
  
  for (i in 1:length(states)) {
    # get the state name and the subset of state data
    state_name<-states[i]
    state_data<-all_outcomes[[state_name]]
    
    # work out which row should be selected for the state and store in n
    n=num
    # If the num contains best or worst, select first or last row respectively
    if (num=="best") {n=1}
    if (num=="worst") {n=nrow(state_data)}
  
    if (n>nrow(state_data)) {
      hospital<-"<NA>"
    }
    else {
      hospital<-state_data$hospital[n]
    }
  result[nrow(result)+1,]<-c(hospital, state_name)
  }

  
  # Return the hospital with the ranking of num
  result
}