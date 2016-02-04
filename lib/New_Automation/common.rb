include Test::Unit::Assertions
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative './pages/login_page.rb'
require_relative './pages/home_page.rb'

class Common
  
  USER_EMAIL = "naomi@joblabs.com"
  PASSWORD  = "muffin99"
  
  
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

  #Selects the option from a Select element, by Text
  # selectElement: dropdown element
  def self.get_selected_option_text(dropdown)
    select = Selenium::WebDriver::Support::Select.new(dropdown)
    selected_optionText = select.selected_options[0].text
  end 
  
  
end