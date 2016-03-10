class QuestionSetsNewQuestion
  
  #BUTTONS
  QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH = ".//*[@title='Save']"
  QUESTION_SETS_NEW_QUESTION_BTN_CANCEL_XPATH = ".//*[@title='Cancel']"
  
#FIELDS
  QUESTION_SETS_NEW_QUESTION_NAME_XPATH = ".//*[text()='Question Name']/../following-sibling::*//input"
  QUESTION_SETS_NEW_QUESTION_ORDER_XPATH = ".//*[text()='Order']/../following-sibling::*//input"
  QUESTION_SETS_NEW_QUESTION_SIZE_XPATH = ".//*[text()='Question Size']/../following-sibling::*//select"
  QUESTION_SETS_NEW_QUESTION_OPTIONAL_XPATH = ".//*[text()='Optional']/../following-sibling::*//input"
  QUESTION_SETS_NEW_QUESTION_SIZE_SMALL_XPATH = ".//*[text()='Question Size']/../following-sibling::*//select//*[contains(.,'Small')]"
  QUESTION_SETS_NEW_QUESTION_SIZE_RICH_XPATH = ".//*[text()='Question Size']/../following-sibling::*//select//*[contains(.,'Rich')]"
  QUESTION_SETS_NEW_QUESTION_TEXT_XPATH = ".//*[text()='Text']/../following-sibling::*//input"
  QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH = ".//*[text()[contains(.,'Question')]]/../following-sibling::*[1]/span/textarea"
  
  #HARD CODE DATA
  QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH = "Another question"
  QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH = 1
  QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH = "About question"
  QUESTION_SETS_NEW_QUESTION_ORDER_2_INT_XPATH = 2
  
end