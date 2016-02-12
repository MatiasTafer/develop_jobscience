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
  JOB_BOARD_APPLY_JOB_QUESTION_NAME_1_XPATH = "(.//*[@class='atsPreScreen']//span)[1]"
  JOB_BOARD_APPLY_JOB_QUESTION_NAME_2_XPATH = "(.//*[@class='atsPreScreen']//span)[2]"

  
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
  
  #HARD CORE DATA
  JOB_BOARD_APPLY_JOB_DATA_NAME_TEXT = "John"
  JOB_BOARD_APPLY_JOB_DATA_LAST_NAME_TEXT = "Doe"
  JOB_BOARD_APPLY_JOB_DATA_EMAIL_TEXT = "matiasq@oktana.io"
  JOB_BOARD_APPLY_JOB_DATA_DATE_START_DATE = "2/16/2017"
  
  #ERROR
  ERRORS_OF_FIELD_TO_SUBMIT_XPATH = ".//*[@class='atsError']"  
  
end