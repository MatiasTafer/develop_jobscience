class ForgotPasswordModal
  
  #TEXTBOX
  EMAIL_TEXTBOX_XPATH = ".//*[@name='email']"
  
  #BUTTON
  SUBMIT_BUTTON_XPATH = ".//*[@type='submit']"
  
  #ERROR MESSAGE
  ERROR_MESSAGE_XPATH = ".//*[@class='form-message-block text-center text-danger']"
  ERROR_MESSAGE_TEXT = "Oops! We couldn't find that email address."
  EMPTY_EMAIL_ERROR_XPATH = ".//*[@class='help-block error-block']"
  EMPTY_EMAIL_ERROR_TEXT = "Please enter a valid email address."
end