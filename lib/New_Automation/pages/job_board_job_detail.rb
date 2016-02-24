class JobBoardJobDetail
  JOB_BOARD_APPLY_JOB_LINK_XPATH = ".//*[@class='atsJobDetailsAlreadyLogin']//a"
  
  #APPLY TO A JOB
  JOB_BOARD_APPLY_JOB_EMAIL_XPATH = "(.//*[@class='atsInput'])[1]"
  JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH = "(.//*[@class='atsInput'])[2]"
  JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH = "(.//*[@class='atsInput'])[3]"
  JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH = ".//*[@id='HowDidYouHearAboutUs']//select"
  
  JOB_BOARD_APPLY_JOB_CONTINUE_XPATH = ".//*[@value='Continue']"
  JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH = ".//*[@id='js-menu-search']/a"
  JOB_BOARD_APPLY_JOB_DATE_ABAILABLE_XPATH = ".//*[@class='dateInput dateOnlyInput']/input"
  JOB_BOARD_APPLY_JOB_DEGREE_XPATH = "(.//*[@class='atsFormTdTwoColumnLeft'])[5]/select"
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
  JOB_BOARD_LINKEDIN_DATA_EMAIL_TEXT = "automationoktana@gmail.com"
  JOB_BOARD_LINKEDIN_DATA_PASSWORD_TEXT = "oktanaqa"



   
  
end