class QuestionSetsDetail
  
  QUESTION_SETS_DETAIL_COPY_QUESTION_SET_XPATH = ".//*[@value='Copy Question Set']"
  QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH = ".//*[@title='Question Builder']"
  QUESTION_SETS_DETAIL_DELETE_XPATH = ".//*[@name='del']"
  QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH = ".//*[@title='New Question']"
  QUESTION_SETS_DETAIL_NAME_XPATH = ".//*[text()='Question Set Name']/following-sibling::*[1]/div"
  QUESTION_SETS_DETAIL_QUESTION_FIRST_XPATH = ".//*[text()='Question Name']/../following-sibling::*[1]//th/a"
  
  QUESTION_SET_DETAIL_PRESCREENS_FIRST_XPATH = ".//*[text()='Prescreen Name']/../following-sibling::*[1]"
  QUESTION_SET_DETAIL_PRESCREENS_SECOND_XPATH = ".//*[text()='Prescreen Name']/../following-sibling::*[1]/following-sibling::*[1]"
  QUESTION_SET_DETAIL_PRESCREENS_THIRD_XPATH = ".//*[text()='Prescreen Name']/../following-sibling::*[1]/following-sibling::*[1]/following-sibling::*[1]"
  QUESTION_SET_DETAIL_PRESCREENS_FOURTH_XPATH = ".//*[text()='Prescreen Name']/../following-sibling::*[1]/following-sibling::*[1]/following-sibling::*[1]/following-sibling::*[1]"
  QUESTION_SET_DETAIL_PRESCREENS_FIRST_APPLICATION_XPATH = ".//*[text()='Prescreen Name']/../following-sibling::*[1]//*[contains(.,'APP')]//a"
  
end