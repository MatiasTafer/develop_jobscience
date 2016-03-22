require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'users.rb'
require './New_Automation/pages/short_lists/short_list_detail_page.rb'
require './New_Automation/pages/short_lists/short_list_home_page.rb'
require './New_Automation/pages/short_lists/short_list_review_email_popup.rb'
require './New_Automation/pages/short_lists/short_list_send_email_popup.rb'
require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/short_lists/short_list_add_to_popup.rb'
require './New_Automation/pages/short_lists/short_list_creation_page.rb'
require './New_Automation/pages/short_lists/short_list_add_contact_popup.rb'
require './New_Automation/pages/short_lists/short_list_detail_old_ui_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'



class TestShortList < TestBasic
 
#TC90 - Successfully Add/Update Status 
def test_addUpdateStauts
  randomName = SecureRandom.hex(4)
  randomSL = "0" + SecureRandom.hex(4)
  
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.CreateAccount(randomName)
  Common.CreateContact(randomName, randomName)
  Common.CreateShortList(randomSL)
  AddContactToShortList(randomName, randomSL)
  EnableOldInterfaceSL(false)
  
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  Common.displayed(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH)
  Common.click(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]")

  test = [{"displayed" => ShortListDetailPage::SL_RECORD_XPATH},
          {"click" => ShortListDetailPage::SL_RECORD_XPATH},
          {"click" => ShortListDetailPage::SL_MENU_XPATH},
          {"displayed" => ShortListDetailPage::SL_UPDATE_STATUS_OPTION_XPATH},
          {"click" => ShortListDetailPage::SL_UPDATE_STATUS_OPTION_XPATH}]
  Common.main(test)  
        
  $browser.switch_to.frame(1)  
  test2 = [ {"displayed" => ShortListDetailPage::SELECT_STATUS_DROPDOWN_XPATH},
            {"set_text" => ShortListDetailPage::SELECT_STATUS_DROPDOWN_XPATH, "text" => "Not Invited"},
            {"click" => ShortListDetailPage::SUBMIT_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until{
    $browser.find_element(:xpath, ShortListDetailPage::CLOSE_BUTTON_XPATH).displayed?
    $browser.find_element(:xpath, ShortListDetailPage::SUBMIT_MESSAGE_XPATH).displayed?
  }      
end

#TC91 - Open Speed review
def test_openSpeedReview
  randomName = SecureRandom.hex(4)
  randomSL = "0" + SecureRandom.hex(4)
  
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.CreateAccount(randomName)
  Common.CreateContact(randomName, randomName)
  Common.CreateShortList(randomSL)
  AddContactToShortList(randomName, randomSL)
  EnableOldInterfaceSL(false)
  
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  Common.displayed(ShortListHomePage::SHORT_LIST_RECORD_XPATH_2)
  Common.click(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]")
  
  test = [{"displayed" => ShortListDetailPage::SL_RECORD_XPATH},
          {"click" => ShortListDetailPage::SL_RECORD_XPATH},
          {"click" => ShortListDetailPage::SPEED_REVIEW_ICON_XPATH}]
  Common.main(test)
  $wait.until{
    $browser.find_element(:xpath, ShortListDetailPage::NAME_FIRST_CONTACT_SPEED_LIST_XPATH).displayed?
  }
  contactName =$browser.find_element(:xpath, ShortListDetailPage::NAME_FIRST_CONTACT_SPEED_LIST_XPATH).text
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow) 
  assert $wait.until {
    $browser.find_element(:xpath, ShortListDetailPage::CONTACT_NAME_SPEED_REVIEW_PAGE_XPATH).displayed?
  }      
  assert_equal($browser.find_element(:xpath, ShortListDetailPage::CONTACT_NAME_SPEED_REVIEW_PAGE_XPATH).text, contactName)
  
  $browser.close
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow) 
  
end

#TC801 Add Contacts to a Short List
def test_addContactShortList
  
  randomName = SecureRandom.hex(4)
  randomSL = "0" + SecureRandom.hex(4)
  
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.CreateAccount(randomName)
  Common.CreateContact(randomName, randomName)
  Common.CreateShortList(randomSL)
  EnableOldInterfaceSL(false)
   
  Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
  
  test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts Created Today"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
   Common.main(test)
 
  test = [{"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]/../../../..//td[1]//input"},
          {"click" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]/../../../..//td[1]//input"},
          {"click" => ContactsHomePage::ADD_TO_LIST_BUTTON_XPATH}]
  Common.main(test)
  
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)       
  test2 = [{"set_text" => AddToShortList::SHORT_LIST_TEXTBOX_XPATH, "text" => randomSL},
           {"click" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until{
    $browser.find_element(:xpath, AddToShortList::CLOSE_BUTTON_XPATH).displayed?
  }
  Common.click(AddToShortList::CLOSE_BUTTON_XPATH)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
end

#TC93 - Successfully Removing Enable Web Sourcing and Enable Speed Review
def test_removeWebSourcing
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  
  EnableOldInterfaceSL(false)
  
  begin
  Common.go_to_short_list()
  test = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_SPEEDREVIEW_XPATH},
          {"unchecked"  => SetupEditPage::CHECKBOX_SPEEDREVIEW_XPATH},
          {"unchecked" => SetupEditPage::CHECKBOX_WEB_SOURCING_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  Common.main(test)
  
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  Common.displayed(ShortListHomePage::SHORT_LIST_RECORD_XPATH_2)
  Common.click(ShortListHomePage::SHORT_LIST_RECORD_XPATH_2)
  #Common.displayed(ShortListDetailPage::SL_RECORD_XPATH)
  assert $wait.until {
   #$browser.find_element(:xpath, ShortListDetailPage::ADD_CONTACT_ICON_XPATH).displayed?
   Common.itemNotExists(ShortListDetailPage::SPEED_REVIEW_ICON_XPATH)
  }  
  
  Common.go_to_short_list()
  
  test = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_SPEEDREVIEW_XPATH},
          {"checked"  => SetupEditPage::CHECKBOX_SPEEDREVIEW_XPATH},
          {"checked" => SetupEditPage::CHECKBOX_WEB_SOURCING_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]  
  rescue
  Common.go_to_short_list()
  test = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_SPEEDREVIEW_XPATH},
          {"checked"  => SetupEditPage::CHECKBOX_SPEEDREVIEW_XPATH},
          {"checked" => SetupEditPage::CHECKBOX_WEB_SOURCING_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]  
  end                 
end

#TC802 - Add Contacts to a Short List, duplicated
def test_addContactShortListDuplicated
  randomName = SecureRandom.hex(4)
  randomName2 = SecureRandom.hex(4)
  randomSL = SecureRandom.hex(4)
  
  
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.CreateAccount(randomName)
  Common.CreateContact(randomName, randomName)
  Common.CreateAccount(randomName2)
  Common.CreateContact(randomName2, randomName2)
  Common.CreateShortList(randomSL)
  AddContactToShortList(randomName, randomSL)
  EnableOldInterfaceSL(false)
  
  Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
  test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts Created Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
  Common.main(test)
   
  test = [{"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]/../../../..//td[1]//input"},
          {"click" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]/../../../..//td[1]//input"},
          {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomName2 + "')]]/../../../..//td[1]//input"},
          {"click" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomName2 + "')]]/../../../..//td[1]//input"},
          {"click" => ContactsHomePage::ADD_TO_LIST_BUTTON_XPATH}]
  Common.main(test) 
  
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)       
  test2 = [{"set_text" => AddToShortList::SHORT_LIST_TEXTBOX_XPATH, "text" => randomSL},
           {"click" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH},
           {"displayed" => AddToShortList::CLOSE_BUTTON_XPATH}
           ]
  Common.main(test2)
  assert_equal("1",$browser.find_element(:xpath, AddToShortList::TOTAL_NUMBER_ADDED_LIST_XPATH).text)
  
  Common.click(AddToShortList::CLOSE_BUTTON_XPATH)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
end

#TC803 - Add Contacts to a Short List, empty values 
def test_addContactToShortListEmptyValues
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  
  EnableOldInterfaceSL(false)
  
  Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
  test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts Created Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
  Common.main(test)
  
  test = [{"displayed" => ContactsHomePage::FIRST_CHECKBOX_OF_FIRST_CONTACT_XPATH},
          {"click" => ContactsHomePage::FIRST_CHECKBOX_OF_FIRST_CONTACT_XPATH},
          {"click" => ContactsHomePage::SECOND_CHECKBOX_OF_SECOND_CONTACT_XPATH},
          {"click" => ContactsHomePage::ADD_TO_LIST_BUTTON_XPATH}]
  Common.main(test)
  
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)       
  test2 = [{"click" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until{
    $browser.find_element(:xpath, AddToShortList::ERROR_MESSAGE_XPATH).displayed?
  }
  test = [{"displayed" => AddToShortList::CANCEL_BUTTON_XPATH},
          {"click" => AddToShortList::CANCEL_BUTTON_XPATH},
          ]
  Common.main(test)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
end

#TC804 - Add a Contact to a Short list
def test_addContactShortListFromShortList
  randomName = SecureRandom.hex(4)
  randomSL = SecureRandom.hex(4)
  
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  
  Common.CreateAccount(randomName)
  Common.CreateContact(randomName, randomName)
  
  EnableOldInterfaceSL(false)
  
  #First step: create a new short list
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  test = [{"displayed" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"click" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"displayed" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH},
          {"set_text" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH, "text" => randomSL},
          {"click" => ShortListCreation::SAVE_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH},
          {"click" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH}]
  Common.main(test)
  #Second step: add contact to short list
  $browser.switch_to.frame(1)
  test2= [{"displayed" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH},
          {"set_text" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH, "text" => randomName},
          {"click" => AddContactPopUp::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_TEXT_XPATH).text, AddContactPopUp::SUCCESS_MESSAGE_TEXT)
  $browser.find_element(:xpath, AddContactPopUp::CLOSE_BUTTON_XPATH).click
  #Fianl step: delete short list 
  $browser.switch_to.default_content
  $wait.until{
    $browser.find_element(:xpath, ShortListDetailPage::SL_RECORD_XPATH).displayed?
  }
  $browser.find_element(:xpath, ShortListDetailPage::DELETE_SHORT_LIST_ICON_XPATH).click
  newWindow= $browser.window_handles
  $browser.switch_to.window(newWindow)
  assert $browser.find_element(:xpath, ShortListDetailPage::CONFIRM_DELETE_SHORT_LIST_BUTTON_XPATH).click
end

#TC805 - Add a Contact to a Short list, no contact selected
def test_noContactSelected
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  
  EnableOldInterfaceSL(false)
  #Generate a random string for Short List name
  randomName = SecureRandom.hex(4)
  #First step: create a new short list
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  test = [{"displayed" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"click" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"displayed" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH},
          {"set_text" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH, "text" => randomName},
          {"click" => ShortListCreation::SAVE_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::SEARCH_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH},
          {"click" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH}]
  Common.main(test)
  #Second step: add contact to short list
  $browser.switch_to.frame(1)
  test2= [{"displayed" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH},
          {"click" => AddContactPopUp::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, AddContactPopUp::ERROR_MESSAGE_TEXT_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, AddContactPopUp::ERROR_MESSAGE_TEXT_XPATH).text, AddContactPopUp::ERROR_MESSAGE_TEXT)
end

#TC806 - Add a Contact to a Short list, existing contact
def test_addExistingContact
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  
  EnableOldInterfaceSL(false)
  #Generate a random string for Short List name
  randomName = SecureRandom.hex(4)
  randomContact = SecureRandom.hex(4)
  Common.CreateAccount(randomContact)
  Common.CreateContact(randomContact, randomContact)
  #First step: create a new short list
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  test = [{"displayed" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"click" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"displayed" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH},
          {"set_text" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH, "text" => randomName},
          {"click" => ShortListCreation::SAVE_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::SEARCH_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH},
          {"click" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH}]
  Common.main(test)
  #Second step: add contact to short list
  $browser.switch_to.frame(1)
  test2= [{"displayed" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH},
          {"set_text" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH, "text" => randomContact},
          {"click" => AddContactPopUp::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_TEXT_XPATH).text, AddContactPopUp::SUCCESS_MESSAGE_TEXT)
  $browser.find_element(:xpath, AddContactPopUp::CLOSE_BUTTON_XPATH).click
  #Third step: add the same contact to the same Short list
  $browser.switch_to.default_content
  test3 = [{"displayed" => ShortListDetailPage::SL_RECORD_XPATH},
           {"displayed" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH},
           {"click" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH}]
  Common.main(test3)
  $browser.switch_to.frame(1)
  test4= [{"displayed" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH},
          {"set_text" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH, "text" => randomContact},
          {"click" => AddContactPopUp::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test4)
  assert $wait.until {
    $browser.find_element(:xpath, AddContactPopUp::ERROR_MESSAGE_XPATH).displayed?
  }
end

#TC807 - Remove Contacts from a Short List
def test_removeContact
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  
  EnableOldInterfaceSL(false)
  #Generate a random string for Short List name
  randomName = SecureRandom.hex(4)
  randomContact = SecureRandom.hex(4)
  Common.CreateAccount(randomContact)
  Common.CreateContact(randomContact, randomContact)
  #First step: create a new short list
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  test = [{"displayed" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"click" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"displayed" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH},
          {"set_text" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH, "text" => randomName},
          {"click" => ShortListCreation::SAVE_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::SEARCH_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH},
          {"click" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH}]
  Common.main(test)
  #Second step: add contact to short list
  $browser.switch_to.frame(1)
  test2= [{"displayed" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH},
          {"set_text" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH, "text" => randomContact},
          {"click" => AddContactPopUp::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_TEXT_XPATH).text, AddContactPopUp::SUCCESS_MESSAGE_TEXT)
  $browser.find_element(:xpath, AddContactPopUp::CLOSE_BUTTON_XPATH).click
  #Third step: delete the contact 
  $browser.switch_to.default_content 
  test3 = [{"displayed" => ShortListDetailPage::SL_RECORD_XPATH},
           {"click" => ShortListDetailPage::SL_RECORD_XPATH},
           {"click" => ShortListDetailPage::SL_MENU_XPATH},
           {"displayed" => ShortListDetailPage::SL_REMOVE_CONTACT_XPATH},
           {"click" => ShortListDetailPage::SL_REMOVE_CONTACT_XPATH},
           {"displayed" => ShortListDetailPage::CONFIRM_DELETE_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test3)
  
 
  assert $browser.find_element(:xpath, ShortListDetailPage::CONFIRM_DELETE_CONTACT_BUTTON_XPATH).click
  
  
  
end

#TC808 - Short list menu - no contacts selected
def test_menuNoContactSelected
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  
  EnableOldInterfaceSL(false)
  #Generate a random string for Short List name
  randomName = SecureRandom.hex(4)
  randomContact = SecureRandom.hex(4)
  
  Common.CreateAccount(randomContact)
  Common.CreateContact(randomContact, randomContact)
  #First step: create a new short list
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  test = [{"displayed" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"click" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"displayed" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH},
          {"set_text" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH, "text" => randomName},
          {"click" => ShortListCreation::SAVE_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::SEARCH_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH},
          {"click" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH}]
  Common.main(test)
  $browser.switch_to.frame(1)
  test2= [{"displayed" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH},
          {"set_text" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH, "text" => randomContact},
          {"click" => AddContactPopUp::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_TEXT_XPATH).text, AddContactPopUp::SUCCESS_MESSAGE_TEXT)
  $browser.find_element(:xpath, AddContactPopUp::CLOSE_BUTTON_XPATH).click
  $browser.switch_to.default_content 
  $wait.until {
    $browser.find_element(:xpath, ShortListDetailPage::SL_RECORD_XPATH).displayed?
  }
  $browser.find_element(:xpath, ShortListDetailPage::SL_MENU_XPATH).click
  assert $browser.find_element(:xpath, ShortListDetailPage::SL_UPDATE_STATUS_OPTION_XPATH).displayed? == false  
end

#TC809 - Add to another Short List (old interface)
def test_addToOldInterface
  randomContact = SecureRandom.hex(4)
  randomSL = SecureRandom.hex(4)
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.CreateAccount(randomContact)
  Common.CreateContact(randomContact, randomContact)
  Common.CreateShortList(randomSL)
  AddContactToShortList(randomContact, randomSL)
  Common.go_to_short_list()
  test = [{"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"unchecked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  Common.main(test)
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  
  Common.displayed(ShortListHomePage::SHORT_LIST_RECORD_XPATH)
  Common.click(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]")
  test2 = [{"displayed" => ShortListDetailOldUi::CHECKBOX_CONTACT_XPATH},
           {"click" => ShortListDetailOldUi::CHECKBOX_CONTACT_XPATH},
           {"click" => ShortListDetailOldUi::ADD_TO_ANOTHER_LIST_BUTTON_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow) 
  test3= [{"set_text" => AddToShortList::SHORT_LIST_TEXTBOX_XPATH, "text" => randomSL},
          {"click" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test3)
  assert $wait.until{
    $browser.find_element(:xpath, AddToShortList::CLOSE_BUTTON_XPATH).displayed?
  }
  Common.click(AddToShortList::CLOSE_BUTTON_XPATH)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  Common.go_to_short_list()
  
  test4 = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"checked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  Common.main(test4)
end

#TC810 - Add to another Short List (old interface), no contacts selected
def test_noContactSelectedOldUi
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.go_to_short_list()
  
  test = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"unchecked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  Common.main(test)
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
 
  test2 = [{"displayed" => ShortListHomePage::SHORT_LIST_RECORD_XPATH},
           {"click" => ShortListHomePage::SHORT_LIST_RECORD_XPATH},
           {"displayed" => ShortListDetailOldUi::CHECKBOX_CONTACT_XPATH},
           {"click" => ShortListDetailOldUi::ADD_TO_ANOTHER_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until{
    $browser.switch_to.alert.accept
  }
  Common.go_to_short_list()
  
  test3 = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"checked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  Common.main(test3)
end

#TC811 - Add to another Short List (old interface), no short list selected
def test_noShortListSelectedoldUi
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  
  Common.go_to_short_list()
  test = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"unchecked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  Common.main(test)
  
  Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
  test2 = [{"displayed" => ShortListHomePage::SHORT_LIST_RECORD_XPATH},
           {"click" => ShortListHomePage::SHORT_LIST_RECORD_XPATH},
           {"displayed" => ShortListDetailOldUi::CHECKBOX_CONTACT_XPATH},
           {"click" => ShortListDetailOldUi::CHECKBOX_CONTACT_XPATH},
           {"click" => ShortListDetailOldUi::ADD_TO_ANOTHER_LIST_BUTTON_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow) 
  
  test3= [
    {"displayed" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH},
    {"click" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test3)
  
  assert $wait.until{
    $browser.find_element(:xpath, AddToShortList::ERROR_MESSAGE_XPATH).displayed?
  }
  Common.displayed(AddToShortList::CANCEL_BUTTON_XPATH)
  Common.click(AddToShortList::CANCEL_BUTTON_XPATH)
  
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow) 
  Common.go_to_short_list()
  test4 = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"checked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  Common.main(test4)
end


def AddContactToShortList(contact, sL)
  Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
  
  test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts Created Today"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
   Common.main(test)
 
  test = [{"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + contact + "')]]/../../../..//td[1]//input"},
          {"click" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + contact + "')]]/../../../..//td[1]//input"},
          {"click" => ContactsHomePage::ADD_TO_LIST_BUTTON_XPATH}]
  Common.main(test)
  
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles.last
  $browser.switch_to.window(newWindow)       
  test2 = [{"displayed" => AddToShortList::SHORT_LIST_TEXTBOX_XPATH},
           {"set_text" => AddToShortList::SHORT_LIST_TEXTBOX_XPATH, "text" => sL},
           {"click" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  $wait.until{
    $browser.find_element(:xpath, AddToShortList::CLOSE_BUTTON_XPATH).displayed?
  }
  Common.click(AddToShortList::CLOSE_BUTTON_XPATH)
  $browser.switch_to.window($browser.window_handles.first)
end

def EnableOldInterfaceSL(set_bool)
  Common.go_to_short_list()
  if set_bool
  test = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"unchecked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  else
    test = [{"displayed" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"checked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  end          
  Common.main(test)
end

end