require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require_relative './pages/home_page.rb'
require_relative './pages/login.rb'
require_relative 'common.rb'

#Suite: Login
class TestLogin < TestBasic

  # Logging in and logging out correctly
  def test_login_logout_ok
    #Login
    $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys Common::USER1_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit    
    $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).text, "Hi Gregory")
    #Logout
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id, HomePage::LOG_OUT_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::LOG_OUT_LINK_ID).click
    $wait.until{
            $browser.find_element(:id, HomePage::LOGIN_LINK_ID).displayed?
    }
    assert_equal($browser.find_element(:id, HomePage::LOGIN_LINK_ID).text,"Log In")
  end

end