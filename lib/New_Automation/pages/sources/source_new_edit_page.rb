class SourceNewEdit
  #BUTTONS
  SOURCE_EDIT_BTN_SAVE_XPATH = ".//*[@id='topButtonRow']/input[1]"
  SOURCE_EDIT_BTN_SAVE_NEW_XPATH = ".//*[@id='topButtonRow']/input[2]"
  SOURCE_EDIT_BTN_CANCEL_XPATH = ".//*[@id='topButtonRow']/input[3]"
  SOURCE_EDIT_BTN_EDIT_XPATH = ".//*[@name='edit']" 
  SOURCE_EDIT_BTN_DELETE_XPATH = ".//*[@value='Delete']" 
  
  #REQUIRED FIELDS
  GENERAL_SOURCE_TYPE_XPATH = ".//*[@id='00No0000008HteW']"
  TYPE_SELECT_XPATH = ".//*[@id='00No0000008Htea']"
  SOURCE_EDIT_SOURCE_NAME_ID = "Name"
  SOURCE_EDIT_SOURCE_NAME_XPATH = ".//*[@id='Name']" 
  #DATE FIELDS
  SOURCE_EDIT_START_DATE = "(.//*[@class='dateInput dateOnlyInput'])[1]/input"
  SOURCE_EDIT_END_DATE = "(.//*[@class='dateInput dateOnlyInput'])[2]/input"
  ACTIVE_CHECKBOX_XPATH = ".//*[@id='00No0000008HteS']"
  
end