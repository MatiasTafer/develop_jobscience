require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/question_sets_home_page.rb'
require_relative './pages/question_sets_new_page.rb'
require_relative './pages/question_set_detail_page.rb'
require_relative './pages/setup_page.rb'

class CustomSettings
    
  def self.QuestionSetHandler(option)
    #HARD CORE DATA
    always = "Always"
    populate = "Populate"
    omit = "Omit"
    
    if option != always && option != populate && option != omit
      puts "Error, bad parameter"
    else
      $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
      $browser.find_element(:id => SetupEditPage::QUESTION_SET_HANDLER_TEXT_ID).clear
      $browser.find_element(:id => SetupEditPage::QUESTION_SET_HANDLER_TEXT_ID).send_keys option
      $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    end    
   end
   
  def self.JobBoardLogin(enable)
    #If enable=true login is needed
    $browser.get(SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH).displayed?
      }
    if enable
      $browser.find_element(:xpath => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH).send_keys "Customer Portal: Jobseeker Portal"
    else
      $browser.find_element(:xpath => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH).send_keys "- None -"
    end
    $browser.find_element(:xpath => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH).click
  end
  
  def self.BoardSetupInit
    
    $browser.get(SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::AUTO_ASSOCIATE_CHECKBOX_XPATH).displayed?
      }
    unless $browser.find_element(:xpath => SetupEditPage::AUTO_ASSOCIATE_CHECKBOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => SetupEditPage::AUTO_ASSOCIATE_CHECKBOX_XPATH).click
    end
    $browser.find_element(:xpath => SetupEditPage::STANDARD_QUESTION_1_OPTION_1_XPATH).click
    $browser.find_element(:xpath => SetupEditPage::STANDARD_QUESTION_2_OPTION_1_XPATH).click
    $browser.find_element(:xpath => SetupEditPage::STANDARD_QUESTION_3_OPTION_1_XPATH).click
    
    if $browser.find_element(:xpath => SetupEditPage::SHOW_SEARCH_ONLY_CHECKBOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => SetupEditPage::SHOW_SEARCH_ONLY_CHECKBOX_XPATH).click
    end
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    
  end
    
   
end