class ContactNewEditPage
  
  #Select Contact Record Type Section
  CONTACT_NEW_RECORD_TYPE_NEW_XPATH = ".//*[@id='p3']"
  CONTACT_NEW_BTN_CONTINUE_XPATH = ".//*[@title='Continue']"
  CONTACT_NEW_BTN_CANCEL_XPATH = ".//*[@title='Cancel']"
  
  #New Contact Section
  CONTACT_NEW_LAST_NAME_INPUT_XPATH = ".//*[@id='name_lastcon2']"
  CONTACT_NEW_ACCOUNT_NAME_INPUT_XPATH = ".//*[@id='con4']"
  CONTACT_NEW_FIELD_LISTS_XPATH = "(.//*[@class='detailList'])[2]"
  
  #BUTTONS
  CONTACT_NEW_BTN_SAVE_XPATH = ".//*[@name='save']"
  CONTACT_NEW_BTN_SAVE_AND_NEW_XPATH = ".//*[@name='save_new']"
  
  #HARD CODE DATA
  CONTACT_NEW_DATA_LAST_NAME_TEXT = "Johnson"
  CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT = "JohnJohn"
  CONTACT_NEW_DATA_LAST_NAME_2_TEXT = "Petersen"
  CONTACT_NEW_DATA_ACCOUNT_NAME_2_TEXT = "PeterPeter"
end