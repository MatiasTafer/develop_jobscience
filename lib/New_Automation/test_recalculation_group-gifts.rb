require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/honeymoon_cash_fund_page.rb'
require_relative './pages/new_cash_item_modal.rb'
require_relative './pages/shop_page.rb'
require_relative './pages/shipping_info_page.rb'
require_relative './pages/registry_settings_page.rb'
require_relative './pages/collection_page.rb'
require_relative './pages/pdp_page.rb'
require_relative './pages/registry_page.rb'
require_relative './pages/remove_item_confirm_modal.rb'
require_relative './pages/adjustments_group_gift_modal.rb'

#To run the test you need an acount:
              # With registry
              # If it has gifts, these doesn't be fulfilled
              # Account default: Common (User:USER_GROUP_GIFT_EMAIL, Password: USER_GROUP_GIFT_PASSWORD)

class TestRecalculationGroupGifts < TestBasic
  
  
  #LOGIN USING THE PROVIDED USER EMAIL AND PASSWORD
  def login (userEmail, password)
    $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys userEmail
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys password
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
  end
  
  
  #CLEANS THE VALUES ON THE FIELDS ON SHIPPING INFORMATION
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
  
  
 #CHANGE SHIPPING INFORMATION TO NEW YORK 
 def change_shipping_information_ny ####Tested
    #clean fields and complete the shipping information with new values
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRS_NAME_3
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME_3
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET_3
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO_3
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY_3
    Common.selectByText($browser.find_element(:id, ShippingInfoPage::STATE_SELECT_ID), ShippingInfoPage::STATE_3)
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE_3
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE_3
    #clicks on button save changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
 end
  
  
  #CHANGE SHIPPING INFORMATION TO NON NEW YORK
  def change_shipping_information_not_ny #####tested
    #Clean fields and complete the shipping information with new values
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME_2
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME_2
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET_2
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO_2
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY_2
    Common.selectByText($browser.find_element(:id, ShippingInfoPage::STATE_SELECT_ID), ShippingInfoPage::STATE_2)
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE_2
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE_2
    #Clicks on button save changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
  end


  #TC1067 TOGGLE ADDRESS BETWEEN NEW YORK AND NON NEW YORK
  def test_toggle_ny_non_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change Shipping information to New York address
    change_shipping_information_ny 
    #Go to browse gift url
    $wait.until{
      $browser.get HomePage::ZOLA_SHOP_URL
    }
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Add gift to registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #Go to registry
    $browser.get HomePage::HOME_URL
    #Select the first gift on registry page
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Convert gift to group gift
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
    }
    #Go to Shipping information page
    $wait.until{
      $browser.get HomePage::HOME_URL
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change Shipping information to non New York address
    change_shipping_information_not_ny
    #Verify Adjustment group gift modal appears
    assert $wait.until{
      $browser.find_element(:xpath, AdjustmentGroupGift::OKAY_GOT_IT_BUTTON_XPATH).displayed?
    }
  end
 
 
  #TC1068 TOGGLE ADDRESS BETWEEN NON-NY AND NEW YORK ADDRESSES
  def test_toggle_non_ny_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to non New York address
    change_shipping_information_not_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Go to browse gift url
    $wait.until{
      $browser.get HomePage::ZOLA_SHOP_URL
    }
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Add gift to registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #Go to registry
    $browser.get HomePage::HOME_URL
    #Select the first gift on registry page
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Convert gift to group gift
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
    }
    #Go to Shipping information page
    $wait.until{
      $browser.get HomePage::HOME_URL
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change Shipping information to New York address
    change_shipping_information_ny
    #Verify Adjustment group gift modal appears
    assert $wait.until{
      $browser.find_element(:xpath, AdjustmentGroupGift::OKAY_GOT_IT_BUTTON_XPATH).displayed?
    }
  end


  #TC1069 TOGGLE ADDRESS BETWEEN NON NEW YORK AND NON NEW YORK ADDRESSES
  def test_toggle_non_ny_non_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to non New York address
    change_shipping_information_not_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Go to browse gift url
    $wait.until{
      $browser.get HomePage::ZOLA_SHOP_URL
    }
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Add gift to registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #Go to registry
    $browser.get HomePage::HOME_URL
    #Select the first gift on registry page
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Convert gift to group gift
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
    }
    #Go to Shipping information page
    $wait.until{
      $browser.get HomePage::HOME_URL
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to non New York address
    change_shipping_information_not_ny
    #Verify adjustment group gift modal not appears
    assert $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
  end


  #TC1070 TOGGLE ADDRESS BETWEEN NEW YORK AND NEW YORK ADDRESSES
  def test_toggle_ny_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to New York
    change_shipping_information_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Go to browse gift url
    $wait.until{
      $browser.get HomePage::ZOLA_SHOP_URL
    }
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Add gift to registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #Go to registry
    $browser.get HomePage::HOME_URL
    #Select the first gift on registry page
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Convert gift to group gift
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
    }
    #Go to Shipping information page
    $wait.until{
      $browser.get HomePage::HOME_URL
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change Shipping information to New York address
    change_shipping_information_ny
    #Verify Adjustment group gift modal not appears
    assert $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
  end


  #TC1085 TOGGLE ADDRESS BETWEEN NEW YORK AND NON NEW YORK NO GROUP GIFT
  def test_not_group_gift_non_ny_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to New York
    change_shipping_information_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Go to browse gift url
    $wait.until{
      $browser.get HomePage::ZOLA_SHOP_URL
    }
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Add gift to registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #Go to Shipping information page
    $wait.until{
      $browser.get HomePage::HOME_URL
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to non New York address
    change_shipping_information_not_ny
    #Verify Adjustment group gift modal not appears
    assert $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
  end


   #TC1071 TOGGLE ADDRESS BETWEEN NON NEW YORK AND NEW YORK ADRESSES NO GROUP GIFT
   def test_not_group_gift_ny_non_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to not New York
    change_shipping_information_not_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Go to browse gift url
    $wait.until{
      $browser.get HomePage::ZOLA_SHOP_URL
    }
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Add gift to registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #Go to Shipping information page
    $wait.until{
      $browser.get HomePage::HOME_URL
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to New York address
    change_shipping_information_ny
    #Verify Adjustment group gift modal not appears
    assert $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
   end
    
    
   #TC1072 TOGGLE ADDRESS BETWEEN NON NEW YORK AND NON NEW YORK NO GROUP GIFT
   def test_not_group_gift_non_ny_non_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to non New York
    change_shipping_information_not_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Go to browse gift url
    $wait.until{
      $browser.get HomePage::ZOLA_SHOP_URL
    }
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Add gift to registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #Go to Shipping information page
    $wait.until{
      $browser.get HomePage::HOME_URL
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to non New York address
    change_shipping_information_not_ny
    #Verify Adjustment group gift modal not appears
    assert $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    } 
   end
   
   
   #TC1084 TOGGLE ADDRESS BETWEEN NEW YORK AND NEW YORK ADRESSES NO GROUP GIFT
   def test_not_group_gift_ny_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to New York
    change_shipping_information_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Go to browse gift url
    $wait.until{
      $browser.get HomePage::ZOLA_SHOP_URL
    }
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Add gift to registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #Go to Shipping information page
    $wait.until{
      $browser.get HomePage::HOME_URL
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to New York address
    change_shipping_information_ny
    #Verify Adjustment group gift modal not appears
    assert $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
   end
    
    
   #TC1073 DELETE GROUP GIFT NEW YORK AND NON NEW YORK ADDRESS
   def test_delete_group_gift_ny_non_ny
   #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to New York
    change_shipping_information_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Add two gifts to registry
    for i in 0..1
      #Go to browse gift url
      $wait.until{
        $browser.get HomePage::ZOLA_SHOP_URL
      }
      $wait.until{
        $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
      }
      #Add gift to registry
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
      $wait.until{
        $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
      }
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
      #Go to registry
      $browser.get HomePage::HOME_URL
      #Select the first gift on the registry page
      $wait.until{
        $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
      }
    end
    #Convert firs gift to group gift
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
      $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH).displayed?
    }
    #Convert second gift to group gift
    $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Save the name of the first element of registry
    firstGiftRegistryName = $browser.find_element(:xpath, RegistryPage::NAME_OF_FIRST_ITEM_IN_REGISTRY_XPATH).text
    #Delete the first item on registry
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).displayed?
    }
    $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_MESSAGE_ID).displayed?
      $browser.get HomePage::HOME_URL
    }
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change Shipping information to non New York
    change_shipping_information_not_ny
    $wait.until {
      $browser.find_element(:xpath, AdjustmentGroupGift::OKAY_GOT_IT_BUTTON_XPATH).displayed?
    }
    #Verify if the deleted product does not appear on modal
    assert $wait.until {
      $browser.find_element(:xpath, AdjustmentGroupGift::NAME_FIRST_GROUP_GIFT_XPATH).text != firstGiftRegistryName 
    }
   end
   
   
   #TC1074 DELETE GROUP GIFT NON NEW YORK AND NEW YORK ADDRESS
   def test_delete_group_gift_non_ny_ny
   #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to non New York
    change_shipping_information_not_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Add two gifts to registry
    for i in 0..1
      #Go to browse gift url
      $wait.until{
        $browser.get HomePage::ZOLA_SHOP_URL
      }
      $wait.until{
        $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
      }
      #Add gift to registry
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
      $wait.until{
        $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
      }
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
      #Go to registry
      $browser.get HomePage::HOME_URL
      #Select the first gift on the registry page
      $wait.until{
        $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
      }
    end
    #Convert firs gift to group gift
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
      $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH).displayed?
    }
    #Convert second gift to group gift
    $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Save the name of the first gift on registry
    firstGiftRegistryName = $browser.find_element(:xpath, RegistryPage::NAME_OF_FIRST_ITEM_IN_REGISTRY_XPATH).text
    #Delete the first item on registry
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).displayed?
    }
    $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_MESSAGE_ID).displayed?
      $browser.get HomePage::HOME_URL
    }
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change Shipping information to New York
    change_shipping_information_ny
    $wait.until {
      $browser.find_element(:xpath, AdjustmentGroupGift::OKAY_GOT_IT_BUTTON_XPATH).displayed?
    }
    #Verify if the deleted product does not appear on modal
    assert $wait.until {
      $browser.find_element(:xpath, AdjustmentGroupGift::NAME_FIRST_GROUP_GIFT_XPATH).text != firstGiftRegistryName 
    }
   end
   
   
   #TC1075 FULFILLED PRODUCT NEW YORK AND NON NEW YORK
   def test_filfilled_ny_non_ny
   #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to New York
    change_shipping_information_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Add two gifts to registry
    for i in 0..1
      #Go to browse gift url
      $wait.until{
        $browser.get HomePage::ZOLA_SHOP_URL
      }
      $wait.until{
        $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
      }
      #Add gift to registry
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
      $wait.until{
        $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
      }
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
      #Go to registry
      $browser.get HomePage::HOME_URL
      #Select the first gift on registry page
      $wait.until{
        $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
      }
    end
    #Convert firs gift to fulfilled gift
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::MARK_AS_FULLFIELD_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::MARK_AS_FULLFIELD_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
      $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH).displayed?
    }
    #Convert second gift to group gift
    $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Save the name of the first gift on registry
    firstGiftRegistryName = $browser.find_element(:xpath, RegistryPage::NAME_OF_FIRST_ITEM_IN_REGISTRY_XPATH).text
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change Shipping information to non New York
    change_shipping_information_not_ny
    $wait.until {
      $browser.find_element(:xpath, AdjustmentGroupGift::OKAY_GOT_IT_BUTTON_XPATH).displayed?
    }
    #verify if fulfilled item does not appears on modal
    assert $wait.until {
      $browser.find_element(:xpath, AdjustmentGroupGift::NAME_FIRST_GROUP_GIFT_XPATH).text != firstGiftRegistryName 
    }
    #Go to registry
    $wait.until {
      $browser.get HomePage::HOME_URL
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Unmark all fulfilled gifts on registry
    unmark_all_fulfilled_items
   end
   
   
    #TC1076 FULFILLED PRODUCT NON NEW YORK AND NEW YORK
    def test_filfilled_non_ny_ny
    #Log in
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #Eliminate all items in registry
    clean_registry
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change shipping information to New York
    change_shipping_information_not_ny
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    }
    #Add two gifts to registry
    for i in 0..1
      #Go to browse gift url
      $wait.until{
        $browser.get HomePage::ZOLA_SHOP_URL
      }
      $wait.until{
        $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
      }
      #Add gift to registry
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
      $wait.until{
        $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
      }
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
      #Go to registry
      $browser.get HomePage::HOME_URL
      #Select the first gift on registry page
      $wait.until{
        $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
      }
    end
    #Convert firs gift to fulfilled gift
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::MARK_AS_FULLFIELD_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::MARK_AS_FULLFIELD_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
      $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH).displayed?
    }
    #Convert second gift to group gift
    $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ENABLE_GROUP_GIFT_CHECKBOX_XPATH).click
    #Save changes
    $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Save the name of the first gift on registry
    firstGiftRegistryName = $browser.find_element(:xpath, RegistryPage::NAME_OF_FIRST_ITEM_IN_REGISTRY_XPATH).text
    #Go to Shipping information page
    $wait.until{
      $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::REGISTRY_SETTINGS_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    $browser.find_element(:xpath, RegistrySettingsPage::SHIPPING_INFO_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).displayed?
    }
    #Change Shipping information to non New York
    change_shipping_information_ny
    $wait.until {
      $browser.find_element(:xpath, AdjustmentGroupGift::OKAY_GOT_IT_BUTTON_XPATH).displayed?
    }
    #verify if fulfilled item does not appears on modal
    assert $wait.until {
      $browser.find_element(:xpath, AdjustmentGroupGift::NAME_FIRST_GROUP_GIFT_XPATH).text != firstGiftRegistryName 
    }
    #Go to registry
    $wait.until {
      $browser.get HomePage::HOME_URL
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #Unmark all fulfilled gifts on registry
    unmark_all_fulfilled_items
   end
   
   
   #METHOD UNMARK ALL FULFILLED ITEMS ON REGISTRY
   def unmark_all_fulfilled_items
    #Save all items of registry
    quantityItems = $browser.find_elements(:xpath, RegistryPage::QUANTITY_OF_ITEMS_IN_REGISTRY_XPATH)
    #I move through each item
    for itemPosition in 0..quantityItems.size-1
      $wait.until{
         quantityItems[itemPosition].click
         $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed? 
      }
      #If the element is fulfilled
      if ($browser.find_elements(:xpath, Pdp::FULFILLED_BUTTON_GREY_XPATH).size == 1) then
        $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
        $wait.until {
          $browser.find_element(:xpath, Pdp::MARK_AS_FULLFIELD_CHECKBOX_XPATH).displayed?
        }
        #Unmark fulfilled checkbox
        $browser.find_element(:xpath, Pdp::MARK_AS_FULLFIELD_CHECKBOX_XPATH).click
        $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
        $wait.until {
          $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
          $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
        }
      #if the element not fullfiled
      else 
        $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
        $wait.until {
          $browser.find_element(:xpath, Pdp::MARK_AS_FULLFIELD_CHECKBOX_XPATH).displayed?
        }
        $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_XPATH).click
        $wait.until {
          $browser.find_element(:id, RegistryPage::CHANGE_SAVED_MESSAGE_ID).displayed?
          $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
        }
      end
    end
   end
   
   
    #METHOD TO DELETE ALL ITEMS ON REGISTRY 
    def clean_registry
    #Save all items of registry
    quantityItems = $browser.find_elements(:xpath, RegistryPage::QUANTITY_OF_ITEMS_IN_REGISTRY_XPATH)
    if ( quantityItems.size > 0) then
      #Save the first and the last item on registry
      firstGiftRegistry = $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH) 
      lastGiftRegistry = $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH)
      #If the registry have only one item
        if (firstGiftRegistry.attribute(RegistryPage::GIFT_ATTRIBUTE_ID) == lastGiftRegistry.attribute(RegistryPage::GIFT_ATTRIBUTE_ID)) then
          $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
          $wait.until{
            $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
          }
          $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
          $wait.until{
            $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).displayed?
          }
            $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).click
          $wait.until{
            $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).displayed?
          }
            $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).click
          $wait.until{
            $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_MESSAGE_ID).displayed?
          }
        #Else eliminate all instances of items 
        else
            #Delete all elements on registry 
            while (firstGiftRegistry.attribute(RegistryPage::GIFT_ATTRIBUTE_ID) != lastGiftRegistry.attribute(RegistryPage::GIFT_ATTRIBUTE_ID) ) do
                $wait.until{
                  $browser.find_element(:id, RegistryPage::YOUR_REGISTRY_LINK_ID).displayed?
                }
                $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
                $wait.until{
                  $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
                }
                $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
                $wait.until{
                  $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).displayed?
                }
                $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).click
                $wait.until{
                  $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).displayed?
                }
                $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).click
                $wait.until{
                  $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_MESSAGE_ID).displayed?
                  $browser.get HomePage::HOME_URL
                  $browser.find_element(:id, RegistryPage::YOUR_REGISTRY_LINK_ID).displayed?
                }
                #Save the first and the last item on registry to continue iteration
                firstGiftRegistry = $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH) 
                lastGiftRegistry = $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH)
                #If the first item on registry is equal to the last then deletes it and stops the iteration
                if (firstGiftRegistry.attribute(RegistryPage::GIFT_ATTRIBUTE_ID) == lastGiftRegistry.attribute(RegistryPage::GIFT_ATTRIBUTE_ID)) then
                    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
                    $wait.until{
                      $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).displayed?
                    }
                    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
                    $wait.until{
                      $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).displayed?
                    }
                    $browser.find_element(:xpath, Pdp::DELETE_GIFT_BUTTON_XPATH).click
                    $wait.until{
                      $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).displayed?
                    }
                    $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_BUTTON_ID).click
                    $wait.until{
                      $browser.find_element(:id, RemoveItemConfirmModal::REMOVE_ITEM_MESSAGE_ID).displayed?
                    }
                    break
                #Else save the new first item to delete in next iteration  
                else
                $wait.until{
                  $browser.find_element(:id, RegistryPage::YOUR_REGISTRY_LINK_ID).displayed?
                }
                firstGiftRegistry = $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH)
                lastGiftRegistry = $browser.find_element(:xpath, RegistryPage::LAST_PRODUCT_XPATH)
                end   
            end
          end   
      end
      end
end