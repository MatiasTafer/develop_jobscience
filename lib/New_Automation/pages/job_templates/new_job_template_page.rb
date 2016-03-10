require 'securerandom'


class NewJobTemplate
  
  SAVE_BUTTON_XPATH = ".//*[@name='save']"
  SAVE_AND_NEW_BUTTON_XPATH = ".//*[@name='save_new']"
  CANCEL_BUTTON_XPATH = ".//*[@name='cancel']"
  JOB_TITLE_TEXT_XPATH = ".//*[@id='Name']"
  
  JOB_TEMPLATE_MAPPING_TEXT_XPATH = "//*[text()='Job Template Mapping']/../..//input"
  CUSTOMFIELD_TEXT_XPATH = "//*[text()='Customfield']/../..//input" 
  SOC_CODE_TEXT_XPATH = "//*[text()='SOC code']/../following-sibling::*//input"
  EEO_CODE_DROPDOWN_XPATH = "//*[text()='EEO Code']/../following-sibling::*//select"
  DESCRIPTION_TEXT_XPATH = "(//*[text()='Description'])[2]/../..//textarea"
  ESSENTIAL_DUTIES_AND_RESPONSIBILITIES_TEXT_XPATH = "//*[text()='Essential Duties & Responsibilities']/../..//textarea"
  EDUCATION_AND_EXPERIENCE_AVAILABLE_LIST_XPATH = "(//*[text()='Education and Experience']/../..//table//td)[3]"  
  EDUCATION_AND_EXPERIENCE_CHOSEN_LIST_XPATH = "(//*[text()='Education and Experience']/../..//table//td)[5]"
  SKILLS_AVAILABLE_LIST_XPATH = "(//*[text()='Skills']/../..//table//td)[3]"
  SKILLS_CHOSEN_LIST_XPATH = "(//*[text()='Skills']/../..//table//td)[5]"
  KNOWLEDGE_AVAILABLE_LIST_XPATH = "(//*[text()='Knowledge']/../..//table//td)[3]"
  KNOWLEDGE_CHOSEN_LIST_XPATH = "(//*[text()='Knowledge']/../..//table//td)[5]"
  ABILITIES_AVAILABLE_LIST_XPATH = "(//*[text()='Abilities']/../..//table//td)[3]"
  ABILITIES_CHOSEN_LIST_XPATH = "(//*[text()='Abilities']/../..//table//td)[5]"
  ACTIVITIES_AVAILABLE_LIST_XPATH = "(//*[text()='Activities']/../..//table//td)[3]"
  ACTIVITIES_CHOSEN_LIST_XPATH = "(//*[text()='Activities']/../..//table//td)[5]"
  INTERESTS_AVAILABLE_LIST_XPATH = "(//*[text()='Interests']/../..//table//td)[3]"
  INTERESTS_CHOSEN_LIST_XPATH = "(//*[text()='Interests']/../..//table//td)[5]"
  WORK_CONTEXT_AVAILABLE_LIST_XPATH = "(//*[text()='Work Context']/../..//table//td)[3]"
  WORK_CONTEXT_CHOSEN_LIST_XPATH = "(//*[text()='Work Context']/../..//table//td)[5]"
  WORK_STYLE_AVAILABLE_LIST_XPATH = "(//*[text()='Work Style']/../..//table//td)[3]"
  WORK_STYLE_CHOSEN_LIST_XPATH = "(//*[text()='Work Style']/../..//table//td)[5]"
  WORK_VALUES_AVAILABLE_LIST_XPATH = "(//*[text()='Work Values']/../..//table//td)[3]"
  WORK_VALUES_CHOASEN_LIST_XPATH = "(//*[text()='Work Values']/../..//table//td)[5]"
  
  ERROR_REQUIRED_FIELDS = ".//*[@class='errorMsg']"
  ERROR_REQUIRED_FIELDS_TEXT = "Error: You must enter a value"
  
  JOB_TEMPLATE_NAME_TEXT = SecureRandom.hex(5)
  JOB_TEMPLATE_MAPPING_TEXT = "Job 1 Mapping"
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end