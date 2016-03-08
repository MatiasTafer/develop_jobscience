class QuestionSetsQuestionBuilder
  #BUTTONS
  QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH = ".//*[@title='New Question']"
  QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_ORDER_XPATH = ".//*[@title='Save New Order']" 
  
  #NEW QUESTION FIELDS
  QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH = "(.//*[@class='LabelCol']//tbody/tr[1]/td)[2]//input"
  QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH = "(.//*[@class='LabelCol']//tbody/tr[1]/td)[4]//input"
  QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH = "(.//*[@class='LabelCol']//tbody/tr[2]/td)[2]//iframe"
  QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH = "(.//*[@class='LabelCol']//tbody/tr[2]/td)[5]//input"
  QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH = "((.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//tbody/tr/td[1]//input)[1]"
  QUESTION_SETS_QUESTION_BUILDER_ANSWER_2_XPATH = "((.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//tbody/tr/td[1]//input)[2]"
  QUESTION_SETS_QUESTION_BUILDER_SCORE_XPATH = "(.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//tbody/tr/td[2]//input"
  QUESTION_SETS_QUESTION_BUILDER_ORDER_XPATH = "(.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//tbody/tr/td[3]//input"
  #NEW QUESTIONS BUTTONS
  QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_ADD_XPATH = "((.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//span)[2]/input[1]"
  QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH = "((.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//span)[2]/input[2]"
  QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_NEW_XPATH = "((.//*[@class='LabelCol']//tbody/tr[3]/td)[3]//span)[2]/input[3]"
  
  #QUESTIONS CREATED
  QUESTION_SETS_QUESTION_1_XPATH = ".//*[@id='QALIST']/li[1]/label[1]"
  QUESTION_SETS_QUESTION_2_XPATH = ".//*[@id='QALIST']/li[2]/label[1]"
  QUESTION_SETS_QUESTION_1_NAME_LABEL_XPATH = "(.//*[@title='Click and Drag to change the order of the questions. Click Save New Order button'])[1]//label"
  QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH = ".//*[@class='ui-sortable']/li[1]"
  QUESTION_SETS_QUESTIONS_LIST_SECOND_XPATH = ".//*[@class='ui-sortable']/li[2]"
  QUESTION_SETS_QUESTIONS_LIST_THIRD_XPATH = ".//*[@id='QALIST']/li[3]"
  QUESTION_SETS_QUESTIONS_LIST_FOURTH_XPATH = ".//*[@id='QALIST']/li[4]"
  QUESTION_SETS_QUESTIONS_LIST_FOURTH_v2_XPATH = "(.//*[@style='font-weight:bold;padding-left:20px;padding-top:5px;cursor:pointer;'])[4]"
  
  #HARD CORE DATA
  QUESTION_SETS_QUESTION_NAME_TEXT = "Work"
  QUESTION_SETS_QUESTION_TEXT = "Do you like to work?"
  QUESTION_SETS_QUESTION_ANSWER_1_TEXT = "YES"
  
  QUESTION_SETS_QUESTION_NAME_2_TEXT = "Icecream"
  QUESTION_SETS_QUESTION_2_TEXT = "Do you like icecream?"
  QUESTION_SETS_QUESTION_ANSWER_2_TEXT = "YES"
  
  QUESTION_SETS_QUESTION_NAME_3_TEXT = "Text Question"
  QUESTION_SETS_QUESTION_3_TEXT = "Do you like text questions?"
  QUESTION_SETS_QUESTION_ANSWER_3_TEXT = "YES"
  
  QUESTION_SETS_QUESTION_NAME_4_TEXT = "Both"
  QUESTION_SETS_QUESTION_4_TEXT = "Do you like text and optional questions?"
  QUESTION_SETS_QUESTION_ANSWER_4_TEXT = "YES"
  
end