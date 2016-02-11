class ProjectsNewProject
  
  PROJECT_NAME = "ProjectName1"
  CURRENCY_INVALID_VALUE = "invalidCurrency"
  DATE_INVALID_VALUE = "invalidDate"
  
  
  
  #BUTTONS
  PROJECTS_NEW_PROJECT_BTN_SAVE_XPATH = ".//*[@name='save']"
  PROJECTS_NEW_PROJECT_BTN_SAVE_AND_NEW_XPATH = ".//*[@id='topButtonRow']//*[@name='save_new']"
  PROJECTS_NEW_PROJECT_BTN_CANCEL_XPATH = ".//*[@id='topButtonRow']//*[@name='cancel']"
  
  #REQUIRED FIELDS
  PROJECTS_NEW_PROJECT_NAME_ID = "Name"
 
  #CURRENCY FIELDS
  PROJECTS_NEW_BUDGET_XPATH = ".//*[@class='detailList']/tbody/tr[3]/td[4]/input"
  
  #DATE FIELDS
  PROJECTS_NEW_START_DATE_XPATH = ".//*[@class='detailList']/tbody/tr[2]/td[4]//input"
  
  #ERRORS
  ERROR = ".//*[@class='errorMsg']"
  
  #ERROR TEXTS
  INVALID_CURRENCY_ERROR = "Error: Invalid currency"
  REQUIRED_FIELD_ERROR = "Error: You must enter a value"
  INVALID_DATE_ERROR = "Error: Invalid Date"
end