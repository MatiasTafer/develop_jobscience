class LoginPage

  NAME_TEXT_FIELD_ID ="username"
  PASSWORD_TEST_FIELD_ID ="password"
  LOGIN_BUTTON_ID = "Login"
  
  # job board login
  USERNAME_TEXT_XPATH = ".//*[text()[contains(., 'Username')]]/../..//input"
  PASSWORD_TEXT_XPATH = ".//*[text()[contains(., 'Password')]]/../..//input"
  LOGIN_BUTTON_XPATH = ".//*[@value='Login']"
  
end