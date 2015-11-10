require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'
require_relative 'common.rb'

#Suite: Login
class TestLogin < TestBasic

  # Check that login link is there
  def login_link_existence
    assert $wait.until {
        	$browser.find_element(:id, HomePage::LOGIN_LINK_ID).displayed?
    	}
  end

  # Checking the modal appears
  def test_login_modal
    $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
    assert $wait.until {
        	$browser.find_element(:xpath => LoginModal::LOG_IN_MODAL_XPATH).displayed?
    	}
  end

  # Logging in and logging out correctly
  def test_login_logout_ok
    #Login
    Common.login Common::USER1_EMAIL, Common::GLOBAL_PASSWORD
    assert $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
    #Logout
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id, HomePage::LOG_OUT_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::LOG_OUT_LINK_ID).click
    assert $wait.until{
            $browser.find_element(:id, HomePage::LOGIN_LINK_ID).displayed?
        }
  end

  # Trying to log in with an unregistered user
  def test_login_unregistered_user
    Common.login 'unregistered_user@test.com', 'password'
    $wait.until {
      $browser.find_element(:xpath => LoginModal::MISMATCH_MESSAGE_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => LoginModal::MISMATCH_MESSAGE_XPATH).text == LoginModal::MISMATCH_MESSAGE_TEXT
  end

  # Trying to log in with a registered user but using a wrong password
  def test_login_wrong_password
    Common.login Common::USER1_EMAIL, 'wrongpassword'
    $wait.until {
      $browser.find_element(:xpath => LoginModal::MISMATCH_MESSAGE_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => LoginModal::MISMATCH_MESSAGE_XPATH).text == LoginModal::MISMATCH_MESSAGE_TEXT
  end

  # Trying to log in with a registered user but leaving the password field blank
  def test_login_blank_password
    Common.login Common::USER1_EMAIL, ''
    $wait.until {
      $browser.find_element(:xpath => LoginModal::PASSWORD_ERROR_MESSAGE_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => LoginModal::PASSWORD_ERROR_MESSAGE_XPATH).text == LoginModal::PASSWORD_ERROR_MESSAGE_TEXT
  end

  # Trying to log in leaving the username field blank
  def test_login_blank_username
    Common.login '', Common::GLOBAL_PASSWORD
    $wait.until {
      $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).text == LoginModal::EMAIL_ERROR_MESSAGE_TEXT
  end

  # Trying to log in using an email address with the @ sign missing
  def test_login_at_sign_missing
    Common.login 'completetest.com', 'password'
    $wait.until {
      $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).text == LoginModal::EMAIL_ERROR_MESSAGE_TEXT
  end

  # Trying to log in using an email address with the dot missing
  def test_login_dot_missing
    Common.login 'complete@testcom', 'password'
    $wait.until {
      $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).text == LoginModal::EMAIL_ERROR_MESSAGE_TEXT
  end
end