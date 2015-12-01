require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require_relative "common.rb"
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
  Common.wait_to_load
  $browser.find_element(:xpath => AccountInfoPage::SAVE_CHANGES_BUTTON_XPATH).click
end

class TestChangePassword < TestBasic
 
  # Change the password successfully
  def test_change_password_successfully
    
    Common.login(Common::USER_CHANGE_PASSWORD_EMAIL, Common::GLOBAL_PASSWORD)
    
    $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
    change_password Common::GLOBAL_PASSWORD, Common::USER_CHANGE_PASSWORD_PASS, Common::USER_CHANGE_PASSWORD_PASS
    $wait.until{
      $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).displayed?
    }
    assert $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).text == AccountInfoPage::CHANGE_PASSWORD_SUCCESSFULLY_TEXT
    Common.wait_to_load
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
    Common.login(Common::USER_CHANGE_PASSWORD_EMAIL, Common::USER_CHANGE_PASSWORD_PASS)
    
    #Change the password to the original one
    $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
    change_password Common::USER_CHANGE_PASSWORD_PASS, Common::GLOBAL_PASSWORD, Common::GLOBAL_PASSWORD
    Common.wait_to_load
  end

  # Trying to change the password to one with less than 8 characters
  def test_password_too_short
    Common.login Common::USER_CHANGE_PASSWORD_EMAIL, Common::GLOBAL_PASSWORD
    
    $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
    change_password Common::GLOBAL_PASSWORD, Common::USER_CHANGE_PASSWORD_SHORT, Common::USER_CHANGE_PASSWORD_SHORT
    $wait.until{
      $browser.find_element(:id, AccountInfoPage::NEW_PASSWORD_ERROR_ID).displayed?
    }
    assert $browser.find_element(:id, AccountInfoPage::NEW_PASSWORD_ERROR_ID).text == AccountInfoPage::NEW_PASSWORD_ERROR_TEXT
    #Log out
    Common.logout
    #Try to log in with the password you tried to change to
    Common.login Common::USER_CHANGE_PASSWORD_EMAIL, Common::USER_CHANGE_PASSWORD_SHORT
    
    assert $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).text == AccountInfoPage::MISMATCH_MESSAGE_TEXT
  end

  # Trying to change the password but with the verification not matching
  def test_confirmation_not_matching
    Common.login Common::USER_CHANGE_PASSWORD_EMAIL, Common::GLOBAL_PASSWORD
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
    change_password Common::GLOBAL_PASSWORD, Common::USER_CHANGE_PASSWORD_PASS, 'test123456'
    $wait.until{
      $browser.find_element(:id, AccountInfoPage::VERIFY_PASSWORD_ERROR_ID).displayed?
    }
    assert $browser.find_element(:id, AccountInfoPage::VERIFY_PASSWORD_ERROR_ID).text == AccountInfoPage::VERIFY_PASSWORD_ERROR_TEXT
    #Log out
    Common.logout
    #Try to log in with the password you tried to change to
    Common.login Common::USER_CHANGE_PASSWORD_EMAIL, Common::USER_CHANGE_PASSWORD_PASS
    $wait.until {
      $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).text == AccountInfoPage::MISMATCH_MESSAGE_TEXT
    #Try to log in with the password you used in the verification
    $browser.find_element(:xpath => LoginModal::CLOSE_MODAL_XPATH).click
    assert $wait.until{
            $browser.find_element(:id, HomePage::LOGIN_LINK_ID).displayed?
    }
    Common.login Common::USER_CHANGE_PASSWORD_EMAIL, 'test123456'
    assert $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).text == AccountInfoPage::MISMATCH_MESSAGE_TEXT
  end

  #Try to change your password providing a wrong current password
  def test_wrong_current_password
    Common.login Common::USER_CHANGE_PASSWORD_EMAIL, Common::GLOBAL_PASSWORD
    
    $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).click
    change_password 'test123456', Common::USER_CHANGE_PASSWORD_PASS, Common::USER_CHANGE_PASSWORD_PASS
    $wait.until{
      $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).displayed?
    }
    assert $browser.find_element(:id, AccountInfoPage::MESSAGE_ID).text == AccountInfoPage::CURRENT_PASSWORD_ERROR_TEXT
    #Log out
    Common.logout
    #Try to log in with the password you tried to change to
    Common.login Common::USER_CHANGE_PASSWORD_EMAIL, Common::USER_CHANGE_PASSWORD_PASS
    assert $browser.find_element(:xpath => AccountInfoPage::MISMATCH_MESSAGE_XPATH).text == AccountInfoPage::MISMATCH_MESSAGE_TEXT
  end
end