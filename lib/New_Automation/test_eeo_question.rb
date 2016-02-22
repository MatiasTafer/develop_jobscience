require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/home_page.rb'
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/job_board_login_page.rb'
require_relative './pages/board_setup_edit_page.rb'
require_relative './pages/board_setup_detail_page.rb'
require_relative './pages/board_setup_home_page.rb' 



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

  
  
end