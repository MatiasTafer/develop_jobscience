class HomePage
  
  
  #TAB LINKS URL
<<<<<<< HEAD
  HOME_TAB_LINK_URL = ".//*[@href='/home/home.jsp']"
  SHORT_LIST_TAB_LINK_URL = "https://na17.salesforce.com/a0r/o"
  POWER_SEARCH_TAB_LINK_URL = "https://ts2.na17.visual.force.com/apex/JobscienceSearch?sfdc.tabName=01ro0000000WeBj"
  REQUISITION_TAB_LINK_URL = "https://na17.salesforce.com/a0K"
  PRESENTATION_TAB_LINK_URL = "https://na17.salesforce.com/a1v/o"
  CONTACT_TAB_LINK_URL = "https://na17.salesforce.com/003/o"
  AMS_SETUP_TAB_LINK_URL = "https://ts2extams.na17.visual.force.com/apex/AMSSetup?sfdc.tabName=01ro0000000hRdi"
  BOARD_SETUP_TAB_LINK_URL = "https://na17.salesforce.com/a0G/o"
  ADVANCED_CONTACT_SEARCH_SIDEBAR_LINK_URL = "https://ts2.na17.visual.force.com/apex/SSearch"
  OFFERS_TAB_LINK_URL = "https://na17.salesforce.com/a0N/o"
  APPLICATIONS_TAB_LINK_URL = "https://ts2extams.na17.visual.force.com/apex/Application_Custom_List?save_new=1&sfdc.override=1"
  CONTACTS_TAB_LINK_URL = "https://na17.salesforce.com/003/o"
  INTERVIEW_TAB_LINK_URL = "https://ts2extams.na17.visual.force.com/apex/Interview_Custom_List?save_new=1&sfdc.override=1"
  PLACEMENT_TAB_LINK_URL = "https://na17.salesforce.com/a0Q/o"
  ADVANCED_CONTACT_SEARCH_SIDEBAR_LINK_XPATH = ".//*[@class='sidebarModuleBody']//*[@class='searchFooter']/a"
  PROJECTS_TAB_LINK_URL = "https://na17.salesforce.com/a0S/o"
  QUESTION_SETS_LINK_URL = "https://na17.salesforce.com/a0T/o"
  REQUISITIONS_LINK_URL = "https://na17.salesforce.com/a0K/o"
  SOURCE_LINK_URL = "https://na17.salesforce.com/a0e/o"
  JOB_TEMPLATES_TAB_LINK_URL = "https://na17.salesforce.com/a0B/o"
  STANDARD_QUESTIONS_TAB_LINK = "https://na17.salesforce.com/a0f/o"
  JOB_TEMPLATE_MAPPING_TAB_LINK = "https://na17.salesforce.com/a0J/o"
  SUBMITTALS_TAB_LINK_XPATH = "https://ts2extams.na17.visual.force.com/apex/Submittal_Custom_List?save_new=1&sfdc.override=1"
  CHATTER_TAB_URL = "https://na17.salesforce.com/_ui/core/chatter/ui/ChatterPage"
  
  LOGIN_URL = "https://login.salesforce.com/"

  ALL_CONTACTS_TAB_LINK = "https://na17.salesforce.com/003?fcf=00Bo0000003aqv0"
  
  ACCOUNTS_TAB_LINK_URL = "https://na17.salesforce.com/001/o"
=======
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
  JOB_TEMPLATE_MAPPING_TAB_XPATH = ".//a[text()[contains(.,'Job Templates Mapping')]]"
  SUBMITTALS_TAB_LINK_XPATH = ".//a[text()[contains(.,'Submittals')]]"
  CHATTER_TAB_XPATH = ".//a[text()[contains(.,'Chatter')]]"
  ACCOUNTS_TAB_LINK_XPATH = ".//a[text()[contains(.,'Accounts')]]"
  
  MENU_USER_XPATH = ".//*[@id='userNavLabel']"
  MENU_USER_SETUP_OPTION_XPATH = ".//*[@id='userNav-menuItems']/a[text()='Setup']"
  DEVELOP_XPATH = ".//a[text()='Develop']"
  CUSTOM_SETTINGS_XPATH = ".//*[@id='CustomSettings_font']"
>>>>>>> develop
  
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