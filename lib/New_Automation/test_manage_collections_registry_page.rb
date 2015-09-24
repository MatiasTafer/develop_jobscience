require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/registry_page.rb'
require_relative './pages/create_gift_collection_modal.rb'
require_relative './pages/choose_image_to_collection_modal.rb'
require_relative './pages/edit_collection_modal.rb'
require_relative './pages/delete_collection_confirmation_modal.rb'




class ManegeCollectionRegistry < TestBasic
  

  #TC578 CREATE A NEW REGISTRY COLLECTION WITHOUT NAME
  def test_collection_without_name
    #Login
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
    #Login
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
  
  
  #TC1488 SUCCESSFULLY CREATE A NEW REGISTRY COLLECTION UPLOADING A PHOTO (dejar para el final)

  
  
  #TC1489 EDIT REGISTRY COLLECTION LEAVING THE NAME FIELD BLANK
  def test_edit_collection_name_blank
    #Login
    Common.login(Common::USER4_EMAIL, Common::USER4_PASSWORD)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Go to registry page
    $browser.get HomePage::HOME_URL
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).displayed?
    }
    quantityCollections = $browser.find_elements(:xpath, RegistryPage::ALL_COLLECTIONS_IN_REGISTRY_XPATH)
    # if registry have or haven't collection previusly created
    if (quantityCollections.size > 0) then
      #Click on edit collection link
      $browser.find_element(:xpath, RegistryPage::EDIT_COLLECTION_BUTTON_XPATH).click
      $wait.until {
        $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).displayed?
      }
      #Clear Collection name field
      $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).clear
      #Save the changes
      $browser.find_element(:xpath, EditCollection::SAVE_COLLECTION_BUTTON_XPATH).click
      #verify if the message error appears
      assert $wait.until{
        $browser.find_element(:id, EditCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_ID).displayed?
        $browser.find_element(:id, EditCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_ID).text == EditCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_TEXT
      }
    else
      #Create a new collection
      create_gift_collection(CreateGiftCollection::COLLECTION_NAME_TEXT, CreateGiftCollection::DESCRIPTION_TEXT)
      $wait.until {
        $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).displayed?
      }
      #Click on edit collection link
      $browser.find_element(:xpath, RegistryPage::EDIT_COLLECTION_BUTTON_XPATH).click
      $wait.until {
        $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).displayed?
      }
      #Clear Collection name field
      $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).clear
      #Save the changes
      $browser.find_element(:xpath, EditCollection::SAVE_COLLECTION_BUTTON_XPATH).click
      #verify if the message error appears
      assert $wait.until{
        $browser.find_element(:id, EditCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_ID).displayed?
        $browser.find_element(:id, EditCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_ID).text == EditCollection::PLEASE_ENTER_COLLECTION_NAME_ERROR_TEXT
      }  
    end
  end
  

  #TC1490 EDIT A REGISTRY COLLECTION CHANGING THE IMAGE TO ONE OF THE ZOLA PHOTOS
  def test_edit_collection_using_zola_photo
    #Login
    Common.login(Common::USER4_EMAIL, Common::USER4_PASSWORD)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Go to registry page
    $browser.get HomePage::HOME_URL
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).displayed?
    }
    quantityCollections = $browser.find_elements(:xpath, RegistryPage::ALL_COLLECTIONS_IN_REGISTRY_XPATH)
    # if registry have or haven't collection previusly created
    if (quantityCollections.size > 0) then
      $browser.find_element(:xpath, RegistryPage::EDIT_COLLECTION_BUTTON_XPATH).click
      $wait.until {
        $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).displayed?
      }
      $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).clear
      $browser.find_element(:xpath, EditCollection::DESCRIPTION_FIELD_XPATH).clear
      $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).send_keys  EditCollection::COLLECTION_NAME_TEXT_2
      $browser.find_element(:xpath, EditCollection::DESCRIPTION_FIELD_XPATH).send_keys  EditCollection::DESCRIPTION_TEXT_2
      #Click on Edit Image link
      $browser.find_element(:xpath, CreateGiftCollection::EDIT_IMAGE_LINK_XPATH).click
      $wait.until {
        $browser.find_element(:xpath, ChooseImageToCollection::FIRST_PHOTO_XPATH).displayed?
      }
      #Choose one photo
      $browser.find_element(:xpath, ChooseImageToCollection::SECOND_PHOTO_XPATH).click
      $wait.until {
      $browser.find_element(:id, CreateGiftCollection::COLLECTION_NAME_FIELD_ID).displayed?
      }
      $browser.find_element(:xpath, EditCollection::SAVE_COLLECTION_BUTTON_XPATH).click
      #Verify if collection saved message appears
      assert $wait.until {
        $browser.find_element(:id, EditCollection::COLLECTION_SAVED_MESSAGE_ID).displayed?
        $browser.find_element(:id, EditCollection::COLLECTION_SAVED_MESSAGE_ID).text == EditCollection::COLLECTION_SAVED_MESSAGE_TEXT
      }
    else
      #Create a new collection
      create_gift_collection(CreateGiftCollection::COLLECTION_NAME_TEXT, CreateGiftCollection::DESCRIPTION_TEXT)
      $wait.until {
        $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).displayed?
      }
      $browser.find_element(:xpath, RegistryPage::EDIT_COLLECTION_BUTTON_XPATH).click
      $wait.until {
        $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).displayed?
      }
      $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).clear
      $browser.find_element(:xpath, EditCollection::DESCRIPTION_FIELD_XPATH).clear
      $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).send_keys  EditCollection::COLLECTION_NAME_TEXT_2
      $browser.find_element(:xpath, EditCollection::DESCRIPTION_FIELD_XPATH).send_keys  EditCollection::DESCRIPTION_TEXT_2
      #Click on Edit Image link
      $browser.find_element(:xpath, CreateGiftCollection::EDIT_IMAGE_LINK_XPATH).click
      $wait.until {
        $browser.find_element(:xpath, ChooseImageToCollection::FIRST_PHOTO_XPATH).displayed?
      }
      #Choose one photo
      $browser.find_element(:xpath, ChooseImageToCollection::SECOND_PHOTO_XPATH).click
      $wait.until {
      $browser.find_element(:id, CreateGiftCollection::COLLECTION_NAME_FIELD_ID).displayed?
      }
      $browser.find_element(:xpath, EditCollection::SAVE_COLLECTION_BUTTON_XPATH).click
      #Verify if collection saved message appears
      assert $wait.until {
        $browser.find_element(:id, EditCollection::COLLECTION_SAVED_MESSAGE_ID).displayed?
        $browser.find_element(:id, EditCollection::COLLECTION_SAVED_MESSAGE_ID).text == EditCollection::COLLECTION_SAVED_MESSAGE_TEXT
      }
    end
  end
  
  #TC1491 EDIT A REGISTRY COLLECTION CHANGING THE IMAGE TO AN UPLOADED PHOTO (lo dejo para el final)
  
  
  

  
  #TC1592 EDIT A REGISTRY COLLECTION DELETING IT
  def test_edit_collection_deleting_it
    #Login
    Common.login(Common::USER4_EMAIL, Common::USER4_PASSWORD)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Go to registry page
    $browser.get HomePage::HOME_URL
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).displayed?
    }
    quantityCollections = $browser.find_elements(:xpath, RegistryPage::ALL_COLLECTIONS_IN_REGISTRY_XPATH)
    # if registry have or haven't collection previusly created
    if (quantityCollections.size > 0) then
      #Click on edit collection button
      $browser.find_element(:xpath, RegistryPage::EDIT_COLLECTION_BUTTON_XPATH).click
      $wait.until {
        $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).displayed?
      }
      #click on delete collection button
      $browser.find_element(:xpath, EditCollection::DELETE_BUTTON_XPATH).click
      $wait.until {
        $browser.find_element(:id, DeleteCollectionConfirmation::DELETE_COLLECTION_ID).displayed?
      }
      #Click on delete collection button on confirmation modal
      $browser.find_element(:id, DeleteCollectionConfirmation::DELETE_COLLECTION_ID).click
      #Verify if deleted collection message appears
      assert $wait.until {
        $browser.find_element(:id, DeleteCollectionConfirmation::DELETED_COLLECTION_MESSAGE_ID).displayed?
        $browser.find_element(:id, DeleteCollectionConfirmation::DELETED_COLLECTION_MESSAGE_ID).text == DeleteCollectionConfirmation::DELETED_COLLECTION_MESSAGE_TEXT
      }
    else  
      #Create a new collection
      create_gift_collection(CreateGiftCollection::COLLECTION_NAME_TEXT, CreateGiftCollection::DESCRIPTION_TEXT)
      $wait.until {
        $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).displayed?
      }
      $browser.find_element(:xpath, RegistryPage::EDIT_COLLECTION_BUTTON_XPATH).click
      $wait.until {
        $browser.find_element(:id, EditCollection::COLLECTION_NAME_FIELD_ID).displayed?
      }
      #click on delete collection button
      $browser.find_element(:xpath, EditCollection::DELETE_BUTTON_XPATH).click
      $wait.until {
        $browser.find_element(:id, DeleteCollectionConfirmation::DELETE_COLLECTION_ID).displayed?
      }
      #Click on delete collection button on confirmation modal
      $browser.find_element(:id, DeleteCollectionConfirmation::DELETE_COLLECTION_ID).click
      #Verify if deleted collection message appears
      assert $wait.until {
        $browser.find_element(:id, DeleteCollectionConfirmation::DELETED_COLLECTION_MESSAGE_ID).displayed?
        $browser.find_element(:id, DeleteCollectionConfirmation::DELETED_COLLECTION_MESSAGE_ID).text == DeleteCollectionConfirmation::DELETED_COLLECTION_MESSAGE_TEXT
      }
    end
  end
  
  
  
  
  
  
  #METHOD TO CREATE ONE GIFT COLLECTION (must be on registry page and have at least one gift)
  def create_gift_collection (name, description)
    $wait.until {
      $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistryPage::NEW_COLLECTION_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, CreateGiftCollection::COLLECTION_NAME_FIELD_ID).displayed?
    }
    #Complete field to create a new collection
    $browser.find_element(:id, CreateGiftCollection::COLLECTION_NAME_FIELD_ID).send_keys name
    $browser.find_element(:xpath, CreateGiftCollection::DESCRIPTION_FIELD_XPATH).send_keys description
    #Click on Create Collection button
    $browser.find_element(:xpath, CreateGiftCollection::CREATE_COLLECTION_BUTTON_XPATH).click
    #Verify if "Added colection" message appears
    $wait.until {
      $browser.find_element(:id, CreateGiftCollection::COLLECTION_ADDED_MESSAGE_ID).displayed?
    }
  end
    
  
  
  
  
  
  
  
  
  
end