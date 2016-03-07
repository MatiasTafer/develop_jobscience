require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/questions/question_sets_home_page.rb'
require './New_Automation/pages/questions/question_sets_new_page.rb'
require './New_Automation/pages/questions/question_set_detail_page.rb'
require './New_Automation/pages/setup_page.rb'

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
    sleep(1)
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
  
  def self.AllowDuplicateApplcation(allow, days = 0)
    
    #If "allow" it's true the checkbox will be checked, if it's false the checkbox will be unchecked
    #"days" will set "Allow Duplicate Application Days", default value is 0
    
    $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::ALLOW_DUPLICATE_APPS_CHECKBOX_XPATH).displayed?
    }
       
    Checkbox(SetupEditPage::ALLOW_DUPLICATE_APPS_CHECKBOX_XPATH, allow)
    
    $browser.find_element(:xpath => SetupEditPage::ALLOW_DUPLICATE_APPS_DAYS_INPUT_XPATH).clear
    $browser.find_element(:xpath => SetupEditPage::ALLOW_DUPLICATE_APPS_DAYS_INPUT_XPATH).send_keys days
    
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::NEW_CONFIG_BTN_XPATH).displayed?
    }
        
  end
  
  def self.MaxNumberOfAttachments(number)
  #number will define the number of attachements that a user can do, if it's =0 no attachment are allowed, 
  #the attachment screen will not be displayed
  
    $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::MAX_NUMB_ATTACHEMNT_INPUT_XPATH).displayed?
    }
    $browser.find_element(:xpath => SetupEditPage::MAX_NUMB_ATTACHEMNT_INPUT_XPATH).clear
    $browser.find_element(:xpath => SetupEditPage::MAX_NUMB_ATTACHEMNT_INPUT_XPATH).send_keys number
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::NEW_CONFIG_BTN_XPATH).displayed?
    }
    
  end
 
 def self.EnableJCardForContact(setBool)
   #If setBool is true "Enable JCard For Contact" will be checked, if setBool is false it will be unchecked
    
   $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
   $wait.until{
     $browser.find_element(:xpath => SetupEditPage::ENABLE_JCARD_FOR_CONTACT_XPATH).displayed?
   }
   
   Checkbox(SetupEditPage::ENABLE_JCARD_FOR_CONTACT_XPATH, setBool)
   
   $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::NEW_CONFIG_BTN_XPATH).displayed?
    }
 end 
 
 def self.ResumeRequired(setBool)
   #If setBool is true "Resume Required" will be checked, if setBool is false it will be unchecked
    
   $browser.get(SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL)
   $wait.until{
     $browser.find_element(:xpath => SetupEditPage::RESUME_REQUIRE_CHECKBOX_XPATH).displayed?
   }
   
   Checkbox(SetupEditPage::RESUME_REQUIRE_CHECKBOX_XPATH, setBool)
   
   $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::EDIT_BUTTON_XPATH).displayed?
    }
 end
 
 def self.AttachToApplications(setBool)
   #If setBool is true "Attach to Applications" will be checked, if setBool is false it will be unchecked
   
   $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
   $wait.until{
     $browser.find_element(:xpath => SetupEditPage::ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH).displayed?
   }
   
   Checkbox(SetupEditPage::ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH, setBool)
   
   $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::NEW_CONFIG_BTN_XPATH).displayed?
    }
    
 end
 
 def self.AutoShareMode(shareMode)
  #shareMode will define if the share mode is "Read" or "Read/Write", if it's empty the shared mode it's not processed 
  
    $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::AUTO_SHARE_MODE_XPATH).displayed?
    }
    $browser.find_element(:xpath => SetupEditPage::AUTO_SHARE_MODE_XPATH).clear
    $browser.find_element(:xpath => SetupEditPage::AUTO_SHARE_MODE_XPATH).send_keys shareMode
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::NEW_CONFIG_BTN_XPATH).displayed?
    }
    
  end 
  
  def self.EEOTextAndDisclaimer(text_eeo, setbool)
  
    $browser.get(SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::EEO_QUESTIONS_GENDER_CHECKBOX_XPATH).displayed?
    }
    Checkbox(SetupEditPage::HIDE_STANDARD_EEO_DISCLAIMER_CHECKBOX_XPATH, setbool)
    
    old_win = $browser.window_handle
    $browser.switch_to.frame(6)
    
    $browser.find_element(:xpath => SetupEditPage::EEO_TEXT_TEXTAREA_IFRAME_XPATH).clear
    $browser.find_element(:xpath => SetupEditPage::EEO_TEXT_TEXTAREA_IFRAME_XPATH).send_keys text_eeo
    
    $browser.switch_to.window(old_win)
    
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ".//*[@name='edit']").displayed?
    }
    
  end 
 
  def self.PrivacyPolicyTextAndDisplay(text_pol, setbool)
  
    $browser.get(SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::DISPLAY_PRIVACY_STATEMENT_XPATH).displayed?
    }
    sleep(3)
    Checkbox(SetupEditPage::DISPLAY_PRIVACY_STATEMENT_XPATH, setbool)
    sleep(1)
    old_win = $browser.window_handle
    $browser.switch_to.frame(6)
    
    $browser.find_element(:xpath => SetupEditPage::PRIVACY_POLICY_TEXTAREA_IFRAME_XPATH).clear
    $browser.find_element(:xpath => SetupEditPage::PRIVACY_POLICY_TEXTAREA_IFRAME_XPATH).send_keys text_pol
    
    $browser.switch_to.window(old_win)
    
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ".//*[@name='edit']").displayed?
    }
    
  end 
  
  def self.InviteToApplyCustomMessage(setbool)
    #If setBool is true "Invite to Apply Custom Message" will be checked, if setBool is false it will be unchecked 
  
    $browser.get(SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::INVITE_TO_APPLY_CUSTOM_MESSAGE_CHECKBOX_XPATH).displayed?
    }
    
    Checkbox(SetupEditPage::INVITE_TO_APPLY_CUSTOM_MESSAGE_CHECKBOX_XPATH, setbool)
    
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::NEW_CONFIG_BTN_XPATH).displayed?
    }
  end
  
  def self.AddResumeDupePrevention(option)
    
    $browser.get(SetupEditPage::PARSE_SETTINGS_EDIT_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::ADD_RESUME_DUPE_PREVENTION_XPATH).displayed?
    }
    
    $browser.find_element(:xpath => SetupEditPage::ADD_RESUME_DUPE_PREVENTION_XPATH).clear
    $browser.find_element(:xpath => SetupEditPage::ADD_RESUME_DUPE_PREVENTION_XPATH).send_keys option
    
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    
     $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
    }
    
  end
  
  def self.JobBoardDupePrevention(option)
    
    $browser.get(SetupEditPage::PARSE_SETTINGS_EDIT_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).displayed?
    }
    
    $browser.find_element(:xpath => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear
    $browser.find_element(:xpath => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).send_keys option
    
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    
     $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
    }
    
  end
  
  def self.DaxtraParseOverwrite(address=false, employment=false, education=false, skills=false)
    
    $browser.get(SetupEditPage::PARSE_SETTINGS_EDIT_URL)
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH).displayed?
    }
    Checkbox(SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH, address)
    Checkbox(SetupEditPage::OVERWRITE_EMPLOYMENT_CHECKBOX_XPATH, employment)
    Checkbox(SetupEditPage::OVERWRITE_EDUCATION_CHECKBOX_XPATH, education)
    Checkbox(SetupEditPage::INLCUDE_SKILLS_CHECKBOX_XPATH, skills)
    
    $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    
     $wait.until{
      $browser.find_element(:xpath => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH).displayed?
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