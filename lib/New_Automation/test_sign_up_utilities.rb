include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

class TestSignUpUtilities
 
def self.create_user_ok
	newEmail = TestSignUpUtilities.generate_email
	$browser.find_element(:xpath => "//*[@class='form-control ng-pristine ng-untouched ng-valid-email ng-invalid ng-invalid-required']").send_keys newEmail
	$browser.find_element(:xpath => ".//*[@class='form-control ng-pristine ng-untouched ng-invalid ng-invalid-required ng-valid-minlength']").send_keys 'test1234'
	assert $wait.until {
		$browser.find_element(:xpath => "(.//*[@class='glyphicon glyphicon-ok form-control-feedback'])[1]").displayed?
		$browser.find_element(:xpath => "(.//*[@class='glyphicon glyphicon-ok form-control-feedback'])[2]").displayed?
	}
	$browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").click
end

def self.generate_email
	"test@"+SecureRandom.hex+".com"
end

end