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
  
  def self.EnableEnhancedApplyToJob(setBool)
    #SetBool=True will leave the checkbox checked, if SetBool=false will leave it unchecked
    
    $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::ENABLE_ENHANCED_APPLY_TO_JOB_XPATH).displayed?
      }
    if setBool
      unless $browser.find_element(:xpath => SetupEditPage::ENABLE_ENHANCED_APPLY_TO_JOB_XPATH).attribute("checked")
        $browser.find_element(:xpath => SetupEditPage::ENABLE_ENHANCED_APPLY_TO_JOB_XPATH).click
      end
    else
      if $browser.find_element(:xpath => SetupEditPage::ENABLE_ENHANCED_APPLY_TO_JOB_XPATH).attribute("checked")
        $browser.find_element(:xpath => SetupEditPage::ENABLE_ENHANCED_APPLY_TO_JOB_XPATH).click
      end  
    end
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    sleep(2)  
    
  end
  
  def self.DefineResumeAllowedTypes(types)
    #"types" must be a string with extensions separated with a comma, like "pdf, doc, txt"
    
    $browser.get(SetupEditPage::PARSE_SETTINGS_EDIT_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
      }  
    $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::ADD_RESUME_ALLOWED_FILETYPES_XPATH).displayed?
      } 
    $browser.find_element(:xpath => SetupEditPage::ADD_RESUME_ALLOWED_FILETYPES_XPATH).clear  
    $browser.find_element(:xpath => SetupEditPage::ADD_RESUME_ALLOWED_FILETYPES_XPATH).send_keys types
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click  
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
      }
  end
  
  def self.DefineResumeAllowedTypesJobBoard(types)
    #"types" must be a string with extensions separated with a comma, like "pdf, doc, txt"
    
    $browser.get(SetupEditPage::PARSE_SETTINGS_EDIT_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
      }  
    $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::JOB_BOARD_ALLOWED_FILETYPES_XPATH).displayed?
      } 
    $browser.find_element(:xpath => SetupEditPage::JOB_BOARD_ALLOWED_FILETYPES_XPATH).clear  
    $browser.find_element(:xpath => SetupEditPage::JOB_BOARD_ALLOWED_FILETYPES_XPATH).send_keys types
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click  
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
      }
  end
  
  def self.DefineEEOQuestions(gender, veteran, race, disabled, required)
    #If each parameter is true, will check the corresponding checkbox.
     
    $browser.get(SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::EEO_QUESTIONS_GENDER_CHECKBOX_XPATH).displayed?
    }
    Checkbox(SetupEditPage::EEO_QUESTIONS_GENDER_CHECKBOX_XPATH, gender)
    Checkbox(SetupEditPage::EEO_QUESTIONS_VETERAN_CHECKBOX_XPATH, veteran)
    Checkbox(SetupEditPage::EEO_QUESTIONS_RACE_CHECKBOX_XPATH, race)  
    Checkbox(SetupEditPage::EEO_QUESTIONS_DISABLE_CHECKBOX_XPATH, disabled) 
    Checkbox(SetupEditPage::EEO_QUESTIONS_REQUIRED_CHECKBOX_XPATH, required)  
    
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::EDIT_BUTTON_XPATH).displayed?
    }
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
    
   
end