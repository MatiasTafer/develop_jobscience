class SignupModal
  
  EMAIL_TEXTBOX_XPATH = ".//*[@name='email']"
  PASSWORD_TEXTBOX_XPATH = ".//*[@name='password']"
  GLYPHICON_EMAIL_XPATH = "(.//*[@class='glyphicon glyphicon-ok form-control-feedback'])[1]"
  GLYPHICON_PASS_XPATH = "(.//*[@class='glyphicon glyphicon-ok form-control-feedback'])[2]"
  BUTTON_SUBMIT_XPATH = ".//*[@class='btn btn-primary btn-lg btn-block']"
  ERROR_MESSAGE_XPATH = "(.//*[@class='help-block error-block'])[1]"
  ERROR_TEXT_MESSAGE_XPATH = 'Please enter a valid email address.'
  EXISTING_ACCOUNT_ERROR_TEXT_XPATH = 'That email address is taken.'
  ERROR_MESSAGE_PASSWORD_XPATH = ".//*[@class='help-block error-block']"
  ERROR_MESSAGE_PASSWORD_TEXT = 'Password must be at least 8 characters long.'
  
end