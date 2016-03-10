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


class Users
  
  USER_EMAIL = "naomi@joblabs.com"
  USER_EMAIL2 = "naomirecruiter@joblabs.com"
  USER_EMAIL3 = "naomimanager@joblabs.com"
  
  USER_AUTOMATION = "oktana@joblabs.com"
  PASSWORD_AUTOMATION = "Jobscience16"
  
  PASSWORD  = "muffin100"
  
  
  def self.create_user_job_board
    
    random_name = "auto_" + SecureRandom.hex(4)
    username = random_name + "@test.com"
    
    username = "testing5@fromthesky.up"
    
    begin
      Common.login(USER_EMAIL, PASSWORD)
    end
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
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
    #Common.login_job_board
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      # 6. Click on (at the right side) in "Register".
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      # 7. Fill the fields (required)
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => username},
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => PASSWORD},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => PASSWORD},
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
    #Common.main(test)
    
    begin
      f = File.open("users.txt", "r")
      f.each_line do |line|
        puts line
      end
      f.close
    rescue
      File.open("users.txt", "w") do |f|     
        f.write()   
      end
    end
    #out_file = File.new("users.txt", "w")
    #out_file.puts(random_name + "@test.com")
    #out_file.close
  end
  
end