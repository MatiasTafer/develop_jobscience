require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

class TestLogin < TestBasic
    
	# Check that login link is there
	def login_link_existence
    	assert $wait.until {
        	$browser.find_element(:id, "loginLink").displayed?
    	}
	end
 
	# Checking the modal appears 
	def test_login_modal
    	$browser.find_element(:id, "loginLink").click  
    	assert $wait.until {
        	$browser.find_element(:xpath => ".//*[@class='modal-dialog modal-md']").displayed?
    	}
	end

    # Logging in correctly
    def test_login_ok
        $browser.find_element(:id, "loginLink").click
        $wait.until{
            $browser.find_element(:xpath => ".//*[@name='email']").displayed?
        }
        $browser.find_element(:xpath => ".//*[@name='email']").send_keys 'complete@test.com'      
        $browser.find_element(:xpath => ".//*[@name='password']").send_keys 'password'
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").submit
        assert $wait.until {
            $browser.find_element(:xpath => ".//*[@class='dropdown dropdown-hover with-arrow']//*[@href='/account/info']").displayed?
        }
    end

    # Trying to log in with an unregistered user
    def test_login_unregistered_user
        $browser.find_element(:id, "loginLink").click
        $wait.until{
            $browser.find_element(:xpath => ".//*[@name='email']").displayed?
        }
        $browser.find_element(:xpath => ".//*[@name='email']").send_keys 'unregistered_user@test.com'      
        $browser.find_element(:xpath => ".//*[@name='password']").send_keys 'password'
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").submit        
        $wait.until {
            $browser.find_element(:xpath => ".//*[@class='form-message-block text-center text-danger']").displayed?
        }
        assert $browser.find_element(:xpath => ".//*[@class='form-message-block text-center text-danger']").text == 'Invalid username or password'
    end

    # Trying to log in with a registered user but using a wrong password
    def test_login_wrong_password
        $browser.find_element(:id, "loginLink").click
        $wait.until{
            $browser.find_element(:xpath => ".//*[@name='email']").displayed?
        }
        $browser.find_element(:xpath => ".//*[@name='email']").send_keys 'complete@test.com'      
        $browser.find_element(:xpath => ".//*[@name='password']").send_keys 'wrongpassword'
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").submit        
        $wait.until {
            $browser.find_element(:xpath => ".//*[@class='form-message-block text-center text-danger']").displayed?
        }
        assert $browser.find_element(:xpath => ".//*[@class='form-message-block text-center text-danger']").text == 'Invalid username or password'
    end

    def test_login_blank_password
        $browser.find_element(:id, "loginLink").click
        $wait.until{
            $browser.find_element(:xpath => ".//*[@name='email']").displayed?
        }
        $browser.find_element(:xpath => ".//*[@name='email']").send_keys 'complete@test.com' 
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").submit        
        $wait.until {
            $browser.find_element(:xpath => ".//*[@ng-show='isPasswordInvalid()']").displayed?
        }
        assert $browser.find_element(:xpath => ".//*[@ng-show='isPasswordInvalid()']").text == 'Please enter your password.'
    end

    def test_login_blank_username
        $browser.find_element(:id, "loginLink").click
        $wait.until{
            $browser.find_element(:xpath => ".//*[@name='email']").displayed?
        }
        $browser.find_element(:xpath => ".//*[@name='password']").send_keys 'password' 
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").submit        
        $wait.until {
            $browser.find_element(:xpath => ".//*[@ng-show='isEmailInvalid()']").displayed?
        }
        assert $browser.find_element(:xpath => ".//*[@ng-show='isEmailInvalid()']").text == 'Please enter a valid email address.'
    end

    def test_login_at_sign_missing
        $browser.find_element(:id, "loginLink").click
        $wait.until{
            $browser.find_element(:xpath => ".//*[@name='email']").displayed?
        }
        $browser.find_element(:xpath => ".//*[@name='email']").send_keys 'completetest.com' 
        $browser.find_element(:xpath => ".//*[@name='password']").send_keys 'password' 
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").submit        
        $wait.until {
            $browser.find_element(:xpath => ".//*[@ng-show='isEmailInvalid()']").displayed?
        }
        assert $browser.find_element(:xpath => ".//*[@ng-show='isEmailInvalid()']").text == 'Please enter a valid email address.'
    end

    def test_login_dot_missing
        $browser.find_element(:id, "loginLink").click
        $wait.until{
            $browser.find_element(:xpath => ".//*[@name='email']").displayed?
        }
        $browser.find_element(:xpath => ".//*[@name='email']").send_keys 'complete@testcom' 
        $browser.find_element(:xpath => ".//*[@name='password']").send_keys 'password' 
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").submit        
        $wait.until {
            $browser.find_element(:xpath => ".//*[@ng-show='isEmailInvalid()']").displayed?
        }
        assert $browser.find_element(:xpath => ".//*[@ng-show='isEmailInvalid()']").text == 'Please enter a valid email address.'
    end

end