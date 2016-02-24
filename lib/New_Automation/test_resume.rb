require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'


require_relative './pages/home_page.rb'
require_relative './pages/requisitions_home_page.rb'
require_relative './pages/requisitions_detail_page.rb' 
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/job_board_login_page.rb'
require_relative './pages/job_board_register_page.rb'  




$EMAIL =  "testrodrigo@gmail.com"
$PASSWOR = "password123"

class TestResume < TestBasic
  
#TC979 - Job Board Resume, Attach Only  
def test_jobBoardResumeAttachOnly
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [{"displyed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
    Common.main(test)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }          
end 

=begin  
#TC978 - Job Board Register and upload Resume  
 def test_jobBoardUploadResume
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get HomePage::JOB_BOARD_URL
    test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
 end 
=end  
  
#TC980 - Job Board Resume, Parse Fields 
def test_jobBoardResumeParseFields
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [{"displyed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
    Common.main(test)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }  
end 
  
  
end