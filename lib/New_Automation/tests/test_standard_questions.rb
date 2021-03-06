require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'users.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/standard_questions/standard_questions_page.rb'
require './New_Automation/pages/standard_questions/new_standard_question_page.rb'
require './New_Automation/pages/board_setup/board_setup_home_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/board_setup/board_setup_detail_page.rb'
require './New_Automation/pages/board_setup/board_setup_edit_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/job_board/job_board_register_page.rb'
require_relative 'custom_settings.rb'



class TestStandardQuestions < TestBasic

  # TC928 New Standard Question, Successfully created, Required By Applicant = true #FIREFOX OK
  def test_successfullyCreated
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    Common.goToTab(HomePage::STANDARD_QUESTIONS_TAB_XPATH)
    $wait.until {
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    Common.click_and_load(StandardQuestions::NEW_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_NAME_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    #$wait.until {
     # $browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH).displayed?
    #}
    #$browser.action.move_to($browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH)).perform
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_LAYOUT_OPTION_1 
    $browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH).send_keys NewStandardQuestion::CONTACT_FIELD_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_SIZE_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_SIZE_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $browser.find_element(:xpath, NewStandardQuestion::REQUIRED_BY_APPLICANT_CHECKBOX_XPATH).click
    Common.click_and_load(NewStandardQuestion::SAVE_BUTTON_XPATH)
    assert $wait.until {
     $browser.find_element(:xpath => StandardQuestions::FIRST_QUESTION_NAME_ITEM_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath => StandardQuestions::FIRST_QUESTION_NAME_ITEM_XPATH).text, NewStandardQuestion::QUESTION_NAME)
  end


  #TC929 - Validation of new standar question, Required By Applicant = true #FIREFOX OK
  def test_validationStandarQuestion
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    Common.goToTab(HomePage::STANDARD_QUESTIONS_TAB_XPATH)
    $wait.until {
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    Common.click_and_load(StandardQuestions::NEW_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_NAME_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_LAYOUT_OPTION_1 
    $browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH).send_keys NewStandardQuestion::CONTACT_FIELD_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_SIZE_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_SIZE_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $browser.find_element(:xpath, NewStandardQuestion::REQUIRED_BY_APPLICANT_CHECKBOX_XPATH).click
    Common.click_and_load(NewStandardQuestion::SAVE_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH).displayed?
    }
    Common.click_and_load(BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH)
    $wait.until {
      $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
    }
    Common.click_and_load(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH).displayed?
    }
    questionDrpdown = $browser.find_element(:xpath, BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH)
    Common.selectByIndex(questionDrpdown, 1)
    Common.click_and_load(BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
    }
    CustomSettings.JobBoardLogin(false)
    $browser.get HomePage::JOB_BOARD_URL
    $wait.until{
      $browser.current_url.eql?(HomePage::JOB_BOARD_URL)
    }
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH).displayed?
    }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
    }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).send_keys JobBoardRegisterPage::EMAIL_ADRESS_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_FIRST_NAME_XPATH).send_keys JobBoardRegisterPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_LAST_NAME_XPATH).send_keys JobBoardRegisterPage::LAST_NAME_TEXT
    begin
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH).send_keys JobBoardRegisterPage::QUESTION_TEXT   
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    begin
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    end
    
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).displayed?
    }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::ERRORS_OF_FIELD_TO_SUBMIT_XPATH).displayed?
    }
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    begin
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    end
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::ERRORS_OF_FIELD_TO_SUBMIT_XPATH).displayed?
    }
    end  
  end

  #TC930 - New Standard Question, Field Validation, Required By Applicant = true #FIREFOX OK
  def test_FieldValidationQuestionAplicantTrue
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    Common.goToTab(HomePage::STANDARD_QUESTIONS_TAB_XPATH)
    $wait.until {
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    Common.click_and_load(StandardQuestions::NEW_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::REQUIRED_BY_APPLICANT_CHECKBOX_XPATH).click
    $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::ERROR_MESSAGE_XPATH).displayed?
    }
  end

  #TC931 - New Standard Question, Successfully created, Required By Applicant = false #FIREFOX OK
  def test_NewStandaQuestionRequiredFalse
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    Common.goToTab(HomePage::STANDARD_QUESTIONS_TAB_XPATH)
    $wait.until {
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    Common.click_and_load(StandardQuestions::NEW_BUTTON_XPATH)
    $wait.until {
    $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_NAME_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_LAYOUT_OPTION_1 
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH)).perform
    $browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH).send_keys NewStandardQuestion::CONTACT_FIELD_OPTION_1
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::QUESTION_SIZE_DROPDOWN_XPATH)
    }
    $browser.action.move_to($browser.find_element(:xpath, NewStandardQuestion::QUESTION_SIZE_DROPDOWN_XPATH)).perform
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_SIZE_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_SIZE_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    Common.click_and_load(NewStandardQuestion::SAVE_BUTTON_XPATH)
    assert $wait.until {
      $browser.find_element(:xpath => StandardQuestions::FIRST_QUESTION_NAME_ITEM_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath => StandardQuestions::FIRST_QUESTION_NAME_ITEM_XPATH).text, NewStandardQuestion::QUESTION_NAME)
  end

  #TC932 - New Standard Question, Adding Standard Questions, Required By Applicant = false #FIREFOX OK
  def test_validationStandarQuestionFalseApplicant
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    Common.goToTab(HomePage::STANDARD_QUESTIONS_TAB_XPATH)
    $wait.until {
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    Common.click_and_load(StandardQuestions::NEW_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_NAME_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath, NewStandardQuestion::QUESTION_NAME_TEXT_FIELD_XPATH)).perform
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_LAYOUT_OPTION_1 
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH)).perform
    $browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH).send_keys NewStandardQuestion::CONTACT_FIELD_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_SIZE_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_SIZE_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    Common.click_and_load(NewStandardQuestion::SAVE_BUTTON_XPATH)
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    $wait.until {
      $browser.find_element(:xpath, BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH).displayed?
    }
    Common.click_and_load(BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH)
    $wait.until {
      $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
    }
    Common.click_and_load(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH).displayed?
    }
    questionDrpdown = $browser.find_element(:xpath, BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH)
    Common.selectByIndex(questionDrpdown, 1)
    Common.click_and_load(BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
    }
    CustomSettings.JobBoardLogin(false)
    $browser.get HomePage::JOB_BOARD_URL
    $wait.until{
      $browser.current_url.eql?(HomePage::JOB_BOARD_URL)
    }
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH).displayed?
    }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
    }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).send_keys JobBoardRegisterPage::EMAIL_ADRESS_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_FIRST_NAME_XPATH).send_keys JobBoardRegisterPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_LAST_NAME_XPATH).send_keys JobBoardRegisterPage::LAST_NAME_TEXT
    begin
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH).send_keys JobBoardRegisterPage::QUESTION_TEXT
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    begin
    $wait.until {
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displyed?
    }
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::ERRORS_OF_FIELD_TO_SUBMIT_XPATH).displayed?
    }
    end
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    begin
    $wait.until {
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displyed?
    }
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH)
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::ERRORS_OF_FIELD_TO_SUBMIT_XPATH).displayed?
    }
    end
  end
end

  #TC933 - New Standard Question, Field Validation, Required By Applicant = false 
  def test_FieldValidationQuestionAplicantFalse
    Common.login(Users::USER_EMAIL, Users::PASSWORD) 
    Common.goToTab(HomePage::STANDARD_QUESTIONS_TAB_XPATH)
    $wait.until {
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    Common.click_and_load(StandardQuestions::NEW_BUTTON_XPATH)
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::ERROR_MESSAGE_XPATH).displayed?
    } 
  end
  
  

  #TC934 - Standard Question Handler, Standard Question Handler = Always
  def test_StandardQuestionHandlerAlways
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.go_to_custom_settings
    CustomSettings.QuestionSetHandler("Always")
    CustomSettings.JobBoardLogin(false)
    $browser.get HomePage::JOB_BOARD_URL
    $wait.until{
      $browser.current_url.eql?(HomePage::JOB_BOARD_URL)
    }
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH).displayed?
    }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
    }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).send_keys JobBoardRegisterPage::EMAIL_ADRESS_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_FIRST_NAME_XPATH).send_keys JobBoardRegisterPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_LAST_NAME_XPATH).send_keys JobBoardRegisterPage::LAST_NAME_TEXT
    begin
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH).send_keys JobBoardRegisterPage::QUESTION_TEX 
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    begin
    assert $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    rescue
      assert $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).displayed?
    }
    end
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load( JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    begin
    assert $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    rescue
      assert $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).displayed?
    }
    end
    end
  end
  
 #TC935 - Standard Question Handler, Standard Question Handler = Populate
  def test_StandardQuestionHandlerPopulate
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.go_to_custom_settings
    CustomSettings.QuestionSetHandler("Populate")
    CustomSettings.JobBoardLogin(false)
    $browser.get HomePage::JOB_BOARD_URL
    $wait.until{
      $browser.current_url.eql?(HomePage::JOB_BOARD_URL)
    }
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH).displayed?
    }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
    }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).send_keys JobBoardRegisterPage::EMAIL_ADRESS_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_FIRST_NAME_XPATH).send_keys JobBoardRegisterPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_LAST_NAME_XPATH).send_keys JobBoardRegisterPage::LAST_NAME_TEXT
    begin
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH).send_keys JobBoardRegisterPage::QUESTION_TEXT
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    begin
    assert $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    rescue
      assert $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).displayed?
    }
    end
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    begin
    assert $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    rescue
      assert $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).displayed?
    }
    end
    end
  end

  #TC936 - Standard Question Handler, Standard Question Handler = Omit
  def test_StandardQuestionHandlerOmit
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.go_to_custom_settings
    CustomSettings.QuestionSetHandler("Omit")
    CustomSettings.JobBoardLogin(false)
    $browser.get HomePage::JOB_BOARD_URL
    $wait.until{
      $browser.current_url.eql?(HomePage::JOB_BOARD_URL)
    }
    $wait.until{
      $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardHomePage::SEARCH_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH).displayed?
    }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
    }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).displayed?
    }
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH).send_keys JobBoardRegisterPage::EMAIL_ADRESS_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_FIRST_NAME_XPATH).send_keys JobBoardRegisterPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_LAST_NAME_XPATH).send_keys JobBoardRegisterPage::LAST_NAME_TEXT
    begin
    $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH).send_keys JobBoardRegisterPage::QUESTION_TEXT
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    begin
    assert $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    rescue
      assert $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).displayed?
    }
    end
    rescue
    $browser.action.move_to($browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)).perform
    Common.click_and_load(JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH)
    begin
    assert $wait.until{
      $browser.find_element(:xpath, JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_TWO_XPATH).displayed?
    }
    rescue
      assert $wait.until{
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).displayed?
    }
    end
    end
  end
end