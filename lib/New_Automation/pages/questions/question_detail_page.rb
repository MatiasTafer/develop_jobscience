class QuestionDetailPage
  
  QUESTION_DETAIL_QUESTION_NAME_XPATH = "(.//*[@class='detailList'])[1]//tr[1]"
  QUESTION_DETAIL_QUESTION_SIZE_XPATH = "(.//*[@class='detailList'])[1]//tr[3]"
  QUESTION_DETAIL_OPTIONAL_XPATH = "(.//*[@class='detailList'])[1]//tr[4]"
  QUESTION_DETAIL_TEXT_XPATH = "(.//*[@class='detailList'])[1]//tr[5]"
  QUESTION_DETAIL_NEW_ANSWER_XPATH = "(.//*[@class='pbButton'])[1]/input"
  QUESTION_DETAIL_FIRST_ANSWER_LIST_XPATH = "((.//*[@class='list'])[1]//tr[2]//a)[3]"
  QUESTION_DETAIL_SECOND_ANSWER_LIST_XPATH = "((.//*[@class='list'])[1]//tr[3]//a)[3]"
  QUESTION_DETAIL_THIRD_ANSWER_LIST_XPATH = "((.//*[@class='list'])[1]//tr[4]//a)[3]"
end