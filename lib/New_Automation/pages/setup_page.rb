class SetupEditPage
  
  # Config
  # setup > develop > custom settings > manage next to config > edit
  CONFIG_SETUP_EDIT_PAGE_URL = "https://na17.salesforce.com/setup/ui/editCustomSettingsData.apexp?retURL=%2Fsetup%2Fui%2FlistCustomSettingsData.apexp%3Fid%3Da07&id=a07o00000021XSy"
  
  
  CONFIG_SETUP_EDIT_SAVE_BTN_XPATH = ".//*[@class='pbButton']//*[@value='Save']"
  AUTO_SHARE_MODE_TEXT_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Auto_Share_Mode__c"
  STANDARD_QUESTION_HANDLER_TEXT_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Standard_Question_Handler__c"
  INVITE_TO_APPLY_CUSTOM_MESSAGE_CHECKBOX_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Invite_to_Apply_Custom_Message__c"
  EEO_QUESTION_HANDLER_TEXT_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__EEO_Question_Handler__c"
  COMMIT_EEO_DEFAULT_VALUE_CHECKBOX_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Commit_EEO_Default_Value__c" 
  ENABLE_CLOSE_JOB_ORDER_WIZARD_CHECKBOX_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Enable_Close_Job_Order_Wizard__c"
  QUESTION_SET_HANDLER_TEXT_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Question_Set_Handler__c"
  QUESTION_SET_DAY_HANDLER = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Question_Set_Days_Valid__c'"
  ATTACH_TO_APPLICATIONS_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Attach_to_Applications__c']"
  DOCUMENT_TYPES_FOR_ATTACHMENTS_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Accepted_Exts__c']"
  MAX_NUMBER_ATTACHMENTS_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Max_Number_of_Attachments__c']"

  ENABLE_ENHANCED_APPLY_TO_JOB_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Enhanced_Apply_to_Job__c']"
  
  SHORT_LIST_CUSTOM_SETINGS_PAGE_URL = "https://na17.salesforce.com/setup/ui/listCustomSettingsData.apexp?id=a1A"
  
  #Short list
  EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH = ".//*[@class='btn'][1]"
  CHECKBOX_SPEEDREVIEW_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Enable_Speed_Review__c']"
  CHECKBOX_WEB_SOURCING_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Enable_Web_Sourcing__c']"
  CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH =".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Enable_Jobscience_UI__c']"
  SAVE_BUTTON_SHORT_LIST_XPATH = ".//*[@class='btn btn'][1]"
  ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Enable_Review_Email__c']"
  REVIEW_MODE_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Review_Mode__c']"
  ENABLE_EMAIL_SEND_OPTIONS_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Review_Email_Send_Options__c']"
  DEFAULT_STAFFING_REVIEW_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Default_Staffing_Review__c']"
  

  
  # Board Setup
  # board setup tab > record link > edit
  JOB_BOARD_SETUP_EDIT_PAGE_URL = "https://ts2.na17.visual.force.com/apex/JobBoardSetup?retURL=%2Fa0Go00000080Tcp&scontrolCaching=1&sfdc.override=1&id=a0Go00000080Tcp"
  JOB_BOARD_SETUP_EDIT_PAGE_INTERNAL_XPATH = "https://ts2.na17.visual.force.com/apex/JobBoardSetup?retURL=%2Fa0Go000001Ij584&scontrolCaching=1&sfdc.override=1&id=a0Go000001Ij584"
  
  AUTO_ASSOCIATE_CHECKBOX_XPATH = ".//*[@id='j_id0:frm:PageBlock:j_id32:j_id42']"
  SHOW_SEARCH_ONLY_CHECKBOX_XPATH = ".//*[@id='j_id0:frm:PageBlock:j_id32:j_id39']"
  ALLOW_REGISTER_ONLY_CHECKBOX_XPATH = ".//*[@id='j_id0:frm:PageBlock:j_id32:j_id41']"
  RESUME_REQUIRE_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id44" 
  HIDE_RESUME_UPLOAD_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id43"
  HIDE_RESUME_PASTE_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id45"
  HIDE_RESUME_BUILDER_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id47"
  HIDE_RESUME_PREVIOUSLY_UPLOADED_ID = "j_id0:frm:PageBlock:j_id32:j_id49"
  HIDE_COVER_LETTER_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id48"
  HIDE_PHONE_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id50"
  HIDE_MOBILE_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id52"
  HIDE_SOURCE_QUESTION_CHECKBOX_ID = "'j_id0:frm:PageBlock:j_id32:j_id54"
  HIDE_CONTACT_METHOD_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id56"
  DISABLE_MOBILE_JOB_BOARD_CHECKBOX_ID = "j_id0:frm:PageBlock:j_id32:j_id57"

  ALLOW_DUPLICATE_APPS_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Allow_Duplicate_Apps__c']"

  STANDARD_QUESTION_1_OPTION_1_XPATH = "((.//*[@class='detailList'])[3]//select)[1]/option[1]"
  STANDARD_QUESTION_2_OPTION_1_XPATH = "((.//*[@class='detailList'])[3]//select)[2]/option[1]"
  STANDARD_QUESTION_3_OPTION_1_XPATH = "((.//*[@class='detailList'])[3]//select)[3]/option[1]"
  EEO_QUESTIONS_GENDER_CHECKBOX_XPATH = ".//*[@id='j_id0:frm:PageBlock:j_id217:PageBlockSectionItem2:Gender']"
  EEO_QUESTIONS_VETERAN_CHECKBOX_XPATH = ".//*[@id='j_id0:frm:PageBlock:j_id217:PageBlockSectionItem4:Veteran']"
  EEO_QUESTIONS_RACE_CHECKBOX_XPATH = ".//*[@id='j_id0:frm:PageBlock:j_id217:PageBlockSectionItem3:Race']"
  EEO_QUESTIONS_DISABLE_CHECKBOX_XPATH = ".//*[@id='j_id0:frm:PageBlock:j_id217:PageBlockSectionItem5:Disabled']"
  EEO_QUESTIONS_REQUIRED_CHECKBOX_XPATH = ".//*[@id='j_id0:frm:PageBlock:j_id217:PageBlockSectionItem6:EEORequired']"

  
  EDIT_BUTTON_XPATH = ".//*[@name='edit']"
  SAVE_BUTTON_XPATH = ".//*[@value='Save']"
  # Custom Settings
  
  # Parse settings edit page
  PARSE_SETTINGS_EDIT_URL = "https://na17.salesforce.com/setup/ui/listCustomSettingsData.apexp?id=a0O"
  PARSE_SETTINGS_EDIT_BUTTON_XPATH = ".//*[@value='Edit']"
  RESUME_DAYS_VALID_TEXT_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Resume_Days_Valid__c']"

  JOB_BOARD_DUPE_PREVENTION_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Job_Board_Dupe_Prevention__c']"
  
  ADD_RESUME_ALLOWED_FILETYPES_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Add_Resume_Allowed_Filetypes__c']"
  JOB_BOARD_ALLOWED_FILETYPES_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Job_Board_Allowed_Filetypes__c']"

  # Social Settings
  # setup > develop > custom settings > manage next to social settings
  SOCIAL_SETTINGS_URL = "https://na17.salesforce.com/setup/ui/listCustomSettingsData.apexp?id=a0t"
  SOCIAL_SETTINGS_EDIT_URL = "https://na17.salesforce.com/setup/ui/editCustomSettingsData.apexp?CS_list%3ACS_Form=CS_list%3ACS_Form&CS_list%3ACS_Form%3AtheDetailPageBlock%3AthePageBlockButtons%3Aedit=Edit&retURL=%2Fsetup%2Fui%2FlistCustomSettingsData.apexp%3Fid%3Da0t&isOrg=1&id=a0to000000081HN&id=a0to000000081HN&com.salesforce.visualforce.ViewStateCSRF=VmpFPSxNakF4Tmkwd01pMHdObFF4T0RvME16bzFOUzR4TWpsYSxKVnlvQkhwanVYWmM4Z1pHVEdpTWpCLFpXWmtNR1Uy&com.salesforce.visualforce.ViewStateVersion=201602022000070248" 
  TWITTER_ISACCESS_CHECKBOX_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Twitter_isAccess__c"
  TWITTER_SECRET_TEXT_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Twitter_secret__c"
  TWITTER_TOKEN_CHECKBOX_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Twitter_token__c"
  TWITTER_SOURCE_TRACKING_TEXT_ID = "CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Twitter_Source_Tracking__c"
  SOCIAL_SETTINGS_EDIT_BUTTON_XPATH = ".//*[@value='Edit']"
  LINKEDIN_SOURCE_TRACKING_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__LinkedIn_Source_Tracking__c']"
  MOBILE_JOB_BOARD_SOURCE_TRACKING_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:ts2__Mobile_Job_Board_Source_Tracking__c']"
  
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
  
  #JOB BOARD LOGIN OPTIONS
  CONFIG_JOB_BOARD_LOGIN_URL = "https://na17.salesforce.com/udd/Site/editSiteLoginSettings.apexp?id=0DMo00000005Nzk"
  CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH = ".//*[@id='thePage:theForm:thePageBlock:loginPageBlockSection:enableLogin']"
  CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH = ".//*[@id='thePage:theForm:thePageBlock:thePageBlockButtons:save']"      
  CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH = ".//*[@value='Edit']"
  
  # MASS MAIL
  ENABLE_MASS_MAIL_CHECKBOX_XPATH = ".//*[@id='CS_Edit:CS_Form:thePageBlock:thePageBlockSection:jsmassmail__EnableMassMailService__c']"
  MASS_MAIL_SERVICE_EDIT_URL = "https://na17.salesforce.com/setup/ui/editCustomSettingsData.apexp?CS_list%3ACS_Form%3AtheDetailPageBlock%3AthePageBlockButtons%3Aedit=Edit&CS_list%3ACS_Form=CS_list%3ACS_Form&retURL=%2Fsetup%2Fui%2FlistCustomSettingsData.apexp%3Fid%3Da1l&setupid=CustomSettings&isOrg=1&id=a1lo0000000UeE6&id=a1lo0000000UeE6&com.salesforce.visualforce.ViewStateVersion=201602242157540280&com.salesforce.visualforce.ViewStateCSRF=VmpFPSxNakF4Tmkwd01pMHlPRlF4T1RveU56bzBOUzR3TVRWYSxRM0RpbWN1cnV6T0E0cThKekFaTmhfLFpXWmtNR1Uy"
  
  
end