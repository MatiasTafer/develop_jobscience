require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'

require_relative './pages/home_page.rb'
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/job_board_login_page.rb'
require_relative './pages/board_setup_edit_page.rb'
require_relative './pages/board_setup_detail_page.rb'
require_relative './pages/board_setup_home_page.rb' 

$EMAIL =  "testrodrigo@gmail.com"
$PASSWOR = "password123"

class EeoQuestion < TestBasic
=begin  
#TC835 - EEO Questions, hidden questions
def   test_eeoQuestionHiddenQuestion
   Common.login(Common::USER_EMAIL, Common::PASSWORD)
   $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
   test = [{"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
           {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
           {"displayed" =>  BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
           {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
           {"displayed" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_VETERAN_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_REQUIRED_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_RACE_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_DISABLED_XPATH},
           {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH}]
   Common.main(test)
   assert $wait.until {
     $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
   } 
end
=end

=begin
#TC836 - EEO Questions, displayed questions
def   test_eeoQuestionHiddenQuestion
   Common.login(Common::USER_EMAIL, Common::PASSWORD)
   $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
   test = [{"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
           {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
           {"displayed" =>  BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
           {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
           {"displayed" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_VETERAN_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_REQUIRED_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_RACE_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_DISABLED_XPATH},
           {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH}]
   Common.main(test)
   assert $wait.until {
     $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
   } 
end
=end

=begin
#TC837 - EEO Commit Default
def test_eeoCommitDefault
  #Preconditions
   Common.login(Common::USER_EMAIL, Common::PASSWORD)
   CustomSettings.JobBoardLogin(true)
   $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
   test = [{"displayed" => SetupEditPage::COMMIT_EEO_DEFAULT_VALUE_CHECKBOX_XPATH},
           {"checked" => SetupEditPage::COMMIT_EEO_DEFAULT_VALUE_CHECKBOX_XPATH},
           {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test)
   #Steps
   $browser.get HomePage::JOB_BOARD_URL
   test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
          {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
          {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
          {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
          {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
          {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
          {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
          {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
          {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
   Common.main(test2)
   assert $wait.until {
     $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
   }
   $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click    
end
=end

=begin
#TC838 - EEO Question Handler, Always
def test_eeoQuestionHandlerAlways
   #Preconditions
   Common.login(Common::USER_EMAIL, Common::PASSWORD)
   CustomSettings.QuestionSetHandler("Always")
   CustomSettings.JobBoardLogin(true)
   #Steps
   $browser.get HomePage::JOB_BOARD_URL
   test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
          {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
          {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
          {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
          {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
          {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
          {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
          {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
          {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
   Common.main(test)
   assert $wait.until {
     $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
   }
   $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click  
end
=end
=begin
#TC839 - EEO Question Handler, Populate
def test_eeoQuestionHandlerPopulate
  #Preconditions
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  CustomSettings.QuestionSetHandler("Populate")
  CustomSettings.JobBoardLogin(true)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
  test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
         {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
  }
  $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click   
end
=end
=begin
#TC840 - EEO Question Handler, Omit
def test_eeoQuestionHandlerOmit
  #Preconditions
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  CustomSettings.QuestionSetHandler("Omit")
  CustomSettings.JobBoardLogin(true)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
  test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
         {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
  }
  $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click 
end
=end

#TC841 - Standard and Custom EEO Disclaimers, standard & custom
def test_eeoDisclaimersStandardCustom
  #Preconditions
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
  test = [{"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
          {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
          {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
          {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
          {"displayed" => BoardSetupEditPage::BOARD_EDIT_EEO_TEXT_XPATH},
          {"set_text" => BoardSetupEditPage::BOARD_EDIT_EEO_TEXT_XPATH, "text" => "eeo text"},
          {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_STANDARD_EEO_DISCLAIMER},
          {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH}]
  Common.main(test)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
  test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
         {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
  }
  $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click 
end
  
end