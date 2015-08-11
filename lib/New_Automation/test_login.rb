require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'

class TestLogin < TestBasic

	# Check that login link is there
	def login_link_existence
    	assert $wait.until {
        	$browser.find_element(:id, HomePage::LOGIN_LINK_ID).displayed?
    	}
	end
 
	# Checking the modal appears 
	def test_login_modal
    	$browser.find_element(:id, HomePage::LOGIN_LINK_ID).click  
    	assert $wait.until {
        	$browser.find_element(:xpath => LoginModal::LOG_IN_MODAL_XPATH).displayed?
    	}
	end

    # Logging in and logging out correctly
    def test_login_logout_ok
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'complete@test.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'password'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
        assert $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
        $wait.until{
            $browser.find_element(:id, HomePage::LOG_OUT_LINK_ID).displayed?
        }
        $browser.find_element(:id, HomePage::LOG_OUT_LINK_ID).click
        assert $wait.until{
            $browser.find_element(:id, HomePage::LOGIN_LINK_ID).displayed?
        }
    end

    # Trying to log in with an unregistered user
    def test_login_unregistered_user
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'unregistered_user@test.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'password'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => LoginModal::MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => LoginModal::MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

    # Trying to log in with a registered user but using a wrong password
    def test_login_wrong_password
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'complete@test.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'wrongpassword'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => LoginModal::MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => LoginModal::MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

    # Trying to log in with a registered user but leaving the password field blank
    def test_login_blank_password
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'complete@test.com' 
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => LoginModal::PASSWORD_ERROR_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => LoginModal::PASSWORD_ERROR_MESSAGE_XPATH).text == 'Please enter your password.'
    end

    # Trying to log in leaving the username field blank
    def test_login_blank_username
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'password' 
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).text == 'Please enter a valid email address.'
    end

    # Trying to log in using an email address with the @ sign missing
    def test_login_at_sign_missing
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'completetest.com' 
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'password' 
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).text == 'Please enter a valid email address.'
    end

    # Trying to log in using an email address with the dot missing
    def test_login_dot_missing
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'complete@testcom' 
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'password' 
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => LoginModal::EMAIL_ERROR_MESSAGE_XPATH).text == 'Please enter a valid email address.'
    end
end