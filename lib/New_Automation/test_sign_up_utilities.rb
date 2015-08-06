include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

class TestSignUpUtilities
  
  FIELD_EMAIL   = "//*[@class='form-control ng-pristine ng-untouched ng-valid-email ng-invalid ng-invalid-required']"
  FIELD_PASS    = ".//*[@class='form-control ng-pristine ng-untouched ng-invalid ng-invalid-required ng-valid-minlength']"
  BUTTON_START  = ".//*[@class='btn btn-primary btn-lg btn-block']"
  
  def self.create_user_ok
    newEmail = TestSignUpUtilities.generate_email
    $browser.find_element(:xpath => FIELD_EMAIL).send_keys newEmail
    $browser.find_element(:xpath => FIELD_PASS).send_keys 'test1234'
    
    assert $wait.until {
      $browser.find_element(:xpath => "(.//*[@class='glyphicon glyphicon-ok form-control-feedback'])[1]").displayed?
		  $browser.find_element(:xpath => "(.//*[@class='glyphicon glyphicon-ok form-control-feedback'])[2]").displayed?
    }
    $browser.find_element(:xpath => BUTTON_START).click
  end

  def self.generate_email
    "test@"+SecureRandom.hex+".com"
  end

end