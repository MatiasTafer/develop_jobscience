require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'



class NewSignup < TestBasic
  
  
  #SUCCESSFULLY NEW SIGN UP (TC1565)
  def test_SuccessfullySignup
    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    
  end
end