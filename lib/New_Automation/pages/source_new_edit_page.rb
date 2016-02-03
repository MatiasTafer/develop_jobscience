class SourceNewEdit
  #BUTTONS
  SOURCE_EDIT_BTN_SAVE_XPATH = ".//*[@id='topButtonRow']/input[1]"
  SOURCE_EDIT_BTN_SAVE_NEW_XPATH = ".//*[@id='topButtonRow']/input[2]"
  SOURCE_EDIT_BTN_CANCEL_XPATH = ".//*[@id='topButtonRow']/input[3]"
  
  #REQUIRED FIELDS
  SOURCE_EDIT_SOURCE_NAME_ID = "Name" 
  #DATE FIELDS
  SOURCE_EDIT_START_DATE = "(.//*[@class='dateInput dateOnlyInput'])[1]/input"
  SOURCE_EDIT_END_DATE = "(.//*[@class='dateInput dateOnlyInput'])[2]/input"
end