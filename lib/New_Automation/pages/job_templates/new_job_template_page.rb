require 'securerandom'


class NewJobTemplate
  
  SAVE_BUTTON_XPATH = "(.//*[@class='pbButton']//*[@class='btn'])[1]"
  SAVE_AND_NEW_BUTTON_XPATH = "(.//*[@class='pbButton']//*[@class='btn'])[2]"
  CANCEL_BUTTON_XPATH = "(.//*[@class='pbButton']//*[@class='btn'])[3]"
  JOB_TITLE_TEXT_XPATH = ".//*[@id='Name']"
  JOB_TEMPLATE_MAPPING_TEXT_XPATH = ".//*[@class='lookupInput']/input"
  CUSTOMFIELD_TEXT_XPATH = ".//*[@class='dataCol last col02']/input"
  SOC_CODE_TEXT_XPATH = ".//*[@class='dataCol']/input"
  EEO_CODE_DROPDOWN_XPATH = "(.//*[@class='dataCol'])[2]/span"
  DESCRIPTION_TEXT_XPATH = "(.//*[@class='last data2Col'])[1]/textarea"
  ESSENTIAL_DUTIES_AND_RESPONSIBILITIES_TEXT_XPATH = "(.//*[@class='last data2Col'])[2]/textarea"
  EDUCATION_AND_EXPERIENCE_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[1]/td)[1]"
  EDUCATION_AND_EXPERIENCE_CHOSEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[1]/td)[3]"
  SKILLS_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[2]/td)[1]"
  SKILLS_CHOSEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[2]/td)[3]"
  KNOWLEDGE_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[3]/td)[1]"
  KNOWLEDGE_CHOSEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[3]/td)[3]"
  ABILITIES_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[4]/td)[1]"
  ABILITIES_CHOSEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[4]/td)[3]"
  ACTIVITIES_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[5]/td)[1]"
  ACTIVITIES_CHOSEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[5]/td)[3]"
  INTERESTS_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[6]/td)[1]"
  INTERESTS_CHOSEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[6]/td)[3]"
  WORK_CONTEXT_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[7]/td)[1]"
  WORK_CONTEXT_CHOSEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[7]/td)[3]"
  WORK_STYLE_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[8]/td)[1]"
  WORK_STYLE_CHOSEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[8]/td)[3]"
  WORK_VALUES_AVAILABLE_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[9]/td)[1]"
  WORK_VALUES_CHOASEN_LIST_XPATH = "((.//*[@class='multiSelectPicklistRow'])[9]/td)[3]"
  
  ERROR_REQUIRED_FIELDS = ".//*[@id='ep']/div[2]/div[3]/table/tbody/tr[1]/td[2]/div/div[2]"
  ERROR_REQUIRED_FIELDS_TEXT = "Error: You must enter a value"
  
  JOB_TEMPLATE_NAME_TEXT = SecureRandom.hex(5)
  JOB_TEMPLATE_MAPPING_TEXT = "Job 1 Mapping"
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end