require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/contacts_home_page.rb'
require_relative './pages/contacts_detail_page.rb'
require_relative './pages/contacts_new_edit_page.rb'
require_relative './pages/answer_detail_page.rb'
require_relative './pages/setup_page.rb'
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/applications_detail_page.rb'
require_relative 'custom_settings.rb'
require_relative './pages/accounts_home_page.rb'
require_relative './pages/accounts_new_edit_page.rb'
require_relative './pages/accounts_detail_page.rb'
require_relative './pages/skill_detail_page.rb'
require_relative './pages/short_list_home_page.rb'
require_relative './pages/short_list_new_edit_page.rb'
require_relative './pages/short_list_detail_page.rb'
require_relative './pages/requisitions_home_page.rb'
require_relative './pages/requisitions_new_and_edit.rb'
require_relative './pages/requisitions_detail_page.rb'

class TestActionsOnListView < TestBasic

  #TC47 - Successfully create a new contact
  def test_CreateNewContact
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #An account must be created for the contact
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    # 1. Click on "Contacts" 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
        
    # 2. Click on "New".
    Common.displayed(ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW)
    Common.click(ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW)
    
    # 3. On "Select Contact Record Type" select the option "contact".
    Common.displayed(ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH)
    Common.set_text(ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH, "Contact")
    
    # 4. Click on button "Continue".
    Common.click(ContactNewEditPage::CONTACT_NEW_BTN_CONTINUE_XPATH)
    
    # 5. Complete the text box (required): "Last name" an "Account Name".
    Common.displayed(ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH)
    Common.set_text(ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH, ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT)
    Common.set_text(ContactNewEditPage::CONTACT_NEW_ACCOUNT_NAME_INPUT_XPATH, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    #6. Complete the fields (optional).
    #7. Click on "Save".
    Common.click(ContactNewEditPage::CONTACT_NEW_BTN_SAVE_XPATH)
    
    #RESULT
    #Redirects to "Contact Detail" page.
    Common.displayed(ContactDetailPage::CONTACT_DETAIL_NAME_XPATH)
    Common.hassert_equal(ContactDetailPage::CONTACT_DETAIL_NAME_XPATH, ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT)
    #assert_equal($browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text, ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT)
    
    #Delete account created in this testcase
    DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
  end

  #TC48 - Successfully Add Skill
  def test_SuccessfullyAddSkill
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least one account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
    
    #At least one contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    
    # 4. Click on "Add skills"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_SKILL_XPATH)
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_SECOND_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_LIST_2_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH}
      ]
    Common.main(test)
    $browser.switch_to.window($browser.window_handles.first)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?   
  
    }
    
    #Delete account created in this testcase
    DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)  

  end
  
   
 #TC253 - Successfully Add and Rate Skill
 def test_SuccessfullyAddRateSkill
   #PRECONDITIONS
   #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least one account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
    
    #At least one contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    
    # 4. Click on "Add skills"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_SKILL_XPATH)
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_SECOND_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_LIST_2_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_RATE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SKILL_BTN_SUBMIT_XPATH}
    ]
    Common.main(test)
    
    #Use slider for rate skills
    element = $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SLIDER_1_XPATH)
    target = $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SKILL_BTN_SUBMIT_XPATH)
    $browser.action.drag_and_drop(element, target).perform
    
    element2 = $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SLIDER_2_XPATH)
    $browser.action.drag_and_drop(element2, target).perform
      
    test = [
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SKILL_BTN_SUBMIT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    #RESULTS
    # Skill record should be created, skill record should show rating
    $browser.switch_to.window($browser.window_handles.first)
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?   
    
    }
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_RECORD_SKILL_LIST_FIRST_XPATH},
      {"displayed" => SkillDetailPage::SKILL_DETAIL_RATING_XPATH}
    ]
    Common.main(test) 
    assert_equal("10", $browser.find_element(:xpath => SkillDetailPage::SKILL_DETAIL_RATING_XPATH).text)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
    
    test = [
    {"displayed" => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH},
    {"click" => ContactDetailPage::CONTACT_DETAIL_RECORD_SKILL_LIST_SECOND_XPATH},
    {"displayed" => SkillDetailPage::SKILL_DETAIL_RATING_XPATH}
     ]
     
    Common.main(test)
    assert_equal("10", $browser.find_element(:xpath => SkillDetailPage::SKILL_DETAIL_RATING_XPATH).text)
    
    #Delete account created in this testcase
    DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)  
    
  end
    
   
  #TC254 - Adding and Rating Skills for multiple contacts
  def test_AddRateSkillMultipleContacts
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least two account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_2_TEXT)
    
    #At least two contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_2_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_2_TEXT)
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_2_TEXT + "')]]/../../../..//td[1]//input").click
  
    
    # 4. Click on "Add skills"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_SKILL_XPATH)
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    # 5. Select one or more "skill to add" (doing click on checkbox)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_SECOND_ELEMENT_XPATH},
      #6. Click on right arrow.
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_LIST_2_ELEMENT_XPATH},
      #7. Click on "Save & Rate Skills"
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_RATE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_ERROR_OUTPUT_XPATH}
    ]
    Common.main(test)
    
    assert_equal($browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_ERROR_OUTPUT_XPATH).text, "Error:")
    
    #Delete accounts created in this testcase
    DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
    DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_2_TEXT) 
    
  end
 
  #TC49 - Successfully Add to Existing Short List
  def test_SuccessfullyAddToExistingList
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least one account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
        
    #At least one contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    #At least one short list must exist 
    CreateShortList(ShortListNewEditPage::SHORT_LIST_DATA_NAME_1_TEXT)
        
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    
    # 4. Click on "Add to List"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_LIST_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH, "text" => ShortListNewEditPage::SHORT_LIST_DATA_NAME_1_TEXT},
    # 5. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH},
    # 6. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    # 7. Click on Short List tab
    $browser.get(HomePage::SHORT_LIST_TAB_LINK_URL)
   
    # 8. Click on name of used short list
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + ShortListNewEditPage::SHORT_LIST_DATA_NAME_1_TEXT + "')]]").click
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").displayed?
    }
    
   #Delete accounts created in this testcase
   DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
   
   #Delete shortlist created in this testcase
   DeleteShortList(ShortListNewEditPage::SHORT_LIST_DATA_NAME_1_TEXT)
        
  end

 #TC255 - Successfully Add to New Short List
  def test_SuccessfullyAddToNewList
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least one account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
        
    #At least one contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    
    # 4. Click on "Add to List"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_LIST_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NEW_NAME_INPUT_XPATH, "text" => ShortListNewEditPage::SHORT_LIST_DATA_NAME_1_TEXT},
    # 5. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH},
    # 6. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    # 7. Click on Short List tab
    $browser.get(HomePage::SHORT_LIST_TAB_LINK_URL)
   
    # 8. Click on name of used short list
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + ShortListNewEditPage::SHORT_LIST_DATA_NAME_1_TEXT + "')]]").click
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").displayed?
    }
    
   #Delete accounts created in this testcase
   DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
   
   #Delete shortlist created in this testcase
   DeleteShortList(ShortListNewEditPage::SHORT_LIST_DATA_NAME_1_TEXT)
        
  end

  #TC50 - Successfully Apply to unposted job with "Enable Enhanced Apply to Job" = FALSE
  def test_ApplyUnpostedJobEnableEnhancedApplyToJobFalse  

  
  #PRECONDITIONS:
  
  #Login
  Common.login(Common::USER_EMAIL, Common::PASSWORD) 
  
  # Job with "Post job" = False. 
  CreateRequisitionPostJob(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE, false)
  
  #Enable Enhanced Apply to Job" = FALSE
  CustomSettings.EnableEnhancedApplyToJob(false)
  
  #At least one account must exist
  CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
        
  #At least one contact must exist 
  CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
  
  
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
  $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
  
  # 3. Click on "Apply to jobs"
  Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
  sleep(3)
  #A pop up window will be disaplyed
  newWindow= $browser.window_handles.last
  $browser.switch_to.window(newWindow)
  sleep(2)
  
  test = [
  # 5. Select the unposted Job
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
    {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE},
  # 6. Click "Apply To Position" 
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_APPLY_XPATH},
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
  # 7. Click "Close"     
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
  
  $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
  $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
      }
  assert $wait.until {
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE + "')]]").displayed?
    }
  
  #Delete accounts created in this testcase
   DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
  #Delete requisition created in this testcase
  DeleteRequisition(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE)  
  end
  
  
  
  #TC256 - Successfully Apply to posted job with "Enable Enhanced Apply to Job" = FALSE
  def test_ApplyPostedJobEnableEnhancedApplyFalsePostTrue  
  
  #PRECONDITIONS:
  
  #Login
  Common.login(Common::USER_EMAIL, Common::PASSWORD) 
  
  # Job with "Post job" = True. 
  CreateRequisitionPostJob(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE, true)
  
  #Enable Enhanced Apply to Job" = FALSE
  CustomSettings.EnableEnhancedApplyToJob(false)
  
  #At least one account must exist
  CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
        
  #At least one contact must exist 
  CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
  
  
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
  $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
  
  # 3. Click on "Apply to jobs"
  Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
  sleep(3)
  #A pop up window will be disaplyed
  newWindow= $browser.window_handles.last
  $browser.switch_to.window(newWindow)
  sleep(2)
  
  test = [
  # 5. Select the unposted Job
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
    {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE},
  # 6. Click "Apply To Position" 
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_APPLY_XPATH},
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
  # 7. Click "Close"     
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
  
  $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
  $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
      }
  assert $wait.until {
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE + "')]]").displayed?
    }
  
  #Delete accounts created in this testcase
   DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
  #Delete requisition created in this testcase
  DeleteRequisition(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE)  
  end
 
  #TC51 - Successfully Apply to posted job with "Enable Enhanced Apply to Job" = TRUE, Invite to Apply
  def test_ApplyPostedJobEnableEnhancedApplyTrueInvite 
  
  #PRECONDITIONS:
  
  #Login
  Common.login(Common::USER_EMAIL, Common::PASSWORD) 
  
  # Job with "Post job" = True
  CreateRequisitionPostJob(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE, true)
  
  #Enable Enhanced Apply to Job" = True
  CustomSettings.EnableEnhancedApplyToJob(true)
  
  #At least one account must exist
  CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
        
  #At least one contact must exist 
  CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
  
  
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
  $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
  
  # 3. Click on "Apply to jobs"
  Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
  sleep(3)
  #A pop up window will be disaplyed
  newWindow= $browser.window_handles.last
  $browser.switch_to.window(newWindow)
  sleep(2)
  
  test = [
  # 5. Select the posted Job
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
    {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE},
  # 6. Click "Next" 
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
  # 7. Click on Invite to Apply   
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH}
    
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
  
  $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
  $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
      }
  assert $wait.until {
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE + "')]]").displayed?
    }
  
  #Delete accounts created in this testcase
   DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
  #Delete requisition created in this testcase
  DeleteRequisition(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE)  
  end  

  #TC52 - Try to Invite to Apply with "Post job" = False
  def test_TryToInvitePostJobFalse 
  
  #PRECONDITIONS:
  
  #Login
  Common.login(Common::USER_EMAIL, Common::PASSWORD) 
  
  # Job with "Post job" = false
  CreateRequisitionPostJob(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE, false)
  
  #Enable Enhanced Apply to Job" = True
  CustomSettings.EnableEnhancedApplyToJob(true)
  
  #At least one account must exist
  CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
        
  #At least one contact must exist 
  CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
  
  
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
  $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
  
  # 3. Click on "Apply to jobs"
  Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
  sleep(3)
  #A pop up window will be disaplyed
  newWindow= $browser.window_handles.last
  $browser.switch_to.window(newWindow)
  sleep(2)
  
  test = [
  # 5. Select the unposted Job
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
    {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE},
  # 6. Click "Next" 
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
  # 7. Click on Invite to Apply   
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
    {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_INVITE_ERROR_XPATH}
  ]
  Common.main(test)

    
  assert_equal($browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_INVITE_ERROR_XPATH).text, "Error:\nYou cannot Invite Candidates to apply for a Job that is not posted.**")
  
  $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CANCEL_XPATH).click
  
  newWindow2= $browser.window_handles.first
  $browser.switch_to.window(newWindow2)
  
  #Delete accounts created in this testcase
   DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
  #Delete requisition created in this testcase
  DeleteRequisition(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE)  
  end

  #TC257 - Successfully Apply to posted job with "Enable Enhanced Apply to Job" = TRUE, Apply via Agency
  def test_ApplyPostedJobEnableEnhancedApplyTrueAgency 
  
    #PRECONDITIONS:
    
    #Login
    #Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    # Job with "Post job" = True
    CreateRequisitionPostJob(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE, true)
    
    #Enable Enhanced Apply to Job" = True
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
          
    #At least one contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    #At least one agency must exist
    CreateAgencyAccount(AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT)
    
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
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 5. Select the posted Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Agency   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_AGENCY_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_AGENCY_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_AGENCY_XPATH, "text" => AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT},
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
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE + "')]]").displayed?
      }  
    
    #Delete accounts created in this testcase
     DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
     DeleteAccount(AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT)
     
    #Delete requisition created in this testcase
    DeleteRequisition(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE)  
  end

  
  #TC258 - Successfully Apply to unposted job with "Enable Enhanced Apply to Job" = TRUE, Apply via Agency
  def test_ApplyUnpostedJobEnableEnhancedApplyTrueAgency 
  
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    # Job with "Post job" = False
    CreateRequisitionPostJob(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE, false)
    
    #Enable Enhanced Apply to Job" = True
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
          
    #At least one contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    #At least one agency must exist
    CreateAgencyAccount(AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT)
    
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
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 5. Select the unposted Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Agency   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_AGENCY_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_AGENCY_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_AGENCY_XPATH, "text" => AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT},
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
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE + "')]]").displayed?
      }  
    
    #Delete accounts created in this testcase
     DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
     DeleteAccount(AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT)
     
    #Delete requisition created in this testcase
    DeleteRequisition(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE)  
  end
  
  #TC259 - Successfully Apply to posted job with "Enable Enhanced Apply to Job" = TRUE, Apply via Exception
  def test_ApplyPostedJobEnableEnhancedApplyTrueException
  
    #PRECONDITIONS:
    
    #Login
    #Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    # Job with "Post job" = true
    CreateRequisitionPostJob(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE, true)
    
    #Enable Enhanced Apply to Job" = True
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
          
    #At least one contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
        
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
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 5. Select the posted Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 8. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # 9. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 10. Go to contact record of contact who was applied
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE + "')]]").displayed?
      }  
    
    #Delete accounts created in this testcase
     DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
     DeleteAccount(AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT)
     
    #Delete requisition created in this testcase
    DeleteRequisition(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE)  
  end
      
  def CreateRequisitionPostJob(name, postjob)
    #postjob=TRUE will check "Post Job" checkbox, postjob=false will not check it.
      
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
      {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
      {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH},
      {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH},
      {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => name},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_TEXT},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT},
      {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH},
    ]
    Common.main(test)
    if postjob
      unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
        $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
      end
    else
      if $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
        $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
      end  
    end
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    
    $wait.until {
        $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).displayed?
      }
  end


  #TC260 - Successfully Apply to unposted job with "Enable Enhanced Apply to Job" = TRUE, Apply via Exception
  def test_ApplyUnpostedJobEnableEnhancedApplyTrueException
  
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    # Job with "Post job" = False
    CreateRequisitionPostJob(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE, false)
    
    #Enable Enhanced Apply to Job" = True
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
          
    #At least one contact must exist 
    CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    #At least one agency must exist
    CreateAgencyAccount(AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT)
    
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
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 5. Select the unposted Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 8. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # 9. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 10. Go to contact record of contact who was applied
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE + "')]]").displayed?
      }  
    
    #Delete accounts created in this testcase
     DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
     DeleteAccount(AccountsNewEditPage::ACCOUNT_NEW_DATA_NAME_TEXT)
     
    #Delete requisition created in this testcase
    DeleteRequisition(RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE)  
  end
 
################### CUSTOM METHODS #####################
      
  def CreateRequisitionPostJob(name, postjob)
    #postjob=TRUE will check "Post Job" checkbox, postjob=false will not check it.
      
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
      {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
      {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH},
      {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH},
      {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => name},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_TEXT},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT},
      {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH},
    ]
    Common.main(test)
    if postjob
      unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
        $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
      end
    else
      if $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
        $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
      end  
    end
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    
    $wait.until {
        $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).displayed?
      }
  end 

  

  
  def CreateAgencyAccount(name)
    #Create a Agency with "name" as its name
    $browser.get(HomePage::ACCOUNTS_TAB_LINK_URL)
    test = [
      {"displayed" => AccountsHomePage::ACCOUNTS_HOME_PAGE_BTN_NEW_XPATH}, 
      {"click" => AccountsHomePage::ACCOUNTS_HOME_PAGE_BTN_NEW_XPATH},
      {"displayed" => AccountsNewEditPage::ACCOUNTS_NEW_CONTINUE_XPATH},
      {"set_text" => AccountsNewEditPage::ACCOUNTS_NEW_RECORD_TYPE_XPATH, "text" => "Account"},
      {"click" => AccountsNewEditPage::ACCOUNTS_NEW_CONTINUE_XPATH},
      {"displayed" => AccountsNewEditPage::ACCOUNTS_NEW_ACCOUNT_NAME_XPATH},
      {"set_text" => AccountsNewEditPage::ACCOUNTS_NEW_ACCOUNT_NAME_XPATH, "text" => name},
      {"click" => AccountsNewEditPage::ACCOUNTS_NEW_BTN_SAVE_XPATH},
      {"displayed" => AccountsDetailPage::ACCOUNTS_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)   
    
  end
  def CreateShortList(name)
    #Create a Short List with "name" as its name
    $browser.get(HomePage::SHORT_LIST_TAB_LINK_URL)
    test = [
      {"displayed" => ShortListHomePage::SHORT_LIST_HOME_BTN_NEW_XPATH}, 
      {"click" => ShortListHomePage::SHORT_LIST_HOME_BTN_NEW_XPATH},
      {"displayed" => ShortListNewEditPage::SHORT_LIST_NEW_NAME_XPATH},
      {"set_text" => ShortListNewEditPage::SHORT_LIST_NEW_NAME_XPATH, "text" => name},
      {"click" => ShortListNewEditPage::SHORT_LIST_NEW_BTN_SAVE_XPATH},
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH}
    ]
    Common.main(test)   
  end      
  def CreateAccount(name)
    #Create an account record with "name" as Account Name
    $browser.get(HomePage::ACCOUNTS_TAB_LINK_URL)
    test = [
      {"displayed" => AccountsHomePage::ACCOUNTS_HOME_PAGE_BTN_NEW_XPATH}, 
      {"click" => AccountsHomePage::ACCOUNTS_HOME_PAGE_BTN_NEW_XPATH},
      {"displayed" => AccountsNewEditPage::ACCOUNTS_NEW_RECORD_TYPE_XPATH},
      {"set_text" => AccountsNewEditPage::ACCOUNTS_NEW_RECORD_TYPE_XPATH, "text" => "Account"},
      {"click" => AccountsNewEditPage::ACCOUNTS_NEW_CONTINUE_XPATH},
      {"displayed" => AccountsNewEditPage::ACCOUNTS_NEW_ACCOUNT_NAME_XPATH},
      {"set_text" =>AccountsNewEditPage::ACCOUNTS_NEW_ACCOUNT_NAME_XPATH, "text" => name},
      {"click" => AccountsNewEditPage::ACCOUNTS_NEW_BTN_SAVE_XPATH},
      {"displayed" => AccountsDetailPage::ACCOUNTS_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
  end
  
  def CreateContact(name, account_name)
     $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW},
      {"click" => ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH},
      {"set_text" => ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH, "text" => "Contact"},
      {"click" => ContactNewEditPage::CONTACT_NEW_BTN_CONTINUE_XPATH},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH},
      {"set_text" => ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH, "text" => name},
      {"set_text" => ContactNewEditPage::CONTACT_NEW_ACCOUNT_NAME_INPUT_XPATH, "text" => account_name},
      {"click" => ContactNewEditPage::CONTACT_NEW_BTN_SAVE_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH}
    ]
    Common.main(test)   
  end
  
  def DeleteAccount(name)
    #Delete the account record with name "name"
    $browser.get(HomePage::ACCOUNTS_TAB_LINK_URL)
    test = [
    {"displayed" => AccountsHomePage::ACCOUNTS_HOME_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    $browser.find_element(:xpath => AccountsHomePage::ACCOUNTS_HOME_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + name + "')]]").click
     test = [
    {"displayed" => AccountsDetailPage::ACCOUNTS_DETAIL_BTN_DELETE_XPATH},
    {"click" => AccountsDetailPage::ACCOUNTS_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)
    sleep(1)
    $browser.switch_to.alert.accept
  end
  
  def DeleteShortList(name)
    #Delete the Short List with name "name"
    $browser.get(HomePage::SHORT_LIST_TAB_LINK_URL)
    test = [
    {"displayed" => ShortListHomePage::SHORT_LIST_HOME_VIEW_SELECT_XPATH},
    {"set_text" => ShortListHomePage::SHORT_LIST_HOME_VIEW_SELECT_XPATH, "text" => "All Short List"},
    {"click" => ShortListHomePage::SHORT_LIST_HOME_BTN_GO_XPATH},
    {"displayed" => ShortListHomePage::SHORT_LIST_HOME_BTN_NEW_XPATH}
    ]
    Common.main(test)
    $browser.find_element(:xpath => "//*[text()[contains(.,'" + name + "')]]/../../../../td[3]//a[2]").click
    sleep(1)
    $browser.switch_to.alert.accept 
  end
  
  def DeleteRequisition(name)
    # 1 - Go to "Requisition" Tab
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH).displayed?  
      }
    sleep(5)  
    # 2 - Click on the Requisition
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + name + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
     # 3 - Click on Delete 
    $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).click
     sleep(1)
    # 4 - Confirm
    $browser.switch_to.alert.accept
  end
end