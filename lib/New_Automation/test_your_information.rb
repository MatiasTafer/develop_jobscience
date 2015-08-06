require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

LOG_IN_LINK_ID = "loginLink"
LOG_IN_MODAL_XPATH = ".//*[@class='modal-dialog modal-md']"
EMAIL_FIELD_XPATH = ".//*[@name='email']"
PASSWORD_FIELD_XPATH = ".//*[@name='password']"
LOG_IN_BUTTON_XPATH = ".//*[@class='btn btn-primary btn-lg btn-block']"
MY_ACCOUNT_LINK_XPATH = ".//*[@class='dropdown dropdown-hover with-arrow']"
FIRST_NAME_FIELD_XPATH = ".//*[@name='first_name']"
LAST_NAME_FIELD_XPATH = ".//*[@name='last_name']"
SAVE_CHANGES_BUTTON_XPATH = "//*[@class='button teal big']"
NEW_PASSWORD_ERROR_ID = "change-pw-form-new_password"
VERIFY_PASSWORD_ERROR_ID = "change-pw-form-verify_password"
MESSAGE_ID = "humaneMessage"
MISMATCH_MESSAGE_XPATH = ".//*[@class='form-message-block text-center text-danger']"
LOG_OUT_LINK_ID = "account-menu-logout"
CLOSE_MODAL_XPATH = ".//*[@class='modal-close']"

def change_your_information (name, surname, email)        
    assert $wait.until{
        $browser.find_element(:xpath, FIRST_NAME_FIELD_XPATH).displayed?
    }
    $browser.find_element(:xpath, FIRST_NAME_FIELD_XPATH).clear
    $browser.find_element(:xpath, FIRST_NAME_FIELD_XPATH).send_keys name
    $browser.find_element(:xpath, LAST_NAME_FIELD_XPATH).clear
    $browser.find_element(:xpath, LAST_NAME_FIELD_XPATH).send_keys surname
    $browser.find_element(:xpath, EMAIL_FIELD_XPATH).clear
    $browser.find_element(:xpath, EMAIL_FIELD_XPATH).send_keys email
    $wait.until {
        $browser.execute_script("return document.readyState;") == "complete"
    }
    $browser.find_element(:xpath => SAVE_CHANGES_BUTTON_XPATH).click 
end

def check_current_information (name, surname, email)
    $wait.until {
        $browser.execute_script("return document.readyState;") == "complete"
    }
    assert $browser.find_element(:xpath, FIRST_NAME_FIELD_XPATH)['value'] == name
    assert $browser.find_element(:xpath, LAST_NAME_FIELD_XPATH)['value'] == surname
    assert $browser.find_element(:xpath, EMAIL_FIELD_XPATH)['value'] == email
end

class TestYourInformation < TestBasic

    def test_change_information_correctly
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', 'Johnson', 'testing@gmail.com'
        $wait.until {
            $browser.find_element(:id, MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, MESSAGE_ID).text == 'Account information updated.'
        $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        check_current_information 'George', 'Johnson', 'testing@gmail.com'
        change_your_information 'John', 'Smith', 'oktanatesting@gmail.com'
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        }
    end

=begin
    def test_email_without_dot
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'John', 'Smith', 'oktanatesting@gmailcom'
    end 


    def test_email_without_at_sign
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'John', 'Smith', 'oktanatestinggmail.com'
    end

    def test_blank_name
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        change_your_information '', 'Smith', 'oktanatesting@gmail.com'
    end 

    def test_blank_surname
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'John', '', 'oktanatesting@gmail.com'
    end 

    def test_blank_email
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'John', 'Smith', ''
    end


    def test_email_account_already_used
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', 'Johnson', 'complete@test.com'        
    end
=end
    
end