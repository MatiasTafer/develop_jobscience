require_relative 'test_basic.rb'
require_relative 'test_sign_up_utilities.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

class TestSignUp < TestBasic
 
# Check that login link is there
def login_link_existence
    assert @wait.until {
        $browser.find_element(:id, "signupLink").displayed?
    }
end
 
# Checking the modal appears 
def test_login_ok
    $browser.find_element(:id, "signupLink").click   
    assert $wait.until {
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").displayed?
    }
end

def test_create_account_ok
	$browser.find_element(:id, "signupLink").click 
	assert $wait.until {
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").displayed?
    }
	TestSignUpUtilities.create_user_ok
	assert $wait.until {
        $browser.find_element(:id, "new-registry-form").displayed?
    }
end

end
