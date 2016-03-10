class ApplicationsHomePage
  
  APPLICATION_OPTION_BAR_XPATH = ".//*[@class='piped']/../.."
  FIRST_APPLICATION_ON_TABLE_XPATH = "(.//span[text()[contains(.,'APP-')]])[1]/.."
  FIRST_APPLICATION_CHECKBOX_XPATH = "(.//span[text()[contains(.,'APP-')]])[1]/../../../..//*[@name='ids']"
  FIRST_APPLICATION_RECORD_LIST_XPATH = "(.//*[@class='x-grid3-row-table']/child::tbody/child::tr/child::td/child::div)[4]"
  LABEL_APPLICATION_XPATH = ".//div[text()='Application']"
  SEND_MAIL_MASS_BUTTON_XPATH = ".//*[@value='Send Email']"
  
end