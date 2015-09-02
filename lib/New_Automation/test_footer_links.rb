require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'

require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'

class TestFooterLinks < TestBasic
  
  #Test Suite: FOOTER LINKS
  
=begin  
  
  #PEND METHOD
  
  def test_emailLink
    
    #TEST : FOOTER - EMAIL LINK (TC1431)  
   
  end
=end

  def test_RegistryLink
    
    #TEST : FOOTER - REGISTRY LINK (TC1432)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::EDIT_REGISTRY_LINK_XPATH).click    
    $browser.current_url == HomePage::REGISTRY_URL
    
  end

  def test_FindLink
    
    #TEST : FOOTER - FIND LINK (TC1433)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::FIND_REGISTRY_LINK_XPATH).click    
    $browser.current_url == HomePage::FIND_REGISTRY_URL
    
  end

  def test_AppsLink
    
    #TEST : FOOTER - APPS LINK (TC1434)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::DOWNLOAD_APPS_XPATH).click    
    $browser.current_url == HomePage::DOWNLOAD_APPS_URL
    
  end

  def test_RegistryBenefitsLink
    
    #TEST : REGISTRY BENEFITS LINK (TC1435)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_BENEFITS_ID).click    
    $browser.current_url == HomePage::REGISTRY_BENEFITS_URL
    
  end

  def test_ZolaShopLink
    
    #TEST : ZOLA SHOP LINK (TC1436)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::ZOLA_SHOP_ID).click    
    $browser.current_url == HomePage::ZOLA_SHOP_URL
    
  end

  def test_AboutZolaLink
    
    #TEST : FOOTER - ABOUT ZOLA LINK (TC1437)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::ABOUT_ZOLA_ID).click    
    $browser.current_url == HomePage::ABOUT_ZOLA_URL
    
  end

  def test_PressLink
    
    #TEST : FOOTER - PRESS LINK (TC1438)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::PRESS_ID).click    
    $browser.current_url == HomePage::PRESS_URL
    
  end

  def test_JobsLink
    
    #TEST : FOOTER - JOBS LINK (TC1439)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::JOBS_ID).click    
    $browser.current_url == HomePage::JOBS_URL
    
  end

  def test_BlogLink
    
    #TEST : FOOTER - BLOG LINK (TC1440)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::BLOG_ID).click    
    $browser.current_url == HomePage::BLOG_URL
    
  end

  def test_FaqsLink
    
    #TEST : FOOTER - FAQS LINK (TC1441)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::FAQS_ID).click    
    $browser.current_url == HomePage::FAQS_URL
    
  end

  def test_OrderStatusLink
    
    #TEST : FOOTER - ORDER STATUS LINK (TC1442)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::ORDER_STATUS_ID).click    
    $browser.current_url == HomePage::ORDER_STATUS_URL
    
  end
  
  def test_TwitterLink
    
    #TEST : FOOTER - TWITTER LINK (TC1443)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::TWITTER_XPATH).click    
    $browser.current_url == HomePage::TWITTER_URL
    
  end

  def test_FacebookLink
    
    #TEST : FOOTER - FACEBOOK LINK (TC1444)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::FACEBOOK_XPATH).click    
    $browser.current_url == HomePage::FACEBOOK_URL
    
  end

  def test_PinterestLink
    
    #TEST : FOOTER - PINTEREST LINK (TC1445)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::PINTEREST_XPATH).click    
    $browser.current_url == HomePage::PINTEREST_URL
    
  end

  def test_InstagramLink
    
    #TEST : FOOTER INSTAGRAM LINK (TC1446)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::INSTAGRAM_XPATH).click    
    $browser.current_url == HomePage::INSTAGRAM_URL
    
  end
  
  def test_GooglePLusLink
    
    #TEST : FOOTER - GOOGLE PLUS LINK (TC1447)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::GOOGLE_PLUS_XPATH).click    
    $browser.current_url == HomePage::GOOGLE_PLUS_URL
    
  end

  def test_ServiceTermsLink
    
    #TEST : FOOTER - TERMS OF SERVICE LINK (TC1448)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::TERMS_SERVICE_ID).click    
    $browser.current_url == HomePage::TERMS_SERVICE_URL
    
  end
  
  def test_PrivacyPolicyLink
    
    #TEST : FOOTER - PRIVACY POLICY LINK (TC1449)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::PRIVACY_POLICY_ID).click    
    $browser.current_url == HomePage::PRIVACY_POLICY_URL
    
  end

  def test_MarketingServiceLink
    
    #TEST : MARKETING SERVICE TERMS (TC1450)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
   $browser.get HomePage::MARKETING_SERVICE_URL
   assert $wait.until{
     $browser.find_element(:xpath => HomePage::MARKETING_SERVICE_TEXT_XPATH).displayed?
     $browser.find_element(:xpath => HomePage::MARKETING_SERVICE_TEXT_XPATH).text == HomePage::MARKETING_SERVICE_TEXT_WORDS
   }
    
  end

  def test_VendorTermsLink
    
    #TEST : VENDOR TERMS (TC1451)
    
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::TEST_USER_EMAIL2
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::TEST_USER_PASSWORD2
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
   $browser.get HomePage::VENDOR_TERMS_URL
   assert $wait.until{
     $browser.find_element(:xpath => HomePage::VENDOR_TERMS_TEXT_XPATH).displayed?
     $browser.find_element(:xpath => HomePage::VENDOR_TERMS_TEXT_XPATH).text == HomePage::VENDOR_TERMS_TEXT_WORDS
   }
    
  end

end