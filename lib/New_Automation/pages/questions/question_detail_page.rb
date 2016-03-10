class QuestionDetailPage
  
  QUESTION_DETAIL_QUESTION_NAME_XPATH = ".//*[text()='Question Name']/.."
  QUESTION_DETAIL_QUESTION_SIZE_XPATH = ".//*[text()='Question Size']/.."
  QUESTION_DETAIL_OPTIONAL_XPATH = ".//*[text()='Optional']/.."
  QUESTION_DETAIL_TEXT_XPATH = ".//*[text()='Text']/.."
  QUESTION_DETAIL_NEW_ANSWER_XPATH = ".//*[@title='New Answer']"
  QUESTION_DETAIL_FIRST_ANSWER_LIST_XPATH = ".//*[text()='Answer Name']/../following-sibling::*[1]/th//a"
  QUESTION_DETAIL_SECOND_ANSWER_LIST_XPATH = ".//*[text()='Answer Name']/../following-sibling::*[1]/following-sibling::*[1]/th//a"
  QUESTION_DETAIL_THIRD_ANSWER_LIST_XPATH = ".//*[text()='Answer Name']/../following-sibling::*[1]/following-sibling::*[1]/following-sibling::*[1]/th//a"
  
end