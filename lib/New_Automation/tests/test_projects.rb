require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'users.rb'
require './New_Automation/pages/projects/projects_detail_page.rb'
require './New_Automation/pages/projects/projects_home_page.rb'
require './New_Automation/pages/projects/projects_new_project_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/projects/project_edit_page.rb'


class TestProjects <TestBasic


  #TC963 - New Project Successfully Created 
  def test_projectSuccessCreated
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).click
    $wait.until {
      $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).displayed?
    }
    $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).send_keys ProjectsNewProject::PROJECT_NAME
    $browser.find_element(:xpath, ProjectsNewProject::PROJECTS_NEW_PROJECT_BTN_SAVE_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_CLONE).displayed?
    }
    assert_equal($browser.find_element(:id, ProjectDetail::PROJECT_NAME_TEXT_ID).text, ProjectsNewProject::PROJECT_NAME)  
  end



  #TC1151 - New Project Fields Validation with blank fields 
  def test_allFieldBlankVerification
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).click
    $wait.until {
      $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).displayed?
    }
    $browser.find_element(:xpath, ProjectsNewProject::PROJECTS_NEW_PROJECT_BTN_SAVE_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath, ProjectsNewProject::ERROR).displayed?
    }
    assert_equal($browser.find_element(:xpath, ProjectsNewProject::ERROR).text, ProjectsNewProject::REQUIRED_FIELD_ERROR)

  end
 

  #TC1152 - New Project Fields Validation with invalid currency 
  def test_invalidCurrencyValidation
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).click
    $wait.until {
      $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).displayed?
    }
    $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).send_keys ProjectsNewProject::PROJECT_NAME
    $browser.find_element(:xpath, ProjectsNewProject::PROJECTS_NEW_BUDGET_XPATH).send_keys ProjectsNewProject::CURRENCY_INVALID_VALUE
    $browser.find_element(:xpath, ProjectsNewProject::PROJECTS_NEW_PROJECT_BTN_SAVE_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath, ProjectsNewProject::ERROR).displayed?
    }
    assert_equal($browser.find_element(:xpath, ProjectsNewProject::ERROR).text, ProjectsNewProject::INVALID_CURRENCY_ERROR)
  end

  #TC1153 - New Project Fields Validation with a invalid date 
  def test_invalidDateValidation
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).click
    $wait.until {
      $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).displayed?
    }
    $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).send_keys ProjectsNewProject::PROJECT_NAME
    $browser.find_element(:xpath, ProjectsNewProject::PROJECTS_NEW_START_DATE_XPATH).send_keys ProjectsNewProject::DATE_INVALID_VALUE
    $browser.find_element(:xpath, ProjectsNewProject::PROJECTS_NEW_PROJECT_BTN_SAVE_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath, ProjectsNewProject::ERROR).displayed?
    }
    assert_equal($browser.find_element(:xpath, ProjectsNewProject::ERROR).text, ProjectsNewProject::INVALID_DATE_ERROR)
  end

  #TC965 - Project, New Job Order 
  def test_projectNewJobOrder
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_FIRST_ENTRY_LIST_LINK_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).displayed?
    }
    $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).click
    $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_RECORD_TYPE_ID).send_keys RequisitionsNewAndEdit::RECORD_TYPE_OF_NEW_RECORD_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys RequisitionsNewAndEdit::JOB_TITLE_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::LOCATION_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH).send_keys RequisitionsNewAndEdit::DEPARTMENT_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::MIN_SALARY_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::MAX_SALARY_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    $browser.switch_to.frame($browser.find_element(:xpath, RequisitionsDetail::LINK_TO_POSTING_IFRAME_XPATH))
    $wait.until {
      $browser.find_element(:xpath, RequisitionsDetail::SITE_URL_XPATH).displayed?
    }
    $browser.find_element(:xpath, RequisitionsDetail::SITE_URL_XPATH).click
    newWindow= $browser.window_handles[1]
    $browser.switch_to.window(newWindow)
    assert $wait.until {
      $browser.find_element(:xpath, RequisitionsDetail::FIRST_SEARCH_RESULT_LINK_XPATH).displayed?
    }
  end


  #TC966 - Project, New Job Order Required Field Validation 
  def test_projectRequiredValidation
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_FIRST_ENTRY_LIST_LINK_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).displayed?
    }
    $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).click
    $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_RECORD_TYPE_ID).send_keys RequisitionsNewAndEdit::RECORD_TYPE_OF_NEW_RECORD_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).displayed?
    }
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::ERROR_MESSAGE_FIELD_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit::ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_REQUIRED_FIELDS_TEXT)
  end

  #TC1157 - Project, New Job Order Validation invalid currency 
  def test_projectInvalidCurrency
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_FIRST_ENTRY_LIST_LINK_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).displayed?
    }
    $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).click
    $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_RECORD_TYPE_ID).send_keys RequisitionsNewAndEdit::RECORD_TYPE_OF_NEW_RECORD_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys RequisitionsNewAndEdit::JOB_TITLE_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::LOCATION_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH).send_keys RequisitionsNewAndEdit::DEPARTMENT_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::MIN_SALARY_WRONG_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::MAX_SALARY_WRONG_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::ERROR_MESSAGE_FIELD_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit::ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_CURRENCY_TEXT)
  end
 

  #TC1158 - Project, New Job Order Validation Invalid Number 
  def test_projectInvalidNumber
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_FIRST_ENTRY_LIST_LINK_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).displayed?
    }
    $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).click
    $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_RECORD_TYPE_ID).send_keys RequisitionsNewAndEdit::RECORD_TYPE_OF_NEW_RECORD_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys RequisitionsNewAndEdit::JOB_TITLE_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::LOCATION_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH).send_keys RequisitionsNewAndEdit::DEPARTMENT_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::MIN_SALARY_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::MAX_SALARY_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_OPENINGS_XPATH).send_keys RequisitionsNewAndEdit::OPENINGS_WRONG_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_PASSING_SCORE_XPATH).send_keys RequisitionsNewAndEdit::PASSING_SCORE_WRONG_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::ERROR_MESSAGE_FIELD_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit::ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_NUMBER_TEXT)
  end


  #TC1159 - Project, New Job Order Validation Invalid Percent 
  def test_projectInvalidPercent
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_FIRST_ENTRY_LIST_LINK_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).displayed?
    }
    $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_NEW_REQUISITION).click
    $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_RECORD_TYPE_ID).send_keys RequisitionsNewAndEdit::RECORD_TYPE_OF_NEW_RECORD_TEXT_2
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).displayed?
    }
    $browser.find_element(:id, RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys RequisitionsNewAndEdit::JOB_TITLE_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::LOCATION_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH).send_keys RequisitionsNewAndEdit::DEPARTMENT_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_JOBS_PROJECTS_FIELD_XPATH).send_keys RequisitionsNewAndEdit::JOB_PROJECTS_TEXT
    #Line 266 wont work because Client Field doesn't appear
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_CLIENT_FIELD_XPATH).send_keys RequisitionsNewAndEdit::CLIENT_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_CONTACT_FIELD_XPATH).send_keys RequisitionsNewAndEdit::CONTACT_TEXT
    #Line 269 wont work because Travel Field doesn't appear
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITION_TRAVEL_FIELD_XPATH).send_keys RequisitionsNewAndEdit::TRAVEL_WRONG_PERCENT_TEXT
    $browser.find_element(:xpath, RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath, RequisitionsNewAndEdit::ERROR_MESSAGE_FIELD_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath, RequisitionsNewAndEdit::ERROR_MESSAGE_FIELD_XPATH).text, RequisitionsNewAndEdit::ERROR_INVALID_PERCENT_TEXT) 
  end


  #TC967 - Clone Project 
  def test_cloneProject
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_FIRST_ENTRY_LIST_LINK_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_CLONE).displayed?
    }
    $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_CLONE).click
    assert $wait.until{
      $browser.find_element(:xpath, ProjectEdit::PROJECT_EDIT_TITLE_XPATH).displayed?
    }
  end


  #TC968 - Delete Project
  def test_deleteProject
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).click
    $wait.until {
      $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).displayed?
    }
    $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).send_keys ProjectsNewProject::PROJECT_NAME
    $browser.find_element(:xpath, ProjectsNewProject::PROJECTS_NEW_PROJECT_BTN_SAVE_XPATH).click
    Common.goToTab(HomePage::PROJECTS_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_FIRST_ENTRY_LIST_LINK_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_DELETE).displayed?
    }
    $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_DELETE).click
    $browser.switch_to.alert.accept
    assert $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    } 
  end

  
  
  
   
end