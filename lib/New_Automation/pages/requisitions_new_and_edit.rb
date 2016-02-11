class RequisitionsNewAndEdit
  
  #FIRST STEP
  REQUISITIONS_NEW_RECORD_TYPE_ID = "p3"
  REQUISITIONS_NEW_BTN_CONTINUE_XPATH = ".//*[@value='Continue']"
  REQUISITIONS_NEW_BTN_CANCEL_XPATH = ".//*[@id='bottomButtonRow']/input[2]"
  
  #SECOND STEP
  
    #BUTTONS
  REQUISITIONS_NEW_BTN_SAVE_XPATH = ".//*[@id='topButtonRow']/input[1]"
  REQUISITIONS_NEW_BTN_SAVE_AND_NEW_XPATH = ".//*[@id='topButtonRow']/input[2]"
  REQUISITIONS_NEW_BTN_CANCEL_2_XPATH = ".//*[@id='topButtonRow']/input[3]"
    
    #REQUIRED FIELDS
  REQUISITIONS_NEW_JOB_TITLE_ID = "Name"
  REQUISITIONS_NEW_PRIMARY_RECRUITER_TYPE_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[5]//select"
  REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH = ".//*[@id='CF00No0000008HtZJ']"
  REQUISITIONS_NEW_LOCATION_XPATH = ".//*[@id='00No0000008HtYp']"
  REQUISITIONS_NEW_MIN_SALARY_XPATH = ".//*[@id='00No0000008HtZ3']"
  REQUISITIONS_NEW_MAX_SALARY_XPATH = ".//*[@id='00No0000008HtYy']"
  REQUISITIONS_NEW_DEPARTAMENT_XPATH = ".//*[@id='00No0000008HtYJ']"
  REQUISITIONS_NEW_BTN_SAVE_EDIT_XPATH = ".//*[@name='save']"
  REQUISITIONS_JOBS_PROJECTS_FIELD_XPATH = ".//*[@id='00No0000008HtYf']"
  REQUISITIONS_CLIENT_FIELD_XPATH = ".//*[@id='CF00No0000008HtXu']"
  REQUISITIONS_CONTACT_FIELD_XPATH = ".//*[@id='CF00No0000008HtY9']"
  
    #DATE FIELDS
  REQUISITIONS_NEW_DATE_POSTED_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[1]/td[4]//input"
  REQUISITIONS_NEW_EXPIRATION_DATE_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[2]/td[4]//input"
  REQUISITIONS_NEW_DATE_CLOSED_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[4]/td[4]//input"
  REQUISITIONS_NEW_ESTIMATED_END_DATE_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[7]/td[last()]//input"
  
    #NUMBER FIELDS
  REQUISITIONS_NEW_OPENINGS_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[5]/td[2]//input"
  REQUISITIONS_NEW_PASSING_SCORE_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[4]/td[4]//input"

  
  #HARD CODE DATA
  RECORD_TYPE_OF_NEW_RECORD_TEXT = "Corporate" 
  RECORD_TYPE_OF_NEW_RECORD_TEXT_2 = "Internship"
  JOB_TITLE_TEXT =  "JobTitle"
  PRIMARY_RECRUITER_TEXT = "Naomi Kihara"
  LOCATION_TEXT = "San Francisco, CA"
  DEPARTMENT_TEXT = "Dept ABC"
  MIN_SALARY_TEXT = "1000"
  MAX_SALARY_TEXT = "2000"
  MIN_SALARY_WRONG_TEXT = "minWrongText"
  MAX_SALARY_WRONG_TEXT = "maxWrongText"
  OPENINGS_WRONG_TEXT = "openingWrong"
  PASSING_SCORE_WRONG_TEXT = "scoreWrong"
  JOB_PROJECTS_TEXT= "Function ABC"
  CLIENT_TEXT = "Candidates"
  CONTACT_TEXT = "Charlie Day2"
  TRAVEL_WRONG_PERCENT_TEXT = "wrongPercent"

    
  #OTHER FIELDS
  REQUISITIONS_NEW_QUESTIONS_SET_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[3]/td[4]//span/input"
  REQUISITIONS_NEW_POST_JOB_BOX_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[2]/td[2]//input"
  REQUISITION_TRAVEL_FIELD_XPATH = ".//*[@id='00No0000008HtZb']"
  
 
 #ERROR
 ERROR_MESSAGE_FIELD_XPATH = ".//*[@class='errorMsg']"
 
 
 #ERROR TEXTS
 ERROR_REQUIRED_FIELDS_TEXT = "Error: You must enter a value"
 ERROR_INVALID_CURRENCY_TEXT = "Error: Invalid currency"
 ERROR_INVALID_NUMBER_TEXT = "Error: Invalid number"
 ERROR_INVALID_PERCENT_TEXT = "Error: Invalid percent"

end