class ShortListReviewEmailPopup
  
  STANDART_CHECKBOX_XPATH = "(.//*[@type='radio'])[1]"
  STAFFING_CHECKBOX_XPATH = "(.//*[@type='radio'])[2]"
  SUBJECT_TEXT_REVIEW_EMAIL_XPATH = "(.//*[@class='requiredInput'])[2]/input"
  SEND_EMAIL_BUTTON_XPATH = ".//*[@title='Send Email']"
  SELECT_TEMPLATE_BUTTON_XPATH = ".//*[@value='Select Template***']"
  #Staffling
  ADD_CANDIDATE_BUTTON_XPATH = ".//*[@title='Add Candidate']"
  
  #Standard
  TO_USER_TEXT_XPATH = ".//*[@class='requiredInput']/span/input"
  TO_USER_ICON_XPATH = ".//*[@class='requiredInput']//a"
  
  TO_CONTACT_TEXT_XPATH = ".//*[@class='requiredInput']/span/input"
  TO_CONTACT_ICON_XPATH = ".//*[@class='requiredInput']//a"
  
  SUBJECT_TEXT_XPATH = "//*[text()[contains(.,'Subject')]]/../../td//input"
  RECORD_ATTACHMENTS_XPATH = "(.//*[@type='checkbox'])[1]"
  ATTACHMENT_CHECKBOX_XPATH = "(.//*[@type='checkbox'])[1]"
  
  CONTACT_ADD_CANDIDATE_XPATH = ".//*[@class='lookupInput']//input"
  ADD_TO_REVIEW_XPATH = ".//*[@title='Add to Review']"
  
end