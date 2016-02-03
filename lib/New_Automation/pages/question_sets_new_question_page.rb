class QuestionSetsNewQuestion
  #BUTTONS
  QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH = "(.//*[@class='btn'])[1]"
  QUESTION_SETS_NEW_QUESTION_BTN_CANCEL_XPATH = "(.//*[@class='btn'])[2]"
  
  #FIELDS
  QUESTION_SETS_NEW_QUESTION_NAME_XPATH = "(.//*[@class='requiredInput']/input)[1]"
  QUESTION_SETS_NEW_QUESTION_ORDER_XPATH = "(.//*[@class='requiredInput']/input)[2]"
  QUESTION_SETS_NEW_QUESTION_SIZE_XPATH = "(.//*[@class='data2Col'])[2]/select"
  QUESTION_SETS_NEW_QUESTION_OPTIONAL_XPATH = "(.//*[@class='data2Col'])[3]/input"
  QUESTION_SETS_NEW_QUESTION_TEXT_XPATH = "(.//*[@type='checkbox'])[2]"
  QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH = "(.//textarea)[1]"
end