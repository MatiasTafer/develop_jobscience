class RequisitionsChangePriority
  REQUISITIONS_CHANGE_PRIORITY_NEW_PRIORITY_XPATH = ".//*[@class='detailList']//select"
  REQUISITIONS_CHANGE_PRIORITY_BTN_UPDATE_PRIORITY_XPATH = ".//*[@class='pbButton ']//*[@class='btn'][1]"
  REQUISITIONS_CHANGE_PRIORITY_BTN_BACK_TO_LIST_XPATH = ".//*[@class='pbButton ']//*[@class='btn'][2]"

  #PAGINATION MUST BE ON SECOND PAGE
  REQUISITIONS_CHANGE_PRIORITY_RECORDS_PER_PAGE_XPATH = ".//*[@class='bottomNav']//select"
  REQUISITIONS_CHANGE_PRIORITY_FIRST_PAGE_XPATH = ".//*[@class='first']"
  REQUISITIONS_CHANGE_PRIORITY_PREVIOUS_PAGE_XPATH = ".//*[@class='prev']"
  REQUISITIONS_CHANGE_PRIORITY_NEXT_PAGE_XPATH = ".//*[@class='next']"
  REQUISITIONS_CHANGE_PRIORITY_LAST_PAGE_XPATH = ".//*[@class='last']"
  REQUISITIONS_CHANGE_PRIORITY_CURRENT_PAGE_XPATH = ".//*[@class='bottomNav']//input"
  REQUISITIONS_CHANGE_PRIORITY_NUMBER_OF_RECORDS_XPATH = "(.//*[@class='bottomNav']//span)[2]"
  
  
  
  NEW_PRIORITY_TEXT = "High"
  
  BACK_TO_LIST_BUTTON_ON_SUCCESS_PAGE_XPATH = ".//*[@title='Back to List']"
end