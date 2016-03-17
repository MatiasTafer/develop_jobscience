class ForwardPopup
  
  # Forward pop-up
  TO_ICON_ID = ".//label[contains(text(),'To')]/ancestor::tr[1]/td/div/span/a"
  TO_TEXT_XPATH = ".//*[contains(text(),'To')]/ancestor::tr[1]/td/div/span/input"
  SUBJECT_TEXT_XPATH = ".//label[contains(text(),'Subject')]/ancestor::tr[1]/td/div/input"
  
  CONTACT_TO_TEXT_XPATH = ".//*[contains(text(),'To')]/ancestor::tr[1]/td/div/span/input"
  CONTACT_SUBJECT_TEXT_XPATH = ".//label[contains(text(),'Subject')]/ancestor::tr[1]/td/div/input"
  
  ATTACHMENTS_CHECKBOX_XPATH = "(.//*[@type='checkbox'])[1]"
  CONTACT_ATTACHMENTS_CHECKBOX_XPATH = ".//*[@class='dataCell']/ancestor::tr[1]/td[1]/input"
  
  SEND_BUTTON_XPATH = ".//*[@value='Send']"
  SKIP_TO_EMAIL = ".//*[@value='Skip to Email']"
  RESUME_UPDATE_XPATH = ".//*[@value='Resume Update']"
  UPDATE_RESUME_XPATH = ".//*[@value='Update Resume']"
  ADD_RESUME_XPATH = ".//*[@value='Add Resume']"
  BROWSE_XPATH = ".//*[@type='file']"
  CLOSE_BUTTON_XPATH = ".//*[@value='Close']"
  CANCEL_BUTTON_XPATH = ".//*[@value='Cancel']"
  SELECT_TEMPLATE_BUTTON_XPATH = ".//input[@title='Select Template***']"
  CONTACT_SELECT_TEMPLATE_BUTTON_XPATH = ".//input[@title='Select Template***']"
  
  FIRST_ELEMENT_SELECT_TEMPLATE_XPATH = ".//*[contains(@class, 'dataCell')][1]/a"
  
  BCC_TEXT_XPATH = ".//*[contains(text(),'BCC')]/ancestor::tr[1]/td/div/textarea"
  BCC_EMAIL_CANDIDATE_XPATH = ".//*[contains(text(),'BCC')]/ancestor::tr[1]/td/div/textarea"
end