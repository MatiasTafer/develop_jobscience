class CreateRegistryModal
  
  #Your Info
  FIRST_NAME_ID = "your-first"
  LAST_NAME_ID  = "your-last"
  BRIDE_CLASS   = ".//*[@id='your-toggle']//*[@class='icon icon-bride']"
  GROOM_CLASS   = ".//*[@id='your-toggle']/*[@class='toggle-option groom-opt last']"
  
  #Your Partner
  FIANCEE_NAME_ID = "fiancee-first"
  FIANCEE_LAST_ID = "fiancee-last"
  FIANCEE_BRIDE_CLASS = ".//*[@id='fiancee-toggle']/*[@class='toggle-option bride-opt first']"
  FIANCEE_GROOM_CLASS = ".//*[@id='fiancee-toggle']/*[@class='toggle-option groom-opt last']"
  
  FIANCEE_EMAIL_ID = "fiancee-email"
  URL_ID  = "url"
  DATE_ID   = "date"
  NO_DATE   = "no-date"
  
  #Buttons
  SKIP_ID = "skip"
  CREATE_REGISTRY_CLASS = ".//*[@class='button teal big']"
  
  #error messages
  ERROR_MESSAGE_YOUR_NAME_ID    = "your-first-error"
  ERROR_MESSAGE_YOUR_LAST_ID    = "your-last-error"
  ERROR_MESSAGE_YOUR_TYPE_ID    = "your_type-error"
  ERROR_MESSAGE_YOUR_INFO_ID    = "Please enter your full name and bride or groom"
  
  ERROR_MESSAGE_FIANCEE_NAME_ID = "fiancee-first-error"
  ERROR_MESSAGE_FIANCEE_LAST_ID = "fiancee-last-error"
  ERROR_MESSAGE_FIANCEE_TYPE_ID = "fiancee_type-error"
  ERROR_MESSAGE_FIANCEE_INFO_ID = "Please enter your fiancee's full name and bride or groom."
  
  ERROR_MESSAGE_DATE_ID         = "date-error"
  ERROR_MESSAGE_DATE_INFO_ID    = "Please enter a valid future date."
  ERROR_MESSAGE_URL_ID          = "url-error"
  ERROR_MESSAGE_URL_INFO_ID     = "Please choose a url for your wedding"
  ERROR_MESSAGE_URL_EXISTING    = "That url is already taken. Sorry!"
  
  #Welcome modal displayed after you create a registry
  WELCOME_LABEL               = ".//*[@class='title']"
  WELCOME_START_BUTTON_CLASS  = ".//*[@class='button big primary']"
  WELCOME_SKIP_LINK           = ".//*[@class='edit-registry-link']"
  
end