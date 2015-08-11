class LoginModal

  LOG_IN_MODAL_XPATH = ".//*[@class='modal-dialog modal-md']"
  EMAIL_FIELD_XPATH = ".//*[@name='email']"
  PASSWORD_FIELD_XPATH = ".//*[@name='password']"
  LOGIN_BUTTON_XPATH  = "//*[@type='submit']"
  CLOSE_MODAL_XPATH = ".//*[@class='modal-close']"
  
  #error messages
  MISMATCH_MESSAGE_XPATH = ".//*[@class='form-message-block text-center text-danger']"
  PASSWORD_ERROR_MESSAGE_XPATH = ".//*[@ng-show='isPasswordInvalid()']"
  EMAIL_ERROR_MESSAGE_XPATH = ".//*[@ng-show='isEmailInvalid()']"
  
end