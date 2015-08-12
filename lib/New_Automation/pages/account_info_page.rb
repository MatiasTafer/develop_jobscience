class AccountInfoPage
  
  #YOUR INFORMATION
  EMAIL_FIELD_XPATH = ".//*[@name='email']"
  PASSWORD_FIELD_XPATH = ".//*[@name='password']"
  FIRST_NAME_FIELD_XPATH = ".//*[@name='first_name']"
  LAST_NAME_FIELD_XPATH = ".//*[@name='last_name']"
  MESSAGE_ID = "humaneMessage"
  INFORMATION_CHANGED_SUCCESSFULLY_TEXT = 'Account information updated.'
  
  #CHANGE PASSWORD
  CHANGE_PASSWORD_LINK_ID       = "changePasswordLink"
  CURRENT_PASSWORD_FIELD_XPATH  = "//*[@name='current_password']"
  NEW_PASSWORD_FIELD_XPATH      = "//*[@name='new_password']"
  VERIFY_PASSWORD_FIELD_XPATH   = "//*[@name='verify_password']"
  SAVE_CHANGES_BUTTON_XPATH     = "//*[@class='button teal big']"
  
  #error messages
  NEW_PASSWORD_ERROR_ID       = "change-pw-form-new_password"
  VERIFY_PASSWORD_ERROR_ID    = "change-pw-form-verify_password"
  MISMATCH_MESSAGE_XPATH      = ".//*[@class='form-message-block text-center text-danger']"
  NEW_PASSWORD_ERROR_TEXT     = "Your password must be at least 8 characters long."
  MISMATCH_MESSAGE_TEXT       = 'Invalid username or password'
  VERIFY_PASSWORD_ERROR_TEXT  = 'Your passwords do not match.'
  CURRENT_PASSWORD_ERROR_TEXT = 'Invalid current password'
  CHANGE_PASSWORD_SUCCESSFULLY_TEXT = 'Password changed.'
  
  #ORDERS YOU'VE PLACED
  
  #EMAIL NOTIFICATIONS
  
  #ZOLA CREDITS
  
end