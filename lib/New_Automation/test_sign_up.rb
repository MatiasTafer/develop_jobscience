require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/home_page.rb'
require_relative './pages/signup_modal.rb'
require_relative './pages/create_registry_modal.rb'

#TEST SUITE : 01 - SIGNUP - ACCOUNT CREATION
class TestSignup < TestBasic

  #TEST : SUCCESSFULLY CREATE A NEW ACCOUNT (TC556)
  def test_successSignUp
    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).displayed?
    }
    newEmail = Common.generate_email('test')
    $browser.find_element(:xpath => SignupModal::EMAIL_TEXTBOX_XPATH).send_keys newEmail
    $browser.find_element(:xpath => SignupModal::PASSWORD_TEXTBOX_XPATH).send_keys Common::GLOBAL_PASSWORD
    $wait.until{
     $browser.find_element(:xpath => SignupModal::GLYPHICON_EMAIL_XPATH).displayed? && $browser.find_element(:xpath => SignupModal::GLYPHICON_PASS_XPATH).displayed?
    }
    $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
  end

  #TEST : CREATE AN ACCOUNT WITH AN INVALID EMAIL ADDRESS (@MISSING) (TC548)
  def test_invalidEmail
    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).displayed?
    }

    $browser.find_element(:xpath => SignupModal::EMAIL_TEXTBOX_XPATH).send_keys 'emailtest.com'
    $browser.find_element(:xpath => SignupModal::PASSWORD_TEXTBOX_XPATH).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).displayed? && !$browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).text.eql?("Checking email availability...")
    }
    assert_equal(
      $browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).text, SignupModal::ERROR_TEXT_MESSAGE_XPATH)
  end

  def test_invalidEmailNoDot
    
    #TEST : CREATE AN ACCOUNT WITH AN INCORRECT EMAIL ADDRESS (DOT MISSING) (TC549)

    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).displayed?
    }

    $browser.find_element(:xpath => SignupModal::EMAIL_TEXTBOX_XPATH).send_keys 'email@testcom'
    $browser.find_element(:xpath => SignupModal::PASSWORD_TEXTBOX_XPATH).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).displayed? && !$browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).text.eql?("Checking email availability...")
    }
    assert_equal($browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).text, SignupModal::ERROR_TEXT_MESSAGE_XPATH)
  end

  def test_allreadyUsedEmail
    
    #TEST : CREATE AN ACCOUNT WITH AN EMAIL ADDRESS ALREADY USED BY A ZOLA ACCOUNT (TC550)

    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).displayed?
    }
    $browser.find_element(:xpath => SignupModal::EMAIL_TEXTBOX_XPATH).send_keys Common::USER1_EMAIL
    $browser.find_element(:xpath => SignupModal::PASSWORD_TEXTBOX_XPATH).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).displayed? && !$browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).text.eql?("Checking email availability...")   
    }
    assert_equal($browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).text, SignupModal::EXISTING_ACCOUNT_ERROR_TEXT_XPATH)
  end

  def test_invalidPassword
    
    #TEST : CREATE AN ACCOUNT WITH AN INVALID PASSWORD (TC551)

    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).displayed?
    }
    newEmail = Common.generate_email('test')
    $browser.find_element(:xpath => SignupModal::EMAIL_TEXTBOX_XPATH).send_keys newEmail
    $browser.find_element(:xpath => SignupModal::PASSWORD_TEXTBOX_XPATH).send_keys 'test'
    $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_PASSWORD_XPATH).displayed?     
    }
    assert_equal($browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_PASSWORD_XPATH).text, SignupModal::ERROR_MESSAGE_PASSWORD_TEXT)
  end

  def test_LeavedEmailBlank
    
    #TEST : CREATE AN ACCOUNT LEAVING THE EMAIL BLANK (TC554)

    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).displayed?
    }
    $browser.find_element(:xpath => SignupModal::PASSWORD_TEXTBOX_XPATH).send_keys 'password'
    $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).click
    $wait.until{
       $browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).displayed? && !$browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).text.eql?("Checking email availability...")
    }
    assert_equal($browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_EMAIL_XPATH).text, SignupModal::ERROR_TEXT_MESSAGE_XPATH)
  end

  def test_invalidBlankPassword
    
    #TEST : CREATE AN ACCOUNT LEAVING THE PASSWORD BLANK (TC555)

    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).displayed?
    }
    newEmail = Common.generate_email('test')
    $browser.find_element(:xpath => SignupModal::EMAIL_TEXTBOX_XPATH).send_keys newEmail
    $browser.find_element(:xpath => SignupModal::PASSWORD_TEXTBOX_XPATH).send_keys ''
    $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_PASSWORD_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath => SignupModal::ERROR_MESSAGE_PASSWORD_XPATH).text, SignupModal::ERROR_MESSAGE_PASSWORD_TEXT)
  end

end