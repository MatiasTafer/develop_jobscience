require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

class TestSignUp < TestBasic
 
# Check that login link is there
def login_link_existence
    assert @wait.until {
        @browser.find_element(:id, "signupLink").displayed?
    }
end
 
# Checking the modal appears 
def test_login_ok
    @browser.find_element(:id, "signupLink").click   
    assert @wait.until {
        @browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").displayed?
    }
end

def test_create_account_ok
	create_user_ok
	assert @wait.until {
        @browser.find_element(:id, "new-registry-form").displayed?
    }
end

#==================================================================================================================================
def create_user_ok
	@browser.find_element(:id, "signupLink").click 
	newEmail = generate_email
	@browser.find_element(:xpath => "//*[@class='form-control ng-pristine ng-untouched ng-valid-email ng-invalid ng-invalid-required']").send_keys newEmail
	@browser.find_element(:xpath => ".//*[@class='form-control ng-pristine ng-untouched ng-invalid ng-invalid-required ng-valid-minlength']").send_keys 'test1234'
	@browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").click
	newEmail
end

def generate_email
	"test@"+SecureRandom.hex+".com"
end

#==================================================================================================================================
end
