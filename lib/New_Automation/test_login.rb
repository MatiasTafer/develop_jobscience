require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

class TestLogin < TestBasic

    LOG_IN_LINK_ID = "loginLink"
    LOG_IN_MODAL_XPATH = ".//*[@class='modal-dialog modal-md']"
    EMAIL_FIELD_XPATH = ".//*[@name='email']"
    PASSWORD_FIELD_XPATH = ".//*[@name='password']"
    LOG_IN_BUTTON_XPATH = ".//*[@class='btn btn-primary btn-lg btn-block']"
    MY_ACCOUNT_LINK_XPATH = ".//*[@class='dropdown dropdown-hover with-arrow']//*[@href='/account/info']"
    MISMATCH_MESSAGE_XPATH = ".//*[@class='form-message-block text-center text-danger']"
    PASSWORD_ERROR_MESSAGE_XPATH = ".//*[@ng-show='isPasswordInvalid()']"
    EMAIL_ERROR_MESSAGE_XPATH = ".//*[@ng-show='isEmailInvalid()']"
    LOG_OUT_LINK_ID = "account-menu-logout"

    
	# Check that login link is there
	def login_link_existence
    	assert $wait.until {
        	$browser.find_element(:id, LOG_IN_LINK_ID).displayed?
    	}
	end
 
	# Checking the modal appears 
	def test_login_modal
    	$browser.find_element(:id, LOG_IN_LINK_ID).click  
    	assert $wait.until {
        	$browser.find_element(:xpath => LOG_IN_MODAL_XPATH).displayed?
    	}
	end

    # Logging in and logging out correctly
    def test_login_logout_ok
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'complete@test.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'password'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit
        assert $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.action.move_to($browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH)).perform
        $wait.until{
            $browser.find_element(:id, LOG_OUT_LINK_ID).displayed?
        }
        $browser.find_element(:id, LOG_OUT_LINK_ID).click
        assert $wait.until{
            $browser.find_element(:id, LOG_IN_LINK_ID).displayed?
        }
    end

    # Trying to log in with an unregistered user
    def test_login_unregistered_user
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'unregistered_user@test.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'password'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

    # Trying to log in with a registered user but using a wrong password
    def test_login_wrong_password
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'complete@test.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'wrongpassword'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

    # Trying to log in with a registered user but leaving the password field blank
    def test_login_blank_password
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'complete@test.com' 
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => PASSWORD_ERROR_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => PASSWORD_ERROR_MESSAGE_XPATH).text == 'Please enter your password.'
    end

    # Trying to log in leaving the username field blank
    def test_login_blank_username
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'password' 
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => EMAIL_ERROR_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => EMAIL_ERROR_MESSAGE_XPATH).text == 'Please enter a valid email address.'
    end

    # Trying to log in using an email address with the @ sign missing
    def test_login_at_sign_missing
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'completetest.com' 
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'password' 
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => EMAIL_ERROR_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => EMAIL_ERROR_MESSAGE_XPATH).text == 'Please enter a valid email address.'
    end

    # Trying to log in using an email address with the dot missing
    def test_login_dot_missing
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'complete@testcom' 
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'password' 
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => EMAIL_ERROR_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => EMAIL_ERROR_MESSAGE_XPATH).text == 'Please enter a valid email address.'
    end


end