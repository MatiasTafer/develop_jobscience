require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/board_setup/board_setup_detail_page.rb'
require_relative './pages/board_setup/board_setup_edit_page.rb'
require_relative './pages/board_setup/board_setup_home_page.rb'
require_relative './pages/setup_page.rb'
require_relative './pages/login_page.rb'
require_relative './pages/requisitions/requisitions_home_page.rb'
require_relative './pages/requisitions/requisitions_new_and_edit.rb'
require_relative './pages/job_board/job_board_home_page.rb'
require_relative './pages/job_board/job_board_register_page.rb'
require_relative './pages/job_board/job_board_job_detail.rb'
require_relative './pages/source_home_page.rb'
require_relative './pages/source_new_edit_page.rb'


class TestJobBoard < TestBasic
  
  $USER_JOB_BOARD = "et@fromthesky.up"
  $PASSWORD_JOB_BOARD = "otherworld666"
  $USER_JOB_BOARD2 = "momiWrewas@a.com"
  $PASSWORD_JOB_BOARD2 = "o1234567" 
  
  $USER_LINKEDIN = "automationoktana@gmail.com"
  $PASSWORD_LINKEDIN = "oktanaqa"
  
=begin
  def test_job_board_tc64 #1 #OK
    # JS2 -  Search jobs by criteria 
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Facility"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      #{"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      #{"set_text" => JobBoardHomePage::JOB_BOARD_FACILITY_SELECT_XPATH, "text" => "D"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH},
    ]
    Common.main(test)
    
  end


  def test_job_board_tc65 #2 #OK
    # JS2 - Set "Show Search Only" to "TRUE" in Board Setup
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # Preconditions
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 4. Click on button "Edit".
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SHOW_SEARCH_ONLY_XPATH},
      # 5. Click on checkbox call "Show Search Only".
      {"checked" => BoardSetupEditPage::BOARD_EDIT_SHOW_SEARCH_ONLY_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Facility"},
      # 6. Click on button "Save".
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"not_displayed" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      # 6. In "Search Openings" select options
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      #{"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      #{"set_text" => JobBoardHomePage::JOB_BOARD_FACILITY_SELECT_XPATH, "text" => "D"},
      # 7. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH},
    ]
    Common.main(test)
  end 
  


  def test_job_board_tc66 #3 #OK
    # JS2 - Edit search criteria fields
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # Steps
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 4. Click on button "Edit".
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SHOW_SEARCH_ONLY_XPATH},
      # 5. Click on checkbox call "Show Search Only".
      {"checked" => BoardSetupEditPage::BOARD_EDIT_SHOW_SEARCH_ONLY_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Facility"},
      # 6. Click on button "Save".
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end


  
  
  def test_job_board_tc67 #4 OK
    # JS2 - Successfully Register on Job Board
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Precondition
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => SetupEditPage::ALLOW_REGISTER_ONLY_CHECKBOX_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_UPLOAD_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PASTE_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_BUILDER_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_COVER_LETTER_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    #
    Common.login_job_board
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      # 6. Click on (at the right side) in "Register".
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      # 7. Fill the fields (required)
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 11. Click on "Continue"
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'You have successfully registered')]]"},
    ]
    Common.main(test)
    
  end

  def test_job_board_tc68 #5
    # JS2 - Successfully Login on Job Board
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Precondition
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
    ]
    Common.main(test)
    
  end  



  def test_job_board_tc69 #6
    # JS2 - Successfully apply for one job.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # Steps
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      # 6. Click on a job title
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      
      # 9. Fill the field...
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]"},
      
    ]
    Common.main(test)
  end



  def test_job_board_tc70 #7
    # JS2 - Successfully apply for one job in Linkedin.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.login_job_board
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"check_apply" => ""},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_LINKEDIN_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_LINKEDIN_XPATH},
      
      {"change_window" => JobBoardJobDetail::JOB_BOARD_APPLY_LINKEDIN_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH, "text" => $USER_LINKEDIN},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_PASSWORD_XPATH, "text" => $PASSWORD_LINKEDIN},
      {"click" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_ALLOW_ACCESS_XPATH},
      {"change_window" => JobBoardJobDetail::JOB_BOARD_APPLY_LINKEDIN_XPATH},
    ]
    Common.main(test)
    
  end
 

  def test_job_board_tc71 #8
    # JS2 - Successfully Add an Standard questions
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      # 4. Click on button "Edit".
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH},
      # 5. Click on checkbox call "Show Search Only".
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH, "text" => "c"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH, "text" => "d"},
      # 6. Click on button "Save".
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end





  def test_job_board_tc72 #9
    # JS2 - Successfully Add Question Sets in a especific job order
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::REQUISITION_TAB_LINK_URL
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_EDIT_XPATH},
      {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_EDIT_XPATH},
      {"displayed" => RequisitionsNewAndEdit::QUESTION_SET_TEXT_XPATH},
      {"set_text" => RequisitionsNewAndEdit::QUESTION_SET_TEXT_XPATH, "text" => "Sales"},
      {"set_text" => RequisitionsNewAndEdit::CONTACT_TEXT_XPATH, "text" => "Naomi Kiharra"},
      {"click" => RequisitionsNewAndEdit::REQUISITIONS_BTN_SAVE_XPATH},
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_EDIT_XPATH},
    ]
    Common.main(test)
    
  end



  
  def test_job_board_tc74 #10
    # JS2 - Successfully applicant updating info
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.login_job_board
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATING_INFO_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_UPDATING_INFO_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_FIRST_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_FIRST_NAME_XPATH, "text" => "test"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LAST_NAME_XPATH, "text" => "last"},
      {"click" => JobBoardJobDetail::JOB_BOARD_CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain']"},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your info was successfully updated')]]"},
    ]
    Common.main(test)
  end



  def test_job_board_tc75 #11
    # JS2 - Updating resume of aplication
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.login_job_board
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
      # 6. Click on "Update Your Resume".
      {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
      {"displayed" => JobBoardJobDetail::PASTE_CHECKBOX_XPATH},
      # 7. Select one checkbox option: "Upload", "Paste" or "Builder".
      {"click" => JobBoardJobDetail::PASTE_CHECKBOX_XPATH},
      {"displayed" => JobBoardJobDetail::PASTE_TEXTAREA_XPATH},
      {"set_text" => JobBoardJobDetail::PASTE_TEXTAREA_XPATH, "text" => "test"},
      # 8. Click on "Continue" or "Next" button depending of the options previously selected.
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your resume was successfully added / updated')]]"},
    ]
    Common.main(test)
  end
  

  
  def test_job_board_tc76 #12
    # JS2 - Successfully create Application Source
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get HomePage::SOURCE_LINK_URL
    test = [
      {"displayed" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      # 3. Click on "New".
      {"click" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      # 4. Fill the fields required.
      {"displayed" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH, "text" => "test"},
      # 6. Click on "Save". and 7. Copy ID in Url.
      {"take_url" => SourceNewEdit::SOURCE_EDIT_BTN_SAVE_XPATH},
    ]
    Common.main(test)
    
    $browser.get SetupEditPage::SOCIAL_SETTINGS_URL
    test = [
      {"displayed" => SetupEditPage::SOCIAL_SETTINGS_EDIT_BUTTON_XPATH},
      {"click" => SetupEditPage::SOCIAL_SETTINGS_EDIT_BUTTON_XPATH},
      {"displayed" => SetupEditPage::LINKEDIN_SOURCE_TRACKING_XPATH},
      {"set_text_url" => SetupEditPage::LINKEDIN_SOURCE_TRACKING_XPATH, "text" => "URL"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end



  def test_job_board_tc77 #13
    # JS2 - Successfully Edit "Disable Mobile Job Board" to False
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_DISABLE_MOBILE_JOB_BOARD_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end


  # TC78 - Apply with LinkedIn via Mobile job board  NOT AUTOMATABLE
  # TC80 - Mobile - Send to email address the job order  NOT AUTOMATABLE
  # TC81 - Filtering jobs on mobile job board  NOT AUTOMATABLE
  # TC82 - View desktop job board on mobile  NOT AUTOMATABLE
  

  def test_job_board_tc83 #14
    # JS2 - Mobile job board source
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get HomePage::SOURCE_LINK_URL
    test = [
      {"displayed" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      # 3. Click on "New".
      {"click" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      # 4. Fill the fields required.
      {"displayed" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH, "text" => "Mobile Job Board"},
      # 6. Click on "Save". and 7. Copy ID in Url.
      {"take_url" => SourceNewEdit::SOURCE_EDIT_BTN_SAVE_XPATH},
    ]
    Common.main(test)
    
    $browser.get SetupEditPage::SOCIAL_SETTINGS_URL
    test = [
      {"displayed" => SetupEditPage::SOCIAL_SETTINGS_EDIT_BUTTON_XPATH},
      {"click" => SetupEditPage::SOCIAL_SETTINGS_EDIT_BUTTON_XPATH},
      {"displayed" => SetupEditPage::LINKEDIN_SOURCE_TRACKING_XPATH},
      {"set_text_url" => SetupEditPage::MOBILE_JOB_BOARD_SOURCE_TRACKING_XPATH, "text" => "URL"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end
  


  def test_job_board_tc864 #15
    # JS2 - Job Search by "Jobs/Projects" field
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Facility"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      #{"set_text" => JobBoardHomePage::JOB_BOARD_FACILITY_SELECT_XPATH, "text" => "N"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
    ]
    Common.main(test)
    
  end


  def test_job_board_tc865 #16
    # JS2 - Job Search by "Department" field
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"hassert" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      
    ]
    Common.main(test)
    
  end



  def test_job_board_tc866 #17
    # JS2 - Job Search by "Location" field
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"hassert" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      
    ]
    Common.main(test)
    
  end



  def test_job_board_tc867 #18
    # JS2 - Job Search by "Employment Type" field
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Employment Type"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_EMPLOYMENT_TYPE_SELECT_XPATH, "text" => "C"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"hassert" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      
    ]
    Common.main(test)
    
  end



  def test_job_board_tc868 #19
    # JS2 - Job Search by "Business Unit" field
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_4_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_4_XPATH, "text" => "Business Unit"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_BUSINESS_UNIT_SELECT_XPATH, "text" => "B"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      
    ]
    Common.main(test)
    
  end

  
  def test_job_board_tc870 #20
    # JS2 - Job Search by "Jobs/Projects", "Department" and "Location" fields 
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      
    ]
    Common.main(test)
    
  end
  

  def test_job_board_tc871 #21
    # JS2 - Job Search by "Jobs/Projects", "Department", "Location" and "Employment Type" fields
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Employment Type"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_EMPLOYMENT_TYPE_SELECT_XPATH, "text" => "C"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      
    ]
    Common.main(test)
    
  end



  def test_job_board_tc872 #22
    # JS2 - Job Search by "Jobs/Projects", "Department", "Location", "Employment Type" and "Business Unit" fields
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    # set Search & Results criteria 1, 2 and 3.
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Employment Type"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_4_XPATH, "text" => "Business Unit"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_EMPLOYMENT_TYPE_SELECT_XPATH, "text" => "C"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_BUSINESS_UNIT_SELECT_XPATH, "text" => "B"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      
    ]
    Common.main(test)
    
  end
  


  def test_job_board_tc874 #23
    # JS2 - Job Search with one keyword
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end


  def test_job_board_tc875 #24
    # JS2 - Job Search with several keyword.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH},
      # 6. In Search by Keyword section fill in the first 2 boxes with search criteria, separated by the AND operator
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      # 7. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      # 8. Fill in the first 2 boxes with search criteria, separated by the OR operator
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "O"},
      # 9. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      # 10. Fill in the 3 boxes with search criteria, separated by the AND then the AND operator
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH, "text" => "c"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH, "text" => "a"},
      # 11. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      # 12. Fill in the 3 boxes with search criteria, separated by the AND then the OR operator
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH, "text" => "c"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH, "text" => "o"},
      # 13. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      # 14. Fill in the 3 boxes with search criteria, separated by the OR then the OR operator
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH, "text" => "c"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "o"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH, "text" => "o"},
      # 15. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
      # 16. Fill in the 3 boxes with search criteria, separated by the OR then the AND operator
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH, "text" => "c"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "o"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH, "text" => "a"},
      # 17. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_JOB_TITLE_LABEL_XPATH},
    ]
    Common.main(test)
    
  end
  

  def test_job_board_tc876 #25
    # JS2 - Job Search with wildcards in keyword.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "^a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "^b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH, "text" => "^c"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH, "text" => "a"},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end

   
  def test_job_board_tc877 #26
    # JS2 - Search with filters and keywords.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Employment Type"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_4_XPATH, "text" => "Business Unit"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      # 7. Select option in "Department" field.
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      # 8. Select option in "Location" field.
      {"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      # 9. Select option in "Employment Type" field.
      {"set_text" => JobBoardHomePage::JOB_BOARD_EMPLOYMENT_TYPE_SELECT_XPATH, "text" => "C"},
      # 10. Select option in "Business Unit" field.
      {"set_text" => JobBoardHomePage::JOB_BOARD_BUSINESS_UNIT_SELECT_XPATH, "text" => "B"},
      # 11. Fill the field "Search by Keyword" and the logical operator "AND" AND "OR"
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH, "text" => "c"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "o"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH, "text" => "a"},
      # 12. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end
  
  


  def test_job_board_tc878 #27
    # JS2 - Search give 0 results
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_1_XPATH, "text" => "Department"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_2_XPATH, "text" => "Location"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_3_XPATH, "text" => "Employment Type"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SEARCH_CRITERIA_4_XPATH, "text" => "Business Unit"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      # 7. Select option in "Department" field.
      {"set_text" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH, "text" => "D"},
      # 8. Select option in "Location" field.
      {"set_text" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH, "text" => "S"},
      # 9. Select option in "Employment Type" field.
      {"set_text" => JobBoardHomePage::JOB_BOARD_EMPLOYMENT_TYPE_SELECT_XPATH, "text" => "C"},
      # 10. Select option in "Business Unit" field.
      {"set_text" => JobBoardHomePage::JOB_BOARD_BUSINESS_UNIT_SELECT_XPATH, "text" => "B"},
      # 11. Fill the field "Search by Keyword" and the logical operator "AND" AND "OR"
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH, "text" => "c"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "o"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH, "text" => "a"},
      # 12. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsNoResultsMessage'][text()[contains(.,'No results were found that match your search')]]"},
      
    ]
    Common.main(test)
    
  end


  

  def test_job_board_tc879 #28
    # JS2 - Sorting search results by fields
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_DEPARTMENT_SELECT_XPATH},
      # 7. Fill the field "Search by Keyword".
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_XPATH, "text" => "a"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_TEXT_XPATH, "text" => "b"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_THIRD_TEXT_XPATH, "text" => "c"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_FIRST_AND_SELECT_XPATH, "text" => "o"},
      {"set_text" => JobBoardHomePage::JOB_BOARD_SEARCH_BY_KEYWORD_SECOND_AND_SELECT_XPATH, "text" => "a"},
      # 12. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_LABEL_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOCATION_LABEL_XPATH},
    ]
    Common.main(test)
    
    
    
  end

  
  def test_job_board_tc880 #29
    # JS2 - Pagination search results
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 12. Click on "Search" button.
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      # 8. Click on bottom of page in "2" link.
      {"displayed" => JobBoardHomePage::JOB_BOARD_PAGE2_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_PAGE2_XPATH},
      # 9. Click on bottom of page in "1" link.
      {"displayed" => JobBoardHomePage::JOB_BOARD_PAGE1_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_PAGE1_XPATH},
      # 10. Click on bottom of page in "Next" link.
      {"displayed" => JobBoardHomePage::JOB_BOARD_NEXT_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_NEXT_BUTTON_XPATH},
      # 11. Click on bottom of page in "Previous" link.
      {"displayed" => JobBoardHomePage::JOB_BOARD_PREVIOUS_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_PREVIOUS_BUTTON_XPATH},
      # 12. Click on bottom of page in "Last" link.
      {"displayed" => JobBoardHomePage::JOB_BOARD_LAST_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LAST_BUTTON_XPATH},
      # 13. Click on bottom of page in "First" link.
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_BUTTON_XPATH},
    ]
    Common.main(test)
  end
  


  
  def test_job_board_tc881 #30
    # JS2 - Resume Page
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.login_job_board
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      # 12. Click on "Search" button.
      {"check_apply" => ""},
     
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      #{"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      #{"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      #{"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      #{"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]"},
      #/Users/admin/Desktop/document.pdf
    ]
    Common.main(test)
  end
  
  



  def test_job_board_tc883 #31
    # JS2 - Resume Builder
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.login_job_board
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      # 12. Click on "Search" button.
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      # 4. Check "Builder" box
      {"displayed" => JobBoardJobDetail::BUILDER_CHECKBOX_XPATH},
      {"click" => JobBoardJobDetail::BUILDER_CHECKBOX_XPATH},
      {"displayed" => JobBoardJobDetail::ADD_EMPLOYMENT_HISTORY_XPATH},
      # 5. Click on "Add Employment History"
      {"click" => JobBoardJobDetail::ADD_EMPLOYMENT_HISTORY_XPATH},
      # 6. Fill the from
      {"set_text" => JobBoardJobDetail::EMPLOYER_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardJobDetail::LOCATION_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardJobDetail::JOB_TITLE_TEXT_XPATH, "text" => "test"},
      # 7. Click on "Add Employment History"
      {"click" => JobBoardJobDetail::ADD_EMPLOYMENT_HISTORY_XPATH},
      # 8. Add several Employment History records
      {"set_text" => JobBoardJobDetail::EMPLOYER_NAME_TEXT_XPATH, "text" => "test2"},
      {"set_text" => JobBoardJobDetail::LOCATION_TEXT_XPATH, "text" => "test2"},
      {"set_text" => JobBoardJobDetail::JOB_TITLE_TEXT_XPATH, "text" => "test2"},
      # 9. Click on "Remove Employment History"
      {"click" => JobBoardJobDetail::REMOVE_EMPLOYMENT_HISTORY_XPATH},
      # 10. Click on "Next"
      {"click" => JobBoardJobDetail::NEXT_BUTTON_XPATH},
      # 11. Click on "Add Education History"
      {"displayed" => JobBoardJobDetail::ADD_EDUCATION_HISTORY_XPATH},
      {"click" => JobBoardJobDetail::ADD_EDUCATION_HISTORY_XPATH},
      # 12 . Fill the form
      {"set_text" => JobBoardJobDetail::SCHOOL_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardJobDetail::MAYOR_TEXT_XPATH, "text" => "test"},
      # 13. Click on "Add Education History"
      {"click" => JobBoardJobDetail::ADD_EDUCATION_HISTORY_XPATH},
      # 14. Add several Education History records
      {"set_text" => JobBoardJobDetail::SCHOOL_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardJobDetail::MAYOR_TEXT_XPATH, "text" => "test"},
      {"click" => JobBoardJobDetail::ADD_EDUCATION_HISTORY_XPATH},
      # 15. Click on "Remove Education History"
      {"displayed" => JobBoardJobDetail::REMOVE_EDUCATION_HISTORY_XPATH},
      {"click" => JobBoardJobDetail::REMOVE_EDUCATION_HISTORY_XPATH},
      # 16. Click on "Next"
      {"click" => JobBoardJobDetail::NEXT_BUTTON_XPATH},
      # 17. Click on "Add Certification"
      {"displayed" => JobBoardJobDetail::ADD_CERTIFICATION_XPATH},
      {"click" => JobBoardJobDetail::ADD_CERTIFICATION_XPATH},
      # 18 . Fill the form
      {"set_text" => JobBoardJobDetail::CERTIFICATION_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardJobDetail::STATE_PROVINCE_XPATH, "text" => "test"},
      # 19. Click on "Add Certification"
      {"click" => JobBoardJobDetail::ADD_CERTIFICATION_XPATH},
      # 20. Add several Certification records
      {"set_text" => JobBoardJobDetail::CERTIFICATION_TEXT_XPATH, "text" => "test2"},
      {"set_text" => JobBoardJobDetail::STATE_PROVINCE_XPATH, "text" => "test2"},
      {"click" => JobBoardJobDetail::ADD_CERTIFICATION_XPATH},
      # 21. Click on "Remove Certification"
      {"click" => JobBoardJobDetail::REMOVE_CERTIFICATION_XPATH},
      # 22. Click on "Next"
      {"click" => JobBoardJobDetail::NEXT_BUTTON_XPATH},
      # 23. Click on "Add Skill"
      {"displayed" => JobBoardJobDetail::ADD_SKILL_BUTTON_XPATH},
      {"click" => JobBoardJobDetail::ADD_SKILL_BUTTON_XPATH},
      # 24 . Fill the form
      {"displayed" => JobBoardJobDetail::ADD_SKILL_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::ADD_SKILL_BUTTON_XPATH, "text" => "skill"},
      # 25. Click on "Add Skill"
      {"click" => JobBoardJobDetail::ADD_SKILL_BUTTON_XPATH},
      # 26. Add several Skill records
      {"set_text" => JobBoardJobDetail::ADD_SKILL_BUTTON_XPATH, "text" => "skill2"},
      {"click" => JobBoardJobDetail::ADD_SKILL_BUTTON_XPATH},
      # 27. Click on "Remove Skill"
      {"click" => JobBoardJobDetail::REMOVE_SKILL_BUTTON_XPATH},
      # 28. Click on "Build Resume"
      {"click" => JobBoardJobDetail::BUILD_RESUME_BUTTON_XPATH},
      # 29. Click on "Continue"
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
    ]
    Common.main(test)
  end




  def test_job_board_tc884 #32 
    # JS2 - Resume Attachments Page with inappropriate filetype
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.login_job_board
    # Preconditios
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      # 6. Checked "Attach to Applications" = true.
      {"displayed" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      {"checked" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      # 7. Fill the field "Accepted Document Types for Attachments".
      {"set_text" => SetupEditPage::DOCUMENT_TYPES_FOR_ATTACHMENTS_XPATH, "text" => "docx, doc, pdf, rtf, html, txt"},
      # 8. Fill field "Max Number of Attachments" with a number greater than 1.
      {"set_text" => SetupEditPage::MAX_NUMBER_ATTACHMENTS_XPATH, "text" => "2"},
      # 9. Click on "Save".
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      # 12. Click on "Search" button.
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      # 9. Upload a Resume a fill the required field.
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 10. Click on "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 11. In the additional attachments step. Attach documents of inappropriate filetype.
      {"displayed" => JobBoardHomePage::ATTACH_ADDITIONAL_DOC_XPATH},
      {"upload" => JobBoardHomePage::ATTACH_ADDITIONAL_DOC_XPATH, "file" => "/Users/admin/Desktop/test.rb"},
      # Error message "Invalid file format" will be displayed.
      #{"displayed" => ".//*[text()[contains(.,'Invalid file format')]]"},
    ]
    Common.main(test)
    
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      # 6. Checked "Attach to Applications" = true.
      {"displayed" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      {"checked" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      # 7. Fill the field "Accepted Document Types for Attachments".
      {"set_text" => SetupEditPage::DOCUMENT_TYPES_FOR_ATTACHMENTS_XPATH, "text" => "docx, doc, pdf, rtf, html, txt"},
      # 8. Fill field "Max Number of Attachments" with a number greater than 1.
      {"set_text" => SetupEditPage::MAX_NUMBER_ATTACHMENTS_XPATH, "text" => "2"},
      # 9. Click on "Save".
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
  end



  def test_job_board_tc885 #33
    # JS2 - Resume Attachments Page with fewer documents than Required Number of Attachments setting specifies.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.login_job_board
    # Preconditios
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      # 6. Checked "Attach to Applications" = true.
      {"displayed" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      {"checked" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      # 7. Fill the field "Accepted Document Types for Attachments".
      {"set_text" => SetupEditPage::DOCUMENT_TYPES_FOR_ATTACHMENTS_XPATH, "text" => "docx, doc, pdf, rtf, html, txt"},
      # 8. Fill field "Max Number of Attachments" with a number greater than 1.
      {"set_text" => SetupEditPage::MAX_NUMBER_ATTACHMENTS_XPATH, "text" => "2"},
      # 9. Click on "Save".
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      # 12. Click on "Search" button.
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      # 8. Click on "Continue".
      
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      # 9. Upload a Resume a fill the required field.
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 10. Click on "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 11. In the additional attachments step, Attach fewer documents than Required Number of Attachments setting specifies.
      # 12. Click on "Continue".
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # Error message "Invalid file format" will be displayed.
      
    ]
    Common.main(test)
    
  end


  def test_job_board_tc886 #34
    # JS2 - Resume Attachments Page with attach the required number of documents with proper filetype.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.login_job_board
    # Preconditios
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      # 6. Checked "Attach to Applications" = true.
      {"displayed" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      {"checked" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      # 7. Fill the field "Accepted Document Types for Attachments".
      {"set_text" => SetupEditPage::DOCUMENT_TYPES_FOR_ATTACHMENTS_XPATH, "text" => "docx, doc, pdf, rtf, html, txt"},
      # 8. Fill field "Max Number of Attachments" with a number greater than 1.
      {"set_text" => SetupEditPage::MAX_NUMBER_ATTACHMENTS_XPATH, "text" => "2"},
      # 9. Click on "Save".
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      # 12. Click on "Search" button.
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      #{"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      #{"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      # 9. Upload a Resume a fill the required field.
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 10. Click on "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 11. In the additional attachments step, Attach the required number of documents with proper filetype..
      {"displayed" => JobBoardHomePage::ATTACH_ADDITIONAL_DOC_XPATH},
      {"upload" => JobBoardHomePage::ATTACH_ADDITIONAL_DOC_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      #{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      # 12. Click on "Continue".
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      # 
    ]
    Common.main(test)
    
  end
  




  def test_job_board_tc887 #35
    # JS2 - Resume Attachments Page with "Attach to Applications" = false.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.logout_job_board
    # Preconditios
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      {"displayed" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      # 6. Checked "Attach to Applications" = false.
      {"unchecked" => SetupEditPage::ATTACH_TO_APPLICATIONS_XPATH},
      # 7. Fill the field "Accepted Document Types for Attachments".
      {"set_text" => SetupEditPage::DOCUMENT_TYPES_FOR_ATTACHMENTS_XPATH, "text" => "docx, doc, pdf, rtf, html, txt"},
      # 8. Fill field "Max Number of Attachments" with a number greater than 1.
      {"set_text" => SetupEditPage::MAX_NUMBER_ATTACHMENTS_XPATH, "text" => "2"},
      # 9. Click on "Save".
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 6. Click on a job title.
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => "test7@gmail.com"},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 9. Click on "Continue".
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 10. In the additional attachments step, Attach the required number of documents with proper filetype.
      {"displayed" => JobBoardHomePage::ATTACH_ADDITIONAL_DOC_XPATH},
      {"upload" => JobBoardHomePage::ATTACH_ADDITIONAL_DOC_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 11. Click on "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
    ]
    Common.main(test)
    
  end




  def test_job_board_tc888 #36
    # JS2 - Referral Page
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 2. Click on any job from the list
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 3. Click on "Refer Candidate"
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      # 4. Enter valid and correct email (Employee email)
      {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => "test@gmail.com"},
      # 5. Click on "Continue"
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 6. Fill all the required fields
      {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "com"},
      {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL, "text" => "a@o.com"},
      # 7. Click on "Submit"
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
    ]
    Common.main(test)
    
  end



  
  def test_job_board_tc889 #37
    # JS2 - Referral Page, Validation
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 2. Click on any job from the list
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 3. Click on "Refer Candidate"
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      # 4. Enter valid and correct email (Employee email)
      {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => "test@gmail.com"},
      # 5. Click on "Continue"
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 6. Fill all the required fields
      {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "com"},
      {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL, "text" => "a@o.com"},
      # 7. Click on "Submit"
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      #{"displayed" => ".//*[@id='j_id0:j_id1:j_id28']/span[1]/table/tbody/tr/td"},
    ]
    Common.main(test)
  end



  def test_job_board_tc890 #38  
    # JS2 - Referral Page, Duplication
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # Preconditions
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      {"displayed" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"unchecked" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 2. Click on any job from the list
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 3. Click on "Refer Candidate"
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      # 4. Enter valid and correct email (Employee email)
      {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => "test@gmail.com"},
      # 5. Click on "Continue"
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 6. Fill all the required fields
      {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "com"},
      {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL, "text" => "a@o.com"},
      # 7. Click on "Submit"
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      #{"displayed" => ".//*[@id='j_id0:j_id1:j_id28']/span[1]/table/tbody/tr/td"},
    ]
    Common.main(test)
    
  end
  



  def test_job_board_tc891 #39
    # JS2 - Referral Page, Max Number Open Referrals
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.logout_job_board
    # Preconditions
    $browser.get SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_INTERNAL_XPATH
    test = [
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_MAX_NUMBER_OPEN_REFERRALS_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_MAX_NUMBER_OPEN_REFERRALS_XPATH, "text" => "2"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 2. Click on any job from the list
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 3. Click on "Refer Candidate"
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      # 4. Enter valid and correct email (Employee email)
      {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => "test@gmail.com"},
      # 5. Click on "Continue"
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 6. Fill all the required fields
      
      {"hassert_equal" => ".//*[@id='atsErrorPageBox']/table/tbody/tr/td", "text" => "You reached the maximum number of allowable open referrals and not allowed to submit further referrals."},
    ]
    Common.main(test)
  end
  



  def test_job_board_tc892 #40
    # JS2 - Referral Page, Max Number Referrals Per Contact
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.logout_job_board
    # Preconditions
    $browser.get SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_INTERNAL_XPATH
    test = [
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_MAX_NUMBER_REFERRALS_PER_CONTACT_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_MAX_NUMBER_REFERRALS_PER_CONTACT_XPATH, "text" => "2"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 2. Click on any job from the list
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 3. Click on "Refer Candidate"
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      # 4. Enter valid and correct email (Employee email)
      {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => "test@gmail.com"},
      # 5. Click on "Continue"
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 6. Fill all the required fields
      
    ]
    Common.main(test)
    
  end
  


  def test_job_board_tc893 #41
    # JS2 - Referral Page, Max Number Referrals Per Contact, Expired
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    Common.logout_job_board
    # Preconditions
    $browser.get SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_INTERNAL_XPATH
    test = [
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_MAX_NUMBER_REFERRALS_PER_CONTACT_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_MAX_NUMBER_REFERRALS_PER_CONTACT_XPATH, "text" => "2"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 2. Click on any job from the list
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 3. Click on "Refer Candidate"
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      # 4. Enter valid and correct email (Employee email)
      {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => "test@gmail.com"},
      # 5. Click on "Continue"
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 6. Fill all the required fields
      
    ]
    Common.main(test)
    # Preconditions
    
  end




  def test_job_board_tc894 #42
    # JS2 - Your Job Application Page
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
   
      # Steps
      # 3. Click on "Your Job Applications" link
      {"displayed" => JobBoardHomePage::JOB_BOARD_YOUR_JOB_APPLICATION_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_YOUR_JOB_APPLICATION_XPATH},
      # 4. Click on "Return To Job Search"
      {"displayed" => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH},
      # 5. Click on any other job from the list
      # 12. Click on "Search" button.
      {"check_apply" => ""},
      # 6. Start application process
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      # 7. Interrupt the process and click on "Your Job Applications"
      {"displayed" => JobBoardHomePage::JOB_BOARD_YOUR_JOB_APPLICATION_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_YOUR_JOB_APPLICATION_XPATH},
    ]
    Common.main(test)
    
  end
  


  def test_job_board_tc895 #43
    # JS2 - Try to Register, Leave all fields blank.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      # 8. Click on "Continue".
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@class='errorMsg']"},
    ]
    Common.main(test)
    
    
  end
  
  
  def test_job_board_tc1242 #44
    # JS2 - Try to Register, Leave all fields blank.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    # 9. Repeat steps 1-8 with unauthenticated job board
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "-"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      # 8. Click on "Continue".
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@class='errorMsg']"},
    ]
    Common.main(test)
    
  end



  def test_job_board_tc896 #45
    # JS2 - Try to Register, Enter a invalid email
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 7. Enter a invalid email.
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "ERROR EMAIL"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"hassert_equal" => ".//*[@class='errorMsg']", "text" => "Error: Invalid Email Address."},
    ]
    Common.main(test)
    # 9. Repeat steps 1-8 with unauthenticated job board
    
    
  end
  
  def test_job_board_tc1243 #46
    # JS2 - Try to Register, Enter a invalid email
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    # 9. Repeat steps 1-8 with unauthenticated job board
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "-"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 7. Enter a invalid email.
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "ERROR EMAIL"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"hassert_equal" => ".//*[@class='errorMsg']", "text" => "Error: Invalid Email Address."},
    ]
    Common.main(test)
    
  end



  
  def test_job_board_tc897 #47
    # JS2 - Try to Register, Enter a invalid passwords
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "p@e.com"},
      # 7. Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => "error"},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => "error"},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"hassert_equal" => ".//*[@id='j_id0:j_id1:atsForm']/span[1]/table/tbody/tr/td", "text" => "Password needs to be at least 8 characters long and contain letters and numbers"},
    ]
    Common.main(test)
    
  end



  def test_job_board_tc898 #48
    # JS2 - Try to Register, Enter a mismatching passwords
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "p@e.com"},
      # 7. Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => "error"},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => "erro"},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"hassert_equal" => ".//*[@id='j_id0:j_id1:atsForm']/span[1]/table/tbody/tr/td", "text" => "Passwords did not match."},
    ]
    Common.main(test)
    
  end
  
  

  def test_job_board_tc899 #49
    # JS2 - Try to Register, Enter a mismatching passwords
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "matiast@oktana.io"},
      # 7. Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => "error"},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => "erro"},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"hassert_equal" => ".//*[@id='j_id0:j_id1:atsForm']/span[1]/table/tbody/tr/td", 
       "text" => "The email below is associated with an existing profile within our system. Use the Log In link within the menu to access your profile or request a new password."},
    ]
    Common.main(test)
    
  end
  



  def test_job_board_tc900 #50
    # JS2 - Successfully Register
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "maqewwe@s.com"},
      # 7. Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => "o1234567"},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => "o1234567"},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardJobDetail::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain']"},
      {"hassert_equal" => ".//*[@id='atsApplicationSubmittedMain']", 
       "text" => "You have successfully registered. Your information has been added to our system."},
      
    ]
    
    Common.main(test)
    
    # Unauthenticated job board
  end
  
  
  
  def test_job_board_tc1245 #51
    # JS2 - Successfully Register
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    # Unauthenticated job board
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "-"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "maswaeee@s.com"},
      # 7. Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardJobDetail::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain']"},
      {"hassert_equal" => ".//*[@id='atsApplicationSubmittedMain']", 
       "text" => "You have successfully registered. Your information has been added to our system."},
      
    ]
    Common.main(test)
  end
  



  def test_job_board_tc901 #52
    # JS2 - Registration / Contact Dupe Prevention = Attach Only.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "moermias@a.com"},
      # 7. Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => "o1234567"},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => "o1234567"},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
    ]
    Common.main(test)   
  end


  
  def test_job_board_tc902 #53 
    # JS2 - Registration and Create new Contact / Contact Dupe Prevention = Attach Only.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => "momwqiras@a.com"},
      # 7. Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => "o1234567"},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => "o1234567"},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"hassert_equal" => ".//*[@id='atsApplicationSubmittedMain']", 
       "text" => "You have successfully registered. Your information has been added to our system."},
    ]
    Common.main(test)
  end
  

  
  def test_job_board_tc903 #54
    # JS2 - Registration and Create new Contact / Contact Dupe Prevention = Attach Only.
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
      {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
      {"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 6. Click on "Register".
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      # 7. Leave all fields blank.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => $USER_JOB_BOARD2},
      # 7. Enter a incorrect password, containing less than 8 characters.
      {"set_text" => JobBoardJobDetail::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      {"set_text" => JobBoardJobDetail::CONFIRM_PASSWORD_TEXT_XPATH, "text" => "o1234567"},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
    ]
    Common.main(test)
  end


  
  
  def test_job_board_tc904 #55  
    # JS2 - Complete Application in Job Board
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"check_apply" => ""},
      # 8. Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      # 9. Upload resume.
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 10. Add text to cover letter field.
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_COVER_LETTER_XPATH, "text" => "THIS IS A LETTER"},
      # 11. Click on "Continue" button.
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 12. Fill the Questions form.
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      # 13, Click on "Submit".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
    ]
    Common.main(test)
  end
  


  
  def test_job_board_tc905 #56 
    # JS2 - Incomplete Application in Job Board
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"check_apply" => ""},
      # 8. Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      # 9. Upload resume.
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 10. Add text to cover letter field.
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_COVER_LETTER_XPATH, "text" => "THIS IS A LETTER"},
      # 11. Click on "Continue" button.
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 12. Fill the Questions form.
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      # 13. Leave the application process incomplete and go to the any other page.
      # 14. Return to the "Job Details" page of the selected job order and click on "Apply ..." link.
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      # 15. Go to the "Your Job Applications" page and click on "[job order]" link for that incomplete application.
      {"displayed" => JobBoardHomePage::JOB_BOARD_YOUR_JOB_APPLICATION_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_YOUR_JOB_APPLICATION_XPATH},
      
    ]
    Common.main(test)
  end
  



  def test_job_board_tc906 #57
    # JS2 - Duplicate for incomplete Applications in Job Board
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    # Preconditions
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      {"displayed" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"unchecked" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 7. Click on some job order.
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 8. Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
    ]
    Common.main(test)
  end
  


  
  def test_job_board_tc907 #58
    # JS2 - Duplicate for complete Applications in Job Board with Allow Duplicate Apps" = false
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    # Preconditions
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      {"displayed" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"unchecked" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"check_apply" => ""},
      # 8. Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 10. Add text to cover letter field.
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_COVER_LETTER_XPATH, "text" => "THIS IS A LETTER"},
      # 11. Click on "Continue" button.
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 12. Fill the Questions form.
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      # 14. Return to the "Job Details" page of the selected job order and click on "Apply ..." link.
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"displayed" => "(.//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:tb']/child::tr/child::td/child::a)[1]"},
      {"click" => "(.//*[@id='j_id0:j_id1:atsForm:atsSearchResultsTable:tb']/child::tr/child::td/child::a)[1]"},

      #{"hassert_equal" => ".//*[@id='j_id0:j_id4:j_id128']","text" => "You have already applied for this Job."},
      
      
    ]
    Common.main(test)
  end
  



  def test_job_board_tc908  #59
    # JS2 - Duplicate for complete Applications in Job Board with Allow Duplicate Apps" = true
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    # Preconditions
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      {"displayed" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"checked" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"check_apply" => ""},
      # 8. Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 10. Add text to cover letter field.
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_COVER_LETTER_XPATH, "text" => "THIS IS A LETTER"},
      # 11. Click on "Continue" button.
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # 12. Fill the Questions form.
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      
      # 14. Return to the "Job Details" page of the selected job order and click on "Apply ..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 7. Click on some job order.
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 8. Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
    ]
    Common.main(test)
  end
  
 

  
  def test_job_board_tc909  #60
    # JS2 - Job Detail Page / Authenticated Job Board Email page
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"check_apply" => ""},
      # 8. Click on "Email this job" link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH},
      # 9. Enter your email address and a message
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_TO_EMAIL_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_TO_EMAIL_XPATH, "text" => "matiast@oktana.io"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_MESSAGE_XPATH, "text" => "test"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_SEND_BUTTON_XPATH},
      {"hassert_equal" => ".//*[@id='j_id0:j_id1:emailJob']/table/tbody/tr[3]/td","text" => "Your message has been sent."},
      
    ]
    Common.main(test)
    
  end
 
  


  # test_job_board_tc910  NO AUTOMATABLE
  
  def test_job_board_tc911  #61
    # JS2 - Job Detail Page / Not Authenticated Job Board Email Page
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "-"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_X_ELEMENT_LIST_XPATH},
      # 7. Click on some job order.
      {"click" => JobBoardHomePage::JOB_BOARD_X_ELEMENT_LIST_XPATH},
      # 8. Click on "Email this job" link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH},
      # 9. Enter your email address and a message
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_FROM_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_FROM_NAME_XPATH, "text" => "test"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_FROM_EMAIL_XPATH, "text" => "matiast@oktana.io"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_TO_EMAIL_XPATH, "text" => "matiast@oktana.io"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_MESSAGE_XPATH, "text" => "test"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_SEND_BUTTON_XPATH},
      {"hassert_equal" => ".//*[@id='j_id0:j_id1:emailJob']/table/tbody/tr[3]/td","text" => "Your message has been sent."},
    ]
    Common.main(test)
    
  end

  


  def test_job_board_tc912  #62
    # JS2 - Job Detail Page / Not Authenticated Job Board
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "-"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_X_ELEMENT_LIST_XPATH},
      # 7. Click on some job order.
      {"click" => JobBoardHomePage::JOB_BOARD_X_ELEMENT_LIST_XPATH},
      # 8. Click on "Apply for the <Job Title> position".
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH},
    ]
    Common.main(test)
    
  end

  


  def test_job_board_tc913  #63
    # JS2 - Job Detail Page / Not Authenticated Job Board - Dupe apps
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    $browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
    test = [
      {"displayed" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"unchecked" => SetupEditPage::ALLOW_DUPLICATE_APPS_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"check_apply" => ""},
      # Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      # Upload resume.
      {"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # Add text to cover letter field.
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_COVER_LETTER_XPATH, "text" => "THIS IS A LETTER"},
      # Click on "Continue" button.
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # Fill the Questions form.
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      # Click on "Submit".
      #{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      #{"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
      # Click "Return To Job Search"
      {"displayed" => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # Click on some job order.
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # Click on "Apply..." link.
      #{"hassert_equal" => ".//form[@id='j_id0:j_id4:j_id128']","text" => "You have already applied for this Job."},
      
    ]
    Common.main(test)
    
  end
  


  def test_job_board_tc914  #64
    # Job Detail Page / Apply with LinkedIn
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get SetupEditPage::SOCIAL_SETTINGS_EDIT_URL
    test = [
      {"displayed" => SetupEditPage::LINKEDIN_SOURCE_TRACKING_XPATH},
      {"set_text" => SetupEditPage::LINKEDIN_SOURCE_TRACKING_XPATH, "text" => ""},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_LINKEDIN_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_LINKEDIN_XPATH},
      
      {"change_window" => JobBoardJobDetail::JOB_BOARD_APPLY_LINKEDIN_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH, "text" => $USER_LINKEDIN},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_PASSWORD_XPATH, "text" => $PASSWORD_LINKEDIN},
      {"click" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_ALLOW_ACCESS_XPATH},
      {"change_window" => JobBoardJobDetail::JOB_BOARD_APPLY_LINKEDIN_XPATH},
      
    ]
    Common.main(test)
    
  end

  # test_job_board_tc1147 NO AUTOMATABLE
  # test_job_board_tc1148 NO AUTOMATABLE


  def test_job_board_tc915  #65
    # JS2 - Questions Page with fields blank
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH, "text" => "Current Salary"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_2_XPATH, "text" => "Start Date"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_3_XPATH, "text" => "Taxonomy Skills"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_4_XPATH, "text" => "Email"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_5_XPATH, "text" => "Home Phone"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_5_XPATH, "text" => "degree"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIVE_ELEMENT_LIST_XPATH},
      # Click on some job order.
      {"click" => JobBoardHomePage::JOB_BOARD_FIVE_ELEMENT_LIST_XPATH},
      # Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # Fill the Questions form.
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      # Standart question
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_START_DATE_XPATH, "text" => "2/18/2016"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_TAXONOMY_SKILLS_XPATH, "text" => "IT SUPPORT"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH, "text" => "test@test.com"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HOME_PHONE_XPATH, "text" => "55555"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_DEGREE_XPATH, "text" => "D"},
      # Click on "Submit".
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
      # Click "Return To Job Search"
    ]
    Common.main(test)
    
  end
  



  def test_job_board_tc916  #66
    # JS2 - Questions Page with fields blank
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH, "text" => "Current Salary"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_2_XPATH, "text" => "Start Date"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_3_XPATH, "text" => "Taxonomy Skills"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_4_XPATH, "text" => "Email"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_5_XPATH, "text" => "Home Phone"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_5_XPATH, "text" => "degree"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"check_apply" => ""},
      # Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # Fill the Questions form.
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      # Standart question
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_TAXONOMY_SKILLS_XPATH, "text" => "12"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "A"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_START_DATE_XPATH, "text" => "A"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_TAXONOMY_SKILLS_XPATH, "text" => "12"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH, "text" => "test"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HOME_PHONE_XPATH, "text" => "HELLO"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_DEGREE_XPATH, "text" => ""},
      # Click on "Submit".
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"hassert_equal" => ".//*[@id='j_id0:j_id1:atsForm']/table/tbody/tr[7]/td/div","text" => "Error: Invalid Date"},
      
      # Click "Return To Job Search"
    ]
    Common.main(test)
    
  end




  def test_job_board_tc917  #67
    # JS2 - Questions Page Picklist
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH, "text" => "Level"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_2_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_3_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_4_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_5_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_6_XPATH, "text" => "-"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_7_XPATH, "text" => "-"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"check_apply" => ""},
      # Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # Fill the Questions form.
      # Standart question
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LEVEL_XPATH, "text" => "P"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      
      # Click on "Submit".
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
      
      # Click "Return To Job Search"
    ]
    Common.main(test)
    
  end

  


  def test_job_board_tc918  #68
    # JS2 - Successfully Questions Page Save
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    $browser.get SetupEditPage::CONFIG_JOB_BOARD_LOGIN_URL
    test = [
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH},
      {"set_text" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_ENABLE_XPATH, "text" => "Customer Portal: Jobseeker Portal"},
      {"click" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_SAVE_XPATH},
      {"displayed" => SetupEditPage::CONFIG_JOB_BOARD_LOGIN_EDIT_XPATH},
    ]
    Common.main(test)
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"displayed" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"click" => BoardSetupHomePage::CAREERS_LINK_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH},
      
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_1_XPATH, "text" => "Current Salary"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_2_XPATH, "text" => "Start Date"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_3_XPATH, "text" => "Taxonomy Skills"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_4_XPATH, "text" => "Email"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_5_XPATH, "text" => "Home Phone"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_6_XPATH, "text" => "degree"},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_QUESTION_7_XPATH, "text" => "Level"},
      {"click" => BoardSetupEditPage::BOARD_EDIT_SAVE_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD2},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD2},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"check_apply" => ""},
      # Click on "Apply..." link.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # Fill the Questions form.
      # Standart question
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_START_DATE_XPATH, "text" => "6/18/2016"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_TAXONOMY_SKILLS_XPATH, "text" => "IT SUPPORT"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_EMAIL_XPATH, "text" => "test@t.com"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_HOME_PHONE_XPATH, "text" => "555555"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_DEGREE_XPATH, "text" => "d"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LEVEL_XPATH, "text" => "P"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      
      # Click on "Submit".
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
     
    ]
    Common.main(test)
    
  end
  

  
  
  
  def test_job_board_tc919  #69
    # JS2 - Update Your Info Page
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    Common.standart_question_null
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATING_INFO_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_UPDATING_INFO_XPATH}, 
      {"displayed" => JobBoardJobDetail::JOB_BOARD_FIRST_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_FIRST_NAME_XPATH, "text" => "p"},
      {"click" => JobBoardJobDetail::JOB_BOARD_CONTINUE_BUTTON_XPATH}, 
      #{"hassert_equal" => ".//*[@id='atsApplicationSubmittedMain']","text" => "Your info was successfully updated."},
    ]
    Common.main(test)
    
  end
  



  def test_job_board_tc922  #70
    # JS2 - Job Board Email Page send with fields blank
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    Common.standart_question_null
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"check_apply" => ""},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH},
      # Click on some job order.
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_SEND_BUTTON_XPATH},
      # Click on some job order.
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_SEND_BUTTON_XPATH},  
      
      
    ]
    Common.main(test)
    
  end

=end

   def test_job_board_tc923  #71
    # JS2 - Job Board Email Page send with invalid email
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Preconditions
    Common.standart_question_null
    $browser.get HomePage::JOB_BOARD_URL
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $USER_JOB_BOARD },
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWORD_JOB_BOARD},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"check_apply" => ""}, 
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH},
      # Click on some job order.
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_EMAIL_THIS_JOB_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_TO_EMAIL_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_TO_EMAIL_XPATH, "text" => "1234567a"},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_APPLY_MESSAGE_XPATH, "text" => "1234567a"},
      # Click on some job order.
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_SEND_BUTTON_XPATH},  
      {"displayed" => ".//*[@id='j_id0:j_id1:emailJob']/span/table/tbody/tr/td[text()[contains(.,'SendEmail failed')]]"},
      
    ]
    Common.main(test)
    
  end
  
  #TC113 - Add Custom Privacy Policy message on registration page
  def test_AddCustomPrivacyPolicy
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    CustomSettings.PrivacyPolicyTextAndDisplay(JobBoardRegisterPage::JOB_BOARD_REGISTER_PRIVACY_POLICY_TEXT, true)
    
    CustomSettings.JobBoardLogin(true)

    # Go to Board Setup tab
    $browser.get(HomePage::JOB_BOARD_URL)
     
    # Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_REGISTER_LINK_XPATH},
      {"displayed" => JobBoardRegisterPage::JOB_BOARD_REGISTER_BTN_CONTINUE_XPATH},  
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath => "//*[text()[contains(.,'" + JobBoardRegisterPage::JOB_BOARD_REGISTER_PRIVACY_POLICY_TEXT + "')]]").displayed?  
    } 
  end
  
end