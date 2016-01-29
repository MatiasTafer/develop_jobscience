class SignupModal
  
  EMAIL_TEXTBOX_XPATH = ".//*[@name='email']"
  PASSWORD_TEXTBOX_XPATH = ".//*[@name='password']"
  GLYPHICON_EMAIL_XPATH = ".//*[@ng-show='isEmailValid()']"
  GLYPHICON_PASS_XPATH = ".//*[@ng-show='isPasswordValid()']"
  BUTTON_SUBMIT_XPATH = ".//*[@class='btn btn-primary btn-lg btn-block']"
  ERROR_MESSAGE_EMAIL_XPATH = ".//*[@ng-show='getEmailMessage()']"
  ERROR_TEXT_MESSAGE_XPATH = 'Please enter a valid email address.'
  EXISTING_ACCOUNT_ERROR_TEXT_XPATH = 'That email address is taken.'
  ERROR_MESSAGE_PASSWORD_XPATH = ".//*[@ng-show='isPasswordInvalid()']"
  ERROR_MESSAGE_PASSWORD_TEXT = 'Password must be at least 8 characters long.'
  
end