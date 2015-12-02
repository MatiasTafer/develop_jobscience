require_relative 'test_basic.rb'
require_relative 'common.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'
require_relative './pages/create_registry_modal.rb'
require_relative './pages/home_page.rb'


class TestRegistryCreation < TestBasic
  


#Successfully creates a new registry
  def test_create_new_registry
 
    #precondition: must be logged in
    Common.create_user_no_registry
    
    #completes required fields
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Kent'
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    url = Common.generate_url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys url
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::WELCOME_SKIP_LINK).displayed?
    }
    
    #Verify the info is correct
    #verfify welcome message
    assert_equal($browser.find_element(:xpath => CreateRegistryModal::WELCOME_LABEL).text, "Welcome, Kent")
    $browser.find_element(:xpath => CreateRegistryModal::WELCOME_SKIP_LINK).click
    
  end

  
  #Create your registry leaving your First Name blank
  def test_your_name_blank
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #leaves the field first name empty and completes the other fields
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    url = Common.generate_url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys url
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_YOUR_NAME_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_YOUR_NAME_ID).text == CreateRegistryModal::ERROR_MESSAGE_YOUR_INFO_ID
    }
  end
    
    #Create your registry leaving your Last Name blank
  def test_your_last_blank
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #leaves the field last name empty and completes the other fields
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Kent'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    url = Common.generate_url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys url
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_YOUR_LAST_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_YOUR_LAST_ID).text == CreateRegistryModal::ERROR_MESSAGE_YOUR_INFO_ID
    }
    
  end

#Create your registry without specifying your type
  def test_your_type
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #leaves the field last name empty and completes the other fields
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Kent'
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    url = Common.generate_url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys url
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_YOUR_TYPE_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_YOUR_TYPE_ID).text == CreateRegistryModal::ERROR_MESSAGE_YOUR_INFO_ID
    }
    
  end

  #Create your registry leaving the fiancee name blank
  def test_fiancee_name_blank
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #leaves the field fiancee's name of empty and completes the other fields
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Kent'
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    url = Common.generate_url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys url
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_FIANCEE_NAME_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_FIANCEE_NAME_ID).text == CreateRegistryModal::ERROR_MESSAGE_FIANCEE_INFO_ID
    }
    
  end

#Create your registry leaving the fiancee last name blank
  def test_fiancee_last_blank
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #leaves the fiancee's first name empty and completes the other fields
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Kent'
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    url = Common.generate_url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys url
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_FIANCEE_LAST_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_FIANCEE_LAST_ID).text == CreateRegistryModal::ERROR_MESSAGE_FIANCEE_INFO_ID
    }
    
  end


#Create your registry whitout specifying the fiancee's type
  def test_fiancee_type
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #leaves the fiancee's type unspecified
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Kent'
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    
    url = Common.generate_url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys url
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_FIANCEE_TYPE_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_FIANCEE_TYPE_ID).text == CreateRegistryModal::ERROR_MESSAGE_FIANCEE_INFO_ID
    }
  end
  
  #Create your registry whitout specifying a wedding date
  def test_no_date
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #completes required fields on sections "your info" and "your partner"
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Kent'
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    #enters the url
    url = Common.generate_url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys url
    
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_DATE_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_DATE_ID).text == CreateRegistryModal::ERROR_MESSAGE_DATE_INFO_ID
    }
  end

  #Create your registry leaving the url empty
  def test_url_empty
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #completes required fields on sections "your info" and "your partner"
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Ryan'
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    #leaves the url empty
    $browser.find_element(:id => CreateRegistryModal::URL_ID).clear
    
    #enters the wedding date
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_URL_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_URL_ID).text == CreateRegistryModal::ERROR_MESSAGE_URL_INFO_ID
    }
  end
  
  #Create your registry with an url already in use
  def test_existing_url
    
    #preconditions: must be logged in
    Common.login_no_registry
    
    #clicks on start your registry
    $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
    
    #completes required fields on sections "your info" and "your partner"
    $browser.find_element(:id => CreateRegistryModal::FIRST_NAME_ID).send_keys 'Ryan'
    $browser.find_element(:id => CreateRegistryModal::LAST_NAME_ID).send_keys 'Brockman'
    $browser.find_element(:xpath => CreateRegistryModal::GROOM_CLASS).click
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_NAME_ID).send_keys 'Edna'
    $browser.find_element(:id => CreateRegistryModal::FIANCEE_LAST_ID).send_keys 'Krabappel'
    $browser.find_element(:xpath => CreateRegistryModal::FIANCEE_BRIDE_CLASS).click
    
    #enters an existin url
    $browser.find_element(:id => CreateRegistryModal::URL_ID).clear
    $browser.find_element(:id => CreateRegistryModal::URL_ID).send_keys Common::URL_EXISTING
    
    #enters the wedding date
    $browser.find_element(:id => CreateRegistryModal::DATE_ID).send_keys "11/20/2015"
    #clicks on create registry button
    $browser.find_element(:xpath => CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).click
    
    #checks error message displayed
    assert $wait.until{
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_URL_ID).displayed?
      $browser.find_element(:id => CreateRegistryModal::ERROR_MESSAGE_URL_ID).text == CreateRegistryModal::ERROR_MESSAGE_URL_EXISTING
    }
  end
end