class QuestionSetsNewQuestion
  
  #BUTTONS
  QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH = ".//*[@title='Save']"
  QUESTION_SETS_NEW_QUESTION_BTN_CANCEL_XPATH = ".//*[@title='Cancel']"
  
  #FIELDS
  QUESTION_SETS_NEW_QUESTION_NAME_XPATH = "(.//*[@class='requiredInput']/input)[1]"
  QUESTION_SETS_NEW_QUESTION_ORDER_XPATH = "(.//*[@class='requiredInput']/input)[2]"
  QUESTION_SETS_NEW_QUESTION_SIZE_XPATH = ".//*[@class='questionSelect']"
  QUESTION_SETS_NEW_QUESTION_OPTIONAL_XPATH = "(.//*[@type='checkbox'])[1]"
  QUESTION_SETS_NEW_QUESTION_SIZE_SMALL_XPATH = ".//*[@class='questionSelect']/option[2]"
  QUESTION_SETS_NEW_QUESTION_SIZE_RICH_XPATH = ".//*[@class='questionSelect']/option[3]"
  QUESTION_SETS_NEW_QUESTION_TEXT_XPATH = "(.//*[@type='checkbox'])[2]"
  QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH = "(.//textarea)[1]"
  
  #HARD CODE DATA
  QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH = "Another question"
  QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH = 1
  QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH = "About question"
  QUESTION_SETS_NEW_QUESTION_ORDER_2_INT_XPATH = 2
  
end