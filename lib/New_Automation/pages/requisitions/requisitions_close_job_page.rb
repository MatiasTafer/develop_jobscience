class RequisitionsCloseJob
  
  #BUTTONS
  REQUISITIONS_CLOSE_JOB_BTN_CANCEL_XPATH = ".//*[@value='Cancel']"
  REQUISITIONS_CLOSE_JOB_BTN_CLOSE_XPATH = ".//*[@value='Close']"
  REQUISITIONS_CLOSE_JOB_SUCCESS_BTN_XPATH = ".//*[@value='Next']"
  
  #FIELDS
  REQUISITIONS_CLOSE_JOB_DATE_CLOSED_XPATH = ".//*[@class='dateInput dateOnlyInput']/input"
  REQUISITIONS_CLOSE_JOB_CLOSED_REASON_XPATH = "(.//select)[1]"
  REQUISITIONS_CLOSE_JOB_OVERALL_REJECT_REASON_XPATH = "(.//select)[2]"
  
  CLOSE_REASON_TEXT = 'Closed'
  
  #Messages
  CONFIRM_DELETED_MESSAGE_XPATH = ".//*[@class='message confirmM3']"
  
  #Errors
  ERROR_REQUIRED_FIELDS_XPATH =".//*[@class='errorMsg']"
  ERROR_REQUIRED_FIELD_TEXT = "Error: You must enter a value"
  
end