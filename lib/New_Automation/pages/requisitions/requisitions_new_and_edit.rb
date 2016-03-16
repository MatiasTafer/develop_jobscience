require 'securerandom'

class RequisitionsNewAndEdit
  
  #FIRST STEP
  REQUISITIONS_NEW_RECORD_TYPE_ID = "p3"
  REQUISITIONS_NEW_BTN_CONTINUE_XPATH = ".//*[@value='Continue']"
  REQUISITIONS_NEW_BTN_CANCEL_XPATH = ".//*[@name='cancel']"
  
  #SECOND STEP
  
    #BUTTONS
  REQUISITIONS_NEW_BTN_SAVE_XPATH = ".//*[@name='save']"
  REQUISITIONS_NEW_BTN_SAVE_AND_NEW_XPATH = ".//*[@name='save_new']"
  REQUISITIONS_NEW_BTN_CANCEL_2_XPATH = ".//*[@name='cancel']"
    
    #REQUIRED FIELDS
  REQUISITIONS_NEW_JOB_TITLE_ID = "Name"
  REQUISITIONS_NEW_JOB_TITLE_XPATH =".//*[@id='Name']"
  REQUISITIONS_NEW_PRIMARY_RECRUITER_TYPE_XPATH = ".//*[text()='Primary Recruiter']/../following-sibling::*[1]//select"
  REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH = ".//*[text()='Primary Recruiter']/../following-sibling::*[1]//span/input"
  REQUISITIONS_NEW_LOCATION_XPATH = ".//*[text()='Location']/../following-sibling::*[1]//select"
  REQUISITIONS_NEW_MIN_SALARY_XPATH = ".//*[text()='Min Salary']/../../following-sibling::*[1]//input"
  REQUISITIONS_NEW_MAX_SALARY_XPATH = ".//*[text()='Max Salary']/../../following-sibling::*[1]//input"
  REQUISITIONS_NEW_DEPARTAMENT_XPATH = ".//*[text()='Department']/../following-sibling::*[1]//select"
  REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH = ".//*[text()='Department']/../following-sibling::*[1]//select/option[2]"
  REQUISITIONS_NEW_BTN_SAVE_EDIT_XPATH = ".//*[@name='save']"
  REQUISITIONS_JOBS_PROJECTS_FIELD_XPATH = ".//*[text()='Jobs/Projects']/../following-sibling::*[1]//select"
  
  
  REQUISITIONS_CLIENT_FIELD_XPATH = ".//*[text()='Client']/../following-sibling::*[1]//span/input"
  
  REQUISITIONS_CONTACT_FIELD_XPATH = ".//*[text()='Contact']/../following-sibling::*[1]//span/input"
  
  REQUISITIONS_HIRING_MANAGER_XPATH = ".//*[text()='Hiring Manager']/../following-sibling::*[1]//input"
  REQUISITIONS_DISABLE_EEO_CHECKBOX_XPATH = ".//*[text()='Disable EEO']/../following-sibling::*[1]//input"
  
    #DATE FIELDS
  REQUISITIONS_NEW_DATE_POSTED_XPATH = ".//*[text()='Date Posted']/../following-sibling::*[1]//input"
  REQUISITIONS_NEW_EXPIRATION_DATE_XPATH = ".//*[text()='Expiration Date']/../following-sibling::*[1]//input"
  REQUISITIONS_NEW_DATE_CLOSED_XPATH = ".//*[text()='Date Closed']/../following-sibling::*[1]//input"
  REQUISITIONS_NEW_ESTIMATED_END_DATE_XPATH = ".//*[text()='Estimated End Date']/../../following-sibling::*[1]//input"
  
    #NUMBER FIELDS
  REQUISITIONS_NEW_OPENINGS_XPATH = ".//*[text()='Openings']/../following-sibling::*[1]//input"
  REQUISITIONS_NEW_PASSING_SCORE_XPATH = ".//*[text()='Passing Score']/../following-sibling::*[1]//input"

  #HARD CODE DATA
  RECORD_TYPE_OF_NEW_RECORD_TEXT = "Corporate" 
  RECORD_TYPE_OF_NEW_RECORD_TEXT_2 = "Internship"
  JOB_TITLE_TEXT =  "JobTitle"
  PRIMARY_RECRUITER_TEXT = "Martin Da Silva"
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
  REQUISITION_NAME = SecureRandom.hex(5)
  DATE_WRONG_TEXT = "WrongDate"
    
  #OTHER FIELDS
  REQUISITIONS_NEW_QUESTIONS_SET_XPATH = ".//*[text()='Question Set']/../following-sibling::*[1]//span/input"
  REQUISITIONS_NEW_POST_JOB_BOX_XPATH = ".//*[text()='Post Job']/../following-sibling::*[1]//input"
  REQUISITION_TRAVEL_FIELD_XPATH = ".//*[text()='Travel']/../../following-sibling::*[1]//input"
  
  #HARD CODE DATA
  REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT = "Naomi Kihara" 
  REQUISITIONS_NEW_DATA_LOCATION_TEXT = "San Francisco, CA" 
  REQUISITIONS_NEW_DATA_DEPARTMENT_TEXT = "Dept ABC"
  REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT = "2000"
  REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT = "4000" 
  
  # SECTION JOB POSTING DETAILS
  QUESTION_SET_TEXT_XPATH = ".//*[text()='Question Set']/../following-sibling::*[1]//span/input"
  REQUISITIONS_BTN_SAVE_XPATH = ".//*[@name='save']"
   
  # CLIENTS DETAILS
  CONTACT_TEXT_XPATH = ".//*[text()='Contact']/../following-sibling::*[1]//span/input"
     
  #ERROR
  ERROR_MESSAGE_FIELD_XPATH = ".//*[@class='errorMsg']"
   
  #ERROR TEXTS
  ERROR_REQUIRED_FIELDS_TEXT = "Error: You must enter a value"
  ERROR_INVALID_CURRENCY_TEXT = "Error: Invalid currency"
  ERROR_INVALID_NUMBER_TEXT = "Error: Invalid number"
  ERROR_INVALID_PERCENT_TEXT = "Error: Invalid percent"
  ERROR_INVALID_DATE_TEXT = "Error: Invalid Date" 
 
end