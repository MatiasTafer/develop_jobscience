require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'

require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'
require_relative './pages/registry_settings_page.rb'
require_relative './pages/cash_gift_settings_page.rb'


class TestCashGiftSettings < TestBasic
  
  #SUITE : CASH GIFT SETTINGS
  
=begin
    #TODO: PENDING METHOD
    def test_YouCoverTheProcessingFee
    
      #TEST : CHANGE CREDIT CARD FEE, MAKING YOU COVER THE PROCESSING FEE (TC698)
    
    end  

    #PENDING METHOD
    def  test_GuestCoverTheProcessingFee
      
      #TEST : CHANGE CREDIT CARD FEE, MAKING THE GUESTS COVER THE PROCESSING FEE (TC699)
      
    end  
=end

   #Test cases TC715 and TC1483 add a successfully bank account and remove it
  def test_SuccessfullyAddRemoveAccount
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings
    
    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::VALID_ACCOUNT_ENTER).displayed?
      $browser.find_element(:id => CashGiftSettings::VALID_ACCOUNT_ENTER).text == CashGiftSettings::VALID_ACCOUNT_ENTER_TEXT
    }
    
    #rollback: remove the bank account associated with the current user
    $browser.find_element(:xpath => CashGiftSettings::REMOVE_BANK_ACCOUNT_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).displayed?
    }
    
  end

  #TEST : ADD A BANK ACCOUNT LEAVING THE ROUTING NUMBER IN BLANK (TC700)
  def test_LeaveRoutingNumBlank
 
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings
    
    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).displayed?
    }
  end

  #TEST : ADD A BANK ACCOUNT LEAVING THE ACCOUNT NUMBER IN BLANK (TC701)
  def test_LeaveAccountNumBlank
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).displayed?
    }
  end

  #TEST : ADD A BANK ACCOUNT LEAVING THE NAME IN BLANK (TC702)
  def test_LeaveNameBlank
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_NAME_MESSAGE).displayed?
    }
  end

  #TEST : ADD A BANK ACCOUNT LEAVING LEAVING THE STREET ADDRESS IN BLANK (TC703)
  def test_LeaveStreetAddressBlank

    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_STREET_MESSAGE).displayed?
    }
  end

  #TEST : ADD A BANK ACCOUNT LEAVING THE CITY IN BLANK (TC704)
  def test_LeaveCityBlank

    #Login 
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings fields
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_CITY_MESSAGE).displayed?
    }
  end

  #TEST : ADD A BANK ACCOUNT LEAVING THE STATE IN BLANK (TC705)
  def test_LeaveStateBlank
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_STATE_MESSAGE).displayed?
    }
  end

  #ADD A BANK ACCOUNT LEAVING THE ZIP CODE IN BLANK (TC706)
  def test_LeaveZipCodeBlank
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).displayed?
    }
  end

  #ADD A BANK ACCOUNT LEAVING THE MONTH FIELD "DATE OF BIRTH" SECTION IN BLANK (TC707)
  def test_LeaveDateOfBirthMonthBlank

    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_MONTH).displayed?
    }
  end

  #TEST : ADD A BANK ACCOUNT LEAVING THE DAY FIELD "DATE OF BIRTH" SECTION IN BLANK (TC708)
  def test_LeaveDateOfBirthDayBlank
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_DAY).displayed?
    }
  end

  #TEST : ADD A BANK ACCOUNT LEAVING THE YEAR FIELD "DATE OF BIRTH" SECTION IN BLANK (TC709)
  def test_LeaveDateOfBirthYearBlank
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_YEAR).displayed?
    }
  end

  #TEST : ADD A BANK ACCOUNT WITH A ROUTING NUMBER THAT HAS LESS THAN 9 DIGITS (TC710)  
  def test_ShorterRoutingNum

    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::SHORT_ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).text == CashGiftSettings::ERROR_ROUTING_TEXT
    }
  end

  #TEST : ADD A BANK ACCOUNT WITH A ROUTING NUMBER THAT HAS MORE THAN 9 DIGITS (TC711)
  def test_LargerRoutingNum

    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::LARGE_ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).text == CashGiftSettings::ERROR_ROUTING_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH A NON-NUMERIC ROUTING NUMBER (TC1484)
  def test_NonNumericRoutingNum
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ROUTING_MESSAGE).text == CashGiftSettings::ERROR_ROUTING_NON_NUMERIC_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH A ACCOUNT NUMBER THAT HAS LESS THAN 3 DIGITS (TC712)
  def test_AccountLessThreeDigits
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::SHORT_ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).text == CashGiftSettings::ERROR_ACCOUNT_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH A ACCOUNT NUMBER THAT HAS MORE THAN 17 DIGITS (TC713)
  def test_AccountLargerSeventeenDigits

    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::LARGER_ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).text == CashGiftSettings::ERROR_ACCOUNT_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH A NON-NUMERIC ACCOUNT NUMBER (TC1485)
  def test_NonNumericAccountNum
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ACCOUNT_MESSAGE).text == CashGiftSettings::ERROR_ROUTING_NON_NUMERIC_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH A NAME OF ONLY ONE WORD (TC1486)
  def test_OneWordBankName
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::CITY
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_NAME_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_NAME_MESSAGE).text == CashGiftSettings::ERROR_NAME_WORDS_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH LESS THAN FIVE NUMBER ZIP CODE (TC714)
  def test_LessFiveNumZipCode

    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    assert $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::SHORT_ACCOUNT_NUMBER
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error messages displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).text == CashGiftSettings::ERROR_ZIPCODE_WORDS_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH A FUTURE DATE AS DATE OF BIRTH (TC1487)
  def test_WrongFutureBirthDate
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::ZIP_CODE
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    $browser.find_element(:id => CashGiftSettings::YEAR_BIRTH_ID).send_keys CashGiftSettings::WRONG_YEAR_BIRTH
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_YEAR).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_DATE_OF_BIRTH_YEAR).text == CashGiftSettings::ERROR_DATE_WORDS_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH MORE FIVE NUMBER ZIP CODE (TC1511)
  def test_MoreFiveNumZipCode
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::LARGE_ZIPCODE_NUMBER
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).text == CashGiftSettings::ERROR_ZIPCODE_WORDS_TEXT
    }
    
  end

  #TEST : ADD A BANK ACCOUNT WITH A NON NUMERIC ZIP CODE (TC1512)
  def test_NonNumericZipCode
    
    #Login
    Common.login(LoginModal::TEST_USER_EMAIL, LoginModal::TEST_USER_PASSWORD)
    $wait.until{
        $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to cash gift settings
    goToCashGiftSettings

    #Complete cash gift settings
    $browser.find_element(:id => CashGiftSettings::ROUTING_NUMBER_ID).send_keys CashGiftSettings::ROUTING_NUMBER
    $browser.find_element(:id => CashGiftSettings::ACCOUNT_TEXTBOX_ID).send_keys CashGiftSettings::ACCOUNT_NUMBER
    $browser.find_element(:id => CashGiftSettings::BANK_NAME_ID).send_keys CashGiftSettings::NAME
    $browser.find_element(:id => CashGiftSettings::STREET_ADDRESS_ID).send_keys CashGiftSettings::STREET_ADDRESS
    $browser.find_element(:id => CashGiftSettings::APT_ADDRESS_ID).send_keys CashGiftSettings::APT_ADDRESS
    $browser.find_element(:id => CashGiftSettings::CITY_ADDRESS_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::STATE_ADDRESS_ID), CashGiftSettings::STATE)
    $browser.find_element(:id => CashGiftSettings::ZIP_CODE_ID).send_keys CashGiftSettings::CITY
    Common.selectByText($browser.find_element(:id, CashGiftSettings::MONTH_BIRTH_ID), CashGiftSettings::MONTH_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::DAY_BIRTH_ID), CashGiftSettings::DAY_OF_BIRTH)
    Common.selectByText($browser.find_element(:id, CashGiftSettings::YEAR_BIRTH_ID), CashGiftSettings::YEAR_OF_BIRTH)
    
    $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).click
    
    #Verify error message is displayed
    assert $wait.until{
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).displayed?
      $browser.find_element(:id => CashGiftSettings::ERROR_ZIP_CODE_MESSAGE).text == CashGiftSettings::ERROR_ZIPCODE_WORDS_TEXT
    }
  end

  #Go to Cash Gift Settings section
  def goToCashGiftSettings
    
    #Clicks on Registry Settings
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
        $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click
    $wait.until{
        $browser.find_element(:id => RegistrySettingsPage::CASH_GIFT_SETTINGS_ID).displayed?
    }
    
    #Clicks on Cash Gift Settings menu
    $browser.find_element(:id => RegistrySettingsPage::CASH_GIFT_SETTINGS_ID).click
    $wait.until{
      $browser.find_element(:xpath => CashGiftSettings::SUBMIT_CHANGES_BUTTON_XPATH).displayed?
    }
  end
end