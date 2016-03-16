require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'users.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/requisitions/requisitions_change_priority_page.rb'
require './New_Automation/pages/requisitions/requisitions_change_status_page.rb'
require './New_Automation/pages/requisitions/requisitions_close_job_page.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_mass_transfer_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'

class TestRequisition < TestBasic
  @@JobBoard01 = "/New_Automation/files/Job Orders/job_order_upload01.pdf"
  
=begin
#TC1059 - New Job Order #FIREFOX #CHROME
def test_newJobOrder
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
   test = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click_and_load" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"displayed" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"click_and_load" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITION_NAME},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH, "text" => RequisitionsNewAndEdit::DEPARTMENT_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MAX_SALARY_TEXT}, 
           {"click_and_load" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}] 
    Common.main(test)
    assert $wait.until {
      $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).displayed? 
    }      
end  
=end

=begin
#TC1060 - New Job Order, Validation #FIREFOX #CHROME
def test_newJobOrderValidation
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click_and_load" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click_and_load" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"click_and_load" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_REQUIRED_FIELDS_TEXT)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test2 = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click_and_load" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click_and_load" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITION_NAME},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH, "text" => RequisitionsNewAndEdit::DEPARTMENT_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MAX_SALARY_TEXT}, 
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DATE_POSTED_XPATH, "text" => RequisitionsNewAndEdit::DATE_WRONG_TEXT},  
           {"click_and_load" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}] 
  Common.main(test2)
  assert $wait.until {
  $browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_DATE_TEXT)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test3 = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click_and_load" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click_and_load" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITION_NAME},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH, "text" => RequisitionsNewAndEdit::DEPARTMENT_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_WRONG_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MAX_SALARY_WRONG_TEXT}, 
           {"click_and_load" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}]
  Common.main(test3)
  assert $wait.until {
  $browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_CURRENCY_TEXT)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test4 = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"click_and_load" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
           {"displayed" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH},
           {"set_text" => RequisitionsHomePage::NEW_RECORD_TYPE_DROPDOWN_XPATH, "text" => RequisitionsHomePage::RECORD_TYPE_REQUISITION_TEXT},
           {"click_and_load" => RequisitionsHomePage::CONTINUE_BUTTON_XPATH},
           {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_XPATH, "text" => RequisitionsNewAndEdit::REQUISITION_NAME},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH, "text" => RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH, "text" => RequisitionsNewAndEdit::LOCATION_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH, "text" => RequisitionsNewAndEdit::DEPARTMENT_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MIN_SALARY_TEXT},
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH, "text" => RequisitionsNewAndEdit::MAX_SALARY_TEXT}, 
           {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_NEW_OPENINGS_XPATH, "text" => RequisitionsNewAndEdit::OPENINGS_WRONG_TEXT},
           {"click_and_load" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}]
  Common.main(test4)
  assert $wait.until {
  $browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit:: ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_NUMBER_TEXT)
end
=end



=begin
#TC1061 - Transfer Jobs  #FIREFOX #CHROME
def test_transferJobs
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"checked" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_TRANSFER_JOBS_XPATH},
          {"click_and_load" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_TRANSFER_JOBS_XPATH},
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
#TC1062 - Transfer Jobs, Validation #FIREFOX
def test_transferJobVlaidation
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test = [{"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"checked" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_TRANSFER_JOBS_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_TRANSFER_JOBS_XPATH},
          {"displayed" => RequisitionMassTransfer::REQUISITIONS_MASS_TRANSFER_TRANSFER_TO_RECRUITER_XPATH },
          {"click" => RequisitionMassTransfer::REQUISITIONS_MASS_TRANSFER_BTN_TRANSFER_XPATH}]
  Common.main(test)
  assert $wait.until {
     $browser.find_element(:xpath, RequisitionMassTransfer::ERROR_RECRUITER_MUST_BE_SELECTED_XPATH).displayed?
  }
end
=end

=begin
#TC1064 - Change Priority #FIREFOX
def test_changePriority
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
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
=end

=begin
#TC1065 - Change Priority, Validation  #FIREFOX
def test_changePriorityValidation
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test = [{"displayed" =>RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_CHANGE_PRIORITY_JOBS_XPATH},
          {"displayed" => RequisitionsChangePriority::REQUISITIONS_CHANGE_PRIORITY_NEW_PRIORITY_XPATH},
          {"click" => RequisitionsChangePriority::REQUISITIONS_CHANGE_PRIORITY_BTN_UPDATE_PRIORITY_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, RequisitionsChangePriority::ERROR_PRIORITY_MUST_BE_SELECTED).displayed?
  }  
end
=end


#TC1067 - Change Status
def test_changeStatus
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test = [{"displayed" =>RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_CHANGE_STATUS_JOBS_XPATH},
          {"displayed" => RequisitionsChangeStatus::REQUISITIONS_CHANGE_STATUS_NEW_STATUS_XPATH},
          {"set_text" => RequisitionsChangeStatus::REQUISITIONS_CHANGE_STATUS_NEW_STATUS_XPATH, "text" => RequisitionsChangeStatus::REQUISITION_NEW_STATUS_TEXT},
          {"click" => RequisitionsChangeStatus::REQUISITIONS_CHANGE_STATUS_BTN_UPDATE_STATUS_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, RequisitionsChangeStatus::BACK_TO_LIST_BUTTON_SUCCESS_PAGE_XPATH).displayed?
  }  
end


=begin
#TC1068 - Change Status, Validation
def test_changeStatusValidation
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH
  test = [{"displayed" =>RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_CHANGE_STATUS_JOBS_XPATH},
          {"displayed" => RequisitionsChangeStatus::REQUISITIONS_CHANGE_STATUS_NEW_STATUS_XPATH},
          {"click" => RequisitionsChangeStatus::REQUISITIONS_CHANGE_STATUS_BTN_UPDATE_STATUS_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, RequisitionsChangeStatus::ERROR_STATUS_MUST_BE_SELECTED).displayed?
  }
end
=end

=begin
#TC1070 - Job Order / Close Job 
def test_closeJobOrder
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH
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
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH
  test2 = [{"displayed" =>RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH},
          {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_CLOSE_JOB_XPATH},
          {"click" =>  RequisitionsDetail::REQUISITIONS_DETAIL_BTN_CLOSE_JOB_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow) 
  $wait.until {
    $browser.find_element(:xpath, RequisitionsCloseJob::REQUISITIONS_CLOSE_JOB_CLOSED_REASON_XPATH).displayed?
  }
  $browser.find_element(:xpath, RequisitionsCloseJob::REQUISITIONS_CLOSE_JOB_CLOSED_REASON_XPATH).send_keys RequisitionsCloseJob::CLOSE_REASON_TEXT
  $browser.find_element(:xpath, RequisitionsCloseJob::REQUISITIONS_CLOSE_JOB_SUCCESS_BTN_XPATH).click
  $wait.until {
    $browser.find_element(:xpath, RequisitionsCloseJob::CONFIRM_DELETED_MESSAGE_XPATH).displayed?
  }
end  
 
  
#TC1071 - Job Order / Close Job, Validation
def test_closeJobOrderValidation
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH) 
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
  Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
  test2 = [{"displayed" =>RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH},
          {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH},
          {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_CLOSE_JOB_XPATH},
          {"click" =>  RequisitionsDetail::REQUISITIONS_DETAIL_BTN_CLOSE_JOB_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow) 
  $wait.until {
    $browser.find_element(:xpath, RequisitionsCloseJob::REQUISITIONS_CLOSE_JOB_CLOSED_REASON_XPATH).displayed?
  }
  $browser.find_element(:xpath, RequisitionsCloseJob::REQUISITIONS_CLOSE_JOB_SUCCESS_BTN_XPATH).click
  $wait.until {
    $browser.find_element(:xpath, RequisitionsCloseJob::ERROR_REQUIRED_FIELDS_XPATH).displayed?
  }
end  

#TC103 - Add Job Order from Uploading File
  def test_AddJobOrderFromUploading
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Go to HomePage
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
    
    # 1 - Click on "Job Order Tools" on sidebar sections
    test = [
      {"displayed" => HomePage::ADD_JOB_ORDERS_XPATH},
    # 2 - Click on "Add Job Order"  
      {"click" => HomePage::ADD_JOB_ORDERS_XPATH}
    ]
    Common.main(test)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@JobBoard01)
    
    test = [
      {"displayed" => HomePage::UPLOAD_BTN_BROWSE_XPATH},
      {"upload" => HomePage::UPLOAD_BTN_BROWSE_XPATH, "file" => file},
      {"click" => HomePage::UPLOAD_BTN_ADD_JOB_XPATH}
    ]
    Common.main(test)
    
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
    assert $wait.until{
      $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_NAME_XPATH).displayed?
    }
    
  end  
  
  
=end  
  
  
end  
  
  
  
  
  
  
  
  
  
  
  
