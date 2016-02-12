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

class TestActionsOnListView < TestBasic
=begin  
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
=end   
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
      {"click" => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH},
      {"displayed" => SkillDetailPage::SKILL_DETAIL_RATING_XPATH}
     ]
    Common.main(test)
    assert_equal("10", $browser.find_element(:xpath => SkillDetailPage::SKILL_DETAIL_RATING_XPATH).text)
    
    #Delete account created in this testcase
    DeleteAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)  
####TERMINARRR
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
end