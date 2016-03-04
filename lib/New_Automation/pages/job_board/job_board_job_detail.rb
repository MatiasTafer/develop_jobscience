class JobBoardJobDetail
  JOB_BOARD_APPLY_JOB_LINK_XPATH = ".//*[@class='atsJobDetailsAlreadyLogin']//a"
  
  # LINKEDIN
  JOB_BOARD_APPLY_LINKEDIN_XPATH = ".//*[@id='applyWithLinkedInBtn']"
  JOB_BOARD_LINKEDIN_ALLOW_ACCESS_XPATH = ".//*[@value='Allow access']"
  
  #APPLY TO A JOB
  JOB_BOARD_APPLY_JOB_EMAIL_XPATH = "(.//*[@class='atsInput'])[1]"
  JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH = "(.//*[@class='atsInput'])[2]"
  JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH = "(.//*[@class='atsInput'])[3]"

  JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH = ".//*[@id='j_id0:j_id1:atsForm:candidateSource']"
  JOB_BOARD_APPLY_COVER_LETTER_XPATH = ".//*[@id='j_id0:j_id1:atsForm:coverLetter']"
  JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH = ".//a[text()[contains(.,'Email this job')]]"
  JOB_BOARD_APPLY_TO_EMAIL_XPATH = ".//*[@id='j_id0:j_id1:emailJob:toEmail']"
  JOB_BOARD_APPLY_MESSAGE_XPATH = ".//*[@id='j_id0:j_id1:emailJob:message']"
  JOB_BOARD_APPLY_SEND_BUTTON_XPATH = ".//*[@id='j_id0:j_id1:emailJob']/table/tbody/tr[8]/td[2]/input"
  JOB_BOARD_APPLY_FROM_NAME_XPATH = ".//*[@id='j_id0:j_id1:emailJob:inputFromName']"
  JOB_BOARD_APPLY_FROM_EMAIL_XPATH = ".//*[@id='j_id0:j_id1:emailJob:inputFromEmail']"
  JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH = ".//*[@id='HowDidYouHearAboutUs']//select"

  
  JOB_BOARD_APPLY_JOB_CONTINUE_XPATH = ".//*[@value='Continue']"
  JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH = ".//*[@id='js-menu-search']/a"
  JOB_BOARD_APPLY_JOB_DATE_ABAILABLE_XPATH = ".//*[@class='dateInput dateOnlyInput']/input"
  JOB_BOARD_APPLY_JOB_DEGREE_XPATH = "(.//*[@class='atsFormTdTwoColumnLeft'])[5]/select"
  JOB_BOARD_APPLY_JOB_SALES_BACKGROUND = ".//*[@id='j_id0:j_id1:atsForm:j_id92:0:prescreenQuestionTag:prescreenQuestionComponent:answerSelectList']"
  JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id92:2:prescreenQuestionTag:prescreenQuestionComponent:answerSelectList']"
  JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id92:1:prescreenQuestionTag:prescreenQuestionComponent:answerSelectList']"
  JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH = ".//*[@id='atsJobDetailsBox']/table/tbody/tr[6]/td/div/a[7]"
  JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id48:0:standardQuestionTag:standardQuestionComponent:answerText']"
  JOB_BOARD_APPLY_JOB_START_DATE_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id48:1:standardQuestionTag:standardQuestionComponent:answerDate']"
  JOB_BOARD_APPLY_JOB_TAXONOMY_SKILLS_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id48:2:standardQuestionTag:standardQuestionComponent:answerTextArea']"
  JOB_BOARD_APPLY_JOB_EMAIL_2_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id48:3:standardQuestionTag:standardQuestionComponent:answerText']"
  JOB_BOARD_APPLY_JOB_HOME_PHONE_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id48:4:standardQuestionTag:standardQuestionComponent:answerText']"
  JOB_BOARD_APPLY_JOB_LEVEL_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id48:6:standardQuestionTag:standardQuestionComponent:answerSelectList']"
  
  # REFER CANDIDATE
  REFERREL_EMAIL_XPATH = ".//*[@id='j_id0:j_id1:j_id28:r2_email']"
  PROSPECT_FIRST_NAME_XPATH = ".//*[@id='j_id0:j_id1:j_id28:p_first_name']"
  PROSPECT_LAST_NAME_XPATH = ".//*[@id='j_id0:j_id1:j_id28:p_last_name']"
  PROSPECT_EMAIL = ".//*[@id='j_id0:j_id1:j_id28:p_email']"
  PROSPECT_RESUME_BROWSE_XPATH = ".//*[@id='j_id0:j_id1:j_id28:p_resume']"
  THANK_YOU_REFERRAL_MESSAGE_XPATH = ".//*[@class='atsThankForReferral']"
  
  JOB_BOARD_APPLY_JOB_QUESTION_1_TR_XPATH = "(.//*[@class='atsPreScreen'])//tr[2]"
  JOB_BOARD_APPLY_JOB_QUESTION_2_TR_XPATH = "(.//*[@class='atsPreScreen'])//tr[4]"
  JOB_BOARD_APPLY_JOB_QUESTION_1_XPATH = "(.//*[@class='atsPreScreen']//*[@class='atsInput'])[1]"
  JOB_BOARD_APPLY_JOB_QUESTION_2_XPATH = "(.//*[@class='atsPreScreen']//*[@class='atsInput'])[2]"
  JOB_BOARD_APPLY_JOB_QUESTION_3_XPATH = "(.//*[@class='atsPreScreen']//*[@class='atsInput'])[3]"
  JOB_BOARD_APPLY_JOB_ERROR_MESSAGE_XPATH = "(.//*[@class='atsError'])//tr[3]/td"
  JOB_BOARD_APPLY_JOB_ERROR_BLOCK_XPATH = "(.//*[@class='atsError'])"
  JOB_BOARD_APPLY_JOB_ERROR_MESSAGE_2_XPATH = "(.//*[@class='atsError'])[2]//td"
  JOB_BOARD_APPLY_JOB_QUESTION_NAME_1_XPATH = "(.//*[@class='atsPreScreen']//span)[1]"
  JOB_BOARD_APPLY_JOB_QUESTION_NAME_2_XPATH = "(.//*[@class='atsPreScreen']//span)[2]"
  JOB_BOARD_APPLY_UPLOAD_RESUME_RADIO_XPATH = "(.//*[@type='radio'])[1]"
 
  JOB_BOARD_APPLY_PREVIOUSLY_UPLOADED_RADIO_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:3']"
  SELECT_RESUME_DROPDOWN_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeAttachments']"
  SELECT_RESUME_FIRST_OPTION_XPATH = "(.//*[@id='j_id0:j_id1:atsForm:resumeAttachments']/option)[2]"
  
  JOB_BOARD_APPLY_UPLOAD_RESUME_BROWSE_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeFile']"
  JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH = ".//*[@id='LinkedInIcon']"

  
  JOB_BOARD_APPLY_JOB_SUBMIT_XPATH = ".//*[@value='Submit']"  
  
  #JOB BOARD QUESTIONS
  JOB_BOARD_QUESTIONS_SET_QUESTION_1_XPATH = "(.//*[@class='atsPreScreen']//td)[1]"
  JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH = "(.//*[@class='atsPreScreen']//td)[2]"
  JOB_BOARD_QUESTIONS_SET_QUESTION_2_XPATH = "(.//*[@class='atsPreScreen']//td)[3]"
  JOB_BOARD_QUESTIONS_SET_QUESTION_2_INPUT_XPATH = "(.//*[@class='atsPreScreen']//td)[4]"
  JOB_BOARD_QUESTIONS_SET_QUESTION_3_XPATH = "(.//*[@class='atsPreScreen']//td)[5]"
  JOB_BOARD_QUESTIONS_SET_QUESTION_3_INPUT_XPATH = "(.//*[@class='atsPreScreen']//td)[6]"
  JOB_BOARD_QUESTIONS_SET_QUESTION_4_XPATH = "(.//*[@class='atsPreScreen']//td)[7]"
  JOB_BOARD_QUESTIONS_SET_QUESTION_4_INPUT_XPATH = "(.//*[@class='atsPreScreen']//td)[8]"
  JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH = ".//*[@value='Submit']"
  
  #JOB BOARD EMPLOYMENT QUESTIONS
  JOB_BOARD_QUESTIONS_SET_DATE_START_XPATH = ".//*[@class='dateInput dateOnlyInput']/input"
  JOB_BOARD_QUESTIONS_SET_DEGREE_OPTION_1_XPATH = "(.//*[@class='atsInput'])[2]/option[1]"
  
  #JOB BOARD LINKEDIN
  JOB_BOARD_LINKEDIN_SUCCESS_DIALOG_XPATH = ".//*[@id='dialogMessage']"
  JOB_BOARD_LINKEDIN_SUCCESS_MSG_XPATH = ".//*[@id='atsApplicationSubmittedMain']"
  JOB_BOARD_LINKEDIN_BTN_CLOSE_POPUP_XPATH = ".//*[@id='closeButton']"
  JOB_BOARD_LINKEDIN_EMAIL_XPATH = ".//*[@id='session_key-oauthAuthorizeForm']"
  JOB_BOARD_LINKEDIN_PASSWORD_XPATH = ".//*[@id='session_password-oauthAuthorizeForm']"
  JOB_BOARD_LINKEDIN_BTN_ALLOW_XPATH = ".//*[@name='authorize']"
  JOB_BOARD_EEO_QUESTIONS_GENDER_XPATH = ".//*[@id='j_id0:j_id1:atsForm:Gender']"
  JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH = ".//*[@id='js-menu-logout']/a"
  JOB_BOARD_EEO_QUESTIONS_RACE_XPATH = ".//*[@id='j_id0:j_id1:atsForm:Race']"
  JOB_BOARD_EEO_QUESTIONS_VETERAN_XPATH = ".//*[@id='j_id0:j_id1:atsForm:Veteran']"
  JOB_BOARD_EEO_QUESTIONS_DISABLED_XPATH = ".//*[@id='j_id0:j_id1:atsForm:Disabled']"
  JOB_BOARD_EEO_QUESTIONS_BTN_SUBMIT_XPATH = ".//*[@type='submit']"
  
  EMAIL_ADDRESS_XPATH = ".//*[@id='j_id0:j_id1:atsForm:email']"
  PASSWORD_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:password']"
  CONFIRM_PASSWORD_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:confirmPassword']"
  FIRST_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:firstName']"
  LAST_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:lastName']"
  
  
  #HARD CORE DATA
  JOB_BOARD_APPLY_JOB_DATA_NAME_TEXT = "John"
  JOB_BOARD_APPLY_JOB_DATA_LAST_NAME_TEXT = "Does"
  JOB_BOARD_APPLY_JOB_DATA_EMAIL_TEXT = "matiasqqq@oktana.io"
  JOB_BOARD_APPLY_JOB_DATA_DATE_START_DATE = "2/16/2017"
  
  #ERROR
  ERRORS_OF_FIELD_TO_SUBMIT_XPATH = ".//*[@class='atsError']"  

  
  #UPDATE YOUR INFO
  JOB_BOARD_FIRST_NAME_XPATH = ".//*[@id='j_id0:j_id1:atsForm:firstName']"
  JOB_BOARD_LAST_NAME_XPATH = ".//*[@id='j_id0:j_id1:atsForm:lastName']"
  JOB_BOARD_CONTINUE_BUTTON_XPATH = ".//*[@value='Continue']"
  
  #UPDATE YOUR RESUME
  UPLOAD_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:0']"
  PASTE_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:1']"
  PASTE_TEXTAREA_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeText']"
  BUILDER_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id53:2']"
  JOB_BOARD_DEPARTMENT_SELECT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:j_id40:1:searchCtrl']"
  CONTINUE_BUTTON_XPATH = ".//*[@value='Continue']"  
  
  # ADD_EMPLOYMENT_HISTORY
  ADD_EMPLOYMENT_HISTORY_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag']/table[1]/tbody/tr[2]/td/input"
  REMOVE_EMPLOYMENT_HISTORY_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag']/table[1]/tbody/tr[8]/td/input[2]"
  REMOVE_EDUCATION_HISTORY_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag']/table[1]/tbody/tr[6]/td/input[2]"
  ADD_CERTIFICATION_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag']/table[1]/tbody/tr[2]/td/input"
  ADD_EDUCATION_HISTORY_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag']/table[1]/tbody/tr[2]/td/input"
  BROWSE_BUTTON_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeFile']"
  EMPLOYER_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag:j_id65:j_id72:0:dynfield']"
  LOCATION_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag:j_id65:j_id72:1:dynfield']"
  JOB_TITLE_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag:j_id65:j_id72:2:dynfield']"
  NEXT_BUTTON_XPATH = ".//*[@value='Next']" 
  # ADD EDUCATION HISTORY
  SCHOOL_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag:j_id65:j_id86:0:dynfield']"
  MAYOR_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag:j_id65:j_id86:1:dynfield']"
  # ADD CERTIFICATION
  CERTIFICATION_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag:j_id65:j_id100:0:dynfield']"
  STATE_PROVINCE_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag:j_id65:j_id100:1:dynfield']"
  REMOVE_CERTIFICATION_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag']/table[1]/tbody/tr[6]/td/input[2]"
  # ADD SKILL
  ADD_SKILL_BUTTON_XPATH = ".//input[@value='Add Skill']"
  SKILL_NAME_TEXT_XPATH = ".//*[@id='j_id0:j_id1:atsForm:resumeBuilderTag:j_id65:j_id114:1:dynfield']"
  REMOVE_SKILL_BUTTON_XPATH = ".//input[@value='Remove Skill']" 
  BUILD_RESUME_BUTTON_XPATH = ".//input[@value='Build Resume']"
  
  JOB_BOARD_LINKEDIN_DATA_EMAIL_TEXT = "automationoktana@gmail.com"
  JOB_BOARD_LINKEDIN_DATA_PASSWORD_TEXT = "oktanaqa"

  # REFERRALS
  PROSPECT_FIRST_NAME_XPATH = ".//*[@id='j_id0:j_id1:j_id28:p_first_name']"
  PROSPECT_LAST_NAME_XPATH = ".//*[@id='j_id0:j_id1:j_id28:p_last_name']"
  PROSPECT_EMAIL_XPATH = ".//*[@id='j_id0:j_id1:j_id28:p_email']"
  
  #MESSAGES
  SUCCESS_UPLOADED_RESUEM_XPATH = ".//*[@id='atsApplicationSubmittedMain']"
end