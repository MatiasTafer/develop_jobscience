class AccountInfoPage
  
  #YOUR INFORMATION
  YOUR_INFORMATION_LINK_ID = "yourInformationLink"
  EMAIL_FIELD_XPATH = ".//*[@name='email']"
  PASSWORD_FIELD_XPATH = ".//*[@name='password']"
  FIRST_NAME_FIELD_XPATH = ".//*[@name='first_name']"
  LAST_NAME_FIELD_XPATH = ".//*[@name='last_name']"
  MESSAGE_ID = "humaneMessage"
  
  #CHANGE PASSWORD
  CHANGE_PASSWORD_LINK_ID       = "changePasswordLink"
  CURRENT_PASSWORD_FIELD_XPATH  = "//*[@name='current_password']"
  NEW_PASSWORD_FIELD_XPATH      = "//*[@name='new_password']"
  VERIFY_PASSWORD_FIELD_XPATH   = "//*[@name='verify_password']"
  SAVE_CHANGES_BUTTON_XPATH     = "//*[@class='button teal big']"
  
  #Change Password error messages
  NEW_PASSWORD_ERROR_ID       = "change-pw-form-new_password"
  VERIFY_PASSWORD_ERROR_ID    = "change-pw-form-verify_password"
  MISMATCH_MESSAGE_XPATH      = ".//*[@class='form-message-block text-center text-danger']"
  NEW_PASSWORD_ERROR_TEXT     = "Your password must be at least 8 characters long."
  MISMATCH_MESSAGE_TEXT       = 'Invalid username or password'
  VERIFY_PASSWORD_ERROR_TEXT  = 'Your passwords do not match.'
  CURRENT_PASSWORD_ERROR_TEXT = 'Invalid current password'
  CHANGE_PASSWORD_SUCCESSFULLY_TEXT = 'Password changed.'
  
  #Your Information error messages
  FIRST_NAME_ERROR_ID = 'account-info-form-first_name'
  LAST_NAME_ERROR_ID = 'account-info-form-last_name'  
  EMAIL_ERROR_ID = 'account-info-form-email'
  INFORMATION_CHANGED_SUCCESSFULLY_TEXT = 'Account information updated.'
  BLANK_FIELD_ERROR_TEXT = 'This field is required.'
  INVALID_EMAIL_ERROR_TEXT = 'Please enter a valid email address.'
  EMAIL_EXISTS_ERROR_TEXT = 'Could not update account information. Please try again.'
  
  #ORDERS YOU'VE PLACED
  
  #EMAIL NOTIFICATIONS
  
  #ZOLA CREDITS
  
end