require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
require './New_Automation/tests/users.rb'
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


class TestActionsOnRecord < TestBasic

  #TC53 - Successfully add new skill to one contact
  def test_AddNewSkillToContact
    randomContact = SecureRandom.hex(4)
    
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # 1. Click on "Contacts". 

    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)

    
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]"},
    ]
    Common.main(test)
    
    # 3. Click on "Add skills"
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      
    ]
    Common.main(test)
    sleep(2)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_SECOND_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_LIST_2_ELEMENT_XPATH},
      {"click_and_load" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH}
      ]
    Common.main(test)
    assert_equal("Success:\nSkills Added Successfully", $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_SUCCESS_MESSAGE_XPATH).text)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH).click
    $browser.switch_to.window($browser.window_handles.first)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)

    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]"},
    ]
    Common.main(test)
    
    $wait.until {
       $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
     }
     
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?   
  
    }
    

  end

  #TC261 - Successfully add/rate new skill to one contact
  def test_SuccessfullyAddRateSkillToContact
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    
    # 3. Click on "Add skills"
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      
    ]
    Common.main(test)
    sleep(2)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
    # 4. Select one or more "skill to add" (doing click on checkbox)  
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_SECOND_ELEMENT_XPATH},
    # 5. Click on right arrow  
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_LIST_2_ELEMENT_XPATH},
    # 6. Click on "Save & Rate Skills"  
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_RATE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SKILL_BTN_SUBMIT_XPATH}
    ]
    Common.main(test)
    
    # 7. Move slider to give rating to 2 skills
    #Use slider for rate skills
    element = $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SLIDER_1_XPATH)
    target = $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SKILL_BTN_SUBMIT_XPATH)
    $browser.action.drag_and_drop(element, target).perform
    
    element2 = $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SLIDER_2_XPATH)
    $browser.action.drag_and_drop(element2, target).perform
      
    test = [
    # 8. Click "Submit"  
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_RATE_SKILL_BTN_SUBMIT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH}
      ]  
    Common.main(test)
    
    assert_equal("Skills Rated (2)", $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_RATED_MSG_XPATH).text)

    # 9. Close window 
    test = [ 
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    #RESULTS
    # Skill record should be created, skill record should show rating
    $browser.switch_to.window($browser.window_handles.first)
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
        
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?   
    
    }
    test = [
      {"click_and_load" => ContactDetailPage::CONTACT_DETAIL_RECORD_SKILL_LIST_FIRST_XPATH}
    ]
    Common.main(test) 

     test = [ 
      {"displayed" => SkillDetailPage::SKILL_DETAIL_RATING_XPATH}
    ]
    Common.main(test) 
    assert_equal("10", $browser.find_element(:xpath => SkillDetailPage::SKILL_DETAIL_RATING_XPATH).text)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
     
    test = [
    {"displayed" => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH},
    {"click_and_load" => ContactDetailPage::CONTACT_DETAIL_RECORD_SKILL_LIST_SECOND_XPATH},
    {"displayed" => SkillDetailPage::SKILL_DETAIL_RATING_XPATH}
     ]
     
    Common.main(test)
    assert_equal("10", $browser.find_element(:xpath => SkillDetailPage::SKILL_DETAIL_RATING_XPATH).text)
    
    
  end  

  #TC54 - Successfully Add to List (Existing) one contact
  def test_SuccessfullyAddToExistingListContact
    randomContact = SecureRandom.hex(4)
    randomSL = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    home_url = $browser.current_url
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #At least one short list must exist 
    Common.CreateShortList(randomSL)
    
    # 1. Click on "Contacts". 
    $browser.get(home_url)
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    $wait.until {
        $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
      } 
      
    # 3. Click on "Add to List"
    Common.click(ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 4. Enter a Short List name  
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH, "text" => randomSL},
    # 5. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH).text)
 
    test = [ 
    # Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 6. Click on Short List tab
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 7. Click on name of used short list
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    Common.click_and_load(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]")
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
        
  end

 
  #TC262 - Successfully Add to List (New) one contact
  def test_SuccessfullyAddToNewListContact
    randomContact = SecureRandom.hex(4)
    randomSL = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
        
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
        $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
      } 
    
    # 3. Click on "Add to List"
    Common.click(ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 4. 4. Enter a value in the fields: "Name (required) an "Description" (optional). 
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NEW_NAME_INPUT_XPATH, "text" => randomSL},
    # 5. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH).text)
 
    test = [ 
    # Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 6. Click on Short List tab
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 7. Click on name of short list created
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    Common.click_and_load(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]")
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    
  end      

  #TC55 - Successfully Apply to Jobs
  def test_ApplyToJobContact
    randomContact = SecureRandom.hex(4)
    randomReq = SecureRandom.hex(4)
  
    #PRECONDITIONS:
    
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    
    # Job with "Post job" = False
    Common.CreateRequisitionPostJob(randomReq, false)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
       
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    $wait.until {
        $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_APPLY_TO_JOB_XPATH).displayed?
      }  
      
    # 3. Click on "Apply to Jobs"
    Common.click(ContactDetailPage::CONTACT_DETAIL_BTN_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 4. Select the created Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 5. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 6. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 7. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # 8. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH}
    ] 
   Common.main(test)
   assert $wait.until {
      $browser.find_element(:xpath, ContactsHomePage::CONTACT_JOB_POPUP_SUCCESS_APP_XPATH).displayed?
      $browser.find_element(:xpath, ContactsHomePage::CONTACT_JOB_POPUP_SUCCESS_CANDIDATE_XPATH).displayed?      
    }  
    test = [
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 10. Go to contact record of contact who was applied
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
     
    $wait.until {
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
    }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }  
    
  end     
end