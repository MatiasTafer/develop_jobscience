class AccountsNewEditPage
  
  #Select Account Record Type Section
  ACCOUNTS_NEW_RECORD_TYPE_XPATH = ".//*[text()[contains(.,'Record Type of new record')]]/../../..//select"
  ACCOUNTS_NEW_CONTINUE_XPATH = ".//*[@title='Continue']"
  
  ACCOUNTS_NEW_ACCOUNT_NAME_XPATH = ".//*[text()[contains(.,'Account Name')]]/../following-sibling::*[1]//input"
  ACCOUNTS_NEW_BTN_SAVE_XPATH = ".//*[@name='save']"
  ACCOUNTS_NEW_BTN_SAVE_AND_NEW_XPATH = ".//*[@name='save_new']"
  
  #HARD CODE DATA
  ACCOUNT_NEW_DATA_NAME_TEXT = "Test Agency Account"
  
end