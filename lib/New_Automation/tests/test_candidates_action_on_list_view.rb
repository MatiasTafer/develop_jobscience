require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
require_relative 'users.rb'
require './New_Automation/pages/home_page.rb'

require './New_Automation/pages/contacts/contacts_home_page.rb'

require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'
require './New_Automation/pages/applications/applications_home_page.rb'

require './New_Automation/pages/answers/answer_detail_page.rb'
require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'

require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'
require './New_Automation/pages/offers/offers_home_page.rb'
require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'

require './New_Automation/tests/custom_settings.rb'
require './New_Automation/pages/accounts/accounts_home_page.rb'
require './New_Automation/pages/accounts/accounts_new_edit_page.rb'
require './New_Automation/pages/accounts/accounts_detail_page.rb'
require './New_Automation/pages/search/skill_detail_page.rb'
require './New_Automation/pages/short_lists/short_list_home_page.rb'
require './New_Automation/pages/short_lists/short_list_new_edit_page.rb'
require './New_Automation/pages/short_lists/short_list_detail_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'

class TestActionsOnListView < TestBasic

  #TC47 - Successfully create a new contact
  def test_CreateNewContact
    randomContact = SecureRandom.hex(4)
    randomAccount = SecureRandom.hex(4)
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #An account must be created for the contact
    Common.CreateAccount(randomAccount)
    
    # 1. Click on "Contacts" 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Click on "New".
    Common.displayed(ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW)
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW)
    
    # 3. On "Select Contact Record Type" select the option "contact".
    Common.displayed(ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH)
    Common.set_text(ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH, "Contact")
    
    # 4. Click on button "Continue".
    Common.click_and_load(ContactNewEditPage::CONTACT_NEW_BTN_CONTINUE_XPATH)
    
    # 5. Complete the text box (required): "Last name" an "Account Name".
    Common.displayed(ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH)
    Common.set_text(ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH, randomContact)
    Common.set_text(ContactNewEditPage::CONTACT_NEW_ACCOUNT_NAME_INPUT_XPATH, randomAccount)
    
    #6. Complete the fields (optional).
    #7. Click on "Save".
    Common.click_and_load(ContactNewEditPage::CONTACT_NEW_BTN_SAVE_XPATH)
    
    #RESULT
    #Redirects to "Contact Detail" page.
    Common.displayed(ContactDetailPage::CONTACT_DETAIL_NAME_XPATH)
    
    assert_equal($browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text, randomContact)
    
  end

  #TC48 - Successfully Add Skill
  def test_SuccessfullyAddSkill
    randomContact = "0" + SecureRandom.hex(4)

    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    Common.click(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input")
    
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
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?   
  
    }
  end
  
  #TC857 - Add Skills, Validation
  def test_AddSkillValidation
    randomContact = "0" + SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 4. Click on "Add skills"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_SKILL_XPATH)
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_ERROR_OUTPUT_2_XPATH}
      ]
    Common.main(test)
    
    assert_equal(ContactsHomePage::CONTACT_SKILL_POPUP_ERROR_MESSAGE_2_TEXT, $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_ERROR_OUTPUT_2_XPATH).text)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CANCEL_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CANCEL_XPATH}
    ]
    Common.main(test)
    $browser.switch_to.window($browser.window_handles.first)
  end    
  
  #TC253 - Successfully Add and Rate Skill
  def test_SuccessfullyAddRateSkill
    randomContact = "0" + SecureRandom.hex(4)
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 4. Click on "Add skills"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_SKILL_XPATH)
    sleep(3)
    
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
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?   
    
    }
    test = [
      {"click_and_load" => ContactDetailPage::CONTACT_DETAIL_RECORD_SKILL_LIST_FIRST_XPATH},
      {"displayed" => SkillDetailPage::SKILL_DETAIL_RATING_XPATH}
    ]
    Common.main(test) 
    assert_equal("10", $browser.find_element(:xpath => SkillDetailPage::SKILL_DETAIL_RATING_XPATH).text)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    
    test = [
    {"displayed" => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH},
    {"click_and_load" => ContactDetailPage::CONTACT_DETAIL_RECORD_SKILL_LIST_SECOND_XPATH},
    {"displayed" => SkillDetailPage::SKILL_DETAIL_RATING_XPATH}
     ]
     
    Common.main(test)
    assert_equal("10", $browser.find_element(:xpath => SkillDetailPage::SKILL_DETAIL_RATING_XPATH).text)
    
  end
    
   
  #TC254 - Adding and Rating Skills for multiple contacts
  def test_AddRateSkillMultipleContacts
    randomContact = "0" + SecureRandom.hex(4)
    randomContact2 = "0" + SecureRandom.hex(4)
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least two account must exist
    Common.CreateAccount(randomContact) 
    Common.CreateAccount(randomContact2)
    
    #At least two contact must exist 
    Common.CreateContact(randomContact, randomContact)
    Common.CreateContact(randomContact2, randomContact2)
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact2 + "')]]/../../../..//td[1]//input").click
  
    
    # 4. Click on "Add skills"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_SKILL_XPATH)
    sleep(3)
    
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
    
    Common.click(ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CANCEL_XPATH)
    
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow) 
    
   end

  #TC49 - Successfully Add to Existing Short List
  def test_SuccessfullyAddToExistingList
    randomContact = "0" + SecureRandom.hex(4)
    randomList = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    url_home = $browser.current_url
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
        
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #At least one short list must exist 
    Common.CreateShortList(randomList)
    
    $browser.get(url_home)    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 4. Click on "Add to List"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_LIST_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH, "text" => randomList},
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
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 8. Click on name of used short list
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    Common.click_and_load(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomList + "')]]")
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    
  end

 #TC255 - Successfully Add to New Short List
  def test_SuccessfullyAddToNewList
    randomContact = "0" + SecureRandom.hex(4)
    randomList = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
        
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Select a Contact List View and click Go
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 3. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 4. Click on "Add to List"
    Common.click(ContactsHomePage::CONTACT_HOME_ADD_LIST_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NEW_NAME_INPUT_XPATH, "text" => randomList},
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
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 8. Click on name of used short list
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    Common.click_and_load(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomList + "')]]")
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    
  end

  #TC50 - Successfully Apply to unposted job with "Enable Enhanced Apply to Job" = FALSE
  def test_ApplyUnpostedJobEnableEnhancedApplyToJobFalse  
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
  
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = False. 
    Common.CreateRequisitionPostJob(randomReq, false)
    
    #Enable Enhanced Apply to Job" = FALSE
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(false)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 6. Click "Apply To Position" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_APPLY_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
    # 7. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }

  end
  
    
  #TC256 - Successfully Apply to posted job with "Enable Enhanced Apply to Job" = FALSE
  def test_ApplyPostedJobEnableEnhancedApplyFalsePostTrue  
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = True. 
    Common.CreateRequisitionPostJob(randomReq, true)
    
    #Enable Enhanced Apply to Job" = FALSE
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(false)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 6. Click "Apply To Position" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_APPLY_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
    # 7. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }
    
  end

  #TC51 - Successfully Apply to posted job with "Enable Enhanced Apply to Job" = TRUE, Invite to Apply
  def test_ApplyPostedJobEnableEnhancedApplyTrueInvite 
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = True
    Common.CreateRequisitionPostJob(randomReq, true)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Invite to Apply   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }
  end  

  #TC52 - Try to Invite to Apply with "Post job" = False
  def test_TryToInvitePostJobFalse 
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = false
    Common.CreateRequisitionPostJob(randomReq, false)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
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
    sleep(2)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
  end

  #TC257 - Successfully Apply to posted job with "Enable Enhanced Apply to Job" = TRUE, Apply via Agency
  def test_ApplyPostedJobEnableEnhancedApplyTrueAgency 
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    randomAgy = SecureRandom.hex(4)
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = True
    Common.CreateRequisitionPostJob(randomReq, true)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #At least one agency must exist
    CreateAgencyAccount(randomAgy)
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Agency   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_AGENCY_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_AGENCY_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_AGENCY_XPATH, "text" => randomAgy},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
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
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }  
    
  end


  #TC258 - Successfully Apply to unposted job with "Enable Enhanced Apply to Job" = TRUE, Apply via Agency
  def test_ApplyUnpostedJobEnableEnhancedApplyTrueAgency 
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    randomAgy = SecureRandom.hex(4)
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = False
    Common.CreateRequisitionPostJob(randomReq, false)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #At least one agency must exist
    CreateAgencyAccount(randomAgy)
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_AGENCY_XPATH},
    # 7. Click on Agency   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_AGENCY_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_AGENCY_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_AGENCY_XPATH, "text" => randomAgy},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }  
    
  end
   
  #TC259 - Successfully Apply to posted job with "Enable Enhanced Apply to Job" = TRUE, Apply via Exception
  def test_ApplyPostedJobEnableEnhancedApplyTrueException
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    randomAgy = SecureRandom.hex(4)
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = true
    Common.CreateRequisitionPostJob(randomReq, true)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
        
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 8. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
       {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_XPATH, "text" => "some text"},
    # 9. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 10. Go to contact record of contact who was applied
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }  
    
  end
  
  #TC260 - Successfully Apply to unposted job with "Enable Enhanced Apply to Job" = TRUE, Apply via Exception
  def test_ApplyUnpostedJobEnableEnhancedApplyTrueException
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = False
    Common.CreateRequisitionPostJob(randomReq, false)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 8. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_XPATH, "text" => "some text"},
    # 9. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 10. Go to contact record of contact who was applied
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }  
    
  end


  #TC855 - Apply to Jobs, Validation
  def test_ApplyToJobsValidation  
    randomContact = "0" + SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
        
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #Custom Settings > Config > Invite to Apply Custom Message = true
    CustomSettings.InviteToApplyCustomMessage(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 4 - Click on "Next" without selection any job order
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_ERROR_OUTPUT_XPATH},
    ]
    Common.main(test)
    
    assert_equal(ContactsHomePage::CONTACT_JOB_POPUP_ERROR_TEXT, $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_ERROR_OUTPUT_XPATH).text)
    test = [
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CANCEL_XPATH}
    ]
    Common.main(test)
    $browser.switch_to.window($browser.window_handles.first)
    
  end  
   
  #TC852 - Apply To Jobs, Disable EEO = false
  def test_ApplyToJobsDisableEEOFalse
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = False
    #Disable EEO = false
    Common.CreateRequisitionPostJob(randomReq, false, false)
    
    #Custom Settings > Config > Invite to Apply Custom Message = true
    Common.go_to_custom_settings()
    CustomSettings.InviteToApplyCustomMessage(true)
    
    #Enable Enhanced Apply to Job" = True
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 5. Select the Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_XPATH, "text" => "some text"},
    # 8. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_GOTO_JOB_XPATH},
    # 9 - Click on "Go to Job"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_GOTO_JOB_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
  


    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test)
    
    # RESULT 9 - You will be redirected to the "Job Order Detail" page. 
    # Verify that new application(s) for selected contact(s) were created. 
    assert $wait.until {
      $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    
    Common.click_and_load(RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../th[1]/a")
    test = [
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH}
    ]
    
    # RESULT Verify that the following application fields were populated according to the application option selected on previous step:
    # App Status = Incomplete; Apply Exception = true; Exception Reason = <Selected Value>; Exception Reason Other = <Entered Value>
    
    assert_equal("Incomplete", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH).text)
    assert $wait.until {
        $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_APPLY_EXCEPTION_CHECKED_XPATH).displayed?
      }  
    assert_equal("New", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_EXCEPTION_REASON_XPATH).text)
    assert_equal(" ", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_EXCEPTION_REASON_OTHER_XPATH).text)
  end
 
  #TC853 - Apply To Jobs, Disable EEO = true
  def test_ApplyToJobsDisableEEOTrue
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = False
    #Disable EEO = true
    Common.CreateRequisitionPostJob(randomReq, false, true)
    
    #Custom Settings > Config > Invite to Apply Custom Message = true
    Common.go_to_custom_settings()
    CustomSettings.InviteToApplyCustomMessage(true)
    
    #Enable Enhanced Apply to Job" = True
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 4. Select Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 5. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
    # 6. Click on "Go to Job"
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_GOTO_JOB_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_GOTO_JOB_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
  

    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test)
    
    # RESULT 6 - You will be redirected to the "Job Order Detail" page. 
    # Verify that new application(s) for selected contact(s) were created. 
    assert $wait.until {
      $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    Common.click_and_load(RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../th[1]/a")
    test = [
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH}
    ]
    
    # RESULT Verify that the following application fields were populated according to the application option selected on previous step:
    # App Status = Incomplete; Apply Exception = true; Exception Reason = <Selected Value>; Exception Reason Other = <Entered Value>
    
    assert_equal("Incomplete", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH).text)
    assert $wait.until {
        $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_APPLY_EXCEPTION_NOT_CHECKED_XPATH).displayed?
      }  
    assert_equal(" ", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_EXCEPTION_REASON_XPATH).text)
    assert_equal(" ", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_EXCEPTION_REASON_OTHER_XPATH).text)
  end
   
  #TC854 - Apply To Jobs, Enable Enhanced Apply to Job = false & Disable EEO = false
  def test_ApplyToJobsDisableEEOFalseEnableEnhancedFalse
    randomContact = "0" + SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = False
    #Disable EEO = false
    Common.CreateRequisitionPostJob(randomReq, false, false)
    
    #Custom Settings > Config > Invite to Apply Custom Message = true
    Common.go_to_custom_settings()
    CustomSettings.InviteToApplyCustomMessage(true)
    
    #Enable Enhanced Apply to Job" = False
    CustomSettings.EnableEnhancedApplyToJob(false)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 4. Select Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 5. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_APPLY_XPATH},
    # 6. Click on "Go to Job"
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_GOTO_JOB_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_GOTO_JOB_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
  

    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test)
    
    # RESULT 6 - You will be redirected to the "Job Order Detail" page. 
    # Verify that new application(s) for selected contact(s) were created. 
    assert $wait.until {
      $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    Common.click_and_load(RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../th[1]/a")
    test = [
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH}
    ]
    
    # RESULT Verify that the following application fields were populated according to the application option selected on previous step:
    # App Status = Incomplete; Apply Exception = true; Exception Reason = <Selected Value>; Exception Reason Other = <Entered Value>
    
    assert_equal("Incomplete", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH).text)
    assert $wait.until {
        $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_APPLY_EXCEPTION_NOT_CHECKED_XPATH).displayed?
      }  
    assert_equal(" ", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_EXCEPTION_REASON_XPATH).text)
    assert_equal(" ", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_EXCEPTION_REASON_OTHER_XPATH).text)
  end     
 
  #TC847 - Add Tags, Public Tag
  def test_AddTagsPublicTag
    
    ##Must have at least one Public tag created for working
    
    randomContact = "0" + SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
        
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
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
    
    ##Must have at least one Personal tag created for working
    
    randomContact = "0" + SecureRandom.hex(4)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
        
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
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
    randomContact = "0" + SecureRandom.hex(4)
    randomTag = SecureRandom.hex(2)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
        
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
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
    randomContact = "0" + SecureRandom.hex(4)
    randomTag = SecureRandom.hex(2)
      
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
        
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
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
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
      
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    #Some error ocurr when clicking the "Go" button. This is not happened in other test cases
    if $browser.browser.to_s == "chrome"
      test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
      ]
      Common.main(test)
    else
      test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
      ]
      Common.main(test)
    end
    
    
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


  ######### CUSTOM METHODS ##########
  def CreateAgencyAccount(name)
    #Create a Agency with "name" as its name
    Common.goToTab(HomePage::ACCOUNTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => AccountsHomePage::ACCOUNTS_HOME_PAGE_BTN_NEW_XPATH}, 
      {"click_and_load" => AccountsHomePage::ACCOUNTS_HOME_PAGE_BTN_NEW_XPATH},
      {"displayed" => AccountsNewEditPage::ACCOUNTS_NEW_CONTINUE_XPATH},
      {"set_text" => AccountsNewEditPage::ACCOUNTS_NEW_RECORD_TYPE_XPATH, "text" => "Account"},
      {"click_and_load" => AccountsNewEditPage::ACCOUNTS_NEW_CONTINUE_XPATH},
      {"displayed" => AccountsNewEditPage::ACCOUNTS_NEW_ACCOUNT_NAME_XPATH},
      {"set_text" => AccountsNewEditPage::ACCOUNTS_NEW_ACCOUNT_NAME_XPATH, "text" => name},
      {"click_and_load" => AccountsNewEditPage::ACCOUNTS_NEW_BTN_SAVE_XPATH},
      {"displayed" => AccountsDetailPage::ACCOUNTS_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)   
    
  end
     

end