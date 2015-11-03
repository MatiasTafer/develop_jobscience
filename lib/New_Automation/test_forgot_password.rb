require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'

require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'
require_relative './pages/forgot_password_modal.rb'

class ForgotPasswordTest < TestBasic
  

  #Try to reset your password using an unregistered email (TC1424)
  def test_usingUnregisteredEmail
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => LoginModal::FORGOT_PASSWORD_LINK_XPATH).displayed?
    }
    #Go to forgot password modal
    $browser.find_element(:xpath => LoginModal::FORGOT_PASSWORD_LINK_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ForgotPasswordModal::EMAIL_TEXTBOX_XPATH).displayed?
    }
    #Once on forgot password modal, complete the email textbox with a not registered email
    $browser.find_element(:xpath => ForgotPasswordModal::EMAIL_TEXTBOX_XPATH).send_keys "notregistered@notregistered.com"
    $browser.find_element(:xpath => ForgotPasswordModal::SUBMIT_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => ForgotPasswordModal::ERROR_MESSAGE_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath => ForgotPasswordModal::ERROR_MESSAGE_XPATH).text, ForgotPasswordModal::ERROR_MESSAGE_TEXT)
  end

  
  #Verify email, error message (TC1430)
  def test_emailValidations
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => LoginModal::FORGOT_PASSWORD_LINK_XPATH).displayed?
    }
    #Go to forgot password modal
    $browser.find_element(:xpath => LoginModal::FORGOT_PASSWORD_LINK_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ForgotPasswordModal::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    #Click on submit button without complete the email textbox
    $browser.find_element(:xpath => ForgotPasswordModal::SUBMIT_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => ForgotPasswordModal::EMPTY_EMAIL_ERROR_XPATH)
    }
    assert_equal($browser.find_element(:xpath => ForgotPasswordModal::EMPTY_EMAIL_ERROR_XPATH).text, ForgotPasswordModal::EMPTY_EMAIL_ERROR_TEXT)
    
    #Click on submit button with a not valid email
    $browser.find_element(:xpath => ForgotPasswordModal::EMAIL_TEXTBOX_XPATH).send_keys "notavalidemail.com"
    $browser.find_element(:xpath => ForgotPasswordModal::SUBMIT_BUTTON_XPATH).click
     assert $wait.until{
      $browser.find_element(:xpath => ForgotPasswordModal::EMPTY_EMAIL_ERROR_XPATH)
    }
    assert_equal($browser.find_element(:xpath => ForgotPasswordModal::EMPTY_EMAIL_ERROR_XPATH).text, ForgotPasswordModal::EMPTY_EMAIL_ERROR_TEXT)
  end

end