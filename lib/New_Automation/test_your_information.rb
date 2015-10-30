require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require_relative "common.rb"
require_relative './pages/account_info_page.rb'
require_relative './pages/login_modal.rb'

def change_your_information (name, surname, email)
    assert $wait.until{
        $browser.find_element(:xpath, AccountInfoPage::FIRST_NAME_FIELD_XPATH).displayed?
    }
    $browser.find_element(:xpath, AccountInfoPage::FIRST_NAME_FIELD_XPATH).clear
    $browser.find_element(:xpath, AccountInfoPage::FIRST_NAME_FIELD_XPATH).send_keys name
    $browser.find_element(:xpath, AccountInfoPage::LAST_NAME_FIELD_XPATH).clear
    $browser.find_element(:xpath, AccountInfoPage::LAST_NAME_FIELD_XPATH).send_keys surname
    $browser.find_element(:xpath, AccountInfoPage::EMAIL_FIELD_XPATH).clear
    $browser.find_element(:xpath, AccountInfoPage::EMAIL_FIELD_XPATH).send_keys email
    $browser.find_element(:xpath => AccountInfoPage::SAVE_CHANGES_BUTTON_XPATH).click
end

def check_current_information (name, surname, email)
    Common.wait_to_load
    assert $browser.find_element(:xpath, AccountInfoPage::FIRST_NAME_FIELD_XPATH)['value'] == name
    assert $browser.find_element(:xpath, AccountInfoPage::LAST_NAME_FIELD_XPATH)['value'] == surname
    assert $browser.find_element(:xpath, AccountInfoPage::EMAIL_FIELD_XPATH)['value'] == email
end

class TestYourInformation < TestBasic
   
    #Updates your information successfully
    def test_01change_information_correctly
        Common.login Common::USER1_EMAIL, Common::GLOBAL_PASSWORD
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', 'Johnson', 'testing@gmail.com'
        $wait.until {
            $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).text == AccountInfoPage::INFORMATION_CHANGED_SUCCESSFULLY_TEXT
        
        $browser.find_element(:id, AccountInfoPage::YOUR_INFORMATION_LINK_ID).click
        Common.wait_to_load
        assert $wait.until{
          $browser.find_element(:xpath, AccountInfoPage::FIRST_NAME_FIELD_XPATH).displayed?
        }
        check_current_information 'George', 'Johnson', 'testing@gmail.com'
        change_your_information 'Gregory', 'McGregor', Common::USER1_EMAIL
        $wait.until {
            $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).text == AccountInfoPage::INFORMATION_CHANGED_SUCCESSFULLY_TEXT
    end

    #Tries to change the email address to one with the dot missing
    def test_email_without_dot
        #Login
        Common.login Common::USER1_EMAIL, Common::GLOBAL_PASSWORD
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', 'Johnson', 'testing@gmailcom'
        $wait.until {
            $browser.find_element(:id => AccountInfoPage::EMAIL_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::EMAIL_ERROR_ID).text == AccountInfoPage::INVALID_EMAIL_ERROR_TEXT
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        check_current_information 'Gregory', 'McGregor', Common::USER1_EMAIL
    end 

    #UTry to update your information without at sign 
    def test_email_without_at_sign
        #Login
        Common.login Common::USER1_EMAIL, Common::GLOBAL_PASSWORD
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', 'Johnson', 'testinggmail.com'
        $wait.until {
            $browser.find_element(:id => AccountInfoPage::EMAIL_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::EMAIL_ERROR_ID).text == AccountInfoPage::INVALID_EMAIL_ERROR_TEXT
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        check_current_information 'Gregory', 'McGregor', Common::USER1_EMAIL
    end
    
    #Try to update your information leaving the first name blank
    def test_blank_name
        #Login
        Common.login Common::USER1_EMAIL, Common::GLOBAL_PASSWORD
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_your_information '', 'Johnson', Common::USER1_EMAIL
        $wait.until {
            $browser.find_element(:id => AccountInfoPage::FIRST_NAME_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::FIRST_NAME_ERROR_ID).text == AccountInfoPage::BLANK_FIELD_ERROR_TEXT
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        check_current_information 'Gregory', 'McGregor', Common::USER1_EMAIL
    end

    #Try to update your information leaving last name blank
    def test_blank_surname
        #Login 
        Common.login Common::USER1_EMAIL, Common::GLOBAL_PASSWORD
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', '', Common::USER1_EMAIL
        $wait.until {
            $browser.find_element(:id => AccountInfoPage::LAST_NAME_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::LAST_NAME_ERROR_ID).text == AccountInfoPage::BLANK_FIELD_ERROR_TEXT
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        check_current_information 'Gregory', 'McGregor', Common::USER1_EMAIL
    end
 
    #Try to update your information leaving the email field blank
    def test_blank_email
        #Login
        Common.login Common::USER1_EMAIL, Common::GLOBAL_PASSWORD
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', 'Johnson', ''
        $wait.until {
            $browser.find_element(:id => AccountInfoPage::EMAIL_ERROR_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::EMAIL_ERROR_ID).text == AccountInfoPage::BLANK_FIELD_ERROR_TEXT
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        check_current_information 'Gregory', 'McGregor', Common::USER1_EMAIL
    end

    #Try to update your information using an existing email account
    def test_email_account_already_used
        #Login
        Common.login Common::USER1_EMAIL, Common::GLOBAL_PASSWORD
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', 'Johnson', 'user2@automation.com'
        #TODO: "PUT THE THIS EMAIL ON COMMON"
        $wait.until {
            $browser.find_element(:id => AccountInfoPage::MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).text == AccountInfoPage::EMAIL_EXISTS_ERROR_TEXT
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        check_current_information 'Gregory', 'McGregor', Common::USER1_EMAIL        
    end

end