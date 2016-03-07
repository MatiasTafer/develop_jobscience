class ApplicationsHomePage
  
  APPLICATION_OPTION_BAR_XPATH = ".//*[@class='linkBar brandSecondaryBrd']"
  FIRST_APPLICATION_ON_TABLE_XPATH = "(.//*[@class='x-grid3-row-table'])[1]//td[4]//a"
  FIRST_APPLICATION_CHECKBOX_XPATH = "(.//*[@class='x-grid3-row-table'])[1]//td[1]//input"
  FIRST_APPLICATION_RECORD_LIST_XPATH = "(.//*[@class='x-grid3-row-table']/child::tbody/child::tr/child::td/child::div)[4]"
  LABEL_APPLICATION_XPATH = "((.//*[@class='x-grid3-hd-row']/child::td)[4])/child::div"
  SEND_MAIL_MASS_BUTTON_XPATH = ".//*[@value='Send Email']"
  
end