include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'
require_relative 'home_page.rb'
require_relative 'signup_modal.rb'
require_relative 'login_modal.rb'
require_relative 'create_registry_modal.rb'

class Common
  
  USER_NO_REGISTRY_EMAIL    = "trinity3@trinity.com"
  USER_NO_REGISTRY_PASS     = "test1234"
  URL_EXISTING              = "homerandmarge"
  
  #Creates a new account without registry
  def self.create_user_no_registry
    #click on signup link
    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    assert $wait.until {
        $browser.find_element(:xpath => Signup_Modal::START_BUTTON).displayed?
    }
    #types email and pass
    newEmail = generate_email("test")
    $browser.find_element(:xpath => Signup_Modal::EMAIL_FIELD).send_keys newEmail
    $browser.find_element(:xpath => Signup_Modal::PASS_FIELD).send_keys "test1234"
    assert $wait.until {
      $browser.find_element(:xpath => Signup_Modal::GLYPHICON_EMAIL).displayed?
      $browser.find_element(:xpath => Signup_Modal::GLYPHICON_PASS).displayed?
    }
    #clicks on START YOUR REGISTRY BUTTON
    $browser.find_element(:xpath => Signup_Modal::START_BUTTON).click
    
    assert $wait.until{
      $browser.find_element(:xpath=> Create_Registry_Modal::CREATE_REGISTRY_CLASS).displayed?
    }
  end
  
  def self.generate_email(name)
    randomString = SecureRandom.hex.gsub('-','')
    name+"@"+randomString+".com"
  end
  
  def self.generate_url
    SecureRandom.hex.gsub('-','')
  end
  
  
  def self.login_no_registry
    #click on login
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until {
        $browser.find_element(:xpath => Login_Modal::LOGIN_BUTTON).displayed?
    }
    #types email and pass
    $browser.find_element(:xpath => Login_Modal::EMAIL_FIELD).send_keys USER_NO_REGISTRY_EMAIL
    $browser.find_element(:xpath => Login_Modal::PASS_FIELD).send_keys USER_NO_REGISTRY_PASS
    $browser.find_element(:xpath => Login_Modal::LOGIN_BUTTON).click
    
    assert $wait.until{
      $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).displayed?
    }
  end
  
end