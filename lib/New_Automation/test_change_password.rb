require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

LOG_IN_LINK_ID = "loginLink"
LOG_IN_MODAL_XPATH = ".//*[@class='modal-dialog modal-md']"
EMAIL_FIELD_XPATH = ".//*[@name='email']"
PASSWORD_FIELD_XPATH = ".//*[@name='password']"
LOG_IN_BUTTON_XPATH = ".//*[@class='btn btn-primary btn-lg btn-block']"
MY_ACCOUNT_LINK_XPATH = ".//*[@class='dropdown dropdown-hover with-arrow']//*[@href='/account/info']"
CHANGE_PASSWORD_LINK_ID = "changePasswordLink"
CURRENT_PASSWORD_FIELD_XPATH = "//*[@name='current_password']"
NEW_PASSWORD_FIELD_XPATH = "//*[@name='new_password']"
VERIFY_PASSWORD_FIELD_XPATH = "//*[@name='verify_password']"
SAVE_CHANGES_BUTTON_XPATH = "//*[@class='button teal big']"
NEW_PASSWORD_ERROR_ID = "change-pw-form-new_password"
VERIFY_PASSWORD_ERROR_ID = "change-pw-form-verify_password"
MESSAGE_ID = "humaneMessage"
MISMATCH_MESSAGE_XPATH = ".//*[@class='form-message-block text-center text-danger']"
LOG_OUT_LINK_ID = "account-menu-logout"
CLOSE_MODAL_XPATH = ".//*[@class='modal-close']"

def change_password (currentPassword, newPassword, verifyPassword)
        $wait.until{
            $browser.find_element(:id, CHANGE_PASSWORD_LINK_ID).displayed?
        }
        $browser.find_element(:id, CHANGE_PASSWORD_LINK_ID).click
        assert $wait.until{
            $browser.find_element(:xpath, CURRENT_PASSWORD_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath, CURRENT_PASSWORD_FIELD_XPATH).send_keys currentPassword
        $browser.find_element(:xpath, NEW_PASSWORD_FIELD_XPATH).send_keys newPassword
        $browser.find_element(:xpath, VERIFY_PASSWORD_FIELD_XPATH).send_keys verifyPassword
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        }
        $browser.find_element(:xpath => SAVE_CHANGES_BUTTON_XPATH).click        
end


class TestChangePassword < TestBasic

    # Change the password successfully
    def test_change_password_successfully
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
        change_password 'test1234', 'test12345', 'test12345'
        $wait.until{
           $browser.find_element(:id, MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, MESSAGE_ID).text == 'Password changed.'
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        }
        #Log out
        $browser.get "https://qa.zola.com"
        $wait.until {
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
        #Log in with your new password
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test12345'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        assert $wait.until {
            $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).displayed?
        }
        #Change the password to the original one
        $browser.find_element(:xpath => MY_ACCOUNT_LINK_XPATH).click
        change_password 'test12345', 'test1234', 'test1234'
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        }
    end

    # Trying to change the password to one with less than 8 characters
    def test_password_too_short
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
        change_password 'test1234', 'test', 'test'
        $wait.until{
            $browser.find_element(:id, NEW_PASSWORD_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, NEW_PASSWORD_ERROR_ID).text == 'Your password must be at least 8 characters long.'
        #Log out
        $browser.get "https://qa.zola.com"
        $wait.until {
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
        #Try to log in with the password you tried to change to
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@test.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

    # Trying to change the password but with the verification not matching
    def test_confirmation_not_matching
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
        change_password 'test1234', 'test12345', 'test123456'
        $wait.until{
           $browser.find_element(:id, VERIFY_PASSWORD_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, VERIFY_PASSWORD_ERROR_ID).text == 'Your passwords do not match.'
        #Log out
        $browser.get "https://qa.zola.com"
        $wait.until {
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
        #Try to log in with the password you tried to change to
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test12345'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
        #Try to log in with the password you used in the verification
        $browser.find_element(:xpath => CLOSE_MODAL_XPATH).click
        assert $wait.until{
            $browser.find_element(:id, LOG_IN_LINK_ID).displayed?
        }
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test123456'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

    #Try to change your password providing a wrong current password
    def test_wrong_current_password
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
        change_password 'test123456', 'test12345', 'test12345'
        $wait.until{
           $browser.find_element(:id, MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, MESSAGE_ID).text == 'Invalid current password'
        #Log out
        $browser.get "https://qa.zola.com"
        $wait.until {
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
        #Try to log in with the password you tried to change to
        $browser.find_element(:id, LOG_IN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => EMAIL_FIELD_XPATH).send_keys 'oktanatesting@test.com'      
        $browser.find_element(:xpath => PASSWORD_FIELD_XPATH).send_keys 'test12345'
        $browser.find_element(:xpath => LOG_IN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end
end