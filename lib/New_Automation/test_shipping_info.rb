require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'
require_relative './pages/registry_settings_page.rb'
require_relative './pages/shipping_info_page.rb'



class TestShippingInfo < TestBasic

#Successfully change a value on shipping information  
  def test_successfully_change_values
    #Preconditions: must be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #must be on shipping info page
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #cleans fields and complete the shipping information with new values
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME_2
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME_2
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET_2
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO_2
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY_2
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE_2
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE_2
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE_2
    #clicks on button save changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verify ok message is displayed
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    
    #verify data was changed
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    $browser.get "https://qa.zola.com/registry/juanandjulisa/settings/shipping"
    assert_equal($browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH)["value"], ShippingInfoPage::FIRST_NAME_2)
    assert_equal($browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH)["value"], ShippingInfoPage::LAST_NAME_2)
    assert_equal($browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH)["value"], ShippingInfoPage::STREET_2)
    assert_equal($browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH)["value"], ShippingInfoPage::APTO_2)
    assert_equal($browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH)["value"], ShippingInfoPage::CITY_2)
    assert_equal($browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID)["value"], ShippingInfoPage::STATE_2)
    assert_equal($browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH)["value"], ShippingInfoPage::ZIPCODE_2)
    assert_equal($browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH)["value"], ShippingInfoPage::PHONE_2)

    #rollback changes so the account used has the original values
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    #clicks on button save changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verify ok message is displayed
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
  end

  #No name at shipping information
  def test_NoNameShippingInfo
    #Preconditions: must be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #must be on shipping information
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #cleans fields and completes shipping information leaving the first name empty
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    #clicks on button save
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verify error message is displayed
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_ERROR_XPATH).displayed?
    }
  end

  #No last name at shipping information
  def test_NoLastNameShippingInfo
    #Preconditions: must be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #cleans fields and completes shipping address information leaving the last name empty
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    #clicks on button save changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verify error message is displayed
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_ERROR_XPATH).displayed?
    }
  end

  #No street address at shipping information
  def test_NoStreetShippingInfo
    #Preconditions: must be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #must be on Registry Settings page
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    assert $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #cleans fields and complete shipping information leaving street address
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::STREET_ERROR_XPATH).displayed?
    }
  end

  #No city at shipping information
  def test_NoCityShippingInfo
    #Preconditions: must be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #must be on registry settings page
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #clean fiels and complete shipping information leaving the city field empty
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    #clicks on save changes button
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verify error message is displayed
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::CITY_ERROR_XPATH).displayed?
    }
  end

  #No zip code at shipping information
  def test_NoZipCodeShippingInfo
    #Preconditions: must be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #must be on Registry Settings page
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #cleans fields and enter all information, but the zip code
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    #clicks on button Save Changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => ShippingInfoPage::ZIP_CODE_ERROR_ID).displayed?
      #TODO: add error message text
    }
  end

  #Use and invalid zip code
  def test_WrongZipCode
    #Preconditions: must be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #must be on registry settings page
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    #clicks on shipping information
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #cleans and complete fields using an invalid zip code
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys '77de'
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    #clicks on Save changes button
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id, ShippingInfoPage::ZIP_CODE_ERROR_ID).displayed?
      $browser.find_element(:id, ShippingInfoPage::ZIP_CODE_ERROR_ID).text == ShippingInfoPage::ZIP_CODE_ERROR_MESSAGE
    }
  end

  #No phone at shipping information
  def test_NoPhoneShippingInfo
    #Preconditions: must be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #clean and enter values on the fields
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE
    #clicks on button save
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verify error message is displayed
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::PHONE_ERROR_XPATH).displayed?
    }
  end

  #Add a non allowed zip code
  def test_UseInvalidZipCode
    #Preconditions: be logged in
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #enters an invalid zip code
    cleanFields
    zipCode = Common.generate_zipcode
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys zipCode
    #completes the fields with some values
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:id => ShippingInfoPage::STATE_SELECT_ID).send_keys ShippingInfoPage::STATE
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    #click on button save changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verfify error message displayed
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::ZIP_CODE_WRONG_XPATH).displayed?
    }
    #clicks on error message
    $browser.find_element(:xpath => ShippingInfoPage::ZIP_CODE_WRONG_XPATH).click
    #checks that 
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
  end

  #No State at shipping information
  def test_NoStateShippingInfo
    #Preconditions: Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Go to Registry Settings
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    #Clicks on Shipping Information
    $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Enter all the shipping information but the state
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE
    #Clicks on Save Changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #Verify if the error message is displayed
    assert $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::STATE_ERROR_XPATH).displayed?
    }
  end

  #Cleans the values on the fields
  def cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).clear
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).clear
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).clear
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).clear
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).clear
    Common.selectByText($browser.find_element(:id, ShippingInfoPage::STATE_SELECT_ID), "")  
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).clear
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).clear
  end
end