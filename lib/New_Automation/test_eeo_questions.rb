require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/question_sets_home_page.rb'
require_relative './pages/question_sets_new_page.rb'
require_relative './pages/question_set_detail_page.rb'
require_relative './pages/question_sets_question_builder_page.rb'
require_relative './pages/question_sets_new_question_page.rb'
require_relative './pages/requisitions_home_page.rb'
require_relative './pages/requisitions_detail_page.rb'
require_relative './pages/requisitions_new_and_edit.rb'
require_relative './pages/setup_page.rb'
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/applications_detail_page.rb'
require_relative './pages/question_detail_page.rb'
require_relative 'custom_settings.rb'

class TestEeoQuestions < TestBasic
=begin    
  #TC819 - New Question Set Successfully Created
  def test_NewQuestionSet
    
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
      
   
    # 1 - Go to "Question Sets" Tab
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
   
    # 2 - Click on New button
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
    }
   
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).click
   
    # 3 - FIll all the fields
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).displayed?
    }
    
    $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).send_keys QuestionSetsNew::QUESTION_SETS_NAME_TEXT
    
    # 4 - Click on "Save" button
    $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).click
    
    #RESULTS   
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_COPY_QUESTION_SET_XPATH).displayed?
      }
    $browser.find_element(:id => QuestionSetsDetail::QUESTION_SETS_DETAIL_NAME_ID).text == QuestionSetsNew::QUESTION_SETS_NAME_TEXT
     
  end
 
  #TC820 - New Question Set Field Validation
  def test_NewQuestionSetsErrors
    
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # 1 - Go to "Question Sets" Tab
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
   
    # 2 - Click on New button
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
    }
   
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).click
    
    # 4 - Click on "Save" button
    $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).click
    
    #RESULT
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNew::ERROR_NAME_QUESTION_SETS_NEW_XPATH).displayed?
      $browser.find_element(:xpath => QuestionSetsNew::ERROR_NAME_QUESTION_SETS_NEW_XPATH).text == QuestionSetsNew::ERROR_NAME_QUESTION_SETS_NEW_TEXT
    }
    
    # 5 - Fill all the required fields
    $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).send_keys QuestionSetsNew::QUESTION_SETS_NAME_TEXT
    
    # 6 - Enter invalid value into number fields ("Passing Score").
    $browser.find_element(:xpath => QuestionSetsNew::QUESTIONS_SETS_NEW_PASSING_SCORE_XPATH).send_keys QuestionSetsNew::QUESTION_SETS_PASSING_SCORE_INVALID_TEXT
    
    # 7 - Click on "Save" button
    $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).click
    
    #RESULT
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNew::ERROR_NUMBER_QUESTION_SETS_NEW_XPATH).displayed?
      }
    $browser.find_element(:xpath => QuestionSetsNew::ERROR_NUMBER_QUESTION_SETS_NEW_XPATH).text == QuestionSetsNew::ERROR_NUMBER_QUESTION_SETS_NEW_TEXT
    
  end
  
  #TC821 - Question Set Handler = Always
  def QuestionSetHandlerAlways
    
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #Must be set on "Custom Settings", Question Set Handler = Always.
    CustomSettings.QuestionSetHandler("Always")
    
    #1 - Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    #2 - Apply to any job
    ##### TERMINARR ##############
  end
  
  #TC824 - Copy Question Set
  def test_CopyQuestionSet
    
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # 1 - Go to "Question Sets" Tab
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
   
    # 2 - Click on any Question Set's name from the list
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).displayed?
    }
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:id => QuestionSetsDetail::QUESTION_SETS_DETAIL_NAME_ID).displayed?
    }
    
    # 3 - Click on "Copy Question Set"
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_COPY_QUESTION_SET_XPATH).click
    sleep(1)
    $browser.switch_to.alert.accept
    
    # 4 - Confirm copying of Question Set
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?
    }
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NAME_XPATH + "[text()[contains(.,'test')]]")
    
  end

 
  #TC825 - Question Set Builder 
  def test_QuestionSetBuilder
    
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # 1 - Go to "Question Sets" Tab
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
   
    # 2 - Click on any Question Set's name from the list
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).displayed?
    }
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NAME_XPATH).displayed?
    }
    
    # 3 - Click on "Question Builder"
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).displayed?
    }
    
    # 4 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 5 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_1_TEXT
    
    # 6 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    
    # 7 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 8 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_2_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_2_TEXT
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
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).displayed?
    }
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NAME_XPATH).displayed?
    }
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).displayed?
    }
    
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_1_NAME_LABEL_XPATH + "[text()[contains(.,'Icecream')]]")
  end
 

  #TC826 - Question Set Builder, Optional and Text 
  def test_QuestionSetBuilderOptionalText
    
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # 1 - Go to "Question Sets" Tab
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
   
    # 2 - Click on any Question Set's name from the list
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).displayed?
    }
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:id => QuestionSetsDetail::QUESTION_SETS_DETAIL_NAME_ID).displayed?
    }
    
    # 3 - Click on "Question Builder"
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).displayed?
    }
    
    # 4 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 5 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT
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
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH).displayed?
    }
    
    # 8 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 9 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_2_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_2_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_2_TEXT
    
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
    # 10 - Check "Optional" box
    unless elementOptional.attribute("checked")
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH).click
    end
    
    # 11 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_NEW_BTN_SAVE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH).displayed?
    }
    
    # 12 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 13 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_4_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_4_TEXT
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
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_SECOND_XPATH).displayed?
    }
    
    # 16 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 17 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_3_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_3_TEXT
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
    
    #RESULTS Step 11
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_SECOND_XPATH + "//*[text()[contains(.,'Optional')]]")
    
    #RESULTS Step 15
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_THIRD_XPATH + "//*[text()[contains(.,'Optional')]]")
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_THIRD_XPATH + "//*[text()[contains(.,'A: Text')]]")
    
    #RESULTS Step 19
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FOURTH_XPATH + "//*[text()[contains(.,'A: Text')]]")
  
  end

  #TC827 - Question Set Builder, Verify Optional and Text Questions
  def test_VerifyQuestionSetJobBoard
    
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #PRECONDITION: Must have a Question Set created, with Questions already created, some with Optional = true some not, some with Text= true, some not and combined.
    self.CreateQuestionSetWithQuestions
    
    #Create Job with Question Set asociated
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH).displayed?
      }
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
      }
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    $wait.until{
      $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).displayed?
      }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_PRIMARY_RECRUITER_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_LOCATION_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_DEPARTMENT_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MIN_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_MAX_SALARY_TEXT
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_QUESTIONS_SET_XPATH).send_keys QuestionSetsNew::QUESTION_SETS_NAME_2_TEXT
    unless $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).attribute("checked")
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_POST_JOB_BOX_XPATH).click
    end
    
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_XPATH).click
    
    #JobBoard without login
    CustomSettings.JobBoardLogin(false)
    
    # 1 - Apply to a job from the job board site, with Question Set asociated.
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE_TEXT + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH).send_keys JobBoardJobDetail::JOB_BOARD_APPLY_JOB_DATA_EMAIL_TEXT
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_FIRST_NAME_XPATH).send_keys JobBoardJobDetail::JOB_BOARD_APPLY_JOB_DATA_NAME_TEXT
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LAST_NAME_XPATH).send_keys JobBoardJobDetail::JOB_BOARD_APPLY_JOB_DATA_LAST_NAME_TEXT
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).click
    
    # 2 - Verify that questions are shown correctly
    # Question 1 must be required and no text
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_XPATH + "//*[@class='atsRequired']")
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select")
    
    # Question 2 must be optional and no text
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_2_XPATH)
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_2_INPUT_XPATH + "//select")
    
    # Question 3 must be optional and text
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_3_XPATH)
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_3_INPUT_XPATH + "//textarea")
    
    # Question 4 must be required and text
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_4_XPATH + "//*[@class='atsRequired']")
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_4_INPUT_XPATH + "//textarea")
    
    # 3 - Answer questions
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_DATE_START_XPATH).send_keys JobBoardJobDetail::JOB_BOARD_APPLY_JOB_DATA_DATE_START_DATE
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_DEGREE_OPTION_1_XPATH).click
    
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_1_INPUT_XPATH + "//select").send_keys "YES"
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_2_INPUT_XPATH + "//select").send_keys "YES"
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_3_INPUT_XPATH + "//textarea").send_keys "YES"
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_QUESTION_4_INPUT_XPATH + "//textarea").send_keys "YES"
    
    # 4 - Click on Submit
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_QUESTIONS_SET_BTN_SUBMIT_XPATH).click
    
    #RESULTS
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SET_LIST_XPATH + "//*[text()[contains(.,'" + QuestionSetsNew::QUESTION_SETS_NAME_2_TEXT + "')]]").click   
    
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?
      }
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_FIRST_XPATH).displayed?
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_SECOND_XPATH).displayed?
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_THIRD_XPATH).displayed?
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_FOURTH_XPATH).displayed?
    
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SET_DETAIL_PRESCREENS_FIRST_APPLICATION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_1_XPATH).displayed?
      }
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_JOB_TEXT_XPATH + "//*[text()[contains(.,'" + RequisitionsNewAndEdit::REQUISITIONS_NEW_DATA_TITLE_TEXT + "')]]").displayed?
    
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_1_XPATH).displayed?
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_2_XPATH).displayed?
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_3_XPATH).displayed?
    $browser.find_element(:xpath => ApplicationsDetailPage::APPLICATIONS_DETAIL_PRESCREEN_4_XPATH).displayed?
      
  end
  
  #TC828 - New Question
  def test_NewQuestion
  
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)  
    
    # 1 - Click on Tab "Question Sets"
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # 2 - Click on any Question Set's name from the list
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 3 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 4 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SET_NEW_QUESTIONS_ORDER_INT_XPATH
    
    #5 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH).displayed?
      }
    
    #RESULTS
    # 5 - You will be redirected to the "Question" page.  
    $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH + "')]]") 
    
  end
=end  
  # TC829 - New Question, Question Size 
  def test_NewQuestionSize
    
    #PRECONDITION: Must be logged in
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # 1 - Click on Tab "Question Sets"
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # 2 - Click on any Question Set's name from the list
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 3 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 4 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_INT_XPATH
    
    # 5 - Select "Small" from "Question Size"
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_SIZE_SMALL_XPATH).click
   
    # 6 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH).displayed?
      } 
    
    #RESULTS
    # 6 - You will be redirected to the "Question" page.
    $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_TEXT_XPATH + "')]]")
    $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_SIZE_XPATH + "//*[text()[contains(.,'Small (255 or less)')]]")
    
    # 7 - Click on Tab "Question Sets"
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
      }
    
    # 8 - Click on any Question Set's name from the list
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_FIRST_ENTRY_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).displayed?  
      }
    
    # 9 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).displayed?
      }
    
    # 10 - Fill all the fields
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_XPATH).send_keys QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_ORDER_2_INT_XPATH
    
    # 11 - Select "Rich Text" from "Question Size"
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_SIZE_RICH_XPATH).click
   
    # 12 - Click on "Save"
    $browser.find_element(:xpath => QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_BTN_SAVE_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH).displayed?
      } 
    
    #RESULTS
    # 12 - You will be redirected to the "Question" page.
    $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_NAME_XPATH + "//*[text()[contains(.,'" + QuestionSetsNewQuestion::QUESTION_SETS_NEW_QUESTION_NAME_2_TEXT_XPATH + "')]]")
    $browser.find_element(:xpath => QuestionDetailPage::QUESTION_DETAIL_QUESTION_SIZE_XPATH + "//*[text()[contains(.,'Rich Text (up to 32k)')]]")
  end  
    
   
  def CreateQuestionSetWithQuestions
         
    # 1 - Go to "Question Sets" Tab
    $browser.get(HomePage::QUESTION_SETS_LINK_URL)
   
    # 2 - Click on New button
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).displayed?
    }
   
    $browser.find_element(:xpath => QuestionSetsHomePage::QUESTION_SETS_HOME_BTN_NEW_XPATH).click
   
    # 3 - FIll all the fields
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).displayed?
    }
    
    $browser.find_element(:id => QuestionSetsNew::QUESTION_SETS_NEW_NAME_ID).send_keys QuestionSetsNew::QUESTION_SETS_NAME_2_TEXT
    
    # 4 - Click on "Save" button
    $browser.find_element(:xpath => QuestionSetsNew::QUESTION_SETS_NEW_BTN_SAVE_XPATH).click
    
    
    # 5 - Click on "Question Builder"
    $browser.find_element(:xpath => QuestionSetsDetail::QUESTION_SETS_DETAIL_QUESTION_BUILDER_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).displayed?
    }
    
    # 6 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 7 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_TEXT
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
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FIRST_XPATH).displayed?
    }
    
    # 10 - Click on "New Question"
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_BTN_NEW_QUESTION_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 11 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_2_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_2_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_ANSWER_1_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_ANSWER_2_TEXT
    
    # 12 - Check "Optional" box
    elementOptional = $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_OPTIONAL_XPATH)
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
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 15 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_4_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_4_TEXT
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
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).displayed?
    }
    
    # 19 - Fill all fields
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_NAME_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_NAME_3_TEXT
    $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_BUILDER_QUESTION_XPATH).send_keys QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTION_3_TEXT
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
      $browser.find_element(:xpath => QuestionSetsQuestionBuilder::QUESTION_SETS_QUESTIONS_LIST_FOURTH_XPATH).displayed?
    }
      
  end
  
  
  
end