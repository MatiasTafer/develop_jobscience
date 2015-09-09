require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'
require_relative './pages/registry_settings_page.rb'

class RegistrySettings < TestBasic

#Deactivates your Registry
def test_DeactivateRegistry
    #Login  
    Common.login(LoginModal::TEST_USER_EMAIL2, LoginModal::TEST_USER_PASSWORD2)
    assert $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Go to Registry Settings page
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingPage::SHIPPING_INFO_XPATH).displayed?
    }
    #Clicks on Deactivate checkbox
    $browser.find_element(:id => RegistrySettingPage::REGISTRY_DEACTIVATE_ID).click
    #Clicks on Save Changes
    $browser.find_element(:xpath => RegistrySettingPage::SAVE_CHANGE_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => RegistrySettingPage::OK_MESSAGE_XPATH).displayed?
    }
    #Checks if the registry was deactivated
    $browser.find_element(:xpath => RegistrySettingPage::REGISTRY_LINK_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MAKE_IT_VISIBLE_BUTTON).displayed?  
    }
    url = $browser.current_url
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    assert $wait.until{
      $browser.find_element(:id => HomePage::LOG_OUT_LINK_ID).displayed?
    }
    $browser.find_element(:id => HomePage::LOG_OUT_LINK_ID).click
    
    assert $wait.until{
      $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).displayed?
    }
    #opens a new windows and gets the url
    $browser.switch_to.window($browser.window_handles.last)
    $browser.get url
    #verify if the registry is deactivated
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::FIND_REGISTRY_BUTTON_XPATH).displayed?
    }
    
    #Activate the registry
    Common.login(LoginModal::TEST_USER_EMAIL2, LoginModal::TEST_USER_PASSWORD2)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MAKE_IT_VISIBLE_BUTTON).displayed?
    }
    $browser.find_element(:xpath => HomePage::MAKE_IT_VISIBLE_BUTTON).click
   
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::ADD_WEDDING_WEB_BUTTON_XPATH).displayed?
    }
  end
end