class SourceNewEdit
  #BUTTONS
  SOURCE_EDIT_BTN_SAVE_XPATH = ".//*[@title='Save']"
  SOURCE_EDIT_BTN_SAVE_NEW_XPATH = ".//*[@title='Save & New']"
  SOURCE_EDIT_BTN_CANCEL_XPATH = ".//*[@title='Cancel']"
  SOURCE_EDIT_BTN_EDIT_XPATH = ".//*[@name='edit']" 
  SOURCE_EDIT_BTN_DELETE_XPATH = ".//*[@value='Delete']" 
  
  #REQUIRED FIELDS
  GENERAL_SOURCE_TYPE_XPATH = "(.//label[contains(text(),'General Source Type')]/ancestor::td[@class='labelCol'])/following-sibling::td[1]/span/select"
  TYPE_SELECT_XPATH = "(.//label[starts-with(text(),'Type')]/ancestor::td[@class='labelCol'])/following-sibling::td[1]/span/select"
  SOURCE_EDIT_SOURCE_NAME_ID = "Name"
  SOURCE_EDIT_SOURCE_NAME_XPATH = ".//*[@id='Name']" 
  #DATE FIELDS
  SOURCE_EDIT_START_DATE = "(.//*[@class='dateInput dateOnlyInput'])[1]/input"
  SOURCE_EDIT_END_DATE = "(.//*[@class='dateInput dateOnlyInput'])[2]/input"
  ACTIVE_CHECKBOX_XPATH = "(.//label[contains(text(),'Active')]/ancestor::td[@class='labelCol'])/following-sibling::td[1]/input"
  
end