class ShortListReviewEmailPopup
  
  STANDART_CHECKBOX_XPATH = ".//label[contains(text(),'Standard')]/ancestor::td[1]/input"
  STAFFING_CHECKBOX_XPATH = ".//label[contains(text(),'Staffing')]/ancestor::td[1]/input"
  SUBJECT_TEXT_XPATH = ".//label[contains(text(),'Subject')]/ancestor::tr/td/div/input"
  SUBJECT_TEXT_REVIEW_EMAIL_XPATH = ".//label[contains(text(),'Subject')]/ancestor::tr/td/div/input"
  SEND_EMAIL_BUTTON_XPATH = ".//*[@value='Send Email']"
  SELECT_TEMPLATE_BUTTON_XPATH = ".//*[@value='Select Template***']"
  ADD_CANDIDATE_BUTTON_XPATH = ".//*[@value='Add Candidate']"
  TO_USER_TEXT_XPATH = ".//label[contains(text(),'To User:')]/ancestor::tr/td/div/span/input"
  TO_USER_ICON_XPATH = ".//label[contains(text(),'To User:')]/ancestor::tr/td/div/span/a"
  
  TO_CONTACT_TEXT_XPATH = ".//label[contains(text(),'To Contact:')]/ancestor::tr/td/div/span/input"
  TO_CONTACT_ICON_XPATH = ".//label[contains(text(),'To Contact:')]/ancestor::tr/td/div/span/a"
  
  SUBJECT_TEXT_XPATH = ".//label[contains(text(),'Subject')]/ancestor::tr/td/div/input"
  RECORD_ATTACHMENTS_XPATH = ".//*[@class='dataCell'][1]/input[1]"
  ATTACHMENT_CHECKBOX_XPATH = ".//*[@class='dataCell'][1]/input[1]"
  
  CONTACT_ADD_CANDIDATE_XPATH = ".//label[contains(text(),'Contact')]/ancestor::tr/child::td/div/span/input"
  ADD_TO_REVIEW_XPATH = ".//*[@value='Add to Review']"
  
end