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
=begin
#Deactivates your Registry
def test_DeactivateRegistry
    #Login  
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
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
      $browser.find_element(:xpath => RegistrySettingsPage::SHIPPING_INFO_XPATH).displayed?
    }
    #Clicks on Deactivate checkbox
    $browser.find_element(:id => RegistrySettingsPage::REGISTRY_DEACTIVATE_ID).click
    #Clicks on Save Changes
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_CHANGE_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => RegistrySettingsPage::OK_MESSAGE_XPATH).displayed?
    }
    #Checks if the registry was deactivated
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_LINK_XPATH).click
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
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MAKE_IT_VISIBLE_BUTTON).displayed?
    }
    $browser.find_element(:xpath => HomePage::MAKE_IT_VISIBLE_BUTTON).click
   
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::ADD_WEDDING_WEB_BUTTON_XPATH).displayed?
    }
  end
=end
  
  #SUCCESSFULLY CHANGE REGISTRY INFO (TC1557)
  def test_SuccessfulyChangeRegistryInfo
    
    #Login
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Goes to registry info page
    goToRegistryInfo
    
    #Get the original values in order to make a rollback
    originalFirstName = $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).attribute('value')
    originalLastName = $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).attribute('value')
    originalPartnerFirstName = $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).attribute('value')
    originalPartnerLastName = $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).attribute('value')
    originalWeddingDate = $browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).attribute('value')
    originalTitle = $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).attribute('value')
    originalGreeting = $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).attribute('value')
    
    #Clean all fields
    cleanFields
    
    #Complete the fields with the new info 
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).send_keys RegistrySettingsPage::FIRST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).send_keys RegistrySettingsPage::LAST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_FIRST_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_LAST_TEXT
    if originalWeddingDate == ""
      #$browser.find_element(:id => RegistrySettingsPage::NO_DECIDED_WEDDING_ID).click
      $browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).send_keys RegistrySettingsPage::DATE_TEXT
    else
      $browser.find_element(:id => RegistrySettingsPage::NO_DECIDED_WEDDING_ID).click
      #$browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).clear
      #$browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).send_keys RegistrySettingsPage::DATE_TEXT
    end
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).send_keys RegistrySettingsPage::TITLE_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys RegistrySettingsPage::GREETING_TEXT
    
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::OK_MESSAGE_ID).displayed?
    }

    #Reload the page
    $browser.navigate.refresh
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::REGISTRY_SETTINGS_BUTTON_ID).displayed?
    }
    nomComp = $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).attribute('value')
    lastNomComp = $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).attribute('value')
    prtNomComp = $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).attribute('value')
    prtLastNomComp = $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).attribute('value')
    weddComp = $browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).attribute('value')
    titleComp = $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).attribute('value')
    greetingComp = $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).attribute('value')

    #Compares if the new values were saved correctly
    assert_equal(nomComp, RegistrySettingsPage::FIRST_NAME_TEXT)
    assert_equal(lastNomComp, RegistrySettingsPage::LAST_NAME_TEXT)
    assert_equal(prtNomComp, RegistrySettingsPage::PARTNER_FIRST_TEXT)
    assert_equal(prtLastNomComp, RegistrySettingsPage::PARTNER_LAST_TEXT)
    if weddComp == ""
      assert_equal($browser.find_element(:id => RegistrySettingsPage::NO_DECIDED_WEDDING_ID).attribute('checked'), "true")
    else
      assert_equal(weddComp, RegistrySettingsPage::DATE_TEXT)
    end
    
    assert_equal(titleComp, RegistrySettingsPage::TITLE_TEXT)
    assert_equal(greetingComp, RegistrySettingsPage::GREETING_TEXT)
    
#------------------------------------- Rollback to original values --------------------------------------------------

    #Clean all fields
    cleanFields
    
    #Complete the fields with the OLD info 
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).send_keys originalFirstName
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).send_keys originalLastName
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).send_keys originalPartnerFirstName
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).send_keys originalPartnerLastName    
    if originalWeddingDate == ""
      $browser.find_element(:id => RegistrySettingsPage::NO_DECIDED_WEDDING_ID).click
    else
      $browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).send_keys originalWeddingDate
    end
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).send_keys originalTitle
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys originalGreeting
    
    #Saves the changes
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::OK_MESSAGE_ID).displayed?
    }
  end

=begin
  #NO FIRST NAME AT REGISTRY INFO (TC1558)
  def test_NoFirstName
    
    #Login
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to Registry info
    goToRegistryInfo
    
    #Clean all fields
    cleanFields
    
    #Complete the fields with the new info leaving the first name empty
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).send_keys RegistrySettingsPage::LAST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_FIRST_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_LAST_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).send_keys RegistrySettingsPage::TITLE_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys RegistrySettingsPage::GREETING_TEXT
    
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    
    #Verify error message displayed
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::YOUR_INFO_FIRST_ERROR_ID).displayed?
    }
    assert_equal($browser.find_element(:id => RegistrySettingsPage::YOUR_INFO_FIRST_ERROR_ID).text, RegistrySettingsPage::YOUR_INFO_ERROR_MESSAGE)
  end

  #NO LAST NAME AT REGISTRY INFO (TC1559)
  def test_NoLastName
    
    #Login
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to Registry info
    goToRegistryInfo
    
    #Clean all fields
    cleanFields
    
    #Complete the fields with the new info leaving the last name empty
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).send_keys RegistrySettingsPage::FIRST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_FIRST_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_LAST_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).send_keys RegistrySettingsPage::TITLE_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys RegistrySettingsPage::GREETING_TEXT
    
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    
    #Look for error message
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::YOUR_INFO_LAST_ERROR_ID).displayed?
    }
    assert_equal($browser.find_element(:id => RegistrySettingsPage::YOUR_INFO_LAST_ERROR_ID).text, RegistrySettingsPage::YOUR_INFO_ERROR_MESSAGE)
  end

  #NO PARTNER FIRST NAME AT REGISTRY INFO (TC1560)
  def test_NoPartnerFirstName
    
    #Login
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to Registry info
    goToRegistryInfo
    
    #Clean all fields
    cleanFields
    
    #Complete the fields with the new info leaving the partner first name empty
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).send_keys RegistrySettingsPage::FIRST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).send_keys RegistrySettingsPage::LAST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_LAST_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).send_keys RegistrySettingsPage::TITLE_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys RegistrySettingsPage::GREETING_TEXT
    
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    
    #Look for error message
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::PARTNER_INFO_FIRST_ERROR_ID).displayed?
    }
    assert_equal($browser.find_element(:id => RegistrySettingsPage::PARTNER_INFO_FIRST_ERROR_ID).text, RegistrySettingsPage::PARTNER_ERROR_MESSAGE)
  end

  #NO PARTNER LAST NAME AT REGISTRY INFO (TC1561)
  def test_NoPartnerLastName
    
    #Login
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to Registry info
    goToRegistryInfo
    
    #Clean all fields
    cleanFields
    
    #Complete the fields with the new info leaving the partner last name empty
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).send_keys RegistrySettingsPage::FIRST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).send_keys RegistrySettingsPage::LAST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_FIRST_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).send_keys RegistrySettingsPage::TITLE_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys RegistrySettingsPage::GREETING_TEXT
    
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    
    #Look for error message
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::PARTNER_INFO_LAST_ERROR_ID).displayed?
    }
    assert_equal($browser.find_element(:id => RegistrySettingsPage::PARTNER_INFO_LAST_ERROR_ID).text, RegistrySettingsPage::PARTNER_ERROR_MESSAGE)
  end

  #NO WEDDING DATE INFO SELECTED (TC1562)
  def test_NoWeddingDateInfo
    
    #Login
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to Registry info
    goToRegistryInfo
        
    #Clean all fields
    cleanFields
    
    #Complete the fields with the new info leaving the wedding date empty
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).send_keys RegistrySettingsPage::FIRST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).send_keys RegistrySettingsPage::LAST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_FIRST_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_LAST_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).send_keys RegistrySettingsPage::TITLE_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys RegistrySettingsPage::GREETING_TEXT
    
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    
    #Look for error message
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::WEDDING_ERROR_ID).displayed?
      $browser.find_element(:id => RegistrySettingsPage::WEDDING_CALENDAR_ID).displayed?
    }
    assert_equal($browser.find_element(:id => RegistrySettingsPage::WEDDING_ERROR_ID).text, RegistrySettingsPage::WEDDING_ERROR_MESSAGE)
  end

  #ENTER INVALID WEDDING DATE (TC1563)
  def test_InvalidWeddingDateInfo
    
    #Login
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to Registry info
    goToRegistryInfo
    
    #Clean all fields
    cleanFields
    
    #Complete the fields with the new info using an invalid date
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).send_keys RegistrySettingsPage::FIRST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).send_keys RegistrySettingsPage::LAST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_FIRST_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_LAST_TEXT
    $browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).send_keys RegistrySettingsPage::WEDDING_INVALID_DATE
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).send_keys RegistrySettingsPage::TITLE_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys RegistrySettingsPage::GREETING_TEXT
    
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    
    #Look for error message
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::WEDDING_ERROR_ID).displayed?
      $browser.find_element(:id => RegistrySettingsPage::WEDDING_CALENDAR_ID).displayed?
    }
    assert_equal($browser.find_element(:id => RegistrySettingsPage::WEDDING_ERROR_ID).text, RegistrySettingsPage::WEDDING_INVALID_MESSAGE)
  end
  
  #NO REGISTRY TITLE (TC1564)
  def test_NoRegitryTitle
    
    #Login
    Common.login(Common::USER2_EMAIL, Common::GLOBAL_PASSWORD)
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Go to Registry info
    goToRegistryInfo
    
    #Clean all fields
    cleanFields
    
    #Complete the fields with the new info leaving the title empty
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).send_keys RegistrySettingsPage::FIRST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).send_keys RegistrySettingsPage::LAST_NAME_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_FIRST_TEXT
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).send_keys RegistrySettingsPage::PARTNER_LAST_TEXT
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).send_keys RegistrySettingsPage::GREETING_TEXT
    
    $browser.find_element(:xpath => RegistrySettingsPage::SAVE_BUTTON_XPATH).click
    
    #Look for error message
    assert $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::REGISTRY_TITLE_ERROR_ID).displayed?
    }
    assert_equal($browser.find_element(:id => RegistrySettingsPage::REGISTRY_TITLE_ERROR_ID).text, RegistrySettingsPage::REGISTRY_TITLE_ERROR_MESSAGE)
  end
=end
  #Goes to Registry Settings page
  def goToRegistryInfo
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $browser.find_element(:id => HomePage::REGISTRY_SETTINGS_ID).click

    $wait.until{
      $browser.find_element(:id => RegistrySettingsPage::REGISTRY_SETTINGS_BUTTON_ID).displayed?
    }
  end

  #Cleans all fields
  def cleanFields
    $browser.find_element(:id => RegistrySettingsPage::YOUR_FIRST_NAME_ID).clear
    $browser.find_element(:id => RegistrySettingsPage::YOUR_LAST_NAME_ID).clear
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_FIRST_NAME_ID).clear
    $browser.find_element(:id => RegistrySettingsPage::PARTNER_LAST_NAME_ID).clear
    if $browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).attribute('value') == ""
      #deselect checkbox if it is already checked
      $browser.find_element(:id => RegistrySettingsPage::NO_DECIDED_WEDDING_ID).click
    else
      $browser.find_element(:id => RegistrySettingsPage::WEDDING_DATE_ID).clear
    end
    
    $browser.find_element(:xpath => RegistrySettingsPage::REGISTRY_TITLE_XPATH).clear
    $browser.find_element(:xpath => RegistrySettingsPage::WELCOME_GREETING_XPATH).clear
  end
end