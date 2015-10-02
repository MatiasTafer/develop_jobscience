require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/login_modal.rb'

class TestFooterLinks < TestBasic
  
  #Test Suite: FOOTER LINKS
  
=begin  
  
  #PENDING METHOD
  
  def test_emailLink
    
    #TEST : FOOTER - EMAIL LINK (TC1431)  
   
  end
=end

  #TEST : FOOTER - REGISTRY LINK (TC1432)
  def test_RegistryLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    registryUrl = $browser.current_url
    $browser.find_element(:xpath => HomePage::EDIT_REGISTRY_LINK_XPATH).click    
    assert_equal($browser.current_url, registryUrl)
  end

  #TEST : FOOTER - FIND LINK (TC1433)
  def test_FindLink  
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::FIND_REGISTRY_LINK_XPATH).click    
    assert_equal($browser.current_url, HomePage::FIND_REGISTRY_URL)
  end

  #TEST : FOOTER - APPS LINK (TC1434)
  def test_AppsLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::DOWNLOAD_APPS_XPATH).click    
    assert_equal($browser.current_url, HomePage::DOWNLOAD_APPS_URL)
  end

  #TEST : REGISTRY BENEFITS LINK (TC1435)
  def test_RegistryBenefitsLink  
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::REGISTRY_BENEFITS_ID).click    
    assert_equal($browser.current_url, HomePage::REGISTRY_BENEFITS_URL)
  end

  #TEST : ZOLA SHOP LINK (TC1436)
  def test_ZolaShopLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::ZOLA_SHOP_ID).click
    Common.wait_to_load   
    assert_equal($browser.current_url, HomePage::ZOLA_SHOP_URL)
  end

  #TEST : FOOTER - ABOUT ZOLA LINK (TC1437)
  def test_AboutZolaLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::ABOUT_ZOLA_ID).click    
    assert_equal($browser.current_url, HomePage::ABOUT_ZOLA_URL)
  end

  #TEST : FOOTER - PRESS LINK (TC1438)
  def test_PressLink  
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::PRESS_ID).click    
    assert_equal($browser.current_url, HomePage::PRESS_URL)
  end

  #TEST : FOOTER - JOBS LINK (TC1439)
  def test_JobsLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::JOBS_ID).click    
    assert_equal($browser.current_url, HomePage::JOBS_URL)
  end

  #TEST : FOOTER - BLOG LINK (TC1440)
  def test_BlogLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::BLOG_ID).click
    $browser.switch_to.window($browser.window_handles.last)
    Common::wait_to_load   
    assert_equal($browser.current_url, HomePage::BLOG_URL)
  end

  #TEST : FOOTER - FAQS LINK (TC1441)
  def test_FaqsLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::FAQS_ID).click    
    assert_equal($browser.current_url, HomePage::FAQS_URL)
  end

  #TEST : FOOTER - ORDER STATUS LINK (TC1442)
  def test_OrderStatusLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::ORDER_STATUS_ID).click    
    assert_equal($browser.current_url, HomePage::ORDER_STATUS_URL)
  end
  
  #TEST : FOOTER - TWITTER LINK (TC1443)
  def test_TwitterLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::TWITTER_XPATH).click
    $wait.until{
      $browser.window_handles.size > 1
      } 
    $browser.switch_to.window($browser.window_handles.last)
    Common::wait_to_load
    assert_equal($browser.current_url, HomePage::TWITTER_URL)
  end

  #TEST : FOOTER - FACEBOOK LINK (TC1444)
  def test_FacebookLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::FACEBOOK_XPATH).click 
    $wait.until{
      $browser.window_handles.size > 1
    } 
    $browser.switch_to.window($browser.window_handles.last)
    assert_equal($browser.current_url, HomePage::FACEBOOK_URL)
  end
  
  #TEST : FOOTER - PINTEREST LINK (TC1445)
  def test_PinterestLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::PINTEREST_XPATH).click
    $wait.until{
      $browser.window_handles.size > 1
      }   
    $browser.switch_to.window($browser.window_handles.last)
    assert_equal($browser.current_url, HomePage::PINTEREST_URL)
  end

  #TEST : FOOTER INSTAGRAM LINK (TC1446)
  def test_InstagramLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::INSTAGRAM_XPATH).click
    $wait.until{
      $browser.window_handles.size > 1
      } 
    $browser.switch_to.window($browser.window_handles.last) 
    assert_equal($browser.current_url, HomePage::INSTAGRAM_URL)
  end
  
  #TEST : FOOTER - GOOGLE PLUS LINK (TC1447)
  def test_GooglePLusLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => HomePage::GOOGLE_PLUS_XPATH).click
    $wait.until{
      $browser.window_handles.size > 1
    } 
    $browser.switch_to.window($browser.window_handles.last)
    assert_equal($browser.current_url, HomePage::GOOGLE_PLUS_URL)
  end

  #TEST : FOOTER - TERMS OF SERVICE LINK (TC1448)
  def test_ServiceTermsLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::TERMS_SERVICE_ID).click    
    assert_equal($browser.current_url, HomePage::TERMS_SERVICE_URL)
  end
  
  #TEST : FOOTER - PRIVACY POLICY LINK (TC1449)
  def test_PrivacyPolicyLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::PRIVACY_POLICY_ID).click    
    assert_equal($browser.current_url, HomePage::PRIVACY_POLICY_URL)
  end

  #TEST : MARKETING SERVICE TERMS (TC1450)
  def test_MarketingServiceLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $browser.find_element(:id => HomePage::LOGIN_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.get HomePage::MARKETING_SERVICE_URL
    assert $wait.until{
     $browser.find_element(:xpath => HomePage::MARKETING_SERVICE_TEXT_XPATH).displayed?
     $browser.find_element(:xpath => HomePage::MARKETING_SERVICE_TEXT_XPATH).text == HomePage::MARKETING_SERVICE_TEXT_WORDS
    }
  end
  
  #TEST : VENDOR TERMS (TC1451)
  def test_VendorTermsLink
    Common.login(Common::USER1_EMAIL, Common::GLOBAL_PASSWORD)
    $wait.until{
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.get HomePage::VENDOR_TERMS_URL
    assert $wait.until{
     $browser.find_element(:xpath => HomePage::VENDOR_TERMS_TEXT_XPATH).displayed?
     $browser.find_element(:xpath => HomePage::VENDOR_TERMS_TEXT_XPATH).text == HomePage::VENDOR_TERMS_TEXT_WORDS
    }
  end
end