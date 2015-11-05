class LoginModal

  LOG_IN_MODAL_XPATH = ".//*[@class='modal-dialog modal-md']"
  EMAIL_FIELD_XPATH = ".//*[@name='email']"
  PASSWORD_FIELD_XPATH = ".//*[@name='password']"
  LOGIN_BUTTON_XPATH  = "//*[@type='submit']"
  CLOSE_MODAL_XPATH = ".//*[@class='modal-close']"
  FORGOT_PASSWORD_LINK_XPATH = ".//*[@class='help-block text-right small']/a"
  
  #error messages
  MISMATCH_MESSAGE_XPATH = ".//*[@class='form-message-block text-center text-danger']"
  PASSWORD_ERROR_MESSAGE_XPATH = ".//*[@ng-show='isPasswordInvalid()']"
  EMAIL_ERROR_MESSAGE_XPATH = ".//*[@ng-show='isEmailInvalid()']"
  MISMATCH_MESSAGE_TEXT = 'Invalid username or password'
  PASSWORD_ERROR_MESSAGE_TEXT = 'Please enter your password.'
  EMAIL_ERROR_MESSAGE_TEXT = 'Please enter a valid email address.'
  
  TEST_USER_EMAIL = 'testuser@testuser.com'
  TEST_USER_PASSWORD = 'testtest'
  
  #Info used by test_cart.rb 
  
  OTHER_USER_TEXT = "modernZola@gmail.com"
  OTHER_USER_PASSWORD_TEXT = "modernZola"
end