require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'

require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/job_board/job_board_login_page.rb'
require './New_Automation/pages/board_setup/board_setup_edit_page.rb'
require './New_Automation/pages/board_setup/board_setup_detail_page.rb'
require './New_Automation/pages/board_setup/board_setup_home_page.rb' 
require_relative 'users.rb'

class EeoQuestion < TestBasic
#TC835 - EEO Questions, hidden questions 
def   test_eeoQuestionHiddenQuestion
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
   test = [{"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
           {"click_and_load" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
           {"displayed" =>  BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
           {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
           {"displayed" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_VETERAN_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_REQUIRED_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_RACE_XPATH},
           {"unchecked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_DISABLED_XPATH},
           {"click_and_load" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH}]
   Common.main(test)
   assert $wait.until {
     $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
   } 
end

#TC836 - EEO Questions, displayed questions 
def   test_eeoQuestionDisplayedQuestion
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
   test = [{"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
           {"click_and_load" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
           {"displayed" =>  BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
           {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
           {"displayed" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_VETERAN_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_REQUIRED_XPATH}
           ]
   Common.main(test)
   begin
   sleep 3
   $browser.switch_to.alert.accept
   rescue
   end
   test2 = [{"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_RACE_XPATH},
           {"checked" => BoardSetupEditPage::BOARD_EDIT_EEO_QUESTION_CHECKBOX_DISABLED_XPATH},
           {"click_and_load" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH}]
   Common.main(test2)
   assert $wait.until {
     $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
   } 
end

#TC837 - EEO Commit Default 
def test_eeoCommitDefault
  #Preconditions
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   CustomSettings.JobBoardLogin(true)
   #$browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
   Common.go_to_custom_settings(true)
   test = [{"displayed" => SetupEditPage::COMMIT_EEO_DEFAULT_VALUE_CHECKBOX_XPATH},
           {"checked" => SetupEditPage::COMMIT_EEO_DEFAULT_VALUE_CHECKBOX_XPATH},
           {"click_and_load" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test)
   #Steps
   $browser.get HomePage::JOB_BOARD_URL
   test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
          {"click_and_load" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
          {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
          {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::USER_JOB_BOARD},
          {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::USER_PASSWORD_JOB_BOARD},
          {"click_and_load" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
          {"displayed" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
          {"click" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
          {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"click_and_load" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
          {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH}]
   Common.main(test2)       
   begin
     test3=[{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
     Common.main(test3)
     assert $wait.until {
       $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
       
     }
     $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click    
   rescue
     test3=[{"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
     Common.main(test3)
     assert $wait.until {
       $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
     }
     $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click  
   end
end

#TC838 - EEO Question Handler, Always 
def test_eeoQuestionHandlerAlways
   #Preconditions
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   Common.go_to_custom_settings
   CustomSettings.QuestionSetHandler("Always")
   CustomSettings.JobBoardLogin(true)
   #Steps
   $browser.get HomePage::JOB_BOARD_URL
   test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
          {"click_and_load" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
          {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
          {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::USER_JOB_BOARD},
          {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::USER_PASSWORD_JOB_BOARD},
          {"click_and_load" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
          {"displayed" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
          {"click" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
          {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"click_and_load" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
          {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH}]
   Common.main(test)      
   begin 
     test= [{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
     Common.main(test)
     assert $wait.until {
       $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
     }
     $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click  
   rescue
     test= [{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
            {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
            {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
     Common.main(test)
     assert $wait.until {
       $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
     }
     $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click
   end
end

#TC839 - EEO Question Handler, Populate 
def test_eeoQuestionHandlerPopulate
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.go_to_custom_settings
  CustomSettings.QuestionSetHandler("Populate")
  CustomSettings.JobBoardLogin(true)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
  test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click_and_load" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::USER_JOB_BOARD},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::USER_PASSWORD_JOB_BOARD},
         {"click_and_load" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"click" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click_and_load" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH}]
  Common.main(test)   
  begin   
    test2= [{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH}, 
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
    Common.main(test2)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click   
  rescue     
    test= [{"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
    Common.main(test)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click
  end
end

#TC840 - EEO Question Handler, Omit 
def test_eeoQuestionHandlerOmit
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.go_to_custom_settings
  CustomSettings.QuestionSetHandler("Omit")
  CustomSettings.JobBoardLogin(true)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
  test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click_and_load" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::USER_JOB_BOARD},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::USER_PASSWORD_JOB_BOARD},
         {"click_and_load" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"click" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click_and_load" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH}]
  Common.main(test)   
  begin   
    test2= [{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
    Common.main(test2)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click   
  rescue     
    test= [{"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
    Common.main(test)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click
  end
end

#TC841 - Standard and Custom EEO Disclaimers, standard & custom 
def test_eeoDisclaimersStandardCustom
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
  test = [{"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
          {"click_and_load" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
          {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
          {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
          {"displayed" => BoardSetupEditPage::BOARD_EDIT_EEO_TEXT_XPATH},
          {"set_text" => BoardSetupEditPage::BOARD_EDIT_EEO_TEXT_XPATH, "text" => "eeo text"},
          {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_STANDARD_EEO_DISCLAIMER},
          {"click_and_load" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH}]
  Common.main(test)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
  test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click_and_load" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::USER_JOB_BOARD},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::USER_PASSWORD_JOB_BOARD},
         {"click_and_load" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"click" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click_and_load" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH}]
   Common.main(test2)
  begin     
    test3=[{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
    Common.main(test3)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click 
  rescue
    test4 =[{"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
    Common.main(test4)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click 
  end
end

#TC842 - Standard and Custom EEO Disclaimers, Only custom 
def test_eeoDisclaimersOnlyCustom
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  CustomSettings.JobBoardLogin(true)
  Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
  test = [{"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
          {"click_and_load" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
          {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
          {"click_and_load" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
          {"displayed" => BoardSetupEditPage::BOARD_EDIT_EEO_TEXT_XPATH},
          {"set_text" => BoardSetupEditPage::BOARD_EDIT_EEO_TEXT_XPATH, "text" => "eeo text"},
          {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_STANDARD_EEO_DISCLAIMER},
          {"click_and_load" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH}]
  Common.main(test)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
  test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click_and_load" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::USER_JOB_BOARD},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::USER_PASSWORD_JOB_BOARD},
         {"click_and_load" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"click" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click_and_load" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
         {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH}]
  Common.main(test2)
  begin
    test3 =[{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
           {"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
    Common.main(test3)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click
  rescue
    test3 =[{"displayed" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
           {"click_and_load" => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH}]
    Common.main(test3)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER2_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH).click
  end
end

#TC131 - Apply To A Job With LinkedIn EEO Questions Enable 
def test_eeoApplyWithLinkedInEeoEnable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  CustomSettings.JobBoardLogin(true)
  Common.go_to_social_settings
  CustomSettings.ApplyToLinkedIn(true)
  $browser.get HomePage::JOB_BOARD_URL
  test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::USER_JOB_BOARD},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::USER_PASSWORD_JOB_BOARD},
         {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"click" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH}] 
  Common.main(test)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test2= [{"displayed" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH},
          {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH, "text" => Users::USER_LINKEDIN},
          {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_PASSWORD_XPATH, "text" => Users::PASSWORD_LINKEDIN},
          {"click" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_BTN_ALLOW_XPATH }]
  Common.main(test2)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)  
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_LINKEDIN_BTN_CLOSE_POPUP_XPATH).displayed?
  }  
end

#TC1224 - Apply To A Job With LinkedIn EEO Questions Disable 
def test_eeoApplyWithLinkedInEeoDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  CustomSettings.JobBoardLogin(true)
  Common.go_to_custom_settings
  CustomSettings.QuestionSetHandler("Always")
  Common.go_to_social_settings
  CustomSettings.ApplyToLinkedIn(true)
  $browser.get HomePage::JOB_BOARD_URL
  test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
         {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::USER_JOB_BOARD},
         {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::USER_PASSWORD_JOB_BOARD},
         {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
         {"displayed" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"click" => JobBoardHomePage::SEARCH_BUTTON_XPATH},
         {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
         {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH}] 
  Common.main(test)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test2= [{"displayed" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH},
          {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH, "text" => Users::USER_LINKEDIN},
          {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_PASSWORD_XPATH, "text" => Users::PASSWORD_LINKEDIN},
          {"click" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_BTN_ALLOW_XPATH }]
  Common.main(test2)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)  
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_LINKEDIN_BTN_CLOSE_POPUP_XPATH).displayed?
  }  
end

end