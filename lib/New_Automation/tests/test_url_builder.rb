require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
require './New_Automation/tests/custom_settings.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/board_setup/board_setup_home_page.rb'
require './New_Automation/pages/board_setup/board_setup_detail_page.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require_relative 'users.rb'

class TestURLBuilder < TestBasic

  #TC843 - Search URL Builder 
  def test_SearchUrlBuilder
    randomName = "Test" + SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_AUTOMATION, Users::PASSWORD_AUTOMATION)
    
    #Create a requisition
    Common.CreateRequisitionPostJob(randomName,true)
    
    # 1 - Click on "Board Setup" Tab
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
    # 2 - Click on a existing Job Board Setup  
      {"click_and_load" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
    # 3 - Click on "Search URL Builder"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 4 - Fill the fields correctly
    # 5 - Click on "Next"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 7 - Click on "Next"
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH},
    # 8 - Enter keyword for keyword search  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH, "text" => "Test"},
    # 9 - Click on "Next"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH},
    # 10 - Enter "Search URL Name"  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH, "text" => randomName},
    # 11 - Click on URL on "Search URL" 
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SEARCH_URL_XPATH}
    ]
    Common.main(test)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(3)
    
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH}
    ]
    Common.main(test)
    
    #RESULT 11 - Verify that generated search link opens job board with job orders that match specified criteria.
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH2 + "//*[text()[contains(.,'Test')]]").displayed?
    }
    $browser.close
    
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
    # 12 - Click on "Save & Close"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH},
    ]
    Common.main(test)
    #RESULT 12 - You will be returned to the "Board Setup Detail" page. Search URL will be saved.
    assert $wait.until {
      $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").displayed?
    }
  end

  #TC844 - Search URL Builder, Validation 
  def test_SearchUrlBuilderValidation
    randomName = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_AUTOMATION, Users::PASSWORD_AUTOMATION)
    
    # 1 - Click on "Board Setup" Tab
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
    # 2 - Click on a existing Job Board Setup  
      {"click_and_load" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
    # 3 - Click on "Search URL Builder"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_CHOOSE_BOARD_XPATH},
    # 4 - Leave all the fields blank
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_CHOOSE_BOARD_XPATH, "text" => "--None--" },
    # 5 - Click on "Next"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH},
     ]
    Common.main(test)
    #RESULT 5 - Error message "Choose Board: Validation Error: Value is required." will be displayed.
    assert_equal(BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_BOARD, $browser.find_element(:xpath => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH).text)
    
    test = [ 
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 6 - Fill the fields correctly
    # 7 - Click on "Next" 
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 9 - Click on "Next"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH},
    # 10 - Enter keyword for keyword search  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH, "text" => "Test"},
    # 11 - Click on "Next"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH},
    # 12 - Leave blank "Search URL Name"
    # 13 - Click on "Save & Close"
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH}
    ]
    Common.main(test)
    #RESULT 13 - Error message "Search URL Name: Validation Error: Value is required."
    assert_equal(BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_NAME, $browser.find_element(:xpath => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH).text)
   
  end

  #TC845 - RSS URL Builder 
  def test_RssUrlBuilder
    randomName = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_AUTOMATION, Users::PASSWORD_AUTOMATION)
 
    # 1 - Click on "Board Setup" Tab
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
    # 2 - Click on a existing Job Board Setup  
      {"click_and_load" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
    # 3 - Click on "Search URL Builder"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 4 - Fill the fields correctly
    # 5 - Click on "Next"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 7 - Click on "Next"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH},
    # 8 - Enter keyword for keyword search  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH, "text" => "Test"},
    # 9 - Click on "Next"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH},
    # 10 - Enter "Search URL Name"  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH, "text" => randomName}
    ]
    Common.main(test)
    
    
    #RESULT 11 - Verify that generated search link opens job board with job orders that match specified criteria.
    #Chrome does not interpret xml files, so until we don't fix this, we can't check the expected result for this case
    if $browserName == "firefox"
      # 11 - Click on URL on "RSS URL" 
      Common.click(BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH)
      
      newWindow = $browser.window_handles.last
      $browser.switch_to.window(newWindow)
      sleep(3)
      
      assert $wait.until {
        $browser.find_element(:xpath,".//*[text()[contains(.,'Test')]]").displayed?
      }
      
      $browser.close
    
      newWindow = $browser.window_handles.first
      $browser.switch_to.window(newWindow)
    end
    
    test = [
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
    # 12 - Click on "Save & Close"  
      {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH},
    ]
    Common.main(test)
    #RESULT 12 - You will be returned to the "Board Setup Detail" page. Search URL will be saved.
    assert $wait.until {
      $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").displayed?
    }
  end
     
end