include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'
require_relative './pages/home_page.rb'
require_relative './pages/signup_modal.rb'
require_relative './pages/login_modal.rb'
require_relative './pages/create_registry_modal.rb'

class Common
  
  USER_NO_REGISTRY_EMAIL    = "trinity3@trinity.com"
  USER_NO_REGISTRY_PASS     = "test1234"
  URL_EXISTING              = "homerandmarge"
  
  
  
  #Creates a new account without registry
  def self.create_user_no_registry
    #click on signup link
    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    assert $wait.until {
        $browser.find_element(:xpath => SignupModal::START_BUTTON).displayed?
    }
    #types email and pass
    newEmail = generate_email("test")
    $browser.find_element(:xpath => SignupModal::EMAIL_FIELD).send_keys newEmail
    $browser.find_element(:xpath => SignupModal::PASS_FIELD).send_keys "test1234"
    assert $wait.until {
      $browser.find_element(:xpath => SignupModal::GLYPHICON_EMAIL).displayed?
      $browser.find_element(:xpath => SignupModal::GLYPHICON_PASS).displayed?
    }
    #clicks on START YOUR REGISTRY BUTTON
    $browser.find_element(:xpath => SignupModal::START_BUTTON).click
    
    assert $wait.until{
      $browser.find_element(:xpath=> CreateRegistryModal::CREATE_REGISTRY_CLASS).displayed?
    }
  end
  
  #Generates an email
  def self.generate_email(name)
    randomString = SecureRandom.hex.gsub('-','')
    name+"@"+randomString+".com"
  end
  
  #Generates a url
  def self.generate_url
    SecureRandom.hex.gsub('-','')
  end
  
  #Login using an existing user without registry
  def self.login_no_registry
    #click on login
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until {
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    #types email and pass
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys USER_NO_REGISTRY_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys USER_NO_REGISTRY_PASS
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    
    assert $wait.until{
      $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).displayed?
    }
  end
  
  def login (userEmail, password)
    $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'    
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
  end
  
end