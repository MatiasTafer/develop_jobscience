class JobBoardRegisterPage
  #FIRST STEP
  JOB_BOARD_REGISTER_EMAIL_XPATH = "(.//*[@class='atsInput'])[1]"
  JOB_BOARD_REGISTER_PASSWORD_XPATH = "(.//*[@class='atsInput'])[2]"
  JOB_BOARD_REGISTER_CONF_PASSWORD_XPATH = "(.//*[@class='atsInput'])[3]"
  JOB_BOARD_REGISTER_FIRST_NAME_XPATH = ".//*[@id='j_id0:j_id1:atsForm:firstName']"
  JOB_BOARD_REGISTER_LAST_NAME_XPATH = ".//*[@id='j_id0:j_id1:atsForm:lastName']"
  JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH = ".//*[@class='atsButton']"
  JOB_BOARD_REGISTER_QUESTION_XPATH = ".//*[@id='j_id0:j_id1:atsForm:candidateSource']"
  #SECOND STEP
  JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH = ".//*[@id='j_id0:j_id1:atsForm']/table/tbody/tr[8]/td/input"
  JOB_BOARD_REGISTER_PRIVACY_POLICY_TEXT = "This is a privacy policy statement. Thank you!"
  
  #HARD CODED DATA
  EMAIL_ADRESS_TEXT = "email@gmail.com"
  FIRST_NAME_TEXT = "FrstName"
  LAST_NAME_TEXT = "LastName"
  QUESTION_TEXT = "Craigslist"
  
  
end