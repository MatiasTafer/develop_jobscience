require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/registry_page.rb'
require_relative './pages/create_gift_collection_modal.rb'
require_relative './pages/choose_image_to_collection_modal.rb'




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
    #Verify if error message appears
    assert $wait.until {
      $browser.find_element(:id, CreateGiftCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_ID).displayed?
      $browser.find_element(:id, CreateGiftCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_ID).text == CreateGiftCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_TEXT
      
    }
  end
  
  
  #TC579 SUCCESSFULLY CREATE A NEW REGISTRY COLLECTION USING ONE OF THE ZOLA PHOTOS
  def test_collection_create_using_zola_photos
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
    #Complete field to create a new collection
    $browser.find_element(:id, CreateGiftCollection::COLLECTION_NAME_FIELD_ID).send_keys CreateGiftCollection::COLLECTION_NAME_TEXT
    $browser.find_element(:xpath, CreateGiftCollection::DESCRIPTION_FIELD_XPATH).send_keys CreateGiftCollection::DESCRIPTION_TEXT
    #Click on Edit Image link
    $browser.find_element(:xpath, CreateGiftCollection::EDIT_IMAGE_LINK_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ChooseImageToCollection::FIRST_PHOTO_XPATH).displayed?
    }
    #Choose one photo
    $browser.find_element(:xpath, ChooseImageToCollection::FIRST_PHOTO_XPATH).click
    $wait.until {
      $browser.find_element(:id, CreateGiftCollection::COLLECTION_NAME_FIELD_ID).displayed?
    }
    #Click on Create Collection button
    $browser.find_element(:xpath, CreateGiftCollection::CREATE_COLLECTION_BUTTON_XPATH).click
    #Verify if "Added colection" message appears
    assert $wait.until {
      $browser.find_element(:id, CreateGiftCollection::COLLECTION_ADDED_MESSAGE_ID).displayed?
      $browser.find_element(:id, CreateGiftCollection::COLLECTION_ADDED_MESSAGE_ID).text == CreateGiftCollection::COLLECTION_ADDED_MESSAGE_TEXT  
    }  
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end