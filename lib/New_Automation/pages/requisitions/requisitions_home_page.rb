class RequisitionsHomePage

  
  REQUISITIONS_PAGE_BTN_NEW_XPATH = ".//*[@name='new']"
  REQUISITIONS_PAGE_BTN_TRANSFER_JOBS_XPATH = ".//*[@title='Transfer Jobs']"
  REQUISITIONS_PAGE_BTN_CHANGE_PRIORITY_JOBS_XPATH = ".//*[@title='Change Priority']"
  REQUISITIONS_PAGE_BTN_CHANGE_STATUS_JOBS_XPATH = ".//*[@title='Change Status']"
  
  REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH = "((.//*[text()='Del'])[1]/ancestor::td[1]/following-sibling::*//a)[2]"
  REQUISITIONS_PAGE_FIRST_ENTRY_LIST_PRIMARY_RECRUITER_TEXT_XPATH = "((.//*[text()='Del'])[1]/ancestor::td[1]/following-sibling::*//a)[3]"
  REQUISITIONS_PAGE_FIRST_ENTRY_LIST_STATUS_TEXT_XPATH = "((.//*[text()='Del'])[1]/ancestor::td[1]/following-sibling::*//div)[4]"
  REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH = "((.//*[text()='Del'])[1]/ancestor::td[1]/preceding-sibling::*)//input"
  REQUISITIONS_PAGE_FIRST_SELECT_ALL_BOX_ID = "allBox"

  REQUISITIONS_PAGE_FIRST_ENTRY_LIST_EDIT_XPATH = ".//span[text()='Edit']/ancestor::a[1]"

  REQUISITIONS_PAGE_LIST_XPATH = ".//*[@class='listBody']"

  #Record Type Page
  NEW_RECORD_TYPE_DROPDOWN_XPATH = ".//*[text()='Record Type of new record']/../following-sibling::*//select"
  RECORD_TYPE_REQUISITION_TEXT = "Corporate"
  CONTINUE_BUTTON_XPATH = ".//*[@value='Continue']"
  
end