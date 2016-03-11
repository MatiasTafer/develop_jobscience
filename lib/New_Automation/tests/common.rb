include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require './New_Automation/pages/login_page.rb'
require './New_Automation/pages/home_page.rb'
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
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'



class Common
  

  
  #LOGIN
  def self.login(username, password)
   #Waits added for Chrome
   $wait.until{
      $browser.find_element(:id, LoginPage::LOGIN_BUTTON_ID).displayed?
   }
   $browser.find_element(:id, LoginPage::NAME_TEXT_FIELD_ID).send_keys username
   $browser.find_element(:id, LoginPage::PASSWORD_TEST_FIELD_ID).send_keys password
   $browser.find_element(:id, LoginPage::LOGIN_BUTTON_ID).click
   $wait.until {
     $browser.find_element(:id, HomePage::HOME_TAB_ID).displayed?
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
    a = $browser.find_element(:xpath => field).click
    return a
  end
  
  #Clicks and element and waits for page to load (assuming that the element triggers a page to load)
  #This method was created because chrome webdriver has a different behaviour
  def self.click_and_load(field)
    current = $browser.current_url
    a = $browser.find_element(:xpath => field).click
    $wait.until {
      $browser.current_url != current
      #$browser.execute_script("return document.readyState;") == "complete" 
    }
      return a
  end
  
  
  def self.displayed(field)
     #puts field

     $wait.until{
        return $browser.find_element(:xpath => field).displayed?
     }

  end
  
  def self.ssleep
      sleep(10)
      puts "sleep"
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
    $wait.until{
      assert $browser.find_element(:xpath, field).displayed?
    }
  end
  
  def self.hassert_equal(text, text2)
    $wait.until{
      assert_equal($browser.find_element(:xpath => text).text, text2)
    }
  end
  
  def self.hassert_match(text, text2)
    $wait.until{
      assert_match($browser.find_element(:xpath => text).text, text2)
    }
  end
  
  def self.set_text_url(field, text)
    # especific function
    if text == "URL"
      $url = $url.split("/")
      $url = $url[3]
      $browser.find_element(:xpath => field).clear()
      $browser.find_element(:xpath => field).send_keys $url
    end
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
  
  
  def self.set_text_exist(field, text)
    begin
      $browser.find_element(:xpath => field).send_keys text    
    rescue
      puts "error in set_text_exist"
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
  
  def self.close_popup()
      $browser.action.send_keys(:escape).perform
  end
  
  def self.error_upload(field)
    begin
      $browser.find_element(:xpath => field).send_keys("/Users/admin/Desktop/test.rb")   
      sleep(5)
      $browser.action.send_keys(:enter).perform
    rescue
      puts "error upload"
    end
  end
  
  def self.change_window
    sleep(5)
    puts "change window"
    $wait.until{
      newWindow= $browser.window_handles.last
      $browser.switch_to.window(newWindow)
    }
    
  end
  
  def self.change_frame
    $wait.until{
      $browser.switch_to.frame(1)  
    }
    
  end
  
  def self.check_apply
    # apply on job board
    $num = 1
    c = true
    begin
      while c do
        path = "(.//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:tb']/child::tr/child::td/child::a)[#{$num}]"
        a = self.displayed(path)
        self.click(path)
        b = self.displayed(".//*[@id='j_id0:j_id4:j_id128'][text()[contains(.,'You have already applied')]]")
        if b
          $num += 1
          self.click(".//*[@id='js-menu-search']/a")
        else
          c = false
        end
      end
    rescue
      puts "\n"
    end
  end
  
  def self.accept_alert
    $browser.switch_to.alert.accept
  end
  
  def self.take_url(field)
    $browser.find_element(:xpath => field).click
    $url = $browser.current_url
    puts $url
    return $url 
  end

  #Find an item that has size options 
  def self.itemNotExists(xpath)
    array = $browser.find_elements(:xpath => xpath)
    found = array.size < 1
    return found
  end
  
  def self.get_cookie
    begin
      #cookie = $browser.manage.add_cookie(opts = {})
      cookie = $browser.manage.cookie_named("apex__tSource")
      cook = cookie[:value]
      puts cook
      #$browser.manage.all_cookies.each do |cookie|
      #    puts cookie[:name]
      #end
    rescue
      puts "no cookie"
    end   
  end
  
  def self.delete_cookie
    #cookie = $browser.manage.add_cookie(opts = {})
    cookie = $browser.manage.delete_cookie("apex__tSource")
    puts cookie
  end
  

  
  def self.main(arr)
    puts "\n"
    puts "main"
    puts "\n"
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
      if i["set_text_url"]
        puts "set_text_url"
        self.set_text_url(i["set_text_url"], i["text"])
      end
      if i["set_text_exist"]
        puts "set_text_exist"
        self.set_text_exist(i["set_text_exist"], i["text"])
      end
      if i["hassert"]
        puts "assert"
        self.hassert(i["hassert"])
      end
      if i["hassert_equal"]
        puts "assert equal"
        self.hassert_equal(i["hassert_equal"], i["text"])
      end
      if i["hassert_match"]
        puts "assert_match"
        self.hassert_match(i["hassert_match"], i["text"])
      end
      if i["take_url"]
        puts "take_url"
        self.take_url(i["take_url"])
      end
      if i["upload"]
        puts "upload"
        self.take_url(i["upload"])
      end
      if i["error_upload"]
        puts "error upload"
        self.take_url(i["error_upload"])
      end
      if i["close_popup"]
        self.close_popup()
      end
      if i["change_window"]
        self.change_window
      end
      if i["check_apply"]
        self.check_apply
      end
      if i["select_by_text"]
        puts "select by text"
        self.selectByText(i["select_by_text"], i["option_text"])
      end
      if i["upload"]
        puts "upload"
        self.upload(i["upload"], i["file"])
      end
      if i["ssleep"]
        puts "sleep"
        self.ssleep
      end
      if i["change_frame"]
        puts "change frame"
        self.change_frame
      end
      if i["get_cookie"]
        puts "get cookie"
        self.get_cookie
      end
      
      if i["delete_cookie"]
        puts "delete cookie"
        self.delete_cookie
      end
      
      if i["accept_alert"]
        puts "accept_alert"
        self.accept_alert
      end
      
      if i["click_and_load"]
        puts "click_and_load"
        self.click_and_load(i["click_and_load"])
      end
    end
    return true
  end
  
  
  def self.login_job_board
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
  end
  
  def self.logout_job_board
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "-"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
  end


  def self.standart_question_null
     self.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH},
      
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_2_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_3_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_4_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_5_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_6_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_7_XPATH, "text" => "-"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
  end

  def self.CreateAccount(name)
    #Create an account record with "name" as Account Name
    self.goToTab(HomePage::ACCOUNTS_TAB_LINK_XPATH)
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
     self.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW},
      {"click" => ContactsHomePage::CONTACT_HOME_PAGE_BTN_NEW},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH},
      {"set_text" => ContactNewEditPage::CONTACT_NEW_RECORD_TYPE_NEW_XPATH, "text" => "Contact"},
      {"click" => ContactNewEditPage::CONTACT_NEW_BTN_CONTINUE_XPATH},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_ACCOUNT_NAME_INPUT_XPATH},
      {"displayed" => ContactNewEditPage::CONTACT_NEW_FIELD_LISTS_XPATH}
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
    self.goToTab(HomePage::ACCOUNTS_TAB_LINK_XPATH)
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
    self.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
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
    self.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
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
  
  def self.DeleteCandidateCreatedToday(name)
    #Delete the Candidate with name "name"
    self.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
    {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
    {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
    {"displayed" => ContactsHomePage::CONTACT_HOME_FIRST_ENTRY_GO_XPATH}
    ]
    Common.main(test)
    $browser.find_element(:xpath => "//*[text()[contains(.,'" + name + "')]]/../../../../td[3]//a[2]").click
    sleep(1)
    $browser.switch_to.alert.accept 
  end
  
  def self.CreateRequisitionPostJob(name, postjob, disableEeo=false, questionSet=nil)
    #postjob=TRUE will check "Post Job" checkbox, so the job will be posted on JobBoard, postjob=false will not check it.
    #disableEeo=TRUE will check "Disable EEO" checkbox, if it is false it will be unchecked.  
    #questionSet will define the name of the Question Set asosiated with the Job Order, the default value is nil
    
    self.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
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
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH, "text" => questionSet},
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
    Checkbox(RequisitionsNewAndEdit::REQUISITIONS_DISABLE_EEO_CHECKBOX_XPATH, disableEeo)
    
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    
    $wait.until {
        $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).displayed?
      }
  end
  
  def self.DeleteRequisition(name)
    #Requisition with name "name" will be deleted
    
    # 1 - Go to "Requisition" Tab
    self.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
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
  
  def self.CreateQuestionSetEmpty(name)
     # 1 - Go to "Question Sets" Tab
    self.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    # 2 - Click on New button
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
    }
    self.click_and_load(QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH)
   
    # 3 - FIll all the fields
    $wait.until{
      $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).displayed?
    }
    
    $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).send_keys name
    
    # 4 - Click on "Save" button
    self.click_and_load(QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).displayed?
    } 
     
  end
  
  def self.CreateUserJobBoard(email, password, fname="a", lname="b")
    
    # Login for JobBoard enable
    CustomSettings.JobBoardLogin(true)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # Leave all fields blank.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => email},
      # Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => password},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => password},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => fname},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => lname},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_RADIO_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain']"},
      {"hassert_equal" => ".//*[@id='atsApplicationSubmittedMain']", 
      "text" => "You have successfully registered.  Your information has been added to our system."},
     
    ]
    Common.main(test)
    
  end


  
  def self.standart_question_set
     self.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH, "text" => "Current Salary"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_2_XPATH, "text" => "Start Date"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_3_XPATH, "text" => "Taxonomy Skills"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_4_XPATH, "text" => "Email"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_5_XPATH, "text" => "Home Phone"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_6_XPATH, "text" => "degree"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_7_XPATH, "text" => "Level"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
  end
  

  def self.Checkbox(checkbox, boolean)
    if boolean
      unless $browser.find_element(:xpath => checkbox).attribute("checked")
        $browser.find_element(:xpath => checkbox).click
      end
    else
      if $browser.find_element(:xpath => checkbox).attribute("checked")
        $browser.find_element(:xpath => checkbox).click
      end  
    end 
  end

  def self.create_sources(name)
    # New Source, Successfully Created
    # If you want to create a URL with the source embedded you can click the Search URL builder button on the board setup page, 
    # click the magnifying glass next to Choose Source to select a source, click Next, click Next, 
    # then click on the Search URL (if you enter a name and click save it will be saved to the notes  and attachments related list)
    
    self.goToTab(HomePage::SOURCE_LINK_XPATH)
    test = [
      {"displayed" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      {"click" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      
      {"displayed" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH, "text" => name},
      {"set_text" => SourceNewEdit::GENERAL_SOURCE_TYPE_XPATH, "text" => "Other"},
      {"set_text" => SourceNewEdit::TYPE_SELECT_XPATH, "text" => "s"},
      {"checked" => SourceNewEdit::ACTIVE_CHECKBOX_XPATH},
      {"click" => SourceNewEdit::SOURCE_EDIT_BTN_SAVE_XPATH},
      
      {"displayed" => ".//*[@class='pageDescription'][text()[contains(.,'" + name + "')]]"},
      # (.//*[@id='j_id0:frm:j_id33:j_id151']/div[2]/table/tbody/tr[2]/th)/following-sibling::td/child::a
      # .attribute("href")
    ]
    Common.main(test)
    
    url_name = 'url_name' + name
    
    $browser.get BoardSetupDetailPage::URL_BUILDER_URL_XPATH
    test = [
      # Create and Save a URL for a Source using Search URL Builder on Board Setup
      {"displayed" => BoardSetupDetailPage::CHOOSE_SOURCE_XPATH},
      {"set_text" => BoardSetupDetailPage::CHOOSE_SOURCE_XPATH, "text" => name},
      {"click" => BoardSetupDetailPage::NEXT_BUTTON_XPATH},
      
      {"displayed" => BoardSetupDetailPage::NEXT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::NEXT_BUTTON_XPATH},
      
      {"displayed" => BoardSetupDetailPage::NEXT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::NEXT_BUTTON_XPATH},
      
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH},
      {"set_text" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NAME_XPATH, "text" => url_name},
      
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH},
      
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end
  
  def self.delete_sources(source_name)
    
    self.goToTab(HomePage::SOURCE_LINK_XPATH)
    test = [
      # Delete the Source associated with the URL
      {"displayed" => ".//*[text()[contains(., '#{source_name}')]]"},
      {"click" => ".//*[text()[contains(., '#{source_name}')]]"},
      
      {"displayed" => SourceNewEdit::SOURCE_EDIT_BTN_DELETE_XPATH},
      {"click" => SourceNewEdit::SOURCE_EDIT_BTN_DELETE_XPATH},
      
      {"accept_alert" => ""},
    ]
    Common.main(test)
    
  end
  
  def self.register_job_board(username, password)
    
    #Common.login(Common::USER_EMAIL, Common::PASSWORD)

    # Precondition
    
    self.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => SetupEditPage::ALLOW_REGISTER_ONLY_CHECKBOX_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_UPLOAD_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PASTE_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_BUILDER_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_COVER_LETTER_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    #
    Common.login_job_board
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      # 6. Click on (at the right side) in "Register".
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      # 7. Fill the fields (required)
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => username},
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => password},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => password},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 11. Click on "Continue"
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'You have successfully registered')]]"},
    ]
    Common.main(test)
    
  end
  
  #This method is used to access each tab
  def self.goToTab(tab)
    #Go to + icon
    self.click_and_load(HomePage::ALL_TABS_LINK_XPATH) 
    $wait.until{
      $browser.find_element(:xpath => tab).displayed?
    }
    self.click_and_load(tab)
  end
  
  def self.custom_settings
    test = [
      {"displayed" => HomePage::MENU_USER_XPATH},
      {"click" => HomePage::MENU_USER_XPATH},
      {"displayed" => HomePage::MENU_USER_SETUP_OPTION_XPATH},
      {"click_and_load" => HomePage::MENU_USER_SETUP_OPTION_XPATH},
      {"displayed" => HomePage::DEVELOP_XPATH},
      {"click_and_load" => HomePage::DEVELOP_XPATH},
      {"displayed" => HomePage::CUSTOM_SETTINGS_XPATH},
      {"click" => HomePage::CUSTOM_SETTINGS_XPATH},
    ]
    Common.main(test)
  end
  
  def self.go_to_custom_settings(edit=false)
    
    self.custom_settings
    
    test = [
      {"displayed" => ".//*[contains(@class,'dataCell')]/a[text()='Config']/ancestor::tr[1]/td[1]/a"},
      {"click" => ".//*[contains(@class,'dataCell')]/a[text()='Config']/ancestor::tr[1]/td[1]/a"},
    ]
    if edit
      a = {"displayed" => ".//a[@class='actionLink'][1]"}
      b = {"click" => ".//a[@class='actionLink'][1]"}
      test << a
      test << b
    end
    Common.main(test)
  end
  
  def self.go_to_short_list(edit=false)
    #Short List
    self.custom_settings
    
    test = [
      {"displayed" => ".//*[contains(@class,'dataCell')]/a[text()='Short List']/ancestor::tr[1]/td[1]/a"},
      {"click" => ".//*[contains(@class,'dataCell')]/a[text()='Short List']/ancestor::tr[1]/td[1]/a"},
    ]
    if edit
      a = {"displayed" => ".//*[@value='Edit']"}
      b = {"click" => ".//*[@value='Edit']"}
      test << a
      test << b
    end
    Common.main(test)
  end
  
  def self.go_to_parser_settings(edit=false)
    #Parser Settings
    self.custom_settings
    
    test = [
      {"displayed" => ".//*[contains(@class,'dataCell')]/a[text()='Parser Settings']/ancestor::tr[1]/td[1]/a"},
      {"click" => ".//*[contains(@class,'dataCell')]/a[text()='Parser Settings']/ancestor::tr[1]/td[1]/a"},
    ]
    if edit
      a = {"displayed" => ".//*[@value='Edit']"}
      b = {"click" => ".//*[@value='Edit']"}
      test << a
      test << b
    end
    Common.main(test)
  end
  
  def self.go_to_social_settings(edit=false)
    #Social Settings
    self.custom_settings
    
    test = [
      {"displayed" => ".//*[contains(@class,'dataCell')]/a[text()='Social Settings']/ancestor::tr[1]/td[1]/a"},
      {"click" => ".//*[contains(@class,'dataCell')]/a[text()='Social Settings']/ancestor::tr[1]/td[1]/a"},
    ]
    if edit
      a = {"displayed" => ".//*[@value='Edit']"}
      b = {"click" => ".//*[@value='Edit']"}
      test << a
      test << b
    end
    Common.main(test)
  end
  
  def self.go_to_sharing_settings(edit=false)
    # Security_font
    test = [
      {"displayed" => HomePage::MENU_USER_XPATH},
      {"click" => HomePage::MENU_USER_XPATH},
      {"displayed" => HomePage::MENU_USER_SETUP_OPTION_XPATH},
      {"click_and_load" => HomePage::MENU_USER_SETUP_OPTION_XPATH},
      {"displayed" => HomePage::DEVELOP_XPATH},
      {"click_and_load" => HomePage::DEVELOP_XPATH},
      {"displayed" => ".//*[@id='Security_font']"},
      {"click" => ".//*[@id='Security_font']"},
      {"displayed" => ".//*[@id='SecuritySharing_font']"},
      {"click" => ".//*[@id='SecuritySharing_font']"},
    ]
    if edit
      a = {"displayed" => ".//*[@name='edit']"}
      b = {"click" => ".//*[@name='edit']"}
      test << a
      test << b
    end
    Common.main(test)
  end
  
  
  def self.go_to_massmail_service(edit=false)
    # MassMail Service
    self.custom_settings
    
    test = [
      {"displayed" => ".//*[contains(@class,'dataCell')]/a[text()='MassMail Service']/ancestor::tr[1]/td[1]/a"},
      {"click" => ".//*[contains(@class,'dataCell')]/a[text()='MassMail Service']/ancestor::tr[1]/td[1]/a"},
    ]
    if edit
      a = {"displayed" => ".//a[@class='actionLink'][1]"}
      b = {"click" => ".//a[@class='actionLink'][1]"}
      test << a
      test << b
    end
    Common.main(test)
  end
end