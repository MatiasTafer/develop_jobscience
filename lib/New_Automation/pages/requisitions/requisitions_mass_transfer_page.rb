class RequisitionMassTransfer
  
  REQUISITIONS_MASS_TRANSFER_TRANSFER_TO_RECRUITER_XPATH = ".//*[text()='Transfer To Recruiter']/../following-sibling::*[1]//span/input"
  REQUISITIONS_MASS_TRANSFER_BTN_TRANSFER_XPATH = ".//*[@title='Transfer']"
  REQUISITIONS_MASS_TRANSFER_BTN_BACK_TO_LIST_XPATH = ".//*[@title='Back to List']"
  BACK_TO_LIST_BUTTON_ON_SUCCSESS_PAGE = ".//*[@title='Back to List']"
  
  
  #PAGINATION MUST BE ON SECOND PAGE
  REQUISITIONS_MASS_TRANSFER_RECORDS_PER_PAGE_XPATH = ".//*[text()[contains(.,'Records per page:')]]//select"
  REQUISITIONS_MASS_TRANSFER_FIRST_PAGE_XPATH = ".//*[@class='first']"
  REQUISITIONS_MASS_TRANSFER_PREVIOUS_PAGE_XPATH = ".//*[@class='prev']"
  REQUISITIONS_MASS_TRANSFER_NEXT_PAGE_XPATH = ".//*[@class='next']"
  REQUISITIONS_MASS_TRANSFER_LAST_PAGE_XPATH = ".//*[@class='last']"
  REQUISITIONS_MASS_TRANSFER_CURRENT_PAGE_XPATH = ".//span[text()[contains(.,'Page')]]//input"
  REQUISITIONS_MASS_TRANSFER_NUMBER_OF_RECORDS_XPATH = ".//*[text()[contains(.,'Records per page')]]"
  
  RECRUITER_TO_TRANSFER_TEXT = "Charlie Day"
  
  #ERRORS
  ERROR_RECRUITER_MUST_BE_SELECTED_XPATH = ".//*[@class='message errorM3']"

end