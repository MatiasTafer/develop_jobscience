require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'
require_relative './pages/home_page.rb'
require_relative './pages/board_setup_home_page.rb'
require_relative './pages/board_setup_detail_page.rb'
require_relative './pages/applications_detail_page.rb'
require_relative './pages/requisitions_detail_page.rb'

class TestURLBuilder < TestBasic

  #TC843 - Search URL Builder 
  def test_SearchUrlBuilder
    randomName = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # 1 - Click on "Board Setup" Tab
    $browser.get(HomePage::BOARD_SETUP_TAB_LINK_URL)
    
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
    # 2 - Click on a existing Job Board Setup  
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
    # 3 - Click on "Search URL Builder"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 4 - Fill the fields correctly
    # 5 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 7 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH},
    # 8 - Enter keyword for keyword search  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH, "text" => "Test"},
    # 9 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
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
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_FIRST_KEYWORD_XPATH}
    ]
    #RESULT 11 - Verify that generated search link opens job board with job orders that match specified criteria.
    assert $wait.until {
      $browser.find_element(:xpath,".//*[text()[contains(.,'test')]]").displayed?
    }
    $browser.close
    
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
    # 12 - Click on "Save & Close"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # 1 - Click on "Board Setup" Tab
    $browser.get(HomePage::BOARD_SETUP_TAB_LINK_URL)
    
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
    # 2 - Click on a existing Job Board Setup  
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
    # 3 - Click on "Search URL Builder"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_CHOOSE_BOARD_XPATH},
    # 4 - Leave all the fields blank
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_CHOOSE_BOARD_XPATH, "text" => "--None--" },
    # 5 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH},
     ]
    Common.main(test)
    #RESULT 5 - Error message "Choose Board: Validation Error: Value is required." will be displayed.
    assert_equal(BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_BOARD, $browser.find_element(:xpath => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH).text)
    
    test = [ 
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 6 - Fill the fields correctly
    # 7 - Click on "Next" 
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 9 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH},
    # 10 - Enter keyword for keyword search  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH, "text" => "Test"},
    # 11 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH},
    # 12 - Leave blank "Search URL Name"
    # 13 - Click on "Save & Close"
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # 1 - Click on "Board Setup" Tab
    $browser.get(HomePage::BOARD_SETUP_TAB_LINK_URL)
    
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
    # 2 - Click on a existing Job Board Setup  
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
    # 3 - Click on "Search URL Builder"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 4 - Fill the fields correctly
    # 5 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
    # 7 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH},
    # 8 - Enter keyword for keyword search  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH, "text" => "Test"},
    # 9 - Click on "Next"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH},
    # 10 - Enter "Search URL Name"  
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH, "text" => randomName},
    # 11 - Click on URL on "RSS URL" 
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH}
    ]
    Common.main(test)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(3)
    
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_FIRST_KEYWORD_XPATH}
    ]
    #RESULT 11 - Verify that generated search link opens job board with job orders that match specified criteria.
    assert $wait.until {
      $browser.find_element(:xpath,".//*[text()[contains(.,'test')]]").displayed?
    }
    $browser.close
    
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
    # 12 - Click on "Save & Close"  
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH},
    ]
    Common.main(test)
    #RESULT 12 - You will be returned to the "Board Setup Detail" page. Search URL will be saved.
    assert $wait.until {
      $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").displayed?
    }
  end
  
  #TC847 - Add Tags, Public Tag
  def test_AddTagsPublicTag
    randomContact = SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
        
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3 - Click on "Add Tags"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_TAGS_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2) 
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_PUBLIC_TAGS_XPATH},
    # 4 - Choose tag to add for the selected candidates from the "Public Tags" drop-down list  
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_PUBLIC_TAGS_FIRST_OPTION_XPATH},
    # 5 - Click on "Add Tags"  
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_ADD_TAGS_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH}
    ]
    Common.main(test)
    
    #RESULT Message "Tags Added Successfully" and  the quantity of total tags added will be displayed.
    assert_equal(ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_TEXT, $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH).text)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_TOTAL_TAGS_XPATH).text)
    
    test = [
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)

    $browser.switch_to.window($browser.window_handles.first) 
  end
 
  #TC848 - Add Tags, Personal Tag
  def test_AddTagsPersonalTag
    randomContact = SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
        
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3 - Click on "Add Tags"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_TAGS_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2) 
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_PERSONAL_TAGS_XPATH},
    # 4 - Choose tag to add for the selected candidates from the "Personal Tags" drop-down list
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_PERSONAL_TAGS_FIRST_OPTION_XPATH},
    # 5 - Click on "Add Tags"  
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_ADD_TAGS_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH}
    ]
    Common.main(test)
    
    #RESULT Message "Tags Added Successfully" and  the quantity of total tags added will be displayed.
    assert_equal(ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_TEXT, $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH).text)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_TOTAL_TAGS_XPATH).text)
    
    test = [
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)

    $browser.switch_to.window($browser.window_handles.first) 
  end 

  
  #TC849 - Add Tags, New Public Tag
  def test_AddTagsNewPublicTag
    randomContact = SecureRandom.hex(4)
    randomTag = SecureRandom.hex(2)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
        
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3 - Click on "Add Tags"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_TAGS_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2) 
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_NEW_TAG_XPATH},
    # 4 - Enter a value on "New Tag" field
      {"set_text" => ContactsHomePage::CONTACT_TAGS_POPUP_NEW_TAG_XPATH, "text" => "TestTag" + randomTag},
    # 5 - Select "Public" from "Type" field
      {"set_text" => ContactsHomePage::CONTACT_TAGS_POPUP_TYPE_XPATH, "text" => "Public"},
    # 6 - Click on "Add Tags"  
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_ADD_TAGS_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH}
      
    ]
    Common.main(test)
    
    #RESULT Message "Tags Added Successfully" and  the quantity of total tags added will be displayed.
    assert_equal(ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_TEXT, $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH).text)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_TOTAL_TAGS_XPATH).text)
    
    test = [
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)

    $browser.switch_to.window($browser.window_handles.first) 
  end 
  
  #TC850 - Add Tags, New Personal Tag
  def test_AddTagsNewPersonalTag
    randomContact = SecureRandom.hex(4)
    randomTag = SecureRandom.hex(2)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
        
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3 - Click on "Add Tags"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_TAGS_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2) 
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_NEW_TAG_XPATH},
    # 4 - Enter a value on "New Tag" field
      {"set_text" => ContactsHomePage::CONTACT_TAGS_POPUP_NEW_TAG_XPATH, "text" => "TestTag" + randomTag},
    # 5 - Select "Private" from "Type" field 
      {"set_text" => ContactsHomePage::CONTACT_TAGS_POPUP_TYPE_XPATH, "text" => "Private"},
    # 6 - Click on "Add Tags"  
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_ADD_TAGS_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH}
      
    ]
    Common.main(test)
    
    #RESULT Message "Tags Added Successfully" and  the quantity of total tags added will be displayed.
    assert_equal(ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_TEXT, $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH).text)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_TOTAL_TAGS_XPATH).text)
    
    test = [
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)

    $browser.switch_to.window($browser.window_handles.first) 
  end 
  
  #TC851 - Add Tag, Validation
  def test_AddTagsValidation
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
      
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_FIRST_ENTRY_GO_XPATH + "/../../../..//td[1]//input").click
    
    # 3 - Click on "Add Tags"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_TAGS_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2) 
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_ADD_TAGS_XPATH},
    # 4 - Click on "Add Tags" without selecting any tag or entering any value
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_ADD_TAGS_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_TAGS_POPUP_ERROR_CELL_XPATH},
    ]
    Common.main(test)
    
    #RESULT Error message "No tags selected" will be displayed.
    assert_equal(ContactsHomePage::CONTACT_TAGS_POPUP_ERROR_TAGS_TEXT, $browser.find_element(:xpath => ContactsHomePage::CONTACT_TAGS_POPUP_ERROR_CELL_XPATH).text)
    
    test = [
      {"click" => ContactsHomePage::CONTACT_TAGS_POPUP_BTN_CANCEL_XPATH}
    ]
    Common.main(test)

    $browser.switch_to.window($browser.window_handles.first) 
  end 

  #TC858 - Revert Stage
  def test_RevertStage
    randomName = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(4)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
     
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_APP_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH},
    ]
    Common.main(test)
    sleep(3)
    
    currentUrl = $browser.current_url
    
    $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH).click
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)   
    sleep(4)
    
    test = [
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
    ]
    Common.main(test) 
    sleep(2)
    
    newWindow4= $browser.window_handles.first
    $browser.switch_to.window(newWindow4)
    
    sleep(6)
    $browser.get(currentUrl)
    
    #
    $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH).click
    sleep(3)
    newWindow5= $browser.window_handles.last
    $browser.switch_to.window(newWindow5)   
    sleep(6)
    
    test = [
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_CS1_STAGE_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_CS1_STAGE_XPATH},
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CLOSE_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test) 
    sleep(2)
    
    newWindow6= $browser.window_handles.first
    $browser.switch_to.window(newWindow6)
    
    sleep(6)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    # 4 - Click on "Revert Stage'  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    ]
    Common.main(test) 
    sleep(1)
    
    newWindow7= $browser.window_handles.last
    $browser.switch_to.window(newWindow7)
    
    sleep(3)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH},
    # 5 - Select any previous stage (except Application)   
      {"click" => ApplicationsDetailPage::REVERT_STAGE_RADIO_2_XPATH},
    # 6 - Click on "Next"  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH}
    ]
    Common.main(test)
    
    # 7 - Click on "OK"
    $browser.switch_to.alert.accept
    sleep(5)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH},
    ]
    Common.main(test)
    
    # RESULT
    # Success message will be displayed.
    assert_equal(ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_TEXT, $browser.find_element(:xpath, ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH).text)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow8= $browser.window_handles.last
    $browser.switch_to.window(newWindow8)
    $browser.close
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    sleep(3)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
          ]
    Common.main(test) 
    
    # RESULT 
    # Further stages will be deleted, and application will have Overall Stage = selected stage. 
    assert_equal("Submittal", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
  end

  #TC859 - Revert Stage, Send Email
  def test_RevertStageSendMail
    randomName = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(4)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
     
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_APP_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH},
    ]
    Common.main(test)
    sleep(3)
    
    currentUrl = $browser.current_url
    
    $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH).click
    
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)   
    sleep(4)
    
    test = [
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
    ]
    Common.main(test) 
    sleep(2)
    
    newWindow4= $browser.window_handles.first
    $browser.switch_to.window(newWindow4)
    
    sleep(6)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    # 4 - Click on "Revert Stage'  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    ]
    Common.main(test) 
    sleep(1)
    
    newWindow7= $browser.window_handles.last
    $browser.switch_to.window(newWindow7)
    
    sleep(3)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_SEND_EMAIL_BOX_XPATH},
    # 5 - Check "Send Email" box  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_SEND_EMAIL_BOX_XPATH},
    # 6 - Select "Aplication" stage  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_RADIO_XPATH},
    # 7 - Click on "Next"  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH}
    ]
    Common.main(test)
    
    # 8 - Click on "OK"
    $browser.switch_to.alert.accept
    sleep(5)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH},
    ]
    Common.main(test)
    
    # RESULT
    # Success message will be displayed.
    assert_equal(ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_TEXT, $browser.find_element(:xpath, ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH).text)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
        
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    sleep(3)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
          ]
    Common.main(test) 
    
    # RESULT 
    # Further stages will be deleted, and application will have Overall Stage = selected stage. Email with merged fields from template will be sent to candidate.
    assert_equal("Application", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
  end

  #TC860 - TC860 - Revert Stage, Can't revert
  def test_RevertStageCantRevert
    randomName = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(4)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 1 - Click on "Contacts" Tab
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2 - Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
     
    test = [
    # 3 - Click on a Candidate's application that fits the preconditions => Application is in Application Stage. 
      {"click" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_APP_XPATH},
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    # 4 - Click on "Revert Stage'  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH}
    ]
    Common.main(test)
    sleep(3)
    # RESULT
    # Pop-up window will be opened.
    newWindow7= $browser.window_handles.last
    $browser.switch_to.window(newWindow7)
    
    sleep(3)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH}
    ]
    Common.main(test) 
    
    # RESULT 
    # The message "The Application selected cannot be Reverted as it is in the Application Stage. There is no stage it can be reverted to" will be displayed.
    assert_equal(ApplicationsDetailPage::REVERT_STAGE_CANNOT_REVERT_MSG_TEXT, $browser.find_element(:xpath, ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH).text)
    
    $browser.close
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    sleep(1)
    
  end 
 
  #TC861 - Rollover, different Question Sets
  def test_RolloverDifferentQuestionSets
    randomName = SecureRandom.hex(4)
    randomName2 = SecureRandom.hex(4)
    randomQS = SecureRandom.hex(4)
    randomQS2 = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    randomContact2 = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    Common.CreateQuestionSetEmpty(randomQS)
    
    Common.CreateQuestionSetEmpty(randomQS2)
    
    Common.CreateRequisitionPostJob(randomName, true, false, randomQS)
    
    Common.CreateRequisitionPostJob(randomName2, true, false, randomQS2)
    
    #Must have several accounts
    Common.CreateAccount(randomContact) 
          
    #Must have several contacs
    Common.CreateContact(randomContact, randomContact)
    
    #Must have several accounts
    Common.CreateAccount(randomContact2) 
          
    #Must have several contacs
    Common.CreateContact(randomContact2, randomContact2)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact2 + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 1 - Click on "Requisitions"
    $browser.get(HomePage::REQUISITION_TAB_LINK_URL)
    
    test= [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2 - Select a Job Order
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    # 3 - Click on "Rollover Contacts"  
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    ]
    Common.main(test)
    
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)
    sleep(2)
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH},
    # 4 - Select another job order that fits the preconditions  
      {"set_text" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH, "text" => randomName2},
    # 5 - Click on "Rollover"  
      {"click" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_BTN_ROLLOVER_XPATH},
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH}
    ]
    Common.main(test)
    sleep(3)
    # RESULT 
    # A message stating that Rollover is impossible and prompt to apply contacts to the selected job order will be displayed.
    assert_equal(RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_WARNING_TEXT, $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH).text)
    
    $browser.close
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
  
  end  
 
  #TC862 - Rollover, same Question Sets
  def test_RolloverSameQuestionSets
    randomName = SecureRandom.hex(4)
    randomName2 = SecureRandom.hex(4)
    randomQS = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    randomContact2 = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    Common.CreateQuestionSetEmpty(randomQS)
    
    Common.CreateRequisitionPostJob(randomName, true, false, randomQS)
    
    Common.CreateRequisitionPostJob(randomName2, true, false, randomQS)
    
    #Must have several accounts
    Common.CreateAccount(randomContact) 
          
    #Must have several contacs
    Common.CreateContact(randomContact, randomContact)
    
    #Must have several accounts
    Common.CreateAccount(randomContact2) 
          
    #Must have several contacs
    Common.CreateContact(randomContact2, randomContact2)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact2 + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    sleep(2)
    # 1 - Click on "Requisitions"
    $browser.get(HomePage::REQUISITION_TAB_LINK_URL)
    
    test= [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    sleep(4)
    # 2 - Select a Job Order
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    # 3 - Click on "Rollover Contacts"  
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    ]
    Common.main(test)
    
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)
    sleep(2)
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH},
    # 4 - Select another job order that fits the preconditions  
      {"set_text" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH, "text" => randomName2},
    # 5 - Click on "Rollover"  
      {"click" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_BTN_ROLLOVER_XPATH},
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH}
    ]
    Common.main(test)
    sleep(3)
    # RESULT 
    # New applications will be created for selected job order, they will have the same status, stage and prescreen as applications from original job order. Message will be displayed.
    assert_equal(RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_SUCCESS_TEXT, $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH).text)
    
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    
    $browser.get(HomePage::REQUISITION_TAB_LINK_URL)
    
    test= [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    sleep(3)
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName2 + "')]]").click
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test)
    
    currentUrl = $browser.current_url
    
    test= [
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_FIRST_APP_LIST_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH}
    ]
    Common.main(test)
    
    assert_equal("New", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_STATUS_XPATH).text)
    assert_equal("Application", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
    $browser.get(currentUrl)
    
      test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test)
    
    currentUrl = $browser.current_url
    
    test= [
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_SECOND_APP_LIST_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH}
    ]
    Common.main(test)
    
    assert_equal("New", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_STATUS_XPATH).text)
    assert_equal("Application", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
    $browser.switch_to.window($browser.window_handles.last)
    $browser.close
    
    $browser.switch_to.window($browser.window_handles.last)
    $browser.close
  end
 
  #TC863 - Rollover, same Job Order
  def test_RolloverSameJobOrder
    randomName = SecureRandom.hex(4)
    randomQS = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    randomContact2 = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    Common.CreateQuestionSetEmpty(randomQS)
        
    Common.CreateRequisitionPostJob(randomName, true, false, randomQS)
    
    
    #Must have several accounts
    Common.CreateAccount(randomContact) 
          
    #Must have several contacs
    Common.CreateContact(randomContact, randomContact)
    
    #Must have several accounts
    Common.CreateAccount(randomContact2) 
          
    #Must have several contacs
    Common.CreateContact(randomContact2, randomContact2)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact2 + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 1 - Click on "Requisitions"
    $browser.get(HomePage::REQUISITION_TAB_LINK_URL)
    
    test= [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2 - Select a Job Order
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    # 3 - Click on "Rollover Contacts"  
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    ]
    Common.main(test)
    
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)
    sleep(2)
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH},
    # 4 - Select another job order that fits the preconditions  
      {"set_text" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH, "text" => randomName},
    # 5 - Click on "Rollover"  
      {"click" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_BTN_ROLLOVER_XPATH},
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH}
    ]
    Common.main(test)
    sleep(3)
    # RESULT 
    # A message stating that Rollover is impossible and prompt to apply contacts to the selected job order will be displayed.
    assert_equal("The Rollover Process has been completed. Applications Rolled Over: 0.", $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH).text)
    
    $browser.close
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    

  end  
            
end