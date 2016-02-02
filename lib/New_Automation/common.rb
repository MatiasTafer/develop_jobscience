include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

class Common
  
  USER_EMAIL = "naomi@joblabs.com"
  PASSWORD  = "muffin99"
  
  
  #LOGIN
  def login(username, password) 
    $browser.find_element(:id, LoginPage::NAME_TEXT_FIELD_ID).send_keys username
    $browser.find_element(:id, LoginPage::PASSWORD_TEST_FIELD_ID).send_keys password
    $browser.find_element(:id, LoginPage::LOGIN_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:id, HomePage::HOME_TAB_LINK_ID).displayed? 
    } 
  end
    
  
  
  
end