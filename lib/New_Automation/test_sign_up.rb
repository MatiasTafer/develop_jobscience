require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'
require './pages/signup_modal.rb'
require './pages/home_page.rb'

class TestSignUp < TestBasic
  # Check that login link is there
  def sign_up_link_existence
    assert $wait.until {
        $browser.find_element(:id, HomePage::SIGNUP_LINK_ID).displayed?
    }
  end

  # Checking the modal appears
  def test_sign_up_ok
    $browser.find_element(:id, HomePage::SIGNUP_LINK_ID).click
    assert $wait.until {
        $browser.find_element(:xpath => SignupModal::START_BUTTON).displayed?
    }
  end

  #Creates a new account
  def test_create_account_ok
    Common.create_user_no_registry
  end

end