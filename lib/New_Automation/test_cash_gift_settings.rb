require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'

require_relative './pages/home_page.rb'
require_relative './pages/Login_modal.rb'
require_relative './pages/registry_settings_page.rb'
require_relative './pages/cash_gift_settings_page.rb'


class TestCashGiftSettings < TestBasic
  
  #SUITE : CASH GIFT SETTINGS
  
=begin
    #PENDING METHOD
    def test_YouCoverTheProcessingFee
    
      #TEST : CHANGE CREDIT CARD FEE, MAKING YOU COVER THE PROCESSING FEE (TC698)
    
    end  

    #PENDING METHOD
    def  test_GuestCoverTheProcessingFee
      
      #TEST : CHANGE CREDIT CARD FEE, MAKING THE GUESTS COVER THE PROCESSING FEE (TC699)
      
    end  
=end


  def test_LeaveRoutingNumBlank
    
    #TEST : ADD A BANK ACCOUNT LEAVING THE ROUTING NUMBER IN BANK (TC700)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).displayed?
    }
  end

  def test_LeaveAccountNumBlank
    
    #TEST : ADD A BANK ACCOUNT LEAVING THE ACCOUNT NUMBER IN BLANK (TC701)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).displayed?
    }
  end

  def test_LeaveNameBlank
    
    #TEST : ADD A BANK ACCOUNT LEAVING THE NAME IN BLANK (TC702)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_NAME_MESSAGE).displayed?
    }
  end

  def test_LeaveStreetAddressBlank
    
    #TEST : ADD A BANK ACCOUNT LEAVING LEAVING THE STREET ADDRESS IN BLANK (TC703)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_STREET_MESSAGE).displayed?
    }
  end
  
  def test_LeaveCityBlank
    
    #TEST : ADD A BANK ACCOUNT LEAVING THE CITY IN BLANK (TC704)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_CITY_MESSAGE).displayed?
    }
  end

  def test_LeaveStateBlank
    
    #TEST : ADD A BANK ACCOUNT LEAVING THE STATE IN BLANK (TC705)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_STATE_MESSAGE).displayed?
    }
  end

  def test_LeaveZipCodeBlank
    
    #ADD A BANK ACCOUNT LEAVING THE ZIP CODE IN BLANK (TC706)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).displayed?
    }
  end

  def test_LeaveDateOfBirthMonthBlank
    
    #ADD A BANK ACCOUNT LEAVING THE MONTH FIELD "DATE OF BIRTH" SECTION IN BLANK (TC707)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_MONTH).displayed?
    }
  end

  def test_LeaveDateOfBirthDayBlank
    
    #TEST : ADD A BANK ACCOUNT LEAVING THE DAY FIELD "DATE OF BIRTH" SECTION IN BLANK (TC708)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_DAY).displayed?
    }
  end

  def test_LeaveDateOfBirthYearBlank
    
    #TEST : ADD A BANK ACCOUNT LEAVING THE YEAR FIELD "DATE OF BIRTH" SECTION IN BLANK (TC709)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_YEAR).displayed?
    }
  end

  def test_ShorterRoutingNum
    
    #TEST : ADD A BANK ACCOUNT WITH A ROUTING NUMBER THAT HAS LESS THAN 9 DIGITS (TC710)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::SHORT_ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).text == CashGiftSettings::ERROR_ROUTING_TEXT
    }
    
  end

  def test_LargerRoutingNum
    
    #TEST : ADD A BANK ACCOUNT WITH A ROUTING NUMBER THAT HAS MORE THAN 9 DIGITS (TC711)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::LARGE_ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).text == CashGiftSettings::ERROR_ROUTING_TEXT
    }
    
  end
  
  def test_NonNumericRoutingNum
    
    #TEST : ADD A BANK ACCOUNT WITH A NON-NUMERIC ROUTING NUMBER (TC1484)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).text == CashGiftSettings::ERROR_ROUTING_NON_NUMERIC_TEXT
    }
    
  end

  def test_AccountLessThreeDigits
    
    #TEST : ADD A BANK ACCOUNT WITH A ACCOUNT NUMBER THAT HAS LESS THAN 3 DIGITS (TC712)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::SHORT_ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).text == CashGiftSettings::ERROR_ACCOUNT_TEXT
    }
    
  end

  def test_AccountLargerSeventeenDigits
    
    #TEST : ADD A BANK ACCOUNT WITH A ACCOUNT NUMBER THAT HAS MORE THAN 17 DIGITS (TC713)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::LARGER_ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).text == CashGiftSettings::ERROR_ACCOUNT_TEXT
    }
    
  end

  def test_NonNumericAccountNum
    
    #TEST : ADD A BANK ACCOUNT WITH A NON-NUMERIC ACCOUNT NUMBER (TC1485)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).text == CashGiftSettings::ERROR_ROUTING_NON_NUMERIC_TEXT
    }
    
  end

  def test_OneWordBankName
    
    #TEST : ADD A BANK ACCOUNT WITH A NAME OF ONLY ONE WORD (TC1486)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_NAME_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_NAME_MESSAGE).text == CashGiftSettings::ERROR_NAME_WORDS_TEXT
    }
    
  end

  def test_LessFiveNumZipCode
    
    #TEST : ADD A BANK ACCOUNT WITH LESS THAN FIVE NUMBER ZIP CODE (TC714)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::SHORT_ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).text == CashGiftSettings::ERROR_ZIPCODE_WORDS_TEXT
    }
    
  end

    def test_WrongFutureBirthDate
    
    #TEST : ADD A BANK ACCOUNT WITH A FUTURE DATE AS DATE OF BIRTH (TC1487)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::WRONG_YEAR_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_YEAR).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_YEAR).text == CashGiftSettings::ERROR_DATE_WORDS_TEXT
    }
    
  end

  def test_SuccessfullyAddRemoveAccount
    
    #Test cases TC715 and TC1483 add a successfully bank account and remove it
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::VALID_ACCOUNT_ENTER).displayed?
      $browser.find_element(:id => CashGiftSettings::VALID_ACCOUNT_ENTER).text == CashGiftSettings::VALID_ACCOUNT_ENTER_TEXT
    }
    $browser.find_element(:xpath => CashGiftSettings::REMOVE_BANK_ACCOUNT_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).displayed?
    }
    
  end

  def test_MoreFiveNumZipCode
    
    #TEST : ADD A BANK ACCOUNT WITH MORE FIVE NUMBER ZIP CODE (TC1511)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::LARGE_ZIPCODE_NUMBER
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).text == CashGiftSettings::ERROR_ZIPCODE_WORDS_TEXT
    }
    
  end

  def test_NonNumericZipCode
    
    #TEST : ADD A BANK ACCOUNT WITH A NON NUMERIC ZIP CODE (TC1512)
    
    #Logueo
    
    $browser.find_element(:id => HomePage::LOGIN_ID).click
    assert $wait.until{
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_LOGIN_TEXTBOX_XPATH).send_keys LoginModal::TEST_USER_PASSWORD
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::ACCOUNT_XPATH).displayed?
    }
    
    #Go to cash gift settings
     
    $browser.action.move_to($browser.find_element(:xpath => HomePage::ACCOUNT_XPATH)).perform
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:xpath => HomePage::REGISTRY_SETTINGS_ID).click
    assert $wait.until{
        $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => RegistrySettingPage::CASH_GIFT_SETTINGS_ID).click

    #Complete cash gift settings
    
    assert $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STATE_ADDRESS_ID).send_keys CashGiftSettings::STATE
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::MONTH_BIRTH_ID).send_keys CashGiftSettings::MONTH_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::DAY_BIRTH_ID).send_keys CashGiftSettings::DAY_OF_BIRTH
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::YEAR_OF_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).text == CashGiftSettings::ERROR_ZIPCODE_WORDS_TEXT
    }
    
  end
end