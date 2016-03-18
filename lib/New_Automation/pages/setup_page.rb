class SetupEditPage
  
  # CONFIG
  # setup > develop > custom settings > manage next to config > edit
  
    # Buttons
  CONFIG_SETUP_EDIT_SAVE_BTN_XPATH = ".//*[@value='Save']"
  NEW_CONFIG_BTN_XPATH = ".//*[@value='New']"
  CONFIG_SETUP_EDIT_BTN_XPATH = ".//a[text()='Config']/../preceding-sibling::*//a[text()='Edit']"
    # Fields  
  INVITE_TO_APPLY_CUSTOM_MESSAGE_CHECKBOX_XPATH = ".//*[text()[contains(.,'Invite to Apply Custom Message')]]/../../..//input"
  EEO_QUESTION_HANDLER_TEXT_XPATH = ".//*[text()[contains(.,'EEO Question Handler')]]/../../..//input"
  COMMIT_EEO_DEFAULT_VALUE_CHECKBOX_XPATH = ".//*[text()[contains(.,'Commit EEO Default Value')]]/../../..//input" 
  QUESTION_SET_HANDLER_TEXT_XPATH = ".//*[text()[contains(.,'Question Set Handler')]]/../../..//input"
  DOCUMENT_TYPES_FOR_ATTACHMENTS_XPATH = ".//*[text()[contains(.,'Accepted Document Types for Attachments')]]/../../..//input"
  ENABLE_ENHANCED_APPLY_TO_JOB_XPATH = ".//*[text()[contains(.,'Enable Enhanced Apply to Job')]]/../..//input"
  ALLOW_DUPLICATE_APPS_CHECKBOX_XPATH = ".//*[text()[contains(.,'Allow Duplicate Apps')]]/ancestor::tr[1]/child::td/input"
  ALLOW_DUPLICATE_APPS_DAYS_INPUT_XPATH = ".//*[text()[contains(.,'Allow Duplicate Application Days')]]/../../..//input"
  ENABLE_JCARD_FOR_CONTACT_XPATH = ".//*[text()[contains(.,'Enable JCard for Contact')]]/../../..//input"
  MAX_NUMB_ATTACHEMNT_INPUT_XPATH = ".//*[text()[contains(.,'Max Number of Attachments')]]/../../..//input"
  ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH = ".//*[text()[contains(.,'Attach to Applications')]]/../../..//input"
  AUTO_SHARE_MODE_XPATH = ".//*[text()[contains(.,'Auto Share Mode')]]/../../..//input"
  
  
  #SHORT LIST
    # Buttons
  SAVE_BUTTON_SHORT_LIST_XPATH = ".//*[@value='Save']"
  EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH = ".//*[@value='Edit']"
    # Fields
  CHECKBOX_SPEEDREVIEW_XPATH = ".//*[text()[contains(.,'Enable Speed Review')]]/../../..//input"
  CHECKBOX_WEB_SOURCING_XPATH = ".//*[text()[contains(.,'Enable Web Sourcing')]]/../../..//input"
  CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH =".//*[text()[contains(.,'Enable Jobscience UI')]]/../../..//input"
  ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH = "(.//*[not (contains(text(), 'Edits'))])[text()[contains(.,'Enable Review Email')]]/ancestor::tr[1]/child::td/input"
  REVIEW_MODE_XPATH = ".//*[text()[starts-with(.,'Review Mode')]]/../../..//input"
  ENABLE_EMAIL_SEND_OPTIONS_XPATH = ".//*[text()[contains(.,'Review Email Send Options')]]/../../..//input"
  DEFAULT_STAFFING_REVIEW_XPATH = ".//*[text()[contains(.,'Default Staffing Review')]]/../../..//input"
  
  # BOARD SETUP
  # board setup tab > record link > edit
    # URL
  JOB_BOARD_SETUP_EDIT_PAGE_URL = "https://ts2.na17.visual.force.com/apex/JobBoardSetup?retURL=%2Fa0Go00000080Tcp&scontrolCaching=1&sfdc.override=1&id=a0Go00000080Tcp"
  JOB_BOARD_SETUP_EDIT_PAGE_INTERNAL_XPATH = "https://ts2.na17.visual.force.com/apex/JobBoardSetup?retURL=%2Fa0Go000001Ij584&scontrolCaching=1&sfdc.override=1&id=a0Go000001Ij584"
    # Buttons
  SAVE_BUTTON_XPATH = ".//*[@value='Save']"  
    # Fields
  AUTO_ASSOCIATE_CHECKBOX_XPATH = ".//*[text()[contains(.,'Auto-Associate')]]/../../following-sibling::*//input"
  SHOW_SEARCH_ONLY_CHECKBOX_XPATH = ".//*[text()[contains(.,'Show Search Only')]]/../../following-sibling::*//input"
  ALLOW_REGISTER_ONLY_CHECKBOX_XPATH = ".//*[text()[contains(.,'Allow Register Only')]]/../../following-sibling::td[1]//input"
  RESUME_REQUIRE_CHECKBOX_XPATH = ".//*[text()[contains(.,'Resume Required')]]/../../following-sibling::*//input" 
  HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH = ".//*[text()[contains(.,'Hide Resume Previously Uploaded')]]/../../following-sibling::*//input"
  DISPLAY_PRIVACY_STATEMENT_XPATH = ".//*[text()[contains(.,'Display Privacy Statement')]]/../../following-sibling::*//input"
  
  STANDARD_QUESTION_1_OPTION_1_XPATH = "(.//*[text()[contains(.,'Question 1')]]/../..)[1]//option[1]"
  STANDARD_QUESTION_2_OPTION_1_XPATH = "(.//*[text()[contains(.,'Question 1')]]/../..)[2]//option[1]"
  STANDARD_QUESTION_3_OPTION_1_XPATH = "(.//*[text()[contains(.,'Question 1')]]/../..)[3]//option[1]"
  EEO_QUESTIONS_GENDER_CHECKBOX_XPATH = ".//*[text()[contains(.,'Gender')]]/../following-sibling::*[1]//input"
  EEO_QUESTIONS_VETERAN_CHECKBOX_XPATH = ".//*[text()[contains(.,'Veteran')]]/../following-sibling::*[1]//input"
  EEO_QUESTIONS_RACE_CHECKBOX_XPATH = ".//*[text()[contains(.,'Race')]]/../following-sibling::*[1]//input"
  EEO_QUESTIONS_DISABLE_CHECKBOX_XPATH = ".//*[text()[contains(.,'Disabled')]]/../following-sibling::*[1]//input"
  EEO_QUESTIONS_REQUIRED_CHECKBOX_XPATH = ".//*[text()[contains(.,'EEO Fields Required')]]/../following-sibling::*[1]//input"

  EEO_TEXT_TEXTAREA_IFRAME_XPATH = ".//body"
  HIDE_STANDARD_EEO_DISCLAIMER_CHECKBOX_XPATH = ".//*[text()[contains(.,'Hide Standard EEO Disclaimer')]]/../../following-sibling::*//input"
  PRIVACY_POLICY_TEXTAREA_IFRAME_XPATH = ".//body"

  
  # PARSE SETTINGS EDIT PAGE
    # Buttons
  PARSE_SETTINGS_EDIT_BUTTON_XPATH = ".//*[@value='Edit']"
    # Fields
  RESUME_DAYS_VALID_TEXT_XPATH = ".//*[text()[contains(.,'Resume Days Valid')]]/../following-sibling::*//input"
  ADD_RESUME_DUPE_PREVENTION_XPATH = ".//*[text()[contains(.,'Add Resume Dupe Prevention')]]/../following-sibling::*//input"
  OVERWRITE_ADDRESS_CHECKBOX_XPATH = ".//*[text()[contains(.,'Overwrite Address')]]/../following-sibling::*//input"
  OVERWRITE_EDUCATION_CHECKBOX_XPATH = ".//*[text()[contains(.,'Overwrite Education')]]/../following-sibling::*//input"
  OVERWRITE_EMPLOYMENT_CHECKBOX_XPATH = ".//*[text()[contains(.,'Overwrite Employment')]]/../following-sibling::*//input"
  INLCUDE_SKILLS_CHECKBOX_XPATH = ".//*[text()[contains(.,'Include Skills')]]/../following-sibling::*//input"
  JOB_BOARD_DUPE_PREVENTION_XPATH = ".//*[text()[contains(.,'Job Board Dupe Prevention')]]/../following-sibling::*//input"
  ADD_RESUME_ALLOWED_FILETYPES_XPATH = ".//*[text()[contains(.,'Add Resume Allowed Filetypes')]]/../../following-sibling::*//input"
  JOB_BOARD_ALLOWED_FILETYPES_XPATH = ".//*[text()[contains(.,'Job Board Allowed Filetypes')]]/../../following-sibling::*//input"
  ENFORCE_SHARING_CHECKBOX_XPATH = ".//*[text()[contains(.,'Enforce Sharing')]]/../../following-sibling::*//input"

  # SOCIAL SETTINGS
  # setup > develop > custom settings > manage next to social settings
    # Buttons
  SOCIAL_SETTINGS_EDIT_BUTTON_XPATH = ".//*[@value='Edit']"
    # Fields
  LINKEDIN_SOURCE_TRACKING_XPATH = ".//*[text()[contains(.,'LinkedIn Source Tracking')]]/../following-sibling::*//input"
  MOBILE_JOB_BOARD_SOURCE_TRACKING_XPATH = ".//*[text()[contains(.,'Mobile Job Board Source Tracking')]]/../following-sibling::*//input"
  
  
  #EEO DEFAULT VALUES ON REQUISITIONS
  
    #RACE
    CONFIG_EEO_RACE_REQUISITIONS_DEFAULT_URL = "https://na17.salesforce.com/00No0000008HtQJ?setupid=CustomObjects"
    EDIT_ASIAN_AS_DEFAULT_EEO_REQUISITION_PAGE_XPATH = ".//*[@title='Edit - Record 2 - Asian']"
    SET_ASIAN_AS_DEFAULT_EEO_REQUISITION_CHECKBOX_ID = "p2"
    SET_ASIAN_AS_DEFAULT_EEO_REQUISITION_SAVE_BTN_XPATH = ".//*[@Title='Save']"
    
    #VETERAN
    CONFIG_EEO_VETERAN_REQUISITIONS_DEFAUL_URL = "https://na17.salesforce.com/00No0000008HtQU?setupid=CustomObjects"
    EDIT_YES_VETERAN_DEFAULT_EEO_REQUISITION_PAGE_XPATH = ".//*[@title='Edit - Record 1 - Yes, I am a protected veteran']"
    SET_YES_VETERAN_DEFAULT_EEO_REQUISITION_CHECKBOX_ID = "p2"
    SET_YES_VETERAN_DEFAULT_EEO_REQUISITION_SAVE_BTN_XPATH = ".//*[@Title='Save']"
    
    #GENDER
    CONFIG_EEO_GENDER_REQUISITIONS_DEFAUL_URL = "https://na17.salesforce.com/00No0000008HtQ1?setupid=CustomObjects"
    EDIT_FEMALE_AS_DEFAULT_EEO_REQUISITION_PAGE_XPATH = ".//*[@title='Edit - Record 1 - Female']"
    SET_FEMALE_AS_DEFAULT_EEO_REQUISITION_CHECKBOX_ID = "p2"
    SET_FEMALE_AS_DEFAULT_EEO_REQUISITION_SAVE_BTN_XPATH = ".//*[@title='Save']"
    
    #DISABLED
    CONFIG_EEO_DISABLED_REQUISITIONS_DEFAUL_URL = "https://na17.salesforce.com/00No0000008HtPz?setupid=CustomObjects"
    EDIT_YES_AS_DEFAULT_EEO_REQUISITION_PAGE_XPATH = ".//*[@title='Edit - Record 1 - Yes, I have a disability (or previously had a disability)']"
    SET_YES_AS_DEFAULT_EEO_REQUISITION_CHECKBOX_ID = "p2"
    SET_YES_AS_DEFAULT_EEO_REQUISITION_SAVE_BTN_XPATH = ".//*[@title='Save']"
  
  
  #SHARING SETTINGS
    # Buttons
  EDIT_SHARING_SETTINGS_BUTTON_XPATH = ".//*[@name='edit']"
    # Fields
  CONTACT_PICKLIST_XPATH = "(.//td[text()[starts-with(.,'Contact')]]/following-sibling::*//select)[1]"
  SHARING_SETTINGS_SAVE_BUTTON_XPATH = ".//*[@title='Save']"
  
  
  #JOB BOARD LOGIN OPTIONS
    # Buttons
  CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH = ".//*[@value='Save']"      
  CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH = ".//*[@value='Edit']"
    # Fields
  CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH = ".//*[text()[contains(.,'Enable Login For')]]/..//select"
  
  
  #SOCIAL SETTINGS
  APPLY_TO_LINKEDIN_CHECKBOX_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__LinkedIn_Apply__c']"
  
  # MASS MAIL
    # Fields
  ENABLE_MASS_MAIL_CHECKBOX_XPATH = ".//*[text()[contains(.,'EnableMassMailService')]]/../..//input"
  
  # SETUP
  DEVELOP_XPATH = ".//a[text()='Develop']"
  OPENINGS_XPATH = ".//a[text()='openings']"
  SITES_XPATH = ".//a[text()='Sites']"
  LOGIN_SETTINGS_BUTTON_XPATH = ".//*[@value='Login Settings']"
  EDIT_BUTTON_XPATH = ".//*[@value='Edit']"
  CUSTOM_SETTINGS_XPATH = ".//*[@id='CustomSettings_font']"
  
end