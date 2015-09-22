require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/make_registry_visible_modal.rb'
require_relative './pages/shipping_info_modal.rb'
require_relative './pages/home_page.rb'


class TestPublicRegistryReminders < TestBasic
  
  
  
  
  
  #TC1128 MAKE IT VISIBLE TO GUESTS WITH NOT SAVED SHIPPING ADDRESS
  def test_visible_to_guests_not_address
    Common.login(Common::USER2_EMAIL, Common::USER23_password)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.get HomePage::HOME_URL
    $wait.until{
      $browser.find_element(:xpath, MakeRegistryVisible::MAKE_IT_VISIBLE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, MakeRegistryVisible::MAKE_IT_VISIBLE_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id, ShippingInfoModal::FIRST_NAME_FIELD_ID).displayed?
    }
  end
  
  
  #TC1128 MAKE IT VISIBLE TO GUESTS WITH SAVED SHIPPING ADDRESS
  
  
  
  
  
  
  
  
  
  
end