class SearchResultsPage
  
  SEARCH_RESULTS_BAR_SKILLS_XPATH = ".//*[text()='Skills']/.."
  SEARCH_RESULTS_BAR_EDU_HISTORY_XPATH = ".//*[@data_title='Education History']"
  SEARCH_RESULTS_BAR_EMP_HISTORY_XPATH = ".//*[@data_title='Employment History']"
  SEARCH_RESULTS_RESULT_LIST_XPATH = ".//*[@class='list']"
  SEARCH_RESULT_ADD_TO_LIST_XPATH = ".//*[@title='Add to List']"
  SEARCH_RESULT_APPLY_TO_JOB_XPATH = ".//*[@title='Apply To Jobs']"
  SEARCH_RESULT_ADD_SKILLS_XPATH = ".//*[@title='Add Skills']"
  SEARCH_RESULT_RESULT_LIST_FIRST_ELEM_XPATH = ".//th[text()[contains(.,'Action')]]/../following-sibling::*[1]"
  SEARCH_RESULT_RESULT_LIST_FIRST_CHECKBOX_XPATH = ".//th[text()[contains(.,'Action')]]/../following-sibling::*[1]//input"
  
  #HARD CODE DATA
  SEARCH_DATA_SKILL_ARCH_TEXT = "Architecture"
  
end