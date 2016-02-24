require 'securerandom'

class JobBoardHomePage

  
  REGISTER_LINK_XPATH = ".//*[@id='js-menu-register']/a"
  # REGISTER
  EMAIL_ADRESS_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:email']"
  FIRST_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:firstName']"
  LAST_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:lastName']"
  PASSWORD_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:password']"
  PASSWORD_CONFIRM_XPATH = ".//*[@id='j_id0:j_id1:atsForm:confirmPassword']"
  CONTINUE_BUTTON_XPATH = ".//*[@value='Continue']"
  UPLOAD_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:0']"
  PASTE_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:1']"
  BUILDER_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:2']"
  JOB_BOARD_DEPARTMENT_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id40:1:searchCtrl']"
  BROWSE_BUTTON_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeFile']"
  ATTACH_ADDITIONAL_DOC_XPATH = ".//*[@id='j_id0:j_id1:file_upload:j_id70']"
  
  SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:candidateSource']"

  JOB_BOARD_LOGIN_LINK_XPATH = ".//*[@id='js-menu-login']/a"
  JOB_BOARD_REGISTER_LINK_XPATH = ".//*[@id='js-menu-register']/a"
  JOB_BOARD_LOGOUT_LINK_XPATH = ".//*[@id='js-menu-logout']/a"
  JOB_BOARD_FIRST_ELEMENT_LIST_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:0:j_id82:0:j_id83']/a"
  JOB_BOARD_SECOND_ELEMENT_LIST_XPATH = "(.//*[@class='atsSearchResultsData']//a)[2]"
  JOB_BOARD_THIRD_ELEMENT_LIST_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:2:j_id82:0:j_id83']/a"
  JOB_BOARD_FOURTH_ELEMENT_LIST_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:3:j_id82:0:j_id83']/a"
  JOB_BOARD_FIVE_ELEMENT_LIST_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:4:j_id82:0:j_id83']/a"
  JOB_BOARD_X_ELEMENT_LIST_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:tb']/child::tr/child::td/child::a"
  JOB_BOARD_SIXTH_LIST_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:5:j_id82:0:j_id83']/a"
  JOB_BOARD_RETURN_TO_SEARCH_XPATH = ".//*[@id='js-menu-search']/a"
  JOB_BOARD_YOUR_JOB_APPLICATION_XPATH = ".//*[@id='js-menu-apps']/a"
  JOB_BOARD_JOB_LIST_XPATH = ".//*[@class='atsSearchResultsData ']"
  JOB_BOARD_SEARCH_BY_KEYWORD_XPATH = ".//*[@name='j_id0:j_id1:atsForm:j_id51']"
  JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH = ".//*[@id='atsSearchBox']/table/tbody/tr[6]/td[2]/input[2]"
  JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH = ".//*[@id='atsSearchBox']/table/tbody/tr[6]/td[2]/input[3]"
  JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:logicalOperator1']"
  JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:logicalOperator2']"
  JOB_BOARD_SEARCH_BUTTON_XPATH = ".//*[@value='Search']"
  JOB_BOARD_SEARCH_RESULTS_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:0:j_id82:0:j_id83']/a"
  JOB_BOARD_LOCATION_LABEL_XPATH = "//*[text()[contains(.,'Location:')]]"
  JOB_BOARD_CONTACT_LABEL_XPATH = "//*[text()[contains(.,'Contact:')]]"
  
  
  JOB_BOARD_URL = "http://js-recruiting-148857d918a-14910044900.force.com/openings"
  
  
  
  
  JOB_BOARD_DEPARTMENT_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id40:0:searchCtrl']"
  JOB_BOARD_LOCATION_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id40:1:searchCtrl']"
  JOB_BOARD_LOCATION_LABEL_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:j_id82:3:j_id86']"
  JOB_BOARD_FACILITY_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id40:2:searchCtrl']"
  JOB_BOARD_JOB_TITLE_LABEL_XPATH = ".//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:j_id82:0:j_id86']"
  JOB_BOARD_EMPLOYMENT_TYPE_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id40:3:searchCtrl']"
  JOB_BOARD_BUSINESS_UNIT_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id40:4:searchCtrl']"
  JOB_BOARD_UPDATING_INFO_XPATH = ".//*[@id='js-menu-updateinfo']/a"
  JOB_BOARD_UPDATE_YOUR_RESUME_XPATH = ".//*[@id='js-menu-resume']/a"
  # PAGINATION
  JOB_BOARD_PAGE2_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id114']"
  JOB_BOARD_PAGE1_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id112']"
  JOB_BOARD_NEXT_BUTTON_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id124']"
  JOB_BOARD_PREVIOUS_BUTTON_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id107']"
  JOB_BOARD_FIRST_BUTTON_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id102']"
  JOB_BOARD_LAST_BUTTON_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id129']"
end