require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/home_page.rb'
require_relative './pages/requisitions_change_priority_page.rb'
require_relative './pages/requisitions_change_status_page.rb'
require_relative './pages/requisitions_close_job_page.rb'
require_relative './pages/requisitions_detail_page.rb'
require_relative './pages/requisitions_home_page.rb'
require_relative './pages/requisitions_mass_transfer_page.rb'
require_relative './pages/requisitions_new_and_edit.rb'

class TestRequisition < TestBasic
=begin  
#TC1059 - New Job Order 
def test_newJobOrder
   Common.login(Common::USER_EMAIL, Common::PASSWORD)
   $browser.get HomePage::REQUISITION_TAB_LINK_URL
   test = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITION_NAME},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH, "text" => RequisitionsNewAndEdit::DEPARTMENT_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MAX_SALARY_TEXT}, 
           {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}] 
    Common.main(test)
    assert $wait.until {
      $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).displayed? 
    }      
end  
=end

=begin
#TC1060 - New Job Order, Validation
def test_newJobOrderValidation
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::REQUISITION_TAB_LINK_URL
  test = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_REQUIRED_FIELDS_TEXT)
  $browser.get HomePage::REQUISITION_TAB_LINK_URL
  test2 = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITION_NAME},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH, "text" => RequisitionsNewAndEdit::DEPARTMENT_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MAX_SALARY_TEXT}, 
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATE_POSTED_XPATH, "text" => RequisitionsNewAndEdit::DATE_WRONG_TEXT},  
           {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}] 
  Common.main(test2)
  assert $wait.until {
  $browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_DATE_TEXT)
  $browser.get HomePage::REQUISITION_TAB_LINK_URL
  test3 = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITION_NAME},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH, "text" => RequisitionsNewAndEdit::DEPARTMENT_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_WRONG_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MAX_SALARY_WRONG_TEXT}, 
           {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}]
  Common.main(test3)
  assert $wait.until {
  $browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_CURRENCY_TEXT)
  $browser.get HomePage::REQUISITION_TAB_LINK_URL
  test4 = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITION_NAME},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH, "text" => RequisitionsNewAndEdit::DEPARTMENT_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MAX_SALARY_TEXT}, 
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_OPENINGS_XPATH, "text" => RequisitionsNewAndEdit::OPENINGS_WRONG_TEXT},
           {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}]
  Common.main(test4)
  assert $wait.until {
  $browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_NUMBER_TEXT)
end
=end
=begin
#TC1061 - Transfer Jobs  
def test_transferJobs
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::REQUISITION_TAB_LINK_URL
  test = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_TRANSFER_JOBS_XPATH},
          {"displayed" => RequisitionMassTransfer::REQUISITIONS_MASS_TRANSFER_TRANSFER_TO_RECRUITER_XPATH },
          {"set_text" => RequisitionMassTransfer::REQUISITIONS_MASS_TRANSFER_TRANSFER_TO_RECRUITER_XPATH, "text" => RequisitionMassTransfer::RECRUITER_TO_TRANSFER_TEXT},
          {"click" => RequisitionMassTransfer::REQUISITIONS_MASS_TRANSFER_BTN_TRANSFER_XPATH}]
  Common.main(test)
  assert $wait.until {
     $browser.find_element(:xpath, RequisitionMassTransfer::BACK_TO_LIST_BUTTON_ON_SUCCSESS_PAGE).displayed?
  }
end  
=end  

=begin
#TC1062 - Transfer Jobs, Validation
def test_transferJobVlaidation
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::REQUISITION_TAB_LINK_URL
  test = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_TRANSFER_JOBS_XPATH},
          {"displayed" => RequisitionMassTransfer::REQUISITIONS_MASS_TRANSFER_TRANSFER_TO_RECRUITER_XPATH },
          {"click" => RequisitionMassTransfer::REQUISITIONS_MASS_TRANSFER_BTN_TRANSFER_XPATH}]
  Common.main(test)
  assert $wait.until {
     $browser.find_element(:xpath, RequisitionMassTransfer::ERROR_RECRUITER_MUST_BE_SELECTED_XPATH).displayed?
  }
end
=end
  
#TC1064 - Change Priority
def test_changePriority
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::REQUISITION_TAB_LINK_URL
  test = [{"displayed" =>RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_CHANGE_PRIORITY_JOBS_XPATH},
          {"displayed" => RequisitionsChangePriority::REQUISITIONS_CHANGE_PRIORITY_NEW_PRIORITY_XPATH},
          {"set_text" => RequisitionsChangePriority::REQUISITIONS_CHANGE_PRIORITY_NEW_PRIORITY_XPATH, "text" => RequisitionsChangePriority::NEW_PRIORITY_TEXT},
          {"click" => RequisitionsChangePriority::REQUISITIONS_CHANGE_PRIORITY_BTN_UPDATE_PRIORITY_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, RequisitionsChangePriority::BACK_TO_LIST_BUTTON_ON_SUCCESS_PAGE_XPATH).displayed?
  } 
end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end