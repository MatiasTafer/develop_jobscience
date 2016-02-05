require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/standard_questions_page.rb'
require_relative './pages/new_standard_question_page.rb'


class TestStandardQuestions < TestBasic
  
  # TC928 New Standard Question, Successfully created, Required By Applicant = true
  def test_successfullyCreated
    
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    $browser.get HomePage::STANDARD_QUESTIONS_TAB_LINK
    $wait.until {
      $browser.current_url.eql? HomePage::STANDARD_QUESTIONS_TAB_LINK
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_NAME_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_LAYOUT_OPTION_1 
    $browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH).send_keys NewStandardQuestion::CONTACT_FIELD_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_SIZE_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_SIZE_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $browser.find_element(:xpath, NewStandardQuestion::REQUIRED_BY_APPLICANT_CHECKBOX_XPATH).click
    $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).click
    assert $wait.until {
      $browser.current_url.eql?(HomePage::STANDARD_QUESTIONS_TAB_LINK)
    }
    assert_equal($browser.find_element(:xpath => StandardQuestions::FIRST_QUESTION_NAME_ITEM_XPATH).text, NewStandardQuestion::QUESTION_NAME)
  end
  
  #TC930 - New Standard Question, Field Validation, Required By Applicant = true
  def test_newStandardQuestion
    
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    $browser.get HomePage::STANDARD_QUESTIONS_TAB_LINK
    $wait.until {
      $browser.current_url.eql? HomePage::STANDARD_QUESTIONS_TAB_LINK
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath, NewStandardQuestion::ERROR_MESSAGE_XPATH).displayed?
    }
    
  end
  
  #TC931 - New Standard Question, Successfully created, Required By Applicant = false
  def test_NewStandaQuestionRequiredFalse
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    $browser.get HomePage::STANDARD_QUESTIONS_TAB_LINK
    $wait.until {
      $browser.current_url.eql? HomePage::STANDARD_QUESTIONS_TAB_LINK
      $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, StandardQuestions::NEW_BUTTON_XPATH).click
    $wait.until {
    $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_NAME_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_LAYOUT_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_LAYOUT_OPTION_1 
    $browser.find_element(:xpath, NewStandardQuestion::CONTACT_FIELD_DROPDOWN_XPATH).send_keys NewStandardQuestion::CONTACT_FIELD_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_SIZE_DROPDOWN_XPATH).send_keys NewStandardQuestion::QUESTION_SIZE_OPTION_1
    $browser.find_element(:xpath, NewStandardQuestion::QUESTION_TEXT_FIELD_XPATH).send_keys NewStandardQuestion::QUESTION_NAME
    $browser.find_element(:xpath, NewStandardQuestion::SAVE_BUTTON_XPATH).click
    assert $wait.until {
      $browser.current_url.eql?(HomePage::STANDARD_QUESTIONS_TAB_LINK)
    }
    assert_equal($browser.find_element(:xpath => StandardQuestions::FIRST_QUESTION_NAME_ITEM_XPATH).text, NewStandardQuestion::QUESTION_NAME)
  end
  
  
end