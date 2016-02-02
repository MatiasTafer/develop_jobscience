require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative './pages/home_page.rb'
require_relative './pages/login_page.rb'
require_relative 'common.rb'
require_relative 'test_basic.rb'

#Suite: Login
class TestLogin < TestBasic


  def test_login
    $browser.find_element(:id, LoginPage::NAME_TEXT_FIELD_ID).send_keys Common::USER_EMAIL
    $browser.find_element(:id, LoginPage::PASSWORD_TEST_FIELD_ID).send_keys Common::PASSWORD
    $browser.find_element(:id, LoginPage::LOGIN_BUTTON_ID).click
    assert $wait.until{
      $browser.find_element(:id, HomePage::HOME_TAB_LINK_ID).displayed?
      
    } 
  end
end