require 'securerandom'

class JobBoardHomePage

  REGISTER_LINK_XPATH = ".//*[@id='js-menu-register']/a"
  # REGISTER
  EMAIL_ADRESS_TEXT_XPATH = "(.//label[contains(text(),'Email Address')]/ancestor::td[@class='atsFormTdLeft'])/following-sibling::td[1]/div/input"
  FIRST_NAME_TEXT_XPATH = "(.//label[contains(text(),'First Name')]/ancestor::td[@class='atsFormTdLeft'])/following-sibling::td[1]/div/input"
  LAST_NAME_TEXT_XPATH = "(.//label[contains(text(),'Last Name')]/ancestor::td[@class='atsFormTdLeft'])/following-sibling::td[1]/div/input"
  PASSWORD_TEXT_XPATH = "(.//label[not (contains(text(),'Confirm'))][contains(text(),'Password')])/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/input"
  PASSWORD_CONFIRM_XPATH = ".//label[contains(text(),'Confirm')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/input"
  CONTINUE_BUTTON_XPATH = ".//*[@value='Continue']"
  UPLOAD_CHECKBOX_XPATH = ".//*[@value='Upload']"
  PASTE_CHECKBOX_XPATH = ".//*[@value='Paste']"
  BUILDER_CHECKBOX_XPATH = ".//*[@value='Builder']"
  JOB_BOARD_DEPARTMENT_SELECT_XPATH = "(.//label[contains(text(),'Department:')])/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/select"
  BROWSE_BUTTON_XPATH = ".//*[@class='atsFormTdTwoColumnLeft']/input"
  ATTACH_ADDITIONAL_DOC_XPATH = ".//*[@type='file']"
  
  JOB_BOARD_LOGIN_LINK_XPATH = ".//*[@id='js-menu-login']/a"
  JOB_BOARD_REGISTER_LINK_XPATH = ".//*[@id='js-menu-register']/a"
  JOB_BOARD_LOGOUT_LINK_XPATH = ".//*[@id='js-menu-logout']/a"
  JOB_BOARD_FIRST_ELEMENT_LIST_XPATH = ".//*[contains(@class,'atsSearchResultsData')]/a"
  JOB_BOARD_SECOND_ELEMENT_LIST_XPATH = "(.//*[contains(@class,'atsSearchResultsData')]/a)[2]"
  JOB_BOARD_THIRD_ELEMENT_LIST_XPATH = "(.//*[contains(@class,'atsSearchResultsData')]/a)[3]"
  JOB_BOARD_FOURTH_ELEMENT_LIST_XPATH = "(.//*[contains(@class,'atsSearchResultsData')]/a)[4]"
  JOB_BOARD_FIVE_ELEMENT_LIST_XPATH = "(.//*[contains(@class,'atsSearchResultsData')]/a)[5]"
  JOB_BOARD_SIXTH_LIST_XPATH = "(.//*[contains(@class,'atsSearchResultsData')]/a)[6]"
  JOB_BOARD_X_ELEMENT_LIST_XPATH = ".//*[contains(@class,'atsSearchResultsData')]/a"
  JOB_BOARD_RETURN_TO_SEARCH_XPATH = ".//*[@id='js-menu-search']/a"
  JOB_BOARD_YOUR_JOB_APPLICATION_XPATH = ".//*[@id='js-menu-apps']/a"
  JOB_BOARD_JOB_LIST_XPATH = ".//*[@class='atsSearchResultsData ']"
  JOB_BOARD_JOB_LIST_XPATH2 = ".//*[text()='Job Title']/ancestor::thead/following-sibling::*"
  JOB_BOARD_SEARCH_BY_KEYWORD_XPATH = ".//label[contains(text(),'Search by Keyword:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/input[1]"
  JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH = ".//label[contains(text(),'Search by Keyword:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/input[2]"
  JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH = ".//label[contains(text(),'Search by Keyword:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/input[3]"
  JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH = ".//label[contains(text(),'Search by Keyword:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/select[1]"
  JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH = ".//label[contains(text(),'Search by Keyword:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/select[2]"
  JOB_BOARD_SEARCH_BUTTON_XPATH = ".//*[@value='Search']"
  JOB_BOARD_SEARCH_RESULTS_XPATH = ".//*[contains(@class,'atsSearchResultsData')]/a"
  JOB_BOARD_CONTACT_LABEL_XPATH = "//*[text()[contains(.,'Contact:')]]"
  JOB_BOARD_SEARCH_FIRST_KEYWORD_XPATH = ".//label[contains(text(),'Search by Keyword:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/input[1]"
  
  JOB_BOARD_LOCATION_SELECT_XPATH = ".//label[contains(text(),'Location:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/select"
  JOB_BOARD_LOCATION_LABEL_XPATH = ".//label[contains(text(),'Location:')]"
  JOB_BOARD_FACILITY_SELECT_XPATH = ".//label[contains(text(),'Facility:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/select"
  JOB_BOARD_JOB_TITLE_LABEL_XPATH = ".//*[contains(text(),'Job Title')]"
  JOB_BOARD_EMPLOYMENT_TYPE_SELECT_XPATH = ".//label[contains(text(),'Employment Type:')]/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/select"
  JOB_BOARD_BUSINESS_UNIT_SELECT_XPATH = "(.//label[contains(text(),'Business Unit:')])/ancestor::td[@class='atsSearchTdLeft']/following-sibling::td[1]/select"
  JOB_BOARD_UPDATING_INFO_XPATH = ".//*[@id='js-menu-updateinfo']/a"
  JOB_BOARD_UPDATE_YOUR_RESUME_XPATH = ".//*[@id='js-menu-resume']/a"
  # PAGINATION
  JOB_BOARD_PAGE2_XPATH = ".//a[@class='ats_pagination-btn'][contains(.,'2')]"
  JOB_BOARD_PAGE1_XPATH = ".//a[@class='ats_pagination-btn_active']"
  JOB_BOARD_NEXT_BUTTON_XPATH = ".//a[contains(.,'Next>')]"
  JOB_BOARD_PREVIOUS_BUTTON_XPATH = ".//a[contains(.,'<Previous')]"
  JOB_BOARD_FIRST_BUTTON_XPATH = ".//a[contains(.,'<<First')]"
  JOB_BOARD_LAST_BUTTON_XPATH = ".//a[contains(.,'Last>')]"
  JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH = ".//*[@id='atsApplicationSubmittedMain']"
  JOB_BOARD_UPLOAD_RESUME_SUCCESS_TEXT = "Your resume was successfully added / updated."
  JOB_BOARD_UPLOAD_RESUME_ERROR_TYPE_XPATH = ".//*[@class='atsError'][contains(.,'Wrong file type')]"
  JOB_BOARD_UPLOAD_RESUME_ERROR_TYPE_TEXT = "Wrong file type. The following file types are allowed: pdf"
  JOB_BOARD_UPLOAD_RESUME_BROWSE_TEXT_XPATH = ".//*[@class='atsFormTdTwoColumnLeft']/input"
  JOB_BOARD_UPLOAD_RESUME_ALL_TYPES_TEXT = "docx, doc, pdf, rtf, html, txt"
  
end