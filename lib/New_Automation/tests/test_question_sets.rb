require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require_relative 'users.rb'
require './New_Automation/tests/common.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/board_setup/board_setup_home_page.rb'
require './New_Automation/pages/board_setup/board_setup_detail_page.rb'
require './New_Automation/pages/board_setup/board_setup_edit_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'

require './New_Automation/pages/questions/question_sets_home_page.rb'
require './New_Automation/pages/questions/question_sets_new_page.rb'
require './New_Automation/pages/questions/question_set_detail_page.rb'
require './New_Automation/pages/questions/question_sets_question_builder_page.rb'
require './New_Automation/pages/questions/question_sets_new_question_page.rb'
require './New_Automation/pages/questions/question_detail_page.rb'
require './New_Automation/pages/answers/answer_edit_page.rb'
require './New_Automation/pages/answers/answer_detail_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'

require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'
require './New_Automation/pages/applications/applications_home_page.rb'
require './New_Automation/pages/offers/offers_home_page.rb'


require './New_Automation/tests/custom_settings.rb'

class TestQuestionSets < TestBasic
 
  #TC819 - New Question Set Successfully Created
  def test_NewQuestionSet
    randomName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
      
   
    # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    
    test = [
      {"displayed" =>  QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH},
    # 2 - Click on New button  
      {"click_and_load" => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH},
      {"displayed" =>  QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH}
    ]
    Common.main(test)
   
    # 3 - FIll all the fields
    $wait.until{
      $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).displayed?
      }
    $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).send_keys randomName
    
    # 4 - Click on "Save" button
    $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).click
    
    #RESULTS   
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_COPY_QUESTION_SET_XPATH).displayed?
      }
    
    assert_equal($browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NAME_XPATH).text, randomName)  
    
  end


  #TC820 - New Question Set Field Validation
  def test_NewQuestionSetsErrors
    randomName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    test = [
      {"displayed" =>  QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH},
    # 2 - Click on New button  
      {"click_and_load" => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH},
      {"displayed" =>  QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH},
    # 4 - Click on "Save" button  
      {"click_and_load" => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH},
    ]
    Common.main(test)
        
    #RESULT
    assert $wait.until{
      $browser.find_element(:xpath => QuestionSetsNew::ERROR_NAME_QUESTION_SETS_NEW_XPATH).displayed?
      $browser.find_element(:xpath => QuestionSetsNew::ERROR_NAME_QUESTION_SETS_NEW_XPATH).text == QuestionSetsNew::ERROR_NAME_QUESTION_SETS_NEW_TEXT
    }
    
    # 5 - Fill all the required fields
    $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).send_keys randomName
    
    # 6 - Enter invalid value into number fields ("Passing Score").
    $browser.find_element(:xpath => QuestionSetsNew::QUESTIONS_SETS_NEW_PASSING_SCORE_XPATH).send_keys QuestionSetsNew::QUESTION_SETS_PASSING_SCORE_INVALID_TEXT
    
    # 7 - Click on "Save" button
    $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNew::ERROR_NUMBER_QUESTION_SETS_NEW_XPATH).displayed?
      }
      
    #RESULT
    assert_equal($browser.find_element(:xpath => QuestionSetsNew::ERROR_NUMBER_QUESTION_SETS_NEW_XPATH).text, QuestionSetsNew::ERROR_NUMBER_QUESTION_SETS_NEW_TEXT)  
    
  end
 

  #TC821 - Question Set Handler = Always
  def test_QuestionSetHandlerAlways
    randomName = SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    randomReq2 = "0" + SecureRandom.hex(4)
    
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Must be set on "Custom Settings", Question Set Handler = Always.
    Common.go_to_custom_settings()
    CustomSettings.QuestionSetHandler("Always")
    
    #Create an empty Question Sets
    Common.CreateQuestionSetEmpty(randomName)
     
     # Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    
    test = [
      {"displayed" =>  QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH},
      {"click_and_load" => QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]"},
      {"displayed" =>  QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH},
    ]
    Common.main(test)  
    
    # Click on "New Question"  
    test = [
      {"click_and_load" => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH},
      {"displayed" =>  QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH}
    ]
    Common.main(test)
    
    # Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    elementText = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_TEXT_XPATH)
    if elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    test = [
    # Click on "Save"  
      {"click_and_load" =>  QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH},
      {"displayed" =>  QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH},
    ]
    Common.main(test)
    
    #Add Answers
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).displayed?
      }
    test = [ 
      {"click_and_load" =>  QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH},
      {"displayed" =>  AnswerEditPage::ANSWER_EDIT_NAME_XPATH},
      {"displayed" =>  AnswerEditPage::ANSWER_EDIT_SCORE_XPATH},
    ]
    Common.main(test)  
   
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_1_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_1_INT
    test = [ 
      {"click_and_load" =>  AnswerEditPage::ANSWER_EDIT_BTN_SAVE_NEW_XPATH},
    ]
    Common.main(test)  
    sleep(1)
    $wait.until{
      $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).displayed?
      }
    $wait.until{
      $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).displayed?
      } 
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_2_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_2_INT
    test = [ 
      {"click_and_load" =>  AnswerEditPage::ANSWER_EDIT_BTN_SAVE_NEW_XPATH},
    ]
    Common.main(test)
    
    # Create Job with Question Set asociated
    
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    test = [ 
      {"displayed" =>  RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
      {"click_and_load" =>  RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
      {"displayed" =>  RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH},
      {"click_and_load" =>  RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH},
      {"displayed" =>  RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    test = [ 
      {"click_and_load" =>  RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}
    ]
    Common.main(test)
    
    
    # Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    test = [ 
      {"displayed" =>  RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
      {"click_and_load" =>  RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
      {"displayed" =>  RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH},
      {"click_and_load" =>  RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH},
      {"displayed" =>  RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq2
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    test = [ 
      {"click_and_load" =>  RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH}
    ]
    Common.main(test)
    
    #JobBoard without login
    CustomSettings.JobBoardLogin(false)
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.ResumeRequired(false)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    # 1 - Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    # 2 - Apply to a job from the job board site, with Question Set asociated.
    test = [ 
      {"displayed" =>  JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH},
      {"click_and_load" =>  JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]"},
      {"displayed" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    test = [
      {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
    ] 
    Common.main(test)  
    
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      test = [
        {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH}
      ] 
      Common.main(test) 
    end
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      test = [
        {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH}
      ] 
      Common.main(test) 
    end
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH).displayed?
      }
    # 3 - Complete the fields from the question set
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select").send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    
    test = [
    # 4 - Click on Submit  
      {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH},
      {"displayed" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
    # 5 - Click on "Return to Job Search"  
      {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"displayed" =>  JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH},
    ]
    Common.main(test)
    
    # 6 - Apply to another job
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq2 + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    test = [
      {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH}
    ] 
    Common.main(test) 
    
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    
    test = [
      {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH}
    ] 
    Common.main(test)    
    
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      test = [
        {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH}
      ] 
      Common.main(test) 
    end
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      test = [
        {"click_and_load" =>  JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH}
      ] 
      Common.main(test) 
    end
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH).displayed?
      }
    
    # RESULT 
    # The Questions page would propose to complete each question from the question set.
    assert $wait.until{
        $browser.find_element(:xpath =>JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select/option[1]").selected?
      }

  end
  
  #TC822 - Question Set Handler = Populate
  def test_QuestionSetHandlerPopulate
    randomName = SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    randomReq2 = "0" + SecureRandom.hex(4)
    
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Must be set on "Custom Settings", Question Set Handler = Populate.
    Common.go_to_custom_settings()
    CustomSettings.QuestionSetHandler("Populate")
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
     # Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?  
      }
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    elementText = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_TEXT_XPATH)
    if elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # Click on "Save"
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH).click
    
    #Add Answers
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).displayed?
      }
    $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH).displayed?
      }
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_1_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_1_INT
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_NEW_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH).displayed?
      }
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_2_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_2_INT
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH)
    
    # Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
      }
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH)
        
    # Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH)   
    
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq2
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH)
    
    #JobBoard without login
    CustomSettings.JobBoardLogin(false)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.ResumeRequired(false)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    # 1 - Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    # 2 - Apply to a job from the job board site, with Question Set asociated.
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)   
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH).displayed?
      }
    # 3 - Complete the fields from the question set
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select").send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    
    # 4 - Click on Submit
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH)
        
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
      
    # 5 - Click on "Return to Job Search"
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    # 6 - Apply to another job
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq2 + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)     
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
     Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH) 
    end
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH) 
    end
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH).displayed?
      }
    
    # RESULT 
    # The Questions page would populate previously answered questions from the question set.
    assert $wait.until{
        $browser.find_element(:xpath =>JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select/option[2]").selected?
      }
 
  end

 #TC823 - Question Set Handler = Omit
  def test_QuestionSetHandlerOmit
    randomName = SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    randomReq2 = "0" + SecureRandom.hex(4)
    
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Must be set on "Custom Settings", Question Set Handler = Omit.
    Common.go_to_custom_settings()
    CustomSettings.QuestionSetHandler("Omit")
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
     # Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?  
      }
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    elementText = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_TEXT_XPATH)
    if elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
        
    #Add Answers
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).displayed?
      }
    Common.click_and_load(QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH).displayed?
      }
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_1_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_1_INT
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_NEW_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH).displayed?
      }
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_2_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_2_INT
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH)
    
    # Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH)
    
    # Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq2
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH)
    
    #JobBoard without login
    CustomSettings.JobBoardLogin(false)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.ResumeRequired(false)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    # 1 - Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    # 2 - Apply to a job from the job board site, with Question Set asociated.
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH).displayed?
      }
    # 3 - Complete the fields from the question set
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select").send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    
    # 4 - Click on Submit
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH)
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
      
    # 5 - Click on "Return to Job Search"
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    # 6 - Apply to another job
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq2 + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    
    # RESULT 
    # The Questions page would hide each previously answered question from the question set.
    
    assert $wait.until{
            $browser.find_element(:xpath => JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
          }
  end 

  #TC824 - Copy Question Set
  def test_CopyQuestionSet
    randomName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
    # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    # 2 - Click on the Question Set's name previously created from the list
     $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?  
      }
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_COPY_QUESTION_SET_XPATH).displayed?  
      }
    url = $browser.current_url
    # 3 - Click on "Copy Question Set"
    Common.click(QuestionSetsDetail::QUESTION_SETS_DETAIL_COPY_QUESTION_SET_XPATH)
    sleep(1)
    $browser.switch_to.alert.accept
    
    # 4 - Confirm copying of Question Set
    #$wait.until{
    #  $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?
    #}
    $wait.until{
      $browser.current_url != url
    }
    assert_match "Copy - " + randomName, $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NAME_XPATH).text
    
  end


  #TC825 - Question Set Builder 
  def test_QuestionSetBuilder
    randomName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
    # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    # 2 - Click on the Question Set's name previously created from the list
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?  
      }
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).displayed?  
      }
    
    # 3 - Click on "Question Builder"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).displayed?
    }
    
    # 4 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    sleep(2)
    
    # 5 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_TEXT
    
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT
    $browser.switch_to.default_content
    
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_1_TEXT
    
    # 6 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    sleep(2)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH).displayed?
    }
    # 7 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    sleep(1)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 8 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_2_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_2_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_2_TEXT
    
    # 9 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_SECOND_XPATH).displayed?
    }
    # 10 - Drag and drop question to the new position
    element = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_SECOND_XPATH)
    target = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH)

    $browser.action.drag_and_drop(element, target).perform
    
    # 11 - Click on "Save New Order"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_ORDER_XPATH).click
    
    #RESULT
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?  
      }
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).displayed?  
      }
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).displayed?
    }
    assert_equal($browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_1_NAME_LABEL_XPATH).text, "Q: " + QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_2_TEXT)
    
  end


  #TC826 - Question Set Builder, Optional and Text 
  def test_QuestionSetBuilderOptionalText
    randomName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
   #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
    # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    # 2 - Click on the Question Set's name previously created from the list
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?  
      }
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 3 - Click on "Question Builder"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).displayed?
    }
    
    # 4 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    sleep(3)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 5 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_1_TEXT
    
    #6 - Uncheck "Optional" and "Text" boxes
    elementText = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH)
    if elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 7 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    sleep(1)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH).displayed?
    }
    
    # 8 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    sleep(3)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 9 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_2_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_2_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_2_TEXT
    
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    # 10 - Check "Optional" box
    unless elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 11 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_SECOND_XPATH).displayed?
    }
    
    # 12 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    sleep(3)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 13 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_4_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_4_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_4_TEXT
    
    # 14 - Check "Text" box
    elementText = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH)
    unless elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    unless elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 15 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_THIRD_XPATH).displayed?
    }
    
    # 16 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    sleep(2)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 17 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_3_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_3_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_3_TEXT
    
    # 18 - Uncheck "Optional" box
    elementText = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH)
    unless elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 19 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FOURTH_v2_XPATH).displayed?
    }
    
    #RESULTS Step 11
    assert_match "Optional", $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_SECOND_XPATH).text
    
    #RESULTS Step 15
    assert_match "Optional", $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_THIRD_XPATH).text
    assert_match $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_THIRD_XPATH + "//label[3]").text,"A: Text"
    
    #RESULTS Step 19
    assert_equal($browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FOURTH_v2_XPATH).text, "A: Text") 
    
  end
 

  #TC827 - Question Set Builder, Verify Optional and Text Questions
  def test_VerifyQuestionSetJobBoard
    randomName = SecureRandom.hex(4)
    randomReq = "0" + SecureRandom.hex(4)
    
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    home_url = $browser.current_url
    
    #PRECONDITION: Must have a Question Set created, with Questions already created, some with Optional = true some not, some with Text= true, some not and combined.
    self.CreateQuestionSetWithQuestions(randomName)
    
    #Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH)  
    $wait.until{
      $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH)
    
    #JobBoard without login
    CustomSettings.JobBoardLogin(false)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.ResumeRequired(false)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    # 1 - Apply to a job from the job board site, with Question Set asociated.
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH).displayed?
      }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)   
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    
    # 2 - Verify that questions are shown correctly
    # Question 1 must be required and no text
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_XPATH).displayed?
      }
    assert $wait.until {
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_XPATH + "//*[@class='atsRequired']")
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select")
    }
    
    # Question 2 must be optional and no text
    assert $wait.until {
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_2_XPATH)
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_2_INPUT_XPATH + "//select")
    }
    
    # Question 3 must be optional and text
    assert $wait.until {
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_3_XPATH)
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_3_INPUT_XPATH + "//textarea")
    }
    
    # Question 4 must be required and text
    assert $wait.until {
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_4_XPATH + "//*[@class='atsRequired']")
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_4_INPUT_XPATH + "//textarea")
    }
    # 3 - Answer questions
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select").send_keys "YES"
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_2_INPUT_XPATH + "//select").send_keys "YES"
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_3_INPUT_XPATH + "//textarea").send_keys "YES"
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_4_INPUT_XPATH + "//textarea").send_keys "YES"
    
    # 4 - Click on Submit
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH)
    
    #RESULTS
    $browser.get(home_url)
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")  
    
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?
      }
    assert $wait.until {  
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_FIRST_XPATH).displayed?
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_SECOND_XPATH).displayed?
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_THIRD_XPATH).displayed?
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_FOURTH_XPATH).displayed?
    }
    Common.click_and_load(QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_FIRST_APPLICATION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_1_XPATH).displayed?
      }
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_JOB_TEXT_XPATH + "[//*[text()[contains(.,'" + randomReq + "')]]]").displayed?
    assert $wait.until { 
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_1_XPATH).displayed?
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_2_XPATH).displayed?
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_3_XPATH).displayed?
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_4_XPATH).displayed?
    }
    
  end 

  #TC828 - New Question
  def test_NewQuestion
    randomName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)  
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
    # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    # 2 - Click on the Question Set's name previously created from the list
     $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?  
      }
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
        
    # 3 - Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 4 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    
    #5 - Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
        
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH).displayed?
      }
    
    #RESULTS
    # 5 - You will be redirected to the "Question" page. 
    assert_equal(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH, $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//span").text) 
    #$browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH + "')]]") 
    
  end
   
  # TC829 - New Question, Question Size 
  def test_NewQuestionSize
    randomName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
    # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    # 2 - Click on the Question Set's name previously created from the list
     $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?  
      }
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 3 - Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 4 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    
    # 5 - Select "Small" from "Question Size"
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_SIZE_SMALL_XPATH).click
   
    # 6 - Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH).displayed?
      } 
    
    #RESULT 6 - You will be redirected to the "Question" page.
    assert $wait.until {
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH + "')]]").displayed?
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_SIZE_XPATH + "//*[text()[contains(.,'Small (255 or less)')]]").displayed?
    }
    
    # 7 - Click on Tab "Question Sets"
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # 8 - Click on any Question Set's name from the list
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 9 - Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 10 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_2_INT_XPATH
    
    # 11 - Select "Rich Text" from "Question Size"
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_SIZE_RICH_XPATH).click
   
    # 12 - Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH).displayed?
      } 
    
    #RESULTS 12 - You will be redirected to the "Question" page.
    assert $wait.until {
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH + "')]]")
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_SIZE_XPATH + "//*[text()[contains(.,'Rich Text (up to 32k)')]]")
    } 
   
  end

  #TC830 - New Question, Optional
  def test_NewQuestionOptional 
    randomName = SecureRandom.hex(4)
    randomReq = SecureRandom.hex(4)
    
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
    
     #Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH)  
    $wait.until{
      $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH)
    Common.displayed(RequisitionsDetail::REQUISITIONS_DETAIL_NAME_XPATH)
    
    # 1 - Click on Tab "Question Sets"
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # 2 - Click on previously created Question Set's name from the list
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 3 - Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 4 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH

    # 5 - Check "Optional" box
    unless $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_OPTIONAL_XPATH).attribute("checked")
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_OPTIONAL_XPATH).click
    end
   
    # 6 - Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).displayed?
      }
       
    #RESULTS
    # 6 - You will be redirected to the "Question" page.
    assert $wait.until {
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH + "')]]").displayed?
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_OPTIONAL_XPATH + "//*[@title='Checked']").displayed?
    }
     
   
     # 7 - Click on Tab "Question Sets"
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # 8 - Click on previously created Question Set's name from the list
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 9 - Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 10 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_2_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH

    # 11 - Uncheck "Optional" box
    if $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_OPTIONAL_XPATH).attribute("checked")
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_OPTIONAL_XPATH).click
    end
   
    # 12 - Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH).displayed?
      } 
    
    #RESULTS
    # 12 - You will be redirected to the "Question" page.
    assert $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH + "')]]").displayed?
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_OPTIONAL_XPATH + "//*[@title='Not Checked']").displayed? 
    }
         #JobBoard without login
    CustomSettings.JobBoardLogin(false)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.ResumeRequired(false)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    # 13 - Apply to a job from the job board site, with Question Set asociated.
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)   
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)   
    end
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)   
    end
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH).displayed?
      }
      
    #14 - Verify that questions from question set are shown correctly, check their order.
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH)
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_ERROR_BLOCK_XPATH).displayed?
      }
    assert_match QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH, $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_ERROR_BLOCK_XPATH).text
    
    #Check order
    assert_match QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH, $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_QUESTION_NAME_1_XPATH).text
    assert_match QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH, $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_QUESTION_NAME_2_XPATH).text
    
   end 
   

   #TC831 - New Question, Text
    def test_NewQuestionText 
    randomName = SecureRandom.hex(4)
    randomReq = SecureRandom.hex(4)
    
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
    
     #Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH)
    Common.displayed(RequisitionsDetail::REQUISITIONS_DETAIL_NAME_XPATH)
    
    # 1 - Click on Tab "Question Sets"
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # 2 - Click on previously created Question Set's name from the list
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 3 - Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 4 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH

    # 5 - Check "Text" box
    unless $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_TEXT_XPATH).attribute("checked")
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_TEXT_XPATH).click
    end
   
    # 6 - Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).displayed?
      }
       
    #RESULTS
    # 6 - You will be redirected to the "Question" page.
    assert $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH + "')]]")
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_TEXT_XPATH + "//*[@title='Checked']")  
    }
     
    # 7 - Click on Tab "Question Sets"
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # 8 - Click on previously created Question Set's name from the list
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 9 - Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 10 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_2_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH

    # 11 - Uncheck "Text" box
    if $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_TEXT_XPATH).attribute("checked")
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_TEXT_XPATH).click
    end
   
    # 12 - Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH).displayed?
      } 
    
    #RESULTS
    # 12 - You will be redirected to the "Question" page.
    assert $wait.until {
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH + "')]]")
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_TEXT_XPATH + "//*[@title='Not Checked']") 
    }
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.ResumeRequired(false)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    #JobBoard without login 
    CustomSettings.JobBoardLogin(false)
    
    # 13 - Apply to a job from the job board site, with Question Set asociated.
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
       
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
      
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH).displayed?
      }
      
    #14 - Verify that questions from question set are shown correctly, check their order.
    
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_APPLY_JOB_QUESTION_1_TR_XPATH + "//textarea").displayed?
      $browser.find_element(:xpath, JobBoardJobDetail::JOB_BOARD_APPLY_JOB_QUESTION_2_TR_XPATH + "//select").displayed?
      }  
    #Check order
    assert_match QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH, $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_QUESTION_NAME_1_XPATH).text
    assert_match QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH, $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_QUESTION_NAME_2_XPATH).text
    
   end 

  
  #TC832 - Answer questions from the question set
  def test_AnswerQuestionsFromQuestionSet
    randomName = SecureRandom.hex(4)
    randomReq = SecureRandom.hex(4)
    
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    current_url = $browser.current_url
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).displayed?
      }  
    
    # Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    elementText = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_TEXT_XPATH)
    if elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
    
    #Add Answers
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).displayed?
      }
    Common.click_and_load(QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH)  
    Common.displayed(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH) 
     
    Common.displayed(AnswerEditPage::ANSWER_EDIT_NAME_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ORDER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_SCORE_XPATH) 
        
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_1_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_1_INT
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_NEW_XPATH)
    Common.displayed(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH) 
     
    Common.displayed(AnswerEditPage::ANSWER_EDIT_NAME_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ORDER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_SCORE_XPATH) 
      
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_2_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_2_INT
    
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH)
    Common.displayed(AnswerDetailPage::ANSWER_DETAIL_BACK_TO_QUESTION_XPATH)
    
    # Create Job with Question Set asociated
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys randomReq
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_OPTION_XPATH).click
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys randomName
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    Common.click_and_load(RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH)
    
    #JobBoard without login
    CustomSettings.JobBoardLogin(false)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.ResumeRequired(false)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    # Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    # 1 - Apply to a job from the job board site, with Question Set asociated.
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    Common.click_and_load(JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]")  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH)  
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys randomEmail + Users::EMAIL_DOMAIN
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys randomEmail
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys randomLastName
    
    #If How did you hear about us? is displayed
    begin
      aboutUsSelect = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).displayed?
    rescue
      aboutUsSelect = false
    end 
    if aboutUsSelect
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HEAR_ABOUT_US_XPATH).send_keys "Job Board"
    end
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)   
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    begin
      continue_button = $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
    rescue
      continue_button = false
    end  
    if continue_button
      Common.click_and_load(JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH)
    end
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH).displayed?
      }  
    
    
    # 2 - Answer questions
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select").send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    
    # 3 - Click on Submit
    Common.click_and_load(JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    
    $browser.get(current_url)
    # Click on Tab "Question Sets"
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # Click on previously created Question Set's name from the list
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }   
    
    assert $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_FIRST_XPATH).displayed?
    }
    
    Common.click_and_load(QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_FIRST_APPLICATION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_1_XPATH).displayed?
      }
    assert $wait.until{
      $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_JOB_TEXT_XPATH + "[//*[text()[contains(.,'" + randomReq + "')]]]").displayed?
      $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_1_XPATH).displayed?
    } 
    
  end 
   

  #TC1149 - New Answer
  def test_NewAnswer
    randomName = SecureRandom.hex(4)
    
    #PRECONDITION: Must be logged in
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #PRECONDITION: Must have a Question Set already created. Must have a Question already created.
    
    #Create an empty Question Sets
    self.CreateQuestionSetEmpty(randomName)
     
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # Click on "New Question"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_QUESTION_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    elementText = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_TEXT_XPATH)
    if elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # Click on "Save"
    Common.click_and_load(QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH)
    
    # 1 - From Question record, click "New Answer"
    # Click on Tab "Question Sets"
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # Click on previously created Question Set's name from the list
    Common.click_and_load(QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    #Click on previously created Question
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_FIRST_XPATH)
    
    #Add Answers
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).displayed?
      }
      
    # 1 - From Question record, click "New Answer" 
    Common.click_and_load(QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH) 
     
    Common.displayed(AnswerEditPage::ANSWER_EDIT_NAME_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ORDER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_SCORE_XPATH)
   
    # 2 - Fill out required fields and click "Save and New" 
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_1_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_1_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_1_INT
    # Click on Save and New
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_NEW_XPATH)
    Common.displayed(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH) 
     
    Common.displayed(AnswerEditPage::ANSWER_EDIT_NAME_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ORDER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_SCORE_XPATH)
    
    # 3 - Fill out required fields and click "Save and New" 
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_2_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_2_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_2_INT
    # Click on Save and New
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_NEW_XPATH)
    Common.displayed(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH) 
     
    Common.displayed(AnswerEditPage::ANSWER_EDIT_NAME_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_ORDER_XPATH) 
    Common.displayed(AnswerEditPage::ANSWER_EDIT_SCORE_XPATH) 
    
    # 4 - Fill out required fields and click "Save"  
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_NAME_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_3_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ANSWER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_NAME_3_TEXT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_ORDER_XPATH).send_keys AnswerEditPage::ANSWER_DATA_ORDER_3_INT
    $browser.find_element(:xpath => AnswerEditPage::ANSWER_EDIT_SCORE_XPATH).send_keys AnswerEditPage::ANSWER_DATA_SCORE_3_INT
    # Click on Save
    Common.click_and_load(AnswerEditPage::ANSWER_EDIT_BTN_SAVE_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => AnswerDetailPage::ANSWER_DETAIL_BACK_TO_QUESTION_XPATH).displayed?
      }
    
    Common.click_and_load(AnswerDetailPage::ANSWER_DETAIL_BACK_TO_QUESTION_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_NEW_ANSWER_XPATH).displayed?
      }
      
    # RESULTS
    # New answers will be shown in the Answers related list on "Question Detail" page.      
    assert_equal($browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_FIRST_ANSWER_LIST_XPATH).text, AnswerEditPage::ANSWER_DATA_NAME_1_TEXT)    
    assert_equal($browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_SECOND_ANSWER_LIST_XPATH).text, AnswerEditPage::ANSWER_DATA_NAME_2_TEXT)    
    assert_equal($browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_THIRD_ANSWER_LIST_XPATH).text, AnswerEditPage::ANSWER_DATA_NAME_3_TEXT)    
    
  end
 
  #TC861 - Rollover, different Question Sets
  def test_RolloverDifferentQuestionSets
    randomName = "a" + SecureRandom.hex(4)
    randomName2 = "a" + SecureRandom.hex(4)
    randomQS = SecureRandom.hex(4)
    randomQS2 = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    randomContact2 = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    Common.go_to_custom_settings
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    Common.CreateQuestionSetEmpty(randomQS)
    
    Common.CreateQuestionSetEmpty(randomQS2)
    
    Common.CreateRequisitionPostJob(randomName, true, false, randomQS)
    
    Common.CreateRequisitionPostJob(randomName2, true, false, randomQS2)
    
    #Must have several accounts
    Common.CreateAccount(randomContact) 
          
    #Must have several contacs
    Common.CreateContact(randomContact, randomContact)
    
    #Must have several accounts
    Common.CreateAccount(randomContact2) 
          
    #Must have several contacs
    Common.CreateContact(randomContact2, randomContact2)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact2 + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(2)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(2)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_XPATH, "text" => "some text"},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 1 - Click on "Requisitions"
    Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
    
    test= [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    sleep(3)
    
    test= [
    # 2 - Select a Job Order  
      {"click_and_load" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]"},
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    # 3 - Click on "Rollover Contacts"  
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    ]
    Common.main(test)
    
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)
    sleep(2)
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH},
    # 4 - Select another job order that fits the preconditions  
      {"set_text" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH, "text" => randomName2},
    # 5 - Click on "Rollover"  
      {"click" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_BTN_ROLLOVER_XPATH},
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH}
    ]
    Common.main(test)
    sleep(3)
    # RESULT 
    # A message stating that Rollover is impossible and prompt to apply contacts to the selected job order will be displayed.
    assert_equal(RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_WARNING_TEXT, $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH).text)
    
    $browser.close
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
  
  end  

  #TC862 - Rollover, same Question Sets
  def test_RolloverSameQuestionSets
    randomName = "a" + SecureRandom.hex(4)
    randomName2 = "a" + SecureRandom.hex(4)
    randomQS = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    randomContact2 = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_custom_settings
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    Common.CreateQuestionSetEmpty(randomQS)
    
    Common.CreateRequisitionPostJob(randomName, true, false, randomQS)
    
    Common.CreateRequisitionPostJob(randomName2, true, false, randomQS)
    
    #Must have several accounts
    Common.CreateAccount(randomContact) 
          
    #Must have several contacs
    Common.CreateContact(randomContact, randomContact)
    
    #Must have several accounts
    Common.CreateAccount(randomContact2) 
          
    #Must have several contacs
    Common.CreateContact(randomContact2, randomContact2)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact2 + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_XPATH, "text" => "some text"},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    sleep(2)
    # 1 - Click on "Requisitions"
    Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
    
    test= [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    sleep(4)
    # 2 - Select a Job Order
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    # 3 - Click on "Rollover Contacts"  
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    ]
    Common.main(test)
    
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)
    sleep(2)
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH},
    # 4 - Select another job order that fits the preconditions  
      {"set_text" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH, "text" => randomName2},
    # 5 - Click on "Rollover"  
      {"click" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_BTN_ROLLOVER_XPATH},
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH}
    ]
    Common.main(test)
    sleep(3)
    # RESULT 
    # New applications will be created for selected job order, they will have the same status, stage and prescreen as applications from original job order. Message will be displayed.
    assert_equal(RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_SUCCESS_TEXT, $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH).text)
    
    Common.click(RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_BTN_OK_XPATH)
    
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    
    Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
    
    test= [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    sleep(3)
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName2 + "')]]")
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test)
    
    currentUrl = $browser.current_url
    
    test= [
      {"click_and_load" => RequisitionsDetail::REQUISITIONS_DETAIL_FIRST_APP_LIST_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH}
    ]
    Common.main(test)
    
    assert_equal("New", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_STATUS_XPATH).text)
    assert_equal("Application", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
    $browser.get(currentUrl)
    
      test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test)
    
    currentUrl = $browser.current_url
    
    test= [
      {"click_and_load" => RequisitionsDetail::REQUISITIONS_DETAIL_SECOND_APP_LIST_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_APP_STATUS_XPATH}
    ]
    Common.main(test)
    
    assert_equal("New", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_STATUS_XPATH).text)
    assert_equal("Application", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
    #$browser.switch_to.window($browser.window_handles.last)
    #$browser.close
    
    #$browser.switch_to.window($browser.window_handles.last)
    #$browser.close
  end

  #TC863 - Rollover, same Job Order
  def test_RolloverSameJobOrder
    randomName = SecureRandom.hex(4)
    randomQS = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    randomContact2 = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_custom_settings
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    Common.CreateQuestionSetEmpty(randomQS)
        
    Common.CreateRequisitionPostJob(randomName, true, false, randomQS)
    
    
    #Must have several accounts
    Common.CreateAccount(randomContact) 
          
    #Must have several contacs
    Common.CreateContact(randomContact, randomContact)
    
    #Must have several accounts
    Common.CreateAccount(randomContact2) 
          
    #Must have several contacs
    Common.CreateContact(randomContact2, randomContact2)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click_and_load" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact2 + "')]]/../../../..//td[1]//input").click
    
    # Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    
    test = [
    # Select a job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    #Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_XPATH, "text" => "some text"},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 1 - Click on "Requisitions"
    Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
    
    test= [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH}
    ]
    Common.main(test)
    sleep(2)
    # 2 - Select a Job Order
    Common.click_and_load(RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]")
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    # 3 - Click on "Rollover Contacts"  
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH},
    ]
    Common.main(test)
    
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)
    sleep(2)
    
    test= [
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH},
    # 4 - Select another job order that fits the preconditions  
      {"set_text" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH, "text" => randomName},
    # 5 - Click on "Rollover"  
      {"click" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_BTN_ROLLOVER_XPATH},
      {"displayed" => RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH}
    ]
    Common.main(test)
    sleep(3)
    # RESULT 
    # A message stating that Rollover is impossible and prompt to apply contacts to the selected job order will be displayed.
    assert_equal("The Rollover Process has been completed. Applications Rolled Over: 0.", $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH).text)
    
    $browser.close
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    

  end


  ######## CUSTOM METHODS ############
  
  def CreateQuestionSetWithQuestions(name)
         
    # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    # 2 - Click on New button
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
    }
   
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).click
   
    # 3 - FIll all the fields
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).displayed?
    }
    
    $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).send_keys name
    
    # 4 - Click on "Save" button
    $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).displayed?
    }
    
    # 5 - Click on "Question Builder"
    Common.click_and_load(QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).displayed?
    }
    
    # 6 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    sleep(3)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 7 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_1_TEXT
    
    # 8 - Uncheck "Optional" and "Text" boxes
    elementText = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH)
    if elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 9 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    sleep(1)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH).displayed?
    }
    
    # 10 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    sleep(3)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 11 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_2_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_2_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_2_TEXT
    
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    # 12 - Check "Optional" box
    unless elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 13 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_SECOND_XPATH).displayed?
    }
    
    # 14 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    sleep(3)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 15 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_4_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_4_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_4_TEXT
    
    # 16 - Check "Text" box
    elementText = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH)
    unless elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    unless elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 17 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_THIRD_XPATH).displayed?
    }
    
    # 18 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).displayed?
    }
    sleep(2)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).displayed?
    }
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).displayed?
    }
    
    # 19 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_3_TEXT
    $browser.switch_to.frame(QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT_IFRAME_ID)
    $browser.find_element(:xpath => "html/body").send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_3_TEXT
    $browser.switch_to.default_content
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_3_TEXT
    
    # 20 - Uncheck "Optional" box
    elementText = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH)
    unless elementText.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_TEXT_XPATH).click
    end
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    if elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 21 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH).displayed?
    }
      
  end

  

  def CreateQuestionSetEmpty(name)
     # 1 - Go to "Question Sets" Tab
    Common.goToTab(HomePage::QUESTION_SETS_LINK_XPATH)
   
    # 2 - Click on New button
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
    }
   
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).click
   
    # 3 - FIll all the fields
    $wait.until{
      $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).displayed?
    }
    
    $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).send_keys name
    
    # 4 - Click on "Save" button
    $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).click
     $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).displayed?
    } 
     
  end
  
end