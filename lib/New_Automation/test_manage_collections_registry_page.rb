require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/registry_page.rb'
require_relative './pages/create_gift_collection_modal.rb'




class ManegeCollectionRegistry < TestBasic
  
  #TC578 CREATE A NEW REGISTRY COLLECTION WITHOUT NAME
  def test_collection_without_name
    Common.login(Common::USER4_EMAIL, Common::USER4_PASSWORD)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Go to registry page
    $browser.get HomePage::HOME_URL
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).displayed?
    }
    #Click on new collection button
    $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, CreateGiftCollection::COLLECTION_NAME_FIELD_ID).displayed?
    }
    #Click on Create collection button on modal
    $browser.find_element(:xpath, CreateGiftCollection::CREATE_COLLECTION_BUTTON_XPATH).click
    #Verify error message appears
    assert $wait.until {
      $browser.find_element(:id, CreateGiftCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_ID).displayed?
    }
  end
  
  
  
  
end