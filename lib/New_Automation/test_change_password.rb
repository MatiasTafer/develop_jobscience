require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'
require_relative './pages/account_info_page.rb'

#change the password
def change_password (currentPassword, newPassword, verifyPassword)
        $wait.until{
            $browser.find_element(:id, AccountInfoPage::CHANGE_PASSWORD_LINK_ID).displayed?
        }
        $browser.find_element(:id, AccountInfoPage::CHANGE_PASSWORD_LINK_ID).click
        assert $wait.until{
            $browser.find_element(:xpath, AccountInfoPage::CURRENT_PASSWORD_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath, AccountInfoPage::CURRENT_PASSWORD_FIELD_XPATH).send_keys currentPassword
        $browser.find_element(:xpath, AccountInfoPage::NEW_PASSWORD_FIELD_XPATH).send_keys newPassword
        $browser.find_element(:xpath, AccountInfoPage::VERIFY_PASSWORD_FIELD_XPATH).send_keys verifyPassword
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        }
        $browser.find_element(:xpath => AccountInfoPage::SAVE_CHANGES_BUTTON_XPATH).click        
end


class TestChangePassword < TestBasic

    # Change the password successfully
    def test_change_password_successfully
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'    
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_password 'test1234', 'test12345', 'test12345'
        $wait.until{
           $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).text == 'Password changed.'
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        }
        #Log out
        $wait.until {
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
        #Log in with your new password
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test12345'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        assert $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        #Change the password to the original one
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_password 'test12345', 'test1234', 'test1234'
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        }
    end

    # Trying to change the password to one with less than 8 characters
    def test_password_too_short
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_password 'test1234', 'test', 'test'
        $wait.until{
            $browser.find_element(:id, AccountInfoPage::NEW_PASSWORD_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::NEW_PASSWORD_ERROR_ID).text == 'Your password must be at least 8 characters long.'
        #Log out
        $wait.until {
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
        #Try to log in with the password you tried to change to
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@test.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

    # Trying to change the password but with the verification not matching
    def test_confirmation_not_matching
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_password 'test1234', 'test12345', 'test123456'
        $wait.until{
           $browser.find_element(:id, AccountInfoPage::VERIFY_PASSWORD_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::VERIFY_PASSWORD_ERROR_ID).text == 'Your passwords do not match.'
        #Log out
        $wait.until {
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
        #Try to log in with the password you tried to change to
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test12345'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
        #Try to log in with the password you used in the verification
        $browser.find_element(:xpath => LoginModal::CLOSE_MODAL_XPATH).click
        assert $wait.until{
            $browser.find_element(:id, HomePage::LOGIN_LINK_ID).displayed?
        }
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test123456'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

    #Try to change your password providing a wrong current password
    def test_wrong_current_password
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@gmail.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test1234'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_password 'test123456', 'test12345', 'test12345'
        $wait.until{
           $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).text == 'Invalid current password'
        #Log out
        $wait.until {
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
        #Try to log in with the password you tried to change to
        $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
        $wait.until{
            $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
        }
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys 'oktanatesting@test.com'      
        $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys 'test12345'
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit        
        $wait.until {
            $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).displayed?
        }
        assert $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).text == 'Invalid username or password'
    end

end