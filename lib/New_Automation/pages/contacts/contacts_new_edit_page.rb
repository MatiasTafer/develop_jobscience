class ContactNewEditPage
  
  #Select Contact Record Type Section
  CONTACT_NEW_RECORD_TYPE_NEW_XPATH = "//*[text()='Record Type of new record']/../following-sibling::*//select"
  CONTACT_NEW_BTN_CONTINUE_XPATH = ".//*[@title='Continue']"
  CONTACT_NEW_BTN_CANCEL_XPATH = ".//*[@title='Cancel']"
  
  #New Contact Section
  CONTACT_NEW_LAST_NAME_INPUT_XPATH = "//*[text()='Last Name']/../..//input"
  
  
  
  CONTACT_NEW_ACCOUNT_NAME_INPUT_XPATH = "//*[text()='Account Name']/../..//span/input"
  CONTACT_NEW_FIELD_LISTS_XPATH = "//*[text()='Account Name']/../../.."
  
  #BUTTONS
  CONTACT_NEW_BTN_SAVE_XPATH = ".//*[@name='save']"
  CONTACT_NEW_BTN_SAVE_AND_NEW_XPATH = ".//*[@name='save_new']"
  
  #HARD CODE DATA
  CONTACT_NEW_DATA_LAST_NAME_TEXT = "Johnson"
  CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT = "JohnJohn"
  CONTACT_NEW_DATA_LAST_NAME_2_TEXT = "Petersen"
  CONTACT_NEW_DATA_ACCOUNT_NAME_2_TEXT = "PeterPeter"
  CONTACT_NEW_DATA_LAST_NAME_OKTANA_TEXT = "Oktana"
end