class QuestionSetsQuestionBuilder
  #BUTTONS
  QUENSTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH = "(.//*[@id='QApage:Qq:theGrid']//span)[1]/input[1]" 
  
  #NEW QUESTION FIELDS
  QUENSTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH = "(.//*[@class='LabelCol']//tbody/tr[1]/td)[2]//input"
  QUENSTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH = "(.//*[@class='LabelCol']//tbody/tr[1]/td)[4]//input"
  QUENSTION_SETS_QUESTION_BUILDER_QUESTION_XPATH = "(.//*[@class='LabelCol']//tbody/tr[2]/td)[2]//textarea"
  QUENSTION_SETS_QUESTION_BUILDER_TEXT_XPATH = "(.//*[@class='LabelCol']//tbody/tr[2]/td)[5]//input"
  QUENSTION_SETS_QUESTION_BUILDER_ANSWER_XPATH = "(.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//tbody/tr/td[1]//input"
  QUENSTION_SETS_QUESTION_BUILDER_SCORE_XPATH = "(.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//tbody/tr/td[2]//input"
  QUENSTION_SETS_QUESTION_BUILDER_ORDER_XPATH = "(.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//tbody/tr/td[3]//input"
  #NEW QUESTIONS BUTTONS
  QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_ADD_XPATH = "((.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//span)[2]/input[1]"
  QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH = "((.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//span)[2]/input[2]"
  QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_NEW_XPATH = "((.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//span)[2]/input[3]"
end