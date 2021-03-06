class BoardSetupHomePage
  
  NEW_BOARD_SETUP_BUTTON_XPATH = ".//*[@name='new']"
  FIRST_ELEMENT_BOARD_LIST_XPATH = ".//*[text()='Job Board Setup Name']/../following-sibling::*[1]//a"
  SECOND_ELEMENT_BOARD_LIST_XPATH = ".//*[text()='Job Board Setup Name']/../following-sibling::*[1]/following-sibling::*[1]//a"
  CAREERS_LINK_LIST_XPATH = ".//*[text()='Careers']"
  INTERNAL_LINK_LIST_XPATH = ".//*[text()='Change Jobs']"
  CAREERS_URL_XPATH = "https://na17.salesforce.com/a0Go00000080Tcp" # NO DELETE
  INTERNAL_URL = "https://na17.salesforce.com/a0Go000001Ij584"   # NO DELETE
  APPLY_MESSAGE_XPATH = ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]"

end