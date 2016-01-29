require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'
require_relative 'common.rb'
require_relative './pages/promotion_page.rb'
require_relative './pages/old_promotion_page'
require_relative './pages/create_registry_modal'


class PromotionPageTest < TestBasic

  #METHOD TO GO TO PROMOTION PAGE
  def go_to_promotion_page
    $browser.get "https://qa.zola.com/promotion/smp"
    $wait.until{
      $browser.find_element(:xpath, PromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).displayed?
    }
  end

  #METHOD TO GO TO OLD PROMOTION PAGE
  def go_to_old_promotion_page
    $browser.get "https://qa.zola.com/promotion/smp?variation=a"
    $wait.until{
      $browser.find_element(:xpath, OldPromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).displayed?
    }
  end
  
  #TC775 SUCCESSFULLY CREATE ACCOUNT
  def test_create_account
    go_to_promotion_page
    $browser.find_element(:id, PromotionPage::EMAIL_FIELD_ID).send_keys Common::generate_email("username")
    $browser.find_element(:id, PromotionPage::PASSWORD_FIELD_ID).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath, PromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify if https://qa.zola.com/registry/new appears  
    assert $wait.until {
      $browser.find_element(:xpath, CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    }   
  end

  #TC770 EMPTY EMAIL
  def test_empty_email
    go_to_promotion_page
    #Complete only password field
    $browser.find_element(:id, PromotionPage::PASSWORD_FIELD_ID).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath, PromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify if error message appears
    $wait.until {
      $browser.find_element(:id, PromotionPage::EMPTY_EMAIL_ERROR_ID).displayed?      
    }
    assert_equal($browser.find_element(:id, PromotionPage::EMPTY_EMAIL_ERROR_ID).text, PromotionPage::EMPTY_EMAIL_ERROR_TEXT)
  end
=begin
  #TC771 INVALID EMAIL
  def test_invalid_email
    go_to_promotion_page
    #Complete fields
    $browser.find_element(:id, PromotionPage::EMAIL_FIELD_ID).send_keys "test.com"
    $browser.find_element(:id, PromotionPage::PASSWORD_FIELD_ID).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath, PromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify error message 
    $wait.until{
      $browser.find_element(:id, PromotionPage::INVALID_EMAIL_ERROR_ID).displayed?      
    }
    assert_equal($browser.find_element(:id, PromotionPage::INVALID_EMAIL_ERROR_ID).text, PromotionPage::INVALID_EMAIL_ERROR_TEXT)
  end
  
  #TC772 ALREADY TAKEN EMAIL
    def test_already_taken_email
    go_to_promotion_page
    #Complete fields
    $browser.find_element(:id, PromotionPage::EMAIL_FIELD_ID).send_keys Common::USER1_EMAIL
    $browser.find_element(:id, PromotionPage::PASSWORD_FIELD_ID).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath, PromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify error message 
    $wait.until {
     $browser.find_element(:id, PromotionPage::TAKEN_EMAIL_ERROR_ID).displayed?     
    } 
    assert_equal($browser.find_element(:id, PromotionPage::TAKEN_EMAIL_ERROR_ID).text, PromotionPage::TAKEN_EMAIL_ERROR_TEXT)
  end

  #TC773 EMPTY PASSWORD
   def test_empty_password
    go_to_promotion_page
    #Complete only email field
    $browser.find_element(:id, PromotionPage::EMAIL_FIELD_ID).send_keys Common::generate_email("username")
    $browser.find_element(:xpath, PromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
   #Verify error message
    $wait.until {
      $browser.find_element(:id, PromotionPage::EMPTY_PASSWORD_ERROR_ID).displayed?      
   }
   assert_equal($browser.find_element(:id, PromotionPage::EMPTY_PASSWORD_ERROR_ID).text, PromotionPage::EMPTY_PASSWORD_ERROR_TEXT)
  end
  
  #TC774 INVALID PASSWORD
  def test_invalid_password
    go_to_promotion_page
    #Complete email and password with less than 8 characters
    $browser.find_element(:id, PromotionPage::EMAIL_FIELD_ID).send_keys Common::generate_email("username")
    $browser.find_element(:id, PromotionPage::PASSWORD_FIELD_ID).send_keys "test"
    $browser.find_element(:xpath, PromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify error message
    $wait.until {
      $browser.find_element(:id, PromotionPage::LENGTH_PASSWORD_ERROR_ID).displayed?      
    }
    assert_equal($browser.find_element(:id, PromotionPage::LENGTH_PASSWORD_ERROR_ID).text, PromotionPage::LENGTH_PASSWORD_ERROR_TEXT)
  end

  #TC1114 TRY TO CREATE ACCOUNT WHEN YOU ARE LOGGED IN
  def test_logged_in   
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $browser.get "https://qa.zola.com/promotion/smp"
    assert $wait.until{
      $browser.find_element(:xpath, PromotionPage::GO_TO_ZOLA_BUTTON_XPATH).displayed?
    }  
  end
  #END NEW PROMOTION PAGE TESTS
=end
=begin   
  #BEGIN OLD PROMOTION PAGE TESTS
  
  #TC1120 SUCCESSFULLY CREATE ACCOUNT IN OLD PROMOTION PAGE
  def test_create_account_old_page
    go_to_old_promotion_page
    $browser.find_element(:id, OldPromotionPage::EMAIL_FIELD_ID).send_keys Common::generate_email("username2")
    $browser.find_element(:id, OldPromotionPage::PASSWORD_FIELD_ID).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath, OldPromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify if https://qa.zola.com/registry/new appears  
    assert $wait.until {
      $browser.find_element(:xpath, CreateRegistryModal::BUTTON_CREATE_REGISTRY_XPATH).displayed?
    } 
  end
  
  #TC1115 EMPTY EMAIL ON OLD PROMOTION PAGE
  def test_empty_email_old_page
    go_to_old_promotion_page
    #Complete only password field
    $browser.find_element(:id, OldPromotionPage::PASSWORD_FIELD_ID).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath, OldPromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify if error message appears
    $wait.until {
      $browser.find_element(:id, OldPromotionPage::EMPTY_EMAIL_ERROR_ID).displayed?      
    }
    assert_equal($browser.find_element(:id, OldPromotionPage::EMPTY_EMAIL_ERROR_ID).text, OldPromotionPage::EMPTY_EMAIL_ERROR_TEXT)
  end

  #TC1116 INVALID EMAIL OLD PROMOTION PAGE
  def test_invalid_email_old_page
    go_to_old_promotion_page
    #Complete field with invalid email
    $browser.find_element(:id, OldPromotionPage::EMAIL_FIELD_ID).send_keys "test@testcom"
    $browser.find_element(:id, OldPromotionPage::PASSWORD_FIELD_ID).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath, OldPromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify if error message appears 
    $wait.until {
      $browser.find_element(:id, OldPromotionPage::INVALID_EMAIL_ERROR_ID).displayed?      
     }
     assert_equal($browser.find_element(:id, OldPromotionPage::INVALID_EMAIL_ERROR_ID).text, OldPromotionPage::INVALID_EMAIL_ERROR_TEXT)
  end

  #TC1117 ALREADY TAKEN EMAIL OLD PROMOTION PAGE
  def test_already_taken_email_old
    go_to_old_promotion_page
    #Complete fields
    $browser.find_element(:id, OldPromotionPage::EMAIL_FIELD_ID).send_keys Common::USER1_EMAIL
    $browser.find_element(:id, OldPromotionPage::PASSWORD_FIELD_ID).send_keys Common::GLOBAL_PASSWORD
    $browser.find_element(:xpath, OldPromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify if error message appears 
    $wait.until {
     $browser.find_element(:id, OldPromotionPage::TAKEN_EMAIL_ERROR_ID).displayed?     
    } 
    assert_equal($browser.find_element(:id, OldPromotionPage::TAKEN_EMAIL_ERROR_ID).text, OldPromotionPage::TAKEN_EMAIL_ERROR_TEXT)
  end
  
  #TC1118 EMPTY PASSWORD OLD PAGE
  def test_empty_password_old_page
    go_to_old_promotion_page
    #Complete only email field
    $browser.find_element(:id, OldPromotionPage::EMAIL_FIELD_ID).send_keys Common::generate_email("username")
    $browser.find_element(:xpath, OldPromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify error message
    $wait.until {
      $browser.find_element(:id, OldPromotionPage::EMPTY_PASSWORD_ERROR_ID).displayed?      
   }
   assert_equal($browser.find_element(:id, OldPromotionPage::EMPTY_PASSWORD_ERROR_ID).text, OldPromotionPage::EMPTY_PASSWORD_ERROR_TEXT)
  end
 
  #TC1119 INVALID PASSWORD OLD PROMOTION PAGE
  def test_invalid_password_old_page
    go_to_old_promotion_page
    #Complete email and password with less than 8 characters
    $browser.find_element(:id, OldPromotionPage::EMAIL_FIELD_ID).send_keys Common::generate_email("username")
    $browser.find_element(:id, OldPromotionPage::PASSWORD_FIELD_ID).send_keys "test"
    $browser.find_element(:xpath, OldPromotionPage::CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH).click
    #Verify error message
    $wait.until {
      $browser.find_element(:id, OldPromotionPage::LENGTH_PASSWORD_ERROR_ID).displayed?      
    }
    assert_equal($browser.find_element(:id, OldPromotionPage::LENGTH_PASSWORD_ERROR_ID).text, OldPromotionPage::LENGTH_PASSWORD_ERROR_TEXT)
  end

  #TC1121 TRY TO CREATE ACCOUNT WHEN YOU ARE LOGGED IN OLD PROMOTION PAGE
  def test_logged_in_old_page
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $browser.get "https://qa.zola.com/promotion/smp?variation=a"
    assert $wait.until{
      $browser.find_element(:xpath, OldPromotionPage::GO_TO_ZOLA_BUTTON_XPATH).displayed?
    }  
  end
=end
end