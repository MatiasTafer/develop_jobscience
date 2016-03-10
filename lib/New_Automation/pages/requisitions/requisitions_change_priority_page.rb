class RequisitionsChangePriority
  
  REQUISITIONS_CHANGE_PRIORITY_NEW_PRIORITY_XPATH = ".//*[text()='New Priority']/../following-sibling::*[1]//select"
  REQUISITIONS_CHANGE_PRIORITY_BTN_UPDATE_PRIORITY_XPATH = ".//*[@title='Update Priority']"
  REQUISITIONS_CHANGE_PRIORITY_BTN_BACK_TO_LIST_XPATH = ".//*[@title='Back to List']"

  #PAGINATION MUST BE ON SECOND PAGE
  REQUISITIONS_CHANGE_PRIORITY_RECORDS_PER_PAGE_XPATH = ".//*[text()[contains(.,'Records per page:')]]//select"
  REQUISITIONS_CHANGE_PRIORITY_FIRST_PAGE_XPATH = ".//*[@class='first']"
  REQUISITIONS_CHANGE_PRIORITY_PREVIOUS_PAGE_XPATH = ".//*[@class='prev']"
  REQUISITIONS_CHANGE_PRIORITY_NEXT_PAGE_XPATH = ".//*[@class='next']"
  REQUISITIONS_CHANGE_PRIORITY_LAST_PAGE_XPATH = ".//*[@class='last']"
  REQUISITIONS_CHANGE_PRIORITY_CURRENT_PAGE_XPATH = ".//span[text()[contains(.,'Page')]]//input"
  REQUISITIONS_CHANGE_PRIORITY_NUMBER_OF_RECORDS_XPATH = ".//*[text()[contains(.,'Records per page')]]"
  NEW_PRIORITY_TEXT = "High"
  
  BACK_TO_LIST_BUTTON_ON_SUCCESS_PAGE_XPATH = ".//*[@title='Back to List']"
  
  ERROR_PRIORITY_MUST_BE_SELECTED = ".//*[@class='message errorM3']"
  
end