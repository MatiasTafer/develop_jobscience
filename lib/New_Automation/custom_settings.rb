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
    
  def QuestionSetHandler(option)
    #HARD CORE DATA
    @QUESTION_SET_HANDLER_ALWAYS_TEXT = "Always"
    @QUESTION_SET_HANDLER_POPULATE_TEXT = "Populate"
    @QUESTION_SET_HANDLER_OMIT_TEXT = "Omit"
    
    if option != @QUESTION_SET_HANDLER_ALWAYS_TEXT && option != @QUESTION_SET_HANDLER_POPULATE_TEXT && option != @QUESTION_SET_HANDLER_OMIT_TEXT
      puts "Error, bad parameter"
    else
      $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
      $browser.find_element(:id => SetupEditPage::QUESTION_SET_HANDLER_TEXT_ID).send_keys option
      $browser.find_element(:xpath => SetupEditPage::CONFIG_SETUP_EDIT_SAVE_BTN_XPATH).click
    end    
   end
   
  def self.JobBoardLogin(enable)
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
   
end