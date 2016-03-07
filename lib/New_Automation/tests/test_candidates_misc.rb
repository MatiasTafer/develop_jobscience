require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
require './New_Automation/tests/custom_settings.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/rss_customization_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/job_board/job_board_login_page.rb'
require './New_Automation/pages/job_board/job_board_register_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'
require './New_Automation/pages/applications/applications_new_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/board_setup/board_setup_home_page.rb'
require './New_Automation/pages/board_setup/board_setup_detail_page.rb'
require_relative 'users.rb'

class TestCandidatesMisc < TestBasic
  @@job_path = "/Users/admin/Desktop/testing job order.pdf"
 
  #JS2 Board Setup
  #TC104 - RSS feed customizable fields
  def test_RSSFeddCustomizableFields
    
    #PRECONDITIONS
    #Need to have pre configured on Setup>Create>Objects>Job Orders>RSS Feed the followings fields: 
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    $browser.get(HomePage::BOARD_SETUP_TAB_LINK_URL)
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH}
    ]
   Common.main(test)
   newWindow= $browser.window_handles.last
   $browser.switch_to.window(newWindow)
   
   sleep(3)

   puts $browser.browser.to_s
   if $browser.browser.to_s == "chrome"
     assert $wait.until{
      $browser.find_element(:xpath => ".//*[text()[contains(.,'Min_Salary')]]").displayed?
      $browser.find_element(:xpath => ".//*[text()[contains(.,'Max_Salary')]]").displayed?
    }
   else
     assert $wait.until{
       $browser.find_element(:xpath => ".//*[@class='entry']").displayed?  
     } 
   end
   sleep(5)
 end  

  
      
end