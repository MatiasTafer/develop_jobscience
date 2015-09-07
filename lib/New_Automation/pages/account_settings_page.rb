class AccountSettingsPage
  
  #Left menu option
  REGISTRY_SETTINGS_BUTTON_ID = "basicInformationLink"
  
  #Fields
  YOUR_FIRST_NAME_ID = "your-first"
  YOUR_LAST_NAME_ID = "your-last"
  PARTNER_FIRST_NAME_ID = "fiancee-first"
  PARTNER_LAST_NAME_ID = "fiancee-last"
  NO_DECIDED_WEDDING_ID = "no-date"
  WEDDING_DATE_ID = "date"
  REGISTRY_TITLE_XPATH = ".//*[@name='registry_name']"
  WELCOME_GREETING_XPATH = ".//*[@name='registry_greeting']"
  OK_MESSAGE_ID = "humaneMessage"
  
  #Button 
  SAVE_BUTTON_XPATH = ".//*[@type='submit']"
  
  #Hardcode info
  FIRST_NAME_TEXT = "Carlos"
  LAST_NAME_TEXT = "Aguiar"
  PARTNER_FIRST_TEXT = "Carla"
  PARTNER_LAST_TEXT = "Lopez"
  DATE_TEXT = "10/10/2020"
  TITLE_TEXT = "Hello world"
  GREETING_TEXT = "Much thanks to everybody, buy everything"
  WEDDING_INVALID_DATE = "12356897"
  
  #Error messages
    #Your Info
    YOUR_INFO_FIRST_ERROR_ID = "registry-settings-info-form-your_first"
    YOUR_INFO_LAST_ERROR_ID = "registry-settings-info-form-your_last"
    YOUR_INFO_ERROR_MESSAGE = "Please enter your full name and bride or groom"
    #Your partner
    PARTNER_INFO_FIRST_ERROR_ID = "registry-settings-info-form-fiancee_first"
    PARTNER_INFO_LAST_ERROR_ID = "registry-settings-info-form-fiancee_last"
    PARTNER_ERROR_MESSAGE = "Please enter your fiancee's full name and bride or groom."
    #Wedding date
    WEDDING_ERROR_ID = "registry-settings-info-form-date"
    WEDDING_ERROR_MESSAGE = "Please select a date or check 'Haven't decided yet'."
    WEDDING_CALENDAR_ID = "ui-datepicker-div"
    WEDDING_INVALID_MESSAGE = "Please enter a valid date."
    #Registry title
    REGISTRY_TITLE_ERROR_ID = "registry-settings-info-form-registry_name"
    REGISTRY_TITLE_ERROR_MESSAGE = "Please choose a title for your registry."
end