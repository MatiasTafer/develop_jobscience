class JobBoardRegisterPage
  #FIRST STEP
  JOB_BOARD_REGISTER_EMAIL_XPATH = ".//label[contains(text(),'Email Address')]/ancestor::tr/child::td/div/input"
  JOB_BOARD_REGISTER_PASSWORD_XPATH = ".//label[not (contains(text(),'Confirm'))][contains(text(),'Password')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/input"
  JOB_BOARD_REGISTER_CONF_PASSWORD_XPATH = ".//label[contains(text(),'Confirm')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/input"
  JOB_BOARD_REGISTER_FIRST_NAME_XPATH = ".//label[contains(text(),'First Name')]/ancestor::tr/child::td/div/input"
  JOB_BOARD_REGISTER_LAST_NAME_XPATH = ".//label[contains(text(),'Last Name')]/ancestor::tr/child::td/div/input"
  JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH = ".//input[@value='Continue']"
  JOB_BOARD_REGISTER_QUESTION_XPATH = ".//label[contains(text(),'How did you hear about us')]/ancestor::tr/child::td[2]/select"
  PHONE_TEXT_XPATH = ".//label[contains(text(),'Phone')]/ancestor::tr/child::td[2]/select"
  #SECOND STEP
  JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH = ".//input[@value='Continue']"
  JOB_BOARD_REGISTER_PRIVACY_POLICY_TEXT = "This is a privacy policy statement. Thank you!"
  
  #HARD CODED DATA
  EMAIL_ADRESS_TEXT = "email@gmail.com"
  FIRST_NAME_TEXT = "FrstName"
  LAST_NAME_TEXT = "LastName"
  QUESTION_TEXT = "Craigslist"
  
  
end