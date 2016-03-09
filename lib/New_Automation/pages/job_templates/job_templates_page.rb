class JobTemplates
  
  NEW_BUTTON_XPATH = ".//*[@name='new']"
  FIRST_JOB_TEMPLATE_IN_LIST_XPATH = "(//*[text()='Job Title']/../..//tr//a)[1]"
  CREATE_JOB_ORDER_BUTTON_XPATH = ".//*[@title='Create Job Order']"
  NEXT_BUTTON_XPATH = "(.//*[@value='Next'])[1]"
  PRIMARY_RECRUITER_TEXT_FIELD_XPATH = "//*[text()='Primary Recruiter']/../following-sibling::*//input"
  
  ERROR_REQUIRED_FIELD_XPATH = ".//*[@class='errorMsg']"
  ERROR_REQUIRED_FIELD_TEXT = "Error: You must enter a value"
end