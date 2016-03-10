class ProjectsNewProject
  
  PROJECT_NAME = "ProjectName1"
  CURRENCY_INVALID_VALUE = "invalidCurrency"
  DATE_INVALID_VALUE = "invalidDate"
  
  
  
  #BUTTONS
  PROJECTS_NEW_PROJECT_BTN_SAVE_XPATH = ".//*[@name='save']"
  PROJECTS_NEW_PROJECT_BTN_SAVE_AND_NEW_XPATH = "(.//*[@value='Save & New'])[1]"
  PROJECTS_NEW_PROJECT_BTN_CANCEL_XPATH = "(.//*[@title='Cancel'])[1]"
  
  #REQUIRED FIELDS
  PROJECTS_NEW_PROJECT_NAME_ID = "Name"
 
  #CURRENCY FIELDS
  PROJECTS_NEW_BUDGET_XPATH = "//*[text()='Budget']/../following-sibling::*//input"
  
  #DATE FIELDS
  PROJECTS_NEW_START_DATE_XPATH = "//*[text()='Start Date']/../following-sibling::*//input"
  
  #ERRORS
  ERROR = ".//*[@class='errorMsg']"
  
  #ERROR TEXTS
  INVALID_CURRENCY_ERROR = "Error: Invalid currency"
  REQUIRED_FIELD_ERROR = "Error: You must enter a value"
  INVALID_DATE_ERROR = "Error: Invalid Date"
end