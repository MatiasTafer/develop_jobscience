class NewStandardQuestion
  
  QUESTION_NAME= "Question1"
  QUESTION_LAYOUT_OPTION_NONE = "None"
  QUESTION_LAYOUT_OPTION_1 = "Above Answer"
  QUESTION_LAYOUT_OPTION_2 = "Below Answer"
  QUESTION_LAYOUT_OPTION_3 = "Left of Answer"
  QUESTION_LAYOUT_OPTION_4 = "Right of Answer"
  
  CONTACT_FIELD_OPTION_NONE = "None"
  CONTACT_FIELD_OPTION_1= "Account ID"
  
  QUESTION_SIZE_OPTION_NONE = "None"
  QUESTION_SIZE_OPTION_1 = "Small (255 or less)"
  QUESTION_SIZE_OPTION_2 = "Large (up to 10k)"
  QUESTION_SIZE_OPTION_3 = "Rich Text (up to 32k)"
  
  SAVE_BUTTON_XPATH = "(.//*[@value='Save'])[1]"
  
  
  
  SAVE_AND_NEW_BUTTON_XPATH = ".//*[@value='Save & New']"
  CANCEL_BUTTON_XPATH = ".//*[@value='Cancel']"
  CONTACT_FIELD_DROPDOWN_XPATH = "//*[text()[contains(., 'Contact Field')]]/../following-sibling::*//select"
  
  
  QUESTION_NAME_TEXT_FIELD_XPATH = "//*[text()='Question Name']/../following-sibling::*//input"
  
  
  QUESTION_SIZE_DROPDOWN_XPATH = "//*[text()='Question Size']/../following-sibling::*//select"
  QUESTION_TEXT_FIELD_XPATH = "(//*[text()[contains(., 'Question')]]/../..//textarea)[1]"
  
  
  
  QUESTION_LAYOUT_DROPDOWN_XPATH = "//*[text()='Question Layout']/../following-sibling::*//select"
  REQUIRED_BY_APPLICANT_CHECKBOX_XPATH = "//*[text()='Required By Applicant']/../following-sibling::*//input"
  ERROR_MESSAGE_XPATH = ".//*[@class='message errorM3']"
  
  
  
end