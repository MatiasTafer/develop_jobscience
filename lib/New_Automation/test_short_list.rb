require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/short_list_detail_page.rb'
require_relative './pages/short_list_home_page.rb'
require_relative './pages/short_list_review_email_popup.rb'
require_relative './pages/short_list_send_email_popup.rb'
require_relative './pages/setup_page.rb'
require_relative './pages/home_page.rb'
require_relative './pages/contacts_home_page.rb'
require_relative './pages/short_list_add_to_popup.rb'
require_relative './pages/short_list_creation_page.rb'
require_relative './pages/short_list_add_contact_popup.rb'



class TestShortList < TestBasic
=begin 
  
#TC90 - Successfully Add/Update Status 
def test_addUpdateStauts
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::SHORT_LIST_TAB_LINK_URL
  $wait.until {
    $browser.current_url.eql? HomePage::SHORT_LIST_TAB_LINK_URL
  }
  test = [{"click" => ShortListHomePage::SHORT_LIST_RECORD_XPATH_2}, 
          {"displayed" => ShortListDetailPage::SL_RECORD_XPATH},
          {"click" => ShortListDetailPage::SL_RECORD_XPATH},
          {"click" => ShortListDetailPage::SL_MENU_XPATH},
          {"displayed" => ShortListDetailPage::SL_UPDATE_STATUS_OPTION_XPATH},
          {"click" => ShortListDetailPage::SL_UPDATE_STATUS_OPTION_XPATH}]
  Common.main(test)        
  #newWindow= $browser.window_handles[1]
  #$browser.switch_to.window(newWindow) 
  #new_frame = $browser.find_element(:xpath, ShortListDetailPage::FRAME_STATUS_XPATH)
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
=end  


=begin
#TC91 - Open Speed review
def test_openSpeedReview
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::SHORT_LIST_TAB_LINK_URL
  $wait.until {
    $browser.current_url.eql? HomePage::SHORT_LIST_TAB_LINK_URL
  }
  test = [{"click" => ShortListHomePage::SHORT_LIST_RECORD_XPATH_2},
          {"displayed" => ShortListDetailPage::SL_RECORD_XPATH},
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
  # hay que vovler a poner el icono de short list y la lupa sino los otros test no funcionan
end
=end


=begin
#TC801 Add Contacts to a Short List
def test_addContactShortList
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  $wait.until {
    $browser.current_url.eql? HomePage::ALL_CONTACTS_TAB_LINK
  }
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
  test2 = [{"set_text" => AddToShortList::SHORT_LIST_TEXTBOX_XPATH, "text" => AddToShortList::SHORTLIST_TEXT},
           {"click" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until{
    $browser.find_element(:xpath, AddToShortList::CLOSE_BUTTON_XPATH).displayed?
  }
  
end
=end

=begin
#TC93 - Successfully Removing Enable Web Sourcing and Enable Speed Review
def test_removeWebSourcing
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get SetupEditPage::SHORT_LIST_CUSTOM_SETINGS_PAGE_URL
  $wait.until {
    $browser.current_url.eql? SetupEditPage::SHORT_LIST_CUSTOM_SETINGS_PAGE_URL
  }
  test = [{"click" => SetupEditPage::EDIT_BUTTON_ON_SHORT_LIST_SETUP_XPATH},
          {"displayed" => SetupEditPage::CHECKBOX_SPEEDREVIEW_XPATH},
          {"unchecked"  => SetupEditPage::CHECKBOX_SPEEDREVIEW_XPATH},
          {"unchecked" => SetupEditPage::CHECKBOX_WEB_SOURCING_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH}]
  Common.main(test)
  $browser.get HomePage::SHORT_LIST_TAB_LINK_URL
  $wait.until {
    $browser.current_url.eql? HomePage::SHORT_LIST_TAB_LINK_URL
  }
  $browser.find_element(:xpath, ShortListHomePage::SHORT_LIST_RECORD_XPATH_2).click
  assert $wait.until {
   $browser.find_element(:xpath, ShortListDetailPage::SL_RECORD_XPATH).displayed?
   #!($browser.find_element(:xpath, ShortListDetailPage::)
   #!($browser.find_element(:xpath, ShortListDetailPage::SPEED_REVIEW_ICON_XPATH).displayed?)
   Common.itemNotExists(ShortListDetailPage::SPEED_REVIEW_ICON_XPATH)
  }  
end
=end

=begin
#TC802 - Add Contacts to a Short List, duplicated
def test_addContactShortListDuplicated
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  $wait.until {
    $browser.current_url.eql? HomePage::ALL_CONTACTS_TAB_LINK
  }
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
  test2 = [{"set_text" => AddToShortList::SHORT_LIST_TEXTBOX_XPATH, "text" => AddToShortList::SHORTLIST_TEXT},
           {"click" => AddToShortList::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until{
    $browser.find_element(:xpath, AddToShortList::CLOSE_BUTTON_XPATH).displayed?
  }
end
=end

=begin 
#TC803 - Add Contacts to a Short List, empty values 
def test_addContactToShortListEmptyValues
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  $wait.until {
    $browser.current_url.eql? HomePage::ALL_CONTACTS_TAB_LINK
  }
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
end
=end

#TC804 - Add a Contact to a Short list
def test_addContactShortList
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  #First step: create a new short list
  $browser.get HomePage::SHORT_LIST_TAB_LINK_URL
  test = [{"displayed" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"click" => ShortListHomePage::NEW_SHORT_LIST_BUTTON_XPATH},
          {"displayed" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH},
          {"set_text" => ShortListCreation::TEXT_BOX_NEW_SHORT_LIST_NAME_XPATH, "text" => ShortListCreation::SHORT_LIST_NAME_TEXT},
          {"click" => ShortListCreation::SAVE_BUTTON_XPATH},
          {"displayed" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH},
          {"click" => ShortListDetailPage::ADD_CONTACT_ICON_XPATH}]
  Common.main(test)
  #Second step: add contact to short list
  $browser.switch_to.frame(1)
  test2= [{"displayed" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH},
          {"set_text" => AddContactPopUp::CONTACT_NAME_TEXTBOX_XPATH, "text" => AddContactPopUp::CONTACT_NAME_TEXT},
          {"click" => AddContactPopUp::ADD_TO_SHORT_LIST_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, AddContactPopUp::SUCCESS_MESSAGE_TEXT_XPATH).text, AddContactPopUp::SUCCESS_MESSAGE_TEXT)
  $browser.find_element(:xpath, AddContactPopUp::CLOSE_BUTTON_XPATH).click
  #Fianl step: delete short list 
  $browser.switch_to.default_content
  $wait.until {
    $browser.find_element(:xpath, ShortListDetailPage::DELETE_SHORT_LIST_ICON_XPATH).displayed?
  }
  sleep 10 #esto es porque el objeto se muestra peo no esta activo 
  $browser.find_element(:xpath, ShortListDetailPage::DELETE_SHORT_LIST_ICON_XPATH).click
  sleep 10
  newWindow= $browser.window_handles
  $browser.switch_to.window(newWindow)
  $browser.switch_to.default_content
  assert $browser.find_element(:xpath, ShortListDetailPage::CONFIRM_DELETE_SHORT_LIST_BUTTON_XPATH).click
end
 
 
 
 
 
  
end