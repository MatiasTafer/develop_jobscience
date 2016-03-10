class RequisitionsChangeStatus
  
  REQUISITIONS_CHANGE_STATUS_NEW_STATUS_XPATH = ".//*[text()='New Status']/../following-sibling::*[1]//select"
  REQUISITIONS_CHANGE_STATUS_BTN_UPDATE_STATUS_XPATH = ".//*[@title='Update Status']"
  REQUISITIONS_CHANGE_STATUS_BTN_BACK_TO_LIST_XPATH = ".//*[@title='Back to List']"

  #PAGINATION MUST BE ON SECOND PAGE
  REQUISITIONS_CHANGE_STATUS_RECORDS_PER_PAGE_XPATH = ".//*[text()[contains(.,'Records per page:')]]//select"
  REQUISITIONS_CHANGE_STATUS_FIRST_PAGE_XPATH = ".//*[@class='first']"
  REQUISITIONS_CHANGE_STATUS_PREVIOUS_PAGE_XPATH = ".//*[@class='prev']"
  REQUISITIONS_CHANGE_STATUS_NEXT_PAGE_XPATH = ".//*[@class='next']"
  REQUISITIONS_CHANGE_STATUS_LAST_PAGE_XPATH = ".//*[@class='last']"
  REQUISITIONS_CHANGE_STATUS_CURRENT_PAGE_XPATH = ".//span[text()[contains(.,'Page')]]//input"
  REQUISITIONS_CHANGE_STATUS_NUMBER_OF_RECORDS_XPATH = ".//*[text()[contains(.,'Records per page')]]"
  
  REQUISITION_NEW_STATUS_TEXT = "Open"
  
  BACK_TO_LIST_BUTTON_SUCCESS_PAGE_XPATH = ".//*[@title='Back to List']"
  
  ERROR_STATUS_MUST_BE_SELECTED = ".//*[@class='message errorM3']"
  
end