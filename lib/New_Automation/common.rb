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
   $wait.until{
      $browser.find_element(:id, LoginPage::LOGIN_BUTTON_ID).displayed?
   }
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
    end
    
    return true
  end


  
end