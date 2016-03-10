require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'users.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/board_setup/board_setup_detail_page.rb'
require './New_Automation/pages/board_setup/board_setup_edit_page.rb'
require './New_Automation/pages/board_setup/board_setup_home_page.rb'
require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_register_page.rb'


class TestBoardSetup < TestBasic
  
  $USER_JOB_BOARD = "testing5@fromthesky.up"
  $PASSWORD_JOB_BOARD = "automatable666"
  

  def test_board_setup_tc1040   #1
    # JS2 - Board Setup - TC1040
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)

    # PRECONDITIONS
    # open board setup page
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    
    Common.click(BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH)
    
    $wait.until{
      $browser.find_element(:xpath => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).click
    begin
      # confirm is checked
      $browser.find_element(:xpath => SetupEditPage::AUTO_ASSOCIATE_CHECKBOX_XPATH + "[@checked='checked']").displayed?
    rescue
      $browser.find_element(:xpath => SetupEditPage::AUTO_ASSOCIATE_CHECKBOX_XPATH).click
      $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    end  
    
    # END PRECONDITIONS
    $browser.get HomePage::REQUISITION_TAB_LINK_XPATH
    # new requisitions button
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).click
    # continue button
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
    }
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    # fill 'Job Title' field 
    $wait.until{
      $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).displayed?
    }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys "TEST"
    # select "Location" field
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys "b"
    # select "Min Salary" field
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys "1"
    # select "Max Salary" field
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys "2"
    # department field
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH).send_keys "d"
    # Primary Recruiter
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys "Alex"
    # SAVE
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_EDIT_XPATH).click
       
  end

=begin
  def test_board_setup_tc1041 #2
    #  TC1041 - Board Setup - Auto Associate = false 
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    # PRECONDITIONS
    # open board setup page
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    $browser.find_element(:xpath => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH).click
    begin
      # confirm is checked
      $browser.find_element(:xpath => SetupEditPage::AUTO_ASSOCIATE_CHECKBOX_XPATH + "[not (@checked='checked')]").displayed?
    rescue
      $browser.find_element(:xpath => SetupEditPage::AUTO_ASSOCIATE_CHECKBOX_XPATH).click
      $browser.find_element(:xpath => SetupEditPage::SAVE_BUTTON_XPATH).click
    end  
    
    $browser.get HomePage::REQUISITION_TAB_LINK_XPATH
    # new requisitions button
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH).click
    # continue button
    $wait.until{
      $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).displayed?
    }
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_CONTINUE_XPATH).click
    # fill 'Job Title' field 
    $wait.until{
      $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).displayed?
    }
    $browser.find_element(:id => RequisitionsNewAndEdit::REQUISITIONS_NEW_JOB_TITLE_ID).send_keys "TEST"
    # select "Location" field
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_LOCATION_XPATH).send_keys "b"
    # select "Min Salary" field
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MIN_SALARY_XPATH).send_keys "1"
    # select "Max Salary" field
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_MAX_SALARY_XPATH).send_keys "2"
    # department field
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_DEPARTAMENT_XPATH).send_keys "d"
    # Primary Recruiter
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH).send_keys "Alex"
    # SAVE
    $browser.find_element(:xpath => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_EDIT_XPATH).click
    
  end

  def test_board_setup_tc1042 #3
    # Set "Show Search Only" to "TRUE" in Board Setup
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditios open board setup page
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
<<<<<<< HEAD
=======
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => SetupEditPage::SHOW_SEARCH_ONLY_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Test case
    $browser.get HomePage::JOB_BOARD_URL
    
    
  end

  def test_board_setup_tc1043 #4
    #Set "Show Search Only" to "FALSE" in Board Setup
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditios open board setup page
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
<<<<<<< HEAD
=======
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => SetupEditPage::SHOW_SEARCH_ONLY_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    
  end
  

  def test_board_setup_tc1044 #5
    # Job Board - Allow Register Only = False
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditios open board setup page
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
<<<<<<< HEAD
=======
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => SetupEditPage::ALLOW_REGISTER_ONLY_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"check_apply" => ""},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardRegisterPage::JOB_BOARD_REGISTER_EMAIL_XPATH},
      
    ]
    Common.main(test)
    
  end
  


  def test_board_setup_tc1045  #6
    # Job Board - Allow Register Only = True
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditios open board setup page
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
<<<<<<< HEAD
=======
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => SetupEditPage::ALLOW_REGISTER_ONLY_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
    ]
    Common.main(test)
    
  end

  def test_board_setup_tc1046   #7
    # Job Board - Job Board Resume Required = true
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions open board setup page
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"displayed" => SetupEditPage::RESUME_DAYS_VALID_TEXT_XPATH},
      {"set_text" => SetupEditPage::RESUME_DAYS_VALID_TEXT_XPATH, "text" => "15"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
<<<<<<< HEAD
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    Common.register_job_board($USER_JOB_BOARD, $PASSWORD_JOB_BOARD)
    
  end
  
=end
  
  def test_board_setup_tc1047   #8
    # Job Board - Job Board Resume Required = false
    #Login
    
    Users.create_user_job_board
    
    #Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"displayed" => SetupEditPage::RESUME_DAYS_VALID_TEXT_XPATH},
      {"set_text" => SetupEditPage::RESUME_DAYS_VALID_TEXT_XPATH, "text" => "15"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
    ]
    #Common.main(test)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
    ]
    #Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'You have successfully registered')]]"},
    ]
    #Common.main(test)
    
    
  end


=begin
  

  def test_board_setup_tc1048  #9
    # Job Board - Hide Resume Upload / Paste / Builder / Previously Uploaded / Cover Letter
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
<<<<<<< HEAD
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_UPLOAD_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PASTE_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_BUILDER_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_COVER_LETTER_XPATH},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => "test@gmail.com"},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"displayed" => JobBoardHomePage::PASTE_CHECKBOX_XPATH},
      {"displayed" => JobBoardHomePage::BUILDER_CHECKBOX_XPATH},
    ]
    Common.main(test)
  end




  def test_board_setup_tc1049  #10
    # Job Board - Hide Resume Upload / Paste / Builder / Previously Uploaded / Cover Letter
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
<<<<<<< HEAD
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_UPLOAD_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PASTE_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_BUILDER_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_COVER_LETTER_XPATH},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end




  def test_board_setup_tc1050  #11
    # Job Board - Hide Resume Upload / Paste / Builder / Previously Uploaded / Cover Letter
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
<<<<<<< HEAD
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_UPLOAD_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PASTE_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_BUILDER_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_COVER_LETTER_XPATH},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'You have successfully registered')]]"},
    ]
    Common.main(test)
    
    
  end




  def test_board_setup_tc1051  #12
    # Job Board - Hide Phone / Hide Mobile / Hide Source Question / Hide Contact Method / will be available
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
<<<<<<< HEAD
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_PHONE_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_MOBILE_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_CONTACT_METHOD_XPATH},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardRegisterPage::PHONE_TEXT_XPATH, "text" => "5555555"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'You have successfully registered')]]"},
    ]
    Common.main(test)
    
  end
  
  


  
  def test_board_setup_tc1052  #13
    # Job Board - Hide Phone / Hide Mobile / Hide Source Question / Hide Contact Method / will be hidden
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
<<<<<<< HEAD
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_PHONE_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_MOBILE_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_CONTACT_METHOD_XPATH},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'You have successfully registered')]]"},
    ]
    Common.main(test)
    
  end

 
  def test_board_setup_tc1053  #14
    # Job Board - Search & Results, Set some job order fields as search criteria.
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions
    # 1. Click on "Board Setup".
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 3. Click on "Edit".
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 4. In the "Search & Results" section select several search criteria
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "d"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "b"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "c"},
      # 5. Click on "Save".
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    assert $wait.until { 
      $browser.find_element(:xpath, JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH).displayed?
    }
  end




  def test_board_setup_tc1054  #15
    # Job Board - Search & Results, Search By Keyword = true.
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions
    # 1. Click on "Board Setup".
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
<<<<<<< HEAD
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      # 2. Click on one record on "Job Board Setup Name" column
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 3. Click on "Edit".
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 4. In the "Search & Results" section set "Search By Keyword" = true
      {"checked" => BoardSetupEditPage::BOARD_EDIT_SEARCH_BY_KEYWORD_XPATH},
      # 5. Click on "Save"
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # 6. Perform search with keyword search.
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_RESULTS_XPATH},
    ]
    Common.main(test)
  end



  
  def test_board_setup_tc1055  #16
    # Job Board - Search & Results, Search By Keyword = false.
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions
    # 1. Click on "Board Setup".
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
<<<<<<< HEAD
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      # 2. Click on one record on "Job Board Setup Name" column
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 3. Click on "Edit".
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 4. In the "Search & Results" section set "Search By Keyword" = false
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_SEARCH_BY_KEYWORD_XPATH},
      # 5. Click on "Save"
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # 6. Perform search with keyword search.
      {"not_displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH},
      
    ]
    Common.main(test)
  end



  

  def test_board_setup_tc1056   #17
    # Job Board - Search & Results Jobs Per Page
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions
    # 1. Click on "Board Setup".
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
<<<<<<< HEAD
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
=======
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      # 2. Click on one record on "Job Board Setup Name" column
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
>>>>>>> develop
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 3. Click on "Edit".
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 4. In the "Search & Results" section select any value "Jobs Per Page" = true
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_JOBS_PER_PAGE_XPATH, "text" => "5"},
      # 5. Click on "Save"
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    # Expected result: Amount of job orders displayed on Job Search page will be limited by selected value.

  end




  
  def test_board_setup_tc1057
    # Job Board - Job Description Fields
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions
    # 1. Click on "Board Setup".
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_JOB_DESCRIPTION_1_XPATH, "text" => "Location"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # 6. Perform search with keyword search.
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
    ]
    Common.main(test)

  end




  #@@job_path = "/Users/admin/Desktop/testing job order.pdf"
  #TC104 - RSS feed customizable fields
  def test_RSSFeddCustomizableFields
    
    #PRECONDITIONS
    #Need to have pre configured on Setup>Create>Objects>Job Orders>RSS Feed the followings fields: 
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_NEXT_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH}
    ]
     Common.main(test)
     newWindow= $browser.window_handles.last
     $browser.switch_to.window(newWindow)
     
     sleep(3)
  
     puts $browser.browser.to_s
     if $browser.browser.to_s == "chrome"
       assert $wait.until{
        $browser.find_element(:xpath => ".//*[text()[contains(.,'Min_Salary')]]").displayed?
        $browser.find_element(:xpath => ".//*[text()[contains(.,'Max_Salary')]]").displayed?
      }
     else
       assert $wait.until{
         $browser.find_element(:xpath => ".//*[@class='entry']").displayed?  
       } 
     end
     sleep(5)
   end  
   
=end

end

