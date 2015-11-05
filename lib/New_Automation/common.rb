  include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative './pages/home_page.rb'
require_relative './pages/signup_modal.rb'
require_relative './pages/login_modal.rb'
require_relative './pages/create_registry_modal.rb'
require_relative './pages/shop_page.rb'

class Common
  
  #NEW USERS
  USER1_EMAIL = "user1@automation.com"
  GLOBAL_PASSWORD  = "test1234"
  
  USER_CHANGE_PASSWORD_EMAIL  = "user_change_password@automation.com"
  USER_CHANGE_PASSWORD_PASS   = "test12345"
  
  USER_NO_REGISTRY_EMAIL    = "trinity3@trinity.com"
  USER_NO_REGISTRY_PASS     = "test1234"
  URL_EXISTING              = "homerandmarge"
  
  #User used to test: "test_registry_settings"
  USER2_EMAIL = "user2@automation.com"
  
  #--------------
  
  
  USER_CHANGE_PASSWORD_SHORT= "test"
  #Users and password for test: "test_recalculation_group-gift"
  USER_GROUP_GIFT_EMAIL = "testgroupgift@gmail.com"
  USER_GROUP_GIFT_PASSWORD = "1password"
  #User and password for test: "test_public_registry_reminders"
  #USER2_EMAIL = "oktanatesting@gmail.com"
  USER3_EMAIL = "martinds@oktana.io"
  USER23_password = "test1234"
  #User and password for test: "test_manage_collections_registry_page"
  USER4_EMAIL = "user4@gmail.com"
  USER4_PASSWORD = "test1234"
    
  #Creates a new account without registry
  def self.create_user_no_registry
    #click on signup link
    $browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until {
        $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).displayed?
    }
    #types email and pass
    newEmail = generate_email("test")
    $browser.find_element(:xpath => SignupModal::EMAIL_TEXTBOX_XPATH).send_keys newEmail
    $browser.find_element(:xpath => SignupModal::PASSWORD_TEXTBOX_XPATH).send_keys "test1234"
    $wait.until {
      $browser.find_element(:xpath => SignupModal::GLYPHICON_EMAIL_XPATH).displayed?
      $browser.find_element(:xpath => SignupModal::GLYPHICON_PASS_XPATH).displayed?
    }
    #clicks on START YOUR REGISTRY BUTTON
    $browser.find_element(:xpath => SignupModal::BUTTON_SUBMIT_XPATH).click

    $wait.until{
      $browser.find_element(:xpath=> CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }
  end

  #Generates an email
  def self.generate_email(name)
    randomString = SecureRandom.hex.gsub('-','')
    name+"@"+randomString+".com"
  end

  #Generates an URL
  def self.generate_url
    SecureRandom.hex.gsub('-','')
  end
  
  #Generate a Zip Code  
  def self.generate_zipcode
    SecureRandom.random_number(99999)
  end

  #Login using an existing user without registry
  def self.login_no_registry
    #click on login
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    $wait.until {
        $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    #types email and pass
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys USER_NO_REGISTRY_EMAIL
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys USER_NO_REGISTRY_PASS
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click

    $wait.until{
      $browser.find_element(:id => HomePage::START_YOUR_REGISTRY_LINK_ID).displayed?
    }
  end

  #Login using the provided user email and password
  def self.login (userEmail, password)
    #$browser.get "https://qa.zola.com/shop"
    $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys userEmail
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys password
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit
  end

  #Log out
  def self.logout
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:id, HomePage::LOG_OUT_LINK_ID).displayed?
    }
    $browser.find_element(:id, HomePage::LOG_OUT_LINK_ID).click
    $wait.until{
            $browser.find_element(:id, HomePage::LOGIN_LINK_ID).displayed?
    }
  end
  
  #Selects the option from a Select element, by Text
  # selectElement: dropdown element
  # optionText: string option to be selected from the dropdown
  def self.selectByText(dropdown, optionText)
    select = Selenium::WebDriver::Support::Select.new(dropdown)
    select.select_by(:text, optionText)
  end
  
  #Selects the option from a Select element, by Index
  # selectElement: dropdown element
  # index: index number to be selected from the dropdown
  def self.selectByIndex(dropdown, index)
    select = Selenium::WebDriver::Support::Select.new(dropdown)
    select.select_by(:index, index)
  end

  #Selects the option from a Select element, by Text
  # selectElement: dropdown element
  def self.get_selected_option_text(dropdown)
    select = Selenium::WebDriver::Support::Select.new(dropdown)
    selected_optionText = select.selected_options[0].text
    return selected_optionText
  end
  
  #Adds items to your cart
  def self.add_items_to_cart

    #Click on SHOP at home page
    $browser.find_element(:xpath => HomePage::HOME_SHOP_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).displayed?
    }
    #Click on SHOP NOW at Shop page
    $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).click
    
    #Click on the first gift at Starter Collections page
    $wait.until{
       $browser.find_element(:xpath => Collection::COLLECTION_GIFT_XPATH).displayed?
    }    
    $browser.find_element(:xpath => Collection::COLLECTION_GIFT_XPATH).click
    #Click on the button ADD TO CART at pdp modal
    $wait.until{
      $browser.find_element(:xpath => Pdp::MODAL_ADDTOCART_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::MODAL_ADDTOCART_BUTTON_XPATH).click
    
    #Click on the button CONTINUE SHOPPING at cart modal
    $wait.until{
      $browser.find_element(:xpath => CartModal::BUTTON_CONTINUE_SHOPPING_XPATH).displayed?
    }
    $browser.find_element(:xpath => CartModal::BUTTON_CONTINUE_SHOPPING_XPATH).click
    
    #Click on the second gift at Starter Collections page
    $wait.until{
       $browser.find_element(:xpath => Collection::COLLECTION_GIFT2_XPATH).displayed?
    }
    $browser.find_element(:xpath => Collection::COLLECTION_GIFT2_XPATH).click
    
    #Click on the button ADD TO CART at pdp modal
    $wait.until {
      $browser.find_element(:xpath => Pdp::MODAL_ADDTOCART_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::MODAL_ADDTOCART_BUTTON_XPATH).click
    #Click on CONTINUE SHOPPING at cart modal
    $wait.until{
      $browser.find_element(:xpath => CartModal::BUTTON_CONTINUE_SHOPPING_XPATH).displayed?
    }
    $browser.find_element(:xpath => CartModal::BUTTON_CONTINUE_SHOPPING_XPATH).click     
  end
  
  
  
  
  #Remove items from your cart
  #You already clicked in cart
  def self.remove_items_cart
    #Get all Remove links in the cart
    presentElements = $browser.find_elements(:xpath => CartModal::ALL_REMOVE_LINKS_XPATH)
    #While there are more Remove links than 0, I keep removing items
    while (presentElements.size>0)
      #Save the number of Remove links
      cartSize= presentElements.size
      #Clicks on the first Remove link
      presentElements[0].click
      #Waits until the number of Remove links is less than before
      $wait.until {
        $browser.find_elements(:xpath => CartModal::ALL_REMOVE_LINKS_XPATH).size < cartSize
      }
      #Obtains again all the Remove links in the cart
      presentElements = $browser.find_elements(:xpath => CartModal::ALL_REMOVE_LINKS_XPATH)
    end
  end
  

  #This method was created because some wait problems were found using Chrome
  #First it waits to the document and all sub-resources have finished loading
  #Then, it waits for jQuery because Selenium runs fast and makes queries to jQuery before it has had a chance to load into the page
  def self.wait_to_load
    $wait.until {
      $browser.execute_script("return document.readyState;") == "complete"
      $browser.execute_script("return window.jQuery != undefined && jQuery.active === 0")
    }
  end
  
  #Method to go to an item, which you can choose its size, modal
  #Tests (TC1498), (TC1501) and (TC1504)
  def self.goToItemWithSizeModal
    #Go to Collection/easy-entertaining
    $wait.until{
      $browser.find_element(:xpath => HomePage::TWITTER_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::HOME_SHOP_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath => Shop::HOME_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:xpath => Shop::BEDROOM_FURNITURE_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => Shop::BEDROOM_FURNITURE_LINK_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => BedroomCategoryPage::ITEM_WITH_SIZE_XPATH).displayed?
    }
    aux = -1;
    @@find = false   
    while(@@find == false)
      @@find = true;
      way = "(.//*[@class='col-xs-6 col-sm-4'])[#{aux}]//*[@class='quickview-inputs-wrapper']//*[@ng-change='zoSkuSelector.handleChange()']"
      @@find = findSpecificSizeElement(way)   
      if @@find == true
        way = way.slice(0..37)
      end
      aux = aux + 1
    end
     $browser.find_element(:xpath => way + "/div/a").click
     $wait.until{
          $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
     }  
  end
  
  #Find an item that has size options 
  def self.findSpecificSizeElement(xpath)
    array = $browser.find_elements(:xpath => xpath)
    found = array.size > 0
    return found
  end
  
  #Method to go to an item, which you can choose its color, modal
  #Tests (TC1499), (TC1502) and (TC1505)
  def self.goToItemWithcolorModal 
    #Go to Collection/easy-entertaining
    $wait.until{
      $browser.find_element(:xpath => HomePage::TWITTER_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::HOME_SHOP_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath => Shop::HOME_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:xpath => Shop::BEDROOM_FURNITURE_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => Shop::BEDROOM_FURNITURE_LINK_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => BedroomCategoryPage::CATEGORY_TITLE_DIV_XPATH).displayed?
    }
    aux = 1;
    @@find = false   
    while(@@find == false)
      @@find = true;
      way = "(.//*[@class='col-xs-6 col-sm-4'])[#{aux}]//*[@class='swatches hidden-xs']"
      @@find = findSpecificColorElement(way)   
      if @@find == true
        way = way.slice(0..37)
      end
      aux = aux + 1
    end
    
    $browser.find_element(:xpath => way + "/div/a").click
    $wait.until{
      $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
    }
  end
  
   
  #Find an item that has color options
  def self.findSpecificColorElement(xpath)
    array = $browser.find_elements(:xpath => xpath)
    found = array.size > 0
    return found
  end
end