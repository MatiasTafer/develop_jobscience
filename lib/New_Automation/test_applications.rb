require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/applications_details_page.rb'
require_relative './pages/applications_home_page.rb'


class TestApplications < TestBasic

  #TC1058 - Application / Create PDF
  def applicationCreationPdf
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::APPLICATIONS_TAB_LINK_URL
    $wait.until{
      
    }
    
    
  end 
  
  
  
  
end