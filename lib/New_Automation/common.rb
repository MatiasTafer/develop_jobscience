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
        a = $browser.find_element(:xpath => field).displayed?
        puts a
        return a
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
    $wait.until{
      newWindow= $browser.window_handles.last
      $browser.switch_to.window(newWindow)
    }
  end
  
  def self.check_apply
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
  
  def self.take_url(field)
    $browser.find_element(:xpath => field).click
    $url = $browser.current_url
    puts $url
    return $url 
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
     $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
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
  
  def self.standart_question_set
     $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
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
  #newWindow= $browser.window_handles.last
  #$browser.switch_to.window(newWindow)
end