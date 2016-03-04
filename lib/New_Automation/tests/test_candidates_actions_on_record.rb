require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'
require './New_Automation/pages/answers/offers_home_page.rb'
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least one account must exist
    CreateAccount(randomContact) 
    
    #At least one contact must exist 
    CreateContact(randomContact, randomContact)
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    # 3. Click on "Add skills"
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      
    ]
    Common.main(test)
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
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH}
      ]
    Common.main(test)
    assert_equal("Success:\nSkills Added Successfully", $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_SUCCESS_MESSAGE_XPATH).text)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH).click
    $browser.switch_to.window($browser.window_handles.first)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least one account must exist
    CreateAccount(randomContact) 
    
    #At least one contact must exist 
    CreateContact(randomContact, randomContact)
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    # 3. Click on "Add skills"
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      
    ]
    Common.main(test)
    sleep(6)
    
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
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
        
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?   
    
    }
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_RECORD_SKILL_LIST_FIRST_XPATH}
    ]
    Common.main(test) 

     test = [ 
      {"displayed" => SkillDetailPage::SKILL_DETAIL_RATING_XPATH}
    ]
    Common.main(test) 
    assert_equal("10", $browser.find_element(:xpath => SkillDetailPage::SKILL_DETAIL_RATING_XPATH).text)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click

     
    test = [
    {"displayed" => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH},
    {"click" => ContactDetailPage::CONTACT_DETAIL_RECORD_SKILL_LIST_SECOND_XPATH},
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least one account must exist
    CreateAccount(randomContact) 
    
    #At least one contact must exist 
    CreateContact(randomContact, randomContact)
    
    #At least one short list must exist 
    CreateShortList(randomSL)
    
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
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
    $browser.get(HomePage::SHORT_LIST_TAB_LINK_URL)
   
    # 7. Click on name of used short list
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]").click
   
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #At least one account must exist
    CreateAccount(randomContact) 
    
    #At least one contact must exist 
    CreateContact(randomContact, randomContact)
        
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
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
    $browser.get(HomePage::SHORT_LIST_TAB_LINK_URL)
   
    # 7. Click on name of short list created
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]").click
   
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    # Job with "Post job" = False
    CreateRequisitionPostJob(randomReq, false)
    
    #Enable Enhanced Apply to Job" = True
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    CreateAccount(randomContact) 
          
    #At least one contact must exist 
    CreateContact(randomContact, randomContact)
       
    # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
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
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
     
    $wait.until {
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
    }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
      }  
    
  end  
  
############### CUSTOM METHODS #####################  
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