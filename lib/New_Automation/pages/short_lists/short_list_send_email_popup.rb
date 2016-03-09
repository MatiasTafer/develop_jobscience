class ShortListSendEmailPopup
  
  ADDITIONAL_TO_TEXT_XPATH = ".//a[contains(text(),'Additional To:')]/ancestor::tr/td/div/textarea"
  ADDITIONAL_TO_ICON_XPATH = ".//a[contains(text(),'Additional To:')]/ancestor::tr/td/a"
  CC_TEXT_XPATH = ".//a[contains(text(),'CC:')]/ancestor::tr/td/div/textarea"
  CC_ICON_XPATH = ".//a[contains(text(),'CC:')]/ancestor::tr/td/a"
  SUBJECT_TEXT_XPATH = ".//label[contains(text(),'Subject')]/ancestor::tr/td/div/input"
  RECORD_ATTACHMENT_XPATH = ".//*[contains(@class,'dataCell')]/input"
  SEND_BUTTON_XPATH = ".//*[@value='Send']"
  SELECT_TEMPLATE_BUTTON_XPATH = ".//*[@value='Select Template***']"
  CLOSE_SEND_EMAIL_XPATH = ".//*[@value='Close']"
  BCC_TEXT_XPATH = ".//a[contains(text(),'BCC:')]/ancestor::tr/td/div/textarea"
  
end