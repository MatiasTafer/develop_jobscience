class RequisitionsChangeStatus
  REQUISITIONS_CHANGE_STATUS_NEW_STATUS_XPATH = ".//*[@class='detailList']//select"
  REQUISITIONS_CHANGE_STATUS_BTN_UPDATE_STATUS_XPATH = ".//*[@class='pbButton ']//*[@class='btn'][1]"
  REQUISITIONS_CHANGE_STATUS_BTN_BACK_TO_LIST_XPATH = ".//*[@class='pbButton ']//*[@class='btn'][2]"

  #PAGINATION MUST BE ON SECOND PAGE
  REQUISITIONS_CHANGE_STATUS_RECORDS_PER_PAGE_XPATH = ".//*[@class='bottomNav']//select"
  REQUISITIONS_CHANGE_STATUS_FIRST_PAGE_XPATH = ".//*[@class='first']"
  REQUISITIONS_CHANGE_STATUS_PREVIOUS_PAGE_XPATH = ".//*[@class='prev']"
  REQUISITIONS_CHANGE_STATUS_NEXT_PAGE_XPATH = ".//*[@class='next']"
  REQUISITIONS_CHANGE_STATUS_LAST_PAGE_XPATH = ".//*[@class='last']"
  REQUISITIONS_CHANGE_STATUS_CURRENT_PAGE_XPATH = ".//*[@class='bottomNav']//input"
  REQUISITIONS_CHANGE_STATUS_NUMBER_OF_RECORDS_XPATH = "(.//*[@class='bottomNav']//span)[2]"
  
  
  REQUISITION_NEW_STATUS_TEXT = "Open"
  
  BACK_TO_LIST_BUTTON_SUCCESS_PAGE_XPATH = ".//*[@title='Back to List']"
end