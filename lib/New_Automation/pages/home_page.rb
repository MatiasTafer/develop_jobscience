class HomePage
  
  
  #TAB LINKS URL
  ALL_TABS_LINK_XPATH = ".//*[@id='AllTab_Tab']"
  HOME_TAB_ID = "home_Tab"
  
  JOB_TEMPLATES_TAB_XPATH = ".//*[text()='Job Templates']"
  JOB_TEMPLATE_MAPPING_TAB_XPATH = ".//*[text()='Job Templates Mapping']"
  
  HOME_TAB_LINK_XPATH = ".//a[text()[contains(.,'Home')]]"
  SHORT_LIST_TAB_LINK_XPATH = ".//a[text()[contains(.,'Short Lists')]]"
  POWER_SEARCH_TAB_LINK_XPATH = ".//a[text()[contains(.,'PowerSearch')]]"
  REQUISITION_TAB_LINK_XPATH = ".//a[text()[contains(.,'Requisitions')]]"
  PRESENTATION_TAB_LINK_XPATH = ".//a[text()[contains(.,'Presentations')]]"
  CONTACT_TAB_LINK_XPATH = ".//a[text()[contains(.,'Contacts')]]"
  AMS_SETUP_TAB_LINK_XPATH = ".//a[text()[contains(.,'AMS Setup')]]"
  BOARD_SETUP_TAB_LINK_XPATH = ".//a[text()[contains(.,'Board Setup')]]"
  OFFERS_TAB_LINK_XPATH = ".//a[text()[contains(.,'Offers')]]"
  APPLICATIONS_TAB_LINK_XPATH = ".//a[text()[contains(.,'Applications')]]"
  CONTACTS_TAB_LINK_XPATH = ".//a[text()[contains(.,'Contacts')]]"
  INTERVIEW_TAB_LINK_XPATH = ".//a[text()[contains(.,'Interviews')]]"
  PLACEMENT_TAB_LINK_XPATH = ".//a[text()[contains(.,'Placements')]]"
  PROJECTS_TAB_LINK_XPATH = ".//a[text()[contains(.,'Projects')]]"
  QUESTION_SETS_LINK_XPATH = ".//a[text()[contains(.,'Question Sets')]]"
  REQUISITIONS_LINK_XPATH = ".//a[text()[contains(.,'Requisitions')]]"
  SOURCE_LINK_XPATH = ".//a[text()[contains(.,'Sources')]]"
  JOB_TEMPLATES_TAB_LINK_XPATH = ".//a[text()[contains(.,'Job Templates')]][not (contains(.,'Mapping'))]"
  STANDARD_QUESTIONS_TAB_XPATH = ".//a[text()[contains(.,'Standard Questions')]]"
  SUBMITTALS_TAB_LINK_XPATH = ".//a[text()[contains(.,'Submittals')]]"
  CHATTER_TAB_XPATH = ".//a[text()[contains(.,'Chatter')]]"
  ACCOUNTS_TAB_LINK_XPATH = ".//a[text()[contains(.,'Accounts')]]"
  
  MENU_USER_XPATH = ".//*[@id='userNavLabel']"
  MENU_USER_SETUP_OPTION_XPATH = ".//*[@id='userNav-menuItems']/a[text()='Setup']"
  DEVELOP_XPATH = ".//a[text()='Develop']"
  CUSTOM_SETTINGS_XPATH = ".//*[@id='CustomSettings_font']"
  
  SEARCH_BAR_XPATH = ".//*[@id='phSearchInput']"
  SEARCH_BUTTON_XPATH = ".//*[@id='phSearchButton']"
  ADD_JOB_ORDERS_XPATH = ".//*[text()[contains(.,'Add Job Orders')]]"
  ADVANCED_CONTACT_SEARCH_SIDEBAR_LINK_XPATH = ".//*[text()[contains(.,'Advanced Contact Search...')]]"
  ADD_RESUMES_XPATH = ".//a[text()[contains(.,'Add Resumes')]]"
  
  #UPLOAD JOB ORDER
  UPLOAD_BTN_BROWSE_XPATH = ".//*[@type='file']"
  UPLOAD_BTN_ADD_JOB_XPATH = ".//*[@value='Add Job']"

  # JOB BOARD URL - this needs to be harcoded because they are custom external sites
  JOB_BOARD_URL = "http://js-recruiting-148857d918a-14910044900.force.com/openings"
  JOB_BOARD_INTERNAL_URL = "http://js-recruiting-148857d918a-14910044900.force.com/internal"
  
  #This will be deleted after we review standard questions and resume suites
  ALL_CONTACTS_TAB_LINK = "https://na17.salesforce.com/003?fcf=00Bo0000003aqv0"
  
  
                        
end