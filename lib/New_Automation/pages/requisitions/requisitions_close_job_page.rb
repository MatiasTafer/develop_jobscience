class RequisitionsCloseJob
  
  #BUTTONS
  REQUISITIONS_CLOSE_JOB_BTN_CANCEL_XPATH = ".//*[@value='Cancel']"
  REQUISITIONS_CLOSE_JOB_BTN_CLOSE_XPATH = ".//*[@value='Close']"
  REQUISITIONS_CLOSE_JOB_SUCCESS_BTN_XPATH = ".//*[@value='Next']"
  
  #FIELDS
  REQUISITIONS_CLOSE_JOB_DATE_CLOSED_XPATH = ".//*[text()='Date Closed']/../following-sibling::*[1]//input"
  REQUISITIONS_CLOSE_JOB_CLOSED_REASON_XPATH = ".//*[text()='Closed Reason']/../following-sibling::*[1]//select"
  OVERALL_REJECTED_REASON_SELECT_XPATH = ".//*[text()='Overall Reject Reason']/../..//select"
    
  CLOSE_REASON_TEXT = 'Closed'
  OVERALL_TEXT = "More Qualified Candidate selected/interview"
  
  #Messages
  CONFIRM_DELETED_MESSAGE_XPATH = ".//*[@class='message confirmM3']"
  
  #Errors
  ERROR_REQUIRED_FIELDS_XPATH =".//*[@class='errorMsg']"
  ERROR_REQUIRED_FIELD_TEXT = "Error: You must enter a value"
  
end