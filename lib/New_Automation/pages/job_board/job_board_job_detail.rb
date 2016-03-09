class JobBoardJobDetail
  JOB_BOARD_APPLY_JOB_LINK_XPATH = ".//*[@class='atsJobDetailsAlreadyLogin']//a"
  
  # LINKEDIN
  JOB_BOARD_APPLY_LINKEDIN_XPATH = ".//*[@id='applyWithLinkedInBtn']"
  JOB_BOARD_LINKEDIN_ALLOW_ACCESS_XPATH = ".//*[@value='Allow access']"
  
  #APPLY TO A JOB
  JOB_BOARD_APPLY_JOB_EMAIL_XPATH = ".//label[contains(text(),'Email Address')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/div/input"
  JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH = ".//label[contains(text(),'First Name')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/div/input"
  JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH = ".//label[contains(text(),'Last Name')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/div/input"

  JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH = ".//label[contains(text(),'How did you hear about us?')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_COVER_LETTER_XPATH = ".//textarea"
  JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH = ".//a[text()[contains(.,'Email this job')]]"
  JOB_BOARD_APPLY_TO_EMAIL_XPATH = ".//label[contains(text(),'To Email:')]/ancestor::tr/child::td[2]/input"
  JOB_BOARD_APPLY_MESSAGE_XPATH = ".//label[contains(text(),'Message:')]/ancestor::tr/child::td[2]/textarea"
  JOB_BOARD_APPLY_SEND_BUTTON_XPATH = ".//*[@class='atsButton']"
  JOB_BOARD_APPLY_FROM_NAME_XPATH = ".//label[contains(text(),'From Name:')]/ancestor::tr/child::td[2]/input"
  JOB_BOARD_APPLY_FROM_EMAIL_XPATH = ".//label[contains(text(),'From Email:')]/ancestor::tr/child::td[2]/input"
  JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH = ".//*[@id='HowDidYouHearAboutUs']//select"

  
  JOB_BOARD_APPLY_JOB_CONTINUE_XPATH = ".//*[@value='Continue']"
  JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH = ".//*[@id='js-menu-search']/a"
  
  JOB_BOARD_APPLY_JOB_DEGREE_XPATH = ".//*[contains(text(),'Job Degree')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_SALES_BACKGROUND = ".//*[contains(text(),'Sales Background')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH = ".//*[contains(text(),'Years Exoerience')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH = ".//*[contains(text(),'Graduate')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH = ".//*[contains(text(),'Refer Candidate')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH = ".//*[contains(text(),'Current Candidate')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_START_DATE_XPATH = ".//*[contains(text(),'Start Date')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_TAXONOMY_SKILLS_XPATH = ".//*[contains(text(),'Taxonomy')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_EMAIL_2_XPATH = ".//*[contains(text(),'Email')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_HOME_PHONE_XPATH = ".//*[contains(text(),'Home Phone')]/ancestor::td[1]/following-sibling::td[1]/select"
  JOB_BOARD_APPLY_JOB_LEVEL_XPATH = ".//*[contains(text(),'Level')]/ancestor::td[1]/following-sibling::td[1]/select"
  
  # REFER CANDIDATE
  REFERREL_EMAIL_XPATH = ".//label[text()[contains(.,'Referrer Email')]]/ancestor::tr/child::td[2]/input"
  PROSPECT_FIRST_NAME_XPATH = ".//label[text()[contains(.,'Prospect First Name')]]/ancestor::tr/child::td[2]/input"
  PROSPECT_LAST_NAME_XPATH = ".//label[text()[contains(.,'Prospect Last Name')]]/ancestor::tr/child::td[2]/input"
  PROSPECT_EMAIL = ".//label[text()[contains(.,'Prospect Email')]]/ancestor::tr/child::td[2]/input"
  PROSPECT_RESUME_BROWSE_XPATH = ".//label[text()[contains(.,'Prospect Resume')]]/ancestor::tr/child::td[2]/input"
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
 
  JOB_BOARD_APPLY_PREVIOUSLY_UPLOADED_RADIO_XPATH = ".//input[@value='PreviouslyUploaded']"
  SELECT_RESUME_DROPDOWN_XPATH = ".//label[text()[contains(.,'Select Resume')]]/ancestor::tr/child::td/select"
  SELECT_RESUME_FIRST_OPTION_XPATH = "(.//*[@id='j_id0:j_id1:atsForm:resumeAttachments']/option)[2]"
  
  JOB_BOARD_APPLY_UPLOAD_RESUME_BROWSE_XPATH = ".//*[@class='atsFormTdTwoColumnLeft']/input[@type='file']"
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
  
  EMAIL_ADDRESS_XPATH = ".//label[contains(text(),'Email Address')]/ancestor::tr/child::td[2]/div/input"
  PASSWORD_TEXT_XPATH = ".//label[not (contains(text(),'Confirm'))][contains(text(),'Password')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/input"
  CONFIRM_PASSWORD_TEXT_XPATH = ".//label[contains(text(),'Confirm')]/ancestor::td[@class='atsFormTdLeft']/following-sibling::td[1]/input"
  FIRST_NAME_TEXT_XPATH = ".//label[contains(text(),'First Name')]/ancestor::tr/child::td[2]/div/input"
  LAST_NAME_TEXT_XPATH = ".//label[contains(text(),'Last Name')]/ancestor::tr/child::td[2]/div/input"
  
  
  #HARD CORE DATA
  JOB_BOARD_APPLY_JOB_DATA_NAME_TEXT = "John"
  JOB_BOARD_APPLY_JOB_DATA_LAST_NAME_TEXT = "Does"
  JOB_BOARD_APPLY_JOB_DATA_EMAIL_TEXT = "matiasqqq@oktana.io"
  JOB_BOARD_APPLY_JOB_DATA_DATE_START_DATE = "2/16/2017"
  
  #ERROR
  ERRORS_OF_FIELD_TO_SUBMIT_XPATH = ".//*[@class='atsError']"  

  
  #UPDATE YOUR INFO
  JOB_BOARD_FIRST_NAME_XPATH = ".//label[contains(text(),'First Name')]/ancestor::tr/child::td[2]/div/input"
  JOB_BOARD_LAST_NAME_XPATH = ".//label[contains(text(),'Last Name')]/ancestor::tr/child::td[2]/div/input"
  JOB_BOARD_CONTINUE_BUTTON_XPATH = ".//*[@value='Continue']"
  
  #UPDATE YOUR RESUME
  UPLOAD_CHECKBOX_XPATH = ".//input[@value='Upload']"
  PASTE_CHECKBOX_XPATH = ".//input[@value='Paste']"
  PASTE_TEXTAREA_XPATH = ".//*[@class='atsFormTdTwoColumnLeft']/textarea"
  BUILDER_CHECKBOX_XPATH = ".//input[@value='Builder']"
  JOB_BOARD_DEPARTMENT_SELECT_XPATH = "//*[text()[contains(.,'Department')]]/ancestor::tr/child::td[2]/select"
  CONTINUE_BUTTON_XPATH = ".//*[@value='Continue']"  
  
  # ADD_EMPLOYMENT_HISTORY
  ADD_EMPLOYMENT_HISTORY_XPATH = ".//input[@type='submit'][contains(@value,'Add Employment History')]"
  REMOVE_EMPLOYMENT_HISTORY_XPATH = ".//input[@type='submit'][contains(@value,'Remove Employment History')]"
  REMOVE_EDUCATION_HISTORY_XPATH = ".//input[@type='submit'][contains(@value,'Remove Education History')]"
  ADD_CERTIFICATION_XPATH = ".//input[@type='submit'][contains(@value,'Add Certification')]"
  ADD_EDUCATION_HISTORY_XPATH = ".//input[@type='submit'][contains(@value,'Add Education History')]"
  BROWSE_BUTTON_XPATH = ".//*[@class='atsFormTdTwoColumnLeft']/input"
  EMPLOYER_NAME_TEXT_XPATH = "//*[text()[contains(.,'Employer Name')]]/ancestor::tr/child::td[2]/input"
  LOCATION_TEXT_XPATH = "//*[text()[contains(.,'Location')]]/ancestor::tr/child::td[2]/input"
  JOB_TITLE_TEXT_XPATH = "//*[text()[contains(.,'Job Title')]]/ancestor::tr/child::td[2]/input"
  NEXT_BUTTON_XPATH = ".//*[@value='Next']" 
  # ADD EDUCATION HISTORY
  SCHOOL_NAME_TEXT_XPATH = "//*[text()[contains(.,'School Name')]]/ancestor::tr/child::td[2]/input"
  MAYOR_TEXT_XPATH = "//*[text()[contains(.,'Major')]]/ancestor::tr/child::td[2]/input"
  # ADD CERTIFICATION
  CERTIFICATION_TEXT_XPATH = "//*[text()[contains(.,'Certification or License Name')]]/ancestor::tr/child::td[2]/input"
  STATE_PROVINCE_XPATH = "//*[text()[contains(.,'State/Province')]]/ancestor::tr/child::td[2]/input"
  REMOVE_CERTIFICATION_XPATH = ".//input[@type='submit'][contains(@value,'Remove Certification')]"
  # ADD SKILL
  ADD_SKILL_BUTTON_XPATH = ".//input[@value='Add Skill']"
  SKILL_NAME_TEXT_XPATH = "//*[text()[contains(.,'Skill Name')]]/ancestor::tr/child::td[2]/input"
  REMOVE_SKILL_BUTTON_XPATH = ".//input[@value='Remove Skill']" 
  BUILD_RESUME_BUTTON_XPATH = ".//input[@value='Build Resume']"
  
  JOB_BOARD_LINKEDIN_DATA_EMAIL_TEXT = "automationoktana@gmail.com"
  JOB_BOARD_LINKEDIN_DATA_PASSWORD_TEXT = "oktanaqa"

  # REFERRALS
  PROSPECT_EMAIL_XPATH = ".//label[text()[contains(.,'Referrer Email')]]/ancestor::tr/child::td[2]/input"
  
  #MESSAGES
  SUCCESS_UPLOADED_RESUEM_XPATH = ".//*[@id='atsApplicationSubmittedMain']"
end