require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require './pages/account_info_page.rb'
require './pages/login_modal.rb'

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
    $wait.until {
        $browser.execute_script("return document.readyState;") == "complete"
    }
    $browser.find_element(:xpath => AccountInfoPage::SAVE_CHANGES_BUTTON_XPATH).click 
end

def check_current_information (name, surname, email)
    $wait.until {
        $browser.execute_script("return document.readyState;") == "complete"
    }
    assert $browser.find_element(:xpath, AccountInfoPage::FIRST_NAME_FIELD_XPATH)['value'] == name
    assert $browser.find_element(:xpath, AccountInfoPage::LAST_NAME_FIELD_XPATH)['value'] == surname
    assert $browser.find_element(:xpath, AccountInfoPage::EMAIL_FIELD_XPATH)['value'] == email
end

class TestYourInformation < TestBasic

    def test_change_information_correctly
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
        Common.login Common::USER_CHANGE_PASSWORD_EMAIL Common::USER_CHANGE_PASSWORD_PASS
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        change_your_information 'George', 'Johnson', 'testing@gmail.com'
        $wait.until {
            $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).displayed?
        }
        assert $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).text == AccountInfoPage::INFORMATION_CHANGED_SUCCESSFULLY_TEXT
        $wait.until {
            $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
        }
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
        check_current_information 'George', 'Johnson', 'testing@gmail.com'
        change_your_information 'John', 'Smith', Common::USER_CHANGE_PASSWORD_EMAIL
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        }
    end

=begin
    def test_email_without_dot
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
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
        change_your_information 'John', 'Smith', 'oktanatesting@gmailcom'
    end 


    def test_email_without_at_sign
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
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
        change_your_information 'John', 'Smith', 'oktanatestinggmail.com'
    end

    def test_blank_name
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
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
        change_your_information '', 'Smith', 'oktanatesting@gmail.com'
    end 

    def test_blank_surname
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
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
        change_your_information 'John', '', 'oktanatesting@gmail.com'
    end 

    def test_blank_email
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
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
        change_your_information 'John', 'Smith', ''
    end


    def test_email_account_already_used
        $wait.until {
            $browser.execute_script("return document.readyState;") == "complete"
        } 
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
        change_your_information 'George', 'Johnson', 'complete@test.com'        
    end
=end
    
end