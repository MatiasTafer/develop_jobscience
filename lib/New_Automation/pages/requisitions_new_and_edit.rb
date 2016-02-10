class RequisitionsNewAndEdit
  
  #FIRST STEP
  REQUISITIONS_NEW_RECORD_TYPE_ID = "p3"
  REQUISITIONS_NEW_BTN_CONTINUE_XPATH = ".//*[@id='bottomButtonRow']/input[1]"
  REQUISITIONS_NEW_BTN_CANCEL_XPATH = ".//*[@id='bottomButtonRow']/input[2]"
  
  #SECOND STEP
  
    #BUTTONS
  REQUISITIONS_NEW_BTN_SAVE_XPATH = ".//*[@id='topButtonRow']/input[1]"
  REQUISITIONS_NEW_BTN_SAVE_AND_NEW_XPATH = ".//*[@id='topButtonRow']/input[2]"
  REQUISITIONS_NEW_BTN_CANCEL_2_XPATH = ".//*[@id='topButtonRow']/input[3]"
    
    #REQUIRED FIELDS
  REQUISITIONS_NEW_JOB_TITLE_ID = "Name"
  REQUISITIONS_NEW_PRIMARY_RECRUITER_TYPE_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[5]//select"
  REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[5]//*[@class = 'lookupInput']/input"
  REQUISITIONS_NEW_LOCATION_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[1]/td[2]//select"
  REQUISITIONS_NEW_MIN_SALARY_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[3]/td[2]//input"
  REQUISITIONS_NEW_MAX_SALARY_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[4]/td[2]//input"
  REQUISITIONS_NEW_DEPARTAMENT_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[2]/td[4]//select"
  
    #DATE FIELDS
  REQUISITIONS_NEW_DATE_POSTED_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[1]/td[4]//input"
  REQUISITIONS_NEW_EXPIRATION_DATE_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[2]/td[4]//input"
  REQUISITIONS_NEW_DATE_CLOSED_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[4]/td[4]//input"
  REQUISITIONS_NEW_ESTIMATED_END_DATE_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[7]/td[last()]//input"
  
    #NUMBER FIELDS
  REQUISITIONS_NEW_OPENINGS_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[5]/td[2]//input"
  REQUISITIONS_NEW_PASSING_SCORE_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[4]/td[4]//input"

  
  #TEXTS
  RECORD_TYPE_OF_NEW_RECORD_TEXT = "Corporate" 
  JOB_TITLE_TEXT =  "JobTitle"
  PRIMARY_RECRUITER_TEXT = "Naomi Kihara"
  LOCATION_TEXT = "San Francisco, CA"
  DEPARTMENT_TEXT = "Dept ABC"
  MIN_SALARY_TEXT = "1000"
  MAX_SALARY_TEXT = "2000"
  
  

    
    #OTHER FIELDS
  REQUISITIONS_NEW_QUESTIONS_SET_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[3]/td[4]//span/input"
  REQUISITIONS_NEW_POST_JOB_BOX_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[2]/td[2]//input"
  
 #HARD CODE DATA
 REQUISITIONS_NEW_DATA_TITLE_TEXT = "Test Job TC827"
 REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT = "Naomi Kihara" 
 REQUISITIONS_NEW_DATA_LOCATION_TEXT = "San Francisco, CA" 
 REQUISITIONS_NEW_DATA_DEPARTMENT_TEXT = "Dept ABC"
 REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT = "2000"
 REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT = "4000" 

end