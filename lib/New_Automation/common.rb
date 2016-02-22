include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb' 


require_relative './pages/login_page.rb'
require_relative './pages/home_page.rb'


class Common
  USER_EMAIL = "naomi@joblabs.com"
  USER_EMAIL2 = "naomirecruiter@joblabs.com"
  PASSWORD  = "muffin100"
 
  

  #LOGIN
  def self.login(username, password) 
   $browser.find_element(:id, LoginPage::NAME_TEXT_FIELD_ID).send_keys username
   $browser.find_element(:id, LoginPage::PASSWORD_TEST_FIELD_ID).send_keys password
   $browser.find_element(:id, LoginPage::LOGIN_BUTTON_ID).click
   $wait.until {
     $browser.current_url.eql?(HomePage::HOME_TAB_LINK_URL)
   } 
 end
    

  #Selects the option from a Select element, by Text
  # selectElement: dropdown element
  # optionText: string option to be selected from the dropdown  
  def self.selectByText(dropdown, optionText)
    select = Selenium::WebDriver::Support::Select.new(dropdown)
    select.select_by(:text, optionText)
  end
  
  
  #Selects the option from a Select element, by Index
  # selectElement: dropdown element
  # index: index number to be selected from the dropdown
  def self.selectByIndex(dropdown, index)
    select = Selenium::WebDriver::Support::Select.new(dropdown)
    select.select_by(:index, index)
  end

  #Selects the option from a Select element, by Text
  # selectElement: dropdown element
  def self.get_selected_option_text(dropdown)
    select = Selenium::WebDriver::Support::Select.new(dropdown)
    selected_optionText = select.selected_options[0].text
    return selected_optionText
  end
  
  def self.click(field)
    return $browser.find_element(:xpath => field).click
  end
  
  def self.displayed(field)
      $wait.until{
        return $browser.find_element(:xpath => field).displayed?
      }
  end
  
  def self.not_displayed(field)
    begin
      $wait.until{
        return $browser.find_element(:xpath => field).displayed?
      }
    rescue
      return true
    end
  end
  
  def self.hassert(field)
    return assert $browser.find_element(:xpath, field).displayed?
 
  end
  
  def self.hassert_equal(text, text2)
    assert_equal($browser.find_element(:xpath => text).text, text2)
  end
  
  def self.set_text(field, text)
    begin
      $browser.find_element(:xpath => field).clear()
    rescue
      $browser.find_element(:xpath => field).send_keys text
    else
      $browser.find_element(:xpath => field).send_keys text
    end
  end
  

  def self.upload(field, file)
    begin
     $browser.find_element(:xpath => field).send_keys(file) # "/Users/admin/Desktop/document.pdf"
     $browser.action.send_keys(:enter).perform
   rescue
     puts "error in upload"
   end
  end

  #Find an item that has size options 
 def self.itemNotExists(xpath)
   array = $browser.find_elements(:xpath => xpath)
   found = array.size < 1
   return found
 end
  

  
  def self.main(arr)
    puts "main"
    for i in arr
      if i["click"]
        puts "click"
        self.click(i["click"])
      end
      if i["displayed"]
        puts "displayed"
        self.displayed(i["displayed"])
      end
      if i["not_displayed"]
        puts "not displayed"
        self.not_displayed(i["not_displayed"])
      end
      if i["checked"]
        puts "checked"
        begin
          self.displayed(i["checked"] + "[@checked='checked']")
        rescue Exception => ex
          #puts "An error of type #{ex.class} happened, message is #{ex.message}"
          puts "Error" 
          self.click(i["checked"])
        end
      end 
      if i["unchecked"]
        puts "unchecked"
        begin
          self.displayed(i["unchecked"] + "[not (@checked='checked')]")
        rescue Exception => ex
          #puts "An error of type #{ex.class} happened, message is #{ex.message}"
          self.click(i["unchecked"])
        end
      end 
      if i["set_text"]
        puts "set_text"
        self.set_text(i["set_text"], i["text"])
      end
      if i["assert"]
        puts "assert"
        self.assert(i["assert"])
      end
      if i["assert_equal"]
        puts "assert equal"
        self.assert_equal(i["assert_equal"])
      end
      if i["select_by_text"]
        puts "select by text"
        self.selectByText(i["select_by_text"], i["option_text"])
      end
      if i["upload"]
        puts "upload"
        self.upload(i["upload"], i["file"])
      end
    end
    
    return true
  end

  def self.CreateAccount(name)
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
  
  def self.CreateContact(name, account_name)
    #Create a Contact with name "name", and asociated with the account record with name "account_name"
     $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW},
      {"click" => ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH},
      {"set_text" => ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH, "text" => "Contact"},
      {"click" => ContactNewEditPage::CONTACT_NEW_BTN_CONTINUE_XPATH},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_ACCOUNT_NAME_INPUT_XPATH}
    ] 
    Common.main(test)
    sleep(2) 
    test = [ 
      {"set_text" => ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH, "text" => name},
      {"set_text" => ContactNewEditPage::CONTACT_NEW_ACCOUNT_NAME_INPUT_XPATH, "text" => account_name},
      {"click" => ContactNewEditPage::CONTACT_NEW_BTN_SAVE_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH}
    ]
    Common.main(test)   
  end
  
  def self.DeleteAccount(name)
    #Delete the account record with name "name", it also will be deleted the contacts asociated with the account
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
  
  def self.CreateShortList(name)
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
  
  def self.DeleteShortList(name)
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
  
  def self.CreateRequisitionPostJob(name, postjob)
    #postjob=TRUE will check "Post Job" checkbox, so the job will be posted on JobBoard, postjob=false will not check it.
      
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
  
  def self.DeleteRequisition(name)
    #Requisition with name "name" will be deleted
    
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