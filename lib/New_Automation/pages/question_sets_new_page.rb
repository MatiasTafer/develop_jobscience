class QuestionSetsNew
  #BUTTONS
  QUESTION_SETS_NEW_BTN_SAVE_XPATH = ".//*[@name='save']"
  QUESTION_SETS_NEW_BTN_SAVE_AND_NEW_XPATH = ".//*[@name='save_new']"
  QUESTION_SETS_NEW_BTN_CANCEL_XPATH = ".//*[@name='cancel']"
  
  #REQUIRED FIELDS
  QUESTION_SETS_NEW_NAME_ID = "Name"
  
  #NUMBER FIELDS
  QUESTIONS_SETS_NEW_PASSING_SCORE_XPATH = ".//*[@class='detailList']/tbody/tr[2]/td[4]/input"
  
  #ERROR MSG
  ERROR_NAME_QUESTION_SETS_NEW_XPATH = "(.//*[@class='errorMsg'])[1]"
  ERROR_NUMBER_QUESTION_SETS_NEW_XPATH = "(.//*[@class='errorMsg'])[1]"
  
  #ERROR MSG TEXT = 
  ERROR_NAME_QUESTION_SETS_NEW_TEXT = "Error: You must enter a value"
  ERROR_NUMBER_QUESTION_SETS_NEW_TEXT = "Error: Invalid number"
  
  #HARD CODE DATA
  QUESTION_SETS_NAME_TEXT = "Test case TC819"
  QUESTION_SETS_NAME_2_TEXT = "Test Question Set w Questions"
  QUESTION_SETS_PASSING_SCORE_INVALID_TEXT = "abcdef"
  

end