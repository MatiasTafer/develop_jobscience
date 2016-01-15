class AccountInfoPage
  
  #YOUR INFORMATION
  YOUR_INFORMATION_LINK_ID = "yourInformationLink"
  EMAIL_FIELD_XPATH = ".//*[@name='email']"
  PASSWORD_FIELD_XPATH = ".//*[@name='password']"
  FIRST_NAME_FIELD_XPATH = ".//*[@name='firstName']"
  LAST_NAME_FIELD_XPATH = ".//*[@name='lastName']"
  SUCCESS_MESSAGE_XPATH = ".//*[@class='humane humane-zola-success humane-animate']"
  ERROR_MESSAGE_XPATH = ".//*[@class='humane humane-zola-error humane-animate']"
  
  #CHANGE PASSWORD
  CHANGE_PASSWORD_LINK_ID       = "changePwLink"
  CURRENT_PASSWORD_FIELD_XPATH  = "//*[@name='currentPassword']"
  NEW_PASSWORD_FIELD_XPATH      = "//*[@name='newPassword']"
  VERIFY_PASSWORD_FIELD_XPATH   = "//*[@name='verifyNewPassword']"
  SAVE_CHANGES_BUTTON_XPATH     = "//*[@class='btn btn-primary btn-md']"
  
  #Change Password error messages
  NEW_PASSWORD_ERROR_XPATH    = "//*[@ng-show='changePw.isNewPasswordInvalid()']"
  VERIFY_PASSWORD_ERROR_XPATH    = "//*[@ng-show='changePw.isVerifyNewPasswordInvalid()']"
  MISMATCH_MESSAGE_XPATH      = ".//*[@class='form-message-block text-center text-danger']"
  NEW_PASSWORD_ERROR_TEXT     = "New password must be at least 8 characters long."
  MISMATCH_MESSAGE_TEXT       = 'Invalid username or password'
  VERIFY_PASSWORD_ERROR_TEXT  = 'Must match new password.'
  CURRENT_PASSWORD_ERROR_TEXT = 'Incorrect current password.'
  CHANGE_PASSWORD_SUCCESSFULLY_TEXT = 'Your password has been changed'
  
  #Your Information error messages
  FIRST_NAME_ERROR_XPATH = "//*[@ng-show='accountInfo.isFirstNameInvalid()']"
  LAST_NAME_ERROR_XPATH = "//*[@ng-show='accountInfo.isLastNameInvalid()']"  
  EMAIL_ERROR_XPATH = "//*[@ng-show='accountInfo.getEmailMessage()']"
  INFORMATION_CHANGED_SUCCESSFULLY_TEXT = 'Your information has been updated'
  BLANK_FIELD_ERROR_TEXT = 'This field is required.'
  INVALID_EMAIL_ERROR_TEXT = 'Please enter a valid email address.'
  EMAIL_EXISTS_ERROR_TEXT = 'Oops, something went wrong. Please try again or contact customer support for assistance.'
  #It used to be 'Could not update account information. Please try again.'
  
  #ORDERS YOU'VE PLACED
  
  #EMAIL NOTIFICATIONS
  
  #ZOLA CREDITS
  
end