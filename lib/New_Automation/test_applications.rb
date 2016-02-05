require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/applications_detail_page.rb'
require_relative './pages/applications_home_page.rb'


class TestApplications < TestBasic

  #TC1058 - Application / Create PDF
  def test_applicationCreationPdf
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::APPLICATIONS_TAB_LINK_URL
    $wait.until{
      $browser.find_element(:xpath, ApplicationsHomePage::APPLICATION_OPTION_BAR_XPATH).displayed?
       $browser.find_element(:xpath, ApplicationsHomePage::FIRST_APPLICATION_ON_TABLE_XPATH).displayed?
    }
    $browser.find_element(:xpath, ApplicationsHomePage::FIRST_APPLICATION_ON_TABLE_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ApplicationsDetailPage::CREATE_PDF_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, ApplicationsDetailPage::CREATE_PDF_BUTTON_XPATH).click
    newWindow= $browser.window_handles[1]
    $browser.switch_to.window(newWindow)
    assert $wait.until{
      $browser.find_element(:xpath, ApplicationsDetailPage::PDF_POP_UP_WINDOWS_ELEMENT_XPATH).displayed?
    }
  end 
  
  
  
  
end