class JobBoardHomePage

  
  REGISTER_LINK_XPATH = ".//*[@id='js-menu-register']/a"
  # REGISTER
  EMAIL_ADRESS_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:email']"
  FIRST_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:firstName']"
  LAST_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:lastName']"
  CONTINUE_BUTTON_XPATH = ".//*[@value='Continue']"
  UPLOAD_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:0']"
  PASTE_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:1']"
  BUILDER_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:2']"
  JOB_BOARD_DEPARTMENT_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id40:1:searchCtrl']"
  
  SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:candidateSource']"

  JOB_BOARD_LOGIN_LINK_XPATH = ".//*[@id='js-menu-login']/a"
  JOB_BOARD_REGISTER_LINK_XPATH = ".//*[@id='js-menu-register']/a"
  JOB_BOARD_LOGOUT_LINK_XPATH = ".//*[@id='js-menu-logout']/a"
  JOB_BOARD_FIRST_ELEMENT_LIST_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:0:j_id82:0:j_id83']/a"
  JOB_BOARD_SECOND_ELEMENT_LIST_XPATH = "(.//*[@class='atsSearchResultsData']//a)[2]"
  JOB_BOARD_THIRD_ELEMENT_LIST_XPATH = "(.//*[@class='atsSearchResultsData']//a)[3]"
  JOB_BOARD_RETURN_TO_SEARCH_XPATH = ".//*[@id='js-menu-search']/a"
  JOB_BOARD_JOB_LIST_XPATH = ".//*[@class='atsSearchResultsData ']"
  JOB_BOARD_SEARCH_BY_KEYWORD_XPATH = ".//*[@name='j_id0:j_id1:atsForm:j_id51']"
  JOB_BOARD_SEARCH_BUTTON_XPATH = ".//*[@value='Search']"
  JOB_BOARD_SEARCH_RESULTS_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:0:j_id82:0:j_id83']/a"
  JOB_BOARD_LOCATION_LABEL_XPATH = "//*[text()[contains(.,'Location:')]]"
  JOB_BOARD_CONTACT_LABEL_XPATH = "//*[text()[contains(.,'Contact:')]]"
  
end