class ShortListHomePage
  
  SHORT_LIST_RECORDS_LIST_XPATH = ".//*[@class='list']"
  SHORT_LIST_RECORD_XPATH = ".//*[text()='Name']/../following-sibling::*[1]//a"
  SHORT_LIST_RECORD_XPATH_2 = ".//*[text()='Name']/../following-sibling::*[19]//a"
  NEW_SHORT_LIST_BUTTON_XPATH = ".//*[@title='New']"
  FIRST_RECORD_CHECKBOX_XPATH = "(.//*[text()='Del'])[1]/../../../..//input"

  SHORT_LIST_HOME_BTN_NEW_XPATH = ".//*[@name='new']"
  SHORT_LIST_HOME_BTN_GO_XPATH = ".//*[@name='go']"
  SHORT_LIST_HOME_VIEW_SELECT_XPATH = ".//*[@id='fcf']"
  
end