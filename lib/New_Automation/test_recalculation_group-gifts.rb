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

class TestRecalculationGroupGifts < TestBasic
  
  #Login using the provided user email and password
  def login (userEmail, password)
    $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys userEmail
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys password
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
  end
  
  
  #CLEANS THE VALUES ON THE FIELDS
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
    #cleans fields and complete the shipping information with new values
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
    #verify ok message is displayed
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    } 
 end
  
  #CHANGE SHIPPING INFORMATION TO NON NEW YORK
  def change_shipping_information_not_ny #####tested
    #cleans fields and complete the shipping information with new values
    cleanFields
    $browser.find_element(:xpath => ShippingInfoPage::FIRST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::FIRST_NAME_2
    $browser.find_element(:xpath => ShippingInfoPage::LAST_NAME_TEXTBOX_XPATH).send_keys ShippingInfoPage::LAST_NAME_2
    $browser.find_element(:xpath => ShippingInfoPage::STREET_ADDRESS_TEXTBOX_XPATH).send_keys ShippingInfoPage::STREET_2
    $browser.find_element(:xpath => ShippingInfoPage::APTO_TEXTBOX_XPATH).send_keys ShippingInfoPage::APTO_2
    $browser.find_element(:xpath => ShippingInfoPage::CITY_TEXTBOX_XPATH).send_keys ShippingInfoPage::CITY_2
    Common.selectByText($browser.find_element(:id, ShippingInfoPage::STATE_SELECT_ID), ShippingInfoPage::STATE_2)
    $browser.find_element(:xpath => ShippingInfoPage::ZIPCODE_TEXTBOX_XPATH).send_keys ShippingInfoPage::ZIPCODE_2
    $browser.find_element(:xpath => ShippingInfoPage::PHONE_TEXTBOX_XPATH).send_keys ShippingInfoPage::PHONE_2
    #clicks on button save changes
    $browser.find_element(:xpath => ShippingInfoPage::BUTTON_SAVE_CHANGES_XPATH).click
    #verify ok message is displayed
    $wait.until{
      $browser.find_element(:xpath => ShippingInfoPage::OK_MESSAGE_XPATH).displayed?
    } 
  end
  
  #TC1067 TOGGLE ADDRESS BETWEEN NEW YORK AND NON NEW YORK
  def test_toggle_ny_non_ny
    #me logueo
    login(Common::USER_GROUP_GIFT_EMAIL, Common::USER_GROUP_GIFT_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath, HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    #voy a browser gift page
    $browser.get HomePage::ZOLA_SHOP_URL
    $wait.until{
      $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #agrego un gift al registry
    $browser.find_element(:xpath, Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::ADD_TO_REGISTRY_BUTTON_XPATH).click
    #voy a registry page
    $browser.get HomePage::HOME_URL
    #clickeo sobre el primer gift
    $wait.until{
      $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).displayed?
    }
    #convierto el gifst a groupgift ##### hasta aca llega falla en el 110
    $browser.find_element(:xpath, RegistryPage::FIRST_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:id, Pdp::ADDTOCART_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, Pdp::EDIT_GIFT_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath, Pdp::SAVE_CHANGE_BUTTON_ID).displayed?
    }
    
  end
    
 
  
  
end