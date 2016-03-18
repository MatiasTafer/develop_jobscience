class AddToShortList
  
  SHORT_LIST_TEXTBOX_XPATH = ".//label[text()[contains(.,'Short List')]]/../following-sibling::*[1]//span/input"
  ADD_TO_SHORT_LIST_BUTTON_XPATH = ".//*[@title='Add to Short List']"
  CLOSE_BUTTON_XPATH = ".//*[@title='Close']"
  CANCEL_BUTTON_XPATH = ".//*[@title='Cancel']"
  ERROR_MESSAGE_XPATH = ".//*[@class='message errorM3']"
  TOTAL_NUMBER_ADDED_LIST_XPATH = ".//*[text()='Total Contacts Added']/../following-sibling::*/span"
  
  SHORTLIST_TEXT = "joblabstest"
  
end