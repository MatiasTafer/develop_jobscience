require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
require './New_Automation/pages/board_setup/board_setup_detail_page.rb'
require './New_Automation/pages/board_setup/board_setup_edit_page.rb'
require './New_Automation/pages/board_setup/board_setup_home_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_register_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'
require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require_relative 'users.rb'
require './New_Automation/tests/custom_settings.rb'

require './New_Automation/pages/sources/source_home_page.rb'
require './New_Automation/pages/sources/source_new_edit_page.rb'



class TestSources < TestBasic
  #
  
  #Common.CreateUserJobBoard(Users::USER_SOURCES, Users::PASSWORD_SOURCES)
  
=begin
  def test_sources_tc937 #1 #FIREFOX OK
    # New Source, Successfully Created
    # Preconditions:
    # Must be logged in.
    
    # Steps:
    # 1 - Click on "Sources" Tab
    # 2 - Click on "New"
    # 3 - Fill all the fields correctly
    # 4 - Click on "Save"
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Steps
    Common.goToTab(HomePage::SOURCE_LINK_XPATH)
    test = [
      {"displayed" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      {"click" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      
      {"displayed" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH, "text" => "MATIAS TEST2"},
      {"set_text" => SourceNewEdit::GENERAL_SOURCE_TYPE_XPATH, "text" => "Other"},
      {"set_text" => SourceNewEdit::TYPE_SELECT_XPATH, "text" => "s"},
      {"click" => SourceNewEdit::SOURCE_EDIT_BTN_SAVE_XPATH}]
    Common.main(test)
    assert $wait.until {
      $browser.find_element(:xpath, SourceNewEdit::SOURCE_EDIT_BTN_EDIT_XPATH).displayed?
    }
    
  end
=end  

=begin
  def test_sources_tc938 #2 #FIREFOX OK
    # New Source, Fields Validation
    # Preconditions:
    # Must be logged in.
    
    # Steps:
    # 1 - Click on "Sources" Tab
    # 2 - Click on "New"
    # 3 - Leave all the fields blank
    # 4 - Click on "Save"
    # 5 - FIl all required fields
    # 6 - Enter invalid values into date fields ("Start Date", "End Date")
    # 7 - Click on "Save"
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Steps
    Common.goToTab(HomePage::SOURCE_LINK_XPATH)
    test = [
      {"displayed" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      {"click" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      {"displayed" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH, "text" => "MATIAS TEST2"},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_START_DATE, "text" => "90/26/2015"},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_END_DATE, "text" => "90/26/2015"},
      {"click" => SourceNewEdit::SOURCE_EDIT_BTN_SAVE_XPATH}#,
    ]
    Common.main(test)
    assert $wait.until{
      $browser.find_element(:xpath, SourceHomePage::INVALID_NAME_XPATH).displayed?
    }
  end
=end  

=begin
  def test_sources_tc939 #3   #FIREFOX OK
    # Applying to the Job, New Candidate, non-authenticated 
    # Preconditions:
    # Must have link to job board with source prepopulated (click on a Search URL from Notes & Attachments list on Board Setup tab)
    
    # Steps:
    #  1 - Go to "Job Board"
    #  2 - Click on a job
    #  3 - Start application process with registering new user
    #  4 - Complete process
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    user_email = Users::USER_RANDOM_EMAIL
    Common.CreateUserJobBoard( Users::USER_RANDOM_EMAIL, Users::PASSWORD_SOURCES)
    # Precondition
    Common.logout_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
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
      {"set_text_exist" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => user_email},
      {"set_text_exist" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text_exist" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 9. Click on "Continue".
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 10. In the additional attachments step, Attach the required number of documents with proper filetype.
      # 11. Click on "Continue".
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
    ]
    Common.main(test)
    
  end
=end 


  def test_sources_tc940 #4  
    # Applying to the Job, New Candidate, Hide Source Question = false, non-authenticated, deleted tSource
    
    # Preconditions:
    # Job Board Setup -> Hide Source Question = false
    
    # Steps:
    # 1 - Create and Save a URL for a Source using Search URL Builder on Board Setup
    # 2 - Delete the Source associated with the URL
    # 3 - Click on the Saved URL in Notes & Attachments section on Board Setup
    # 4 - Click on a job order to go to detail page
    # 5 - Click Apply
    # 6 - Complete Application process and select a Source
    
    # If you want to create a URL with the source embedded you can click the Search URL builder button on the board setup page, 
    # click the magnifying glass next to Choose Source to select a source, click Next, click Next, 
    # then click on the Search URL (if you enter a name and click save it will be saved to the notes  and attachments related list)
    
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.logout_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    source_name = 'source_test21'
    url_name = 'url_name' + source_name
    
    Common.create_sources(source_name)
    
    Common.delete_sources(source_name)
    
    #Common.CreateUserJobBoard(Users::USER_SOURCES, Users::PASSWORD_SOURCES)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    Common.click(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    test = [
      # Click on the Saved URL in Notes & Attachments section on Board Setup
      {"displayed" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      {"click" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      
      {"displayed" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      {"click" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      
      {"change_window" => ""},
      
      # Click on "Apply..." link.
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      # Fill the Questions form.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardJobDetail::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
      
      {"change_window" => ""},
      {"change_window" => ""},
    ]
    Common.main(test)
    
  end
  

=begin
  def test_sources_tc941 #5 
    # Applying to the Job, New Candidate, Hide Source Question = false, Blank tSource, non-authenticated
    # Preconditions:
    #  Job Board Setup -> Hide Source Question = false
    
    # Steps:
    #  1 - Go to "Job Board"
    #  2 - Click on a job
    #  3 - Delete tSource cookie, URL should contain empty tSource parameter
    #  4 - Start application process with registering new user
    #  5 - Complete process
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    # Precondition
    Common.logout_job_board
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [
      {"check_apply" => ""},
      {"delete_cookie" => ""},
      {"displayed" => JobBoardHomePage::REGISTER_LINK_XPATH},
      # 6. Click on (at the right side) in "Register".
      {"click" => JobBoardHomePage::REGISTER_LINK_XPATH},
      # 7. Fill the fields (required)
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 11. Click on "Continue"
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You have successfully registered')]]"},
      {"get_cookie" => ""},
      
    ]
    Common.main(test)
    
  end
  

  
  def test_sources_tc942 #6 
    # Applying to the Job, New Candidate, Hide Source Question = true, non-authenticated, deleted tSource
    # Preconditions:
    # Job Board Setup -> Hide Source Question = false
    
    # Steps:
    #  1 - Create and Save a URL for a Source using Search URL Builder on Board Setup
    #  2 - Delete the Source associated with the URL
    #  3 - Click on the Saved URL in Notes & Attachments section on Board Setup
    #  4 - Click on a job order to go to detail page
    #  5 - Click Apply
    #  6 - Complete Application process
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.logout_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    source_name = 'source_test21'
    url_name = 'url_name' + source_name
    
    Common.create_sources(source_name)
    
    Common.delete_sources(source_name)
    
    #Common.CreateUserJobBoard(Users::USER_SOURCES, Users::PASSWORD_SOURCES)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    Common.click(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    test = [
      # Click on the Saved URL in Notes & Attachments section on Board Setup
      {"displayed" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      {"click" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      
      {"displayed" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      {"click" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      
      {"change_window" => ""},
      
      # Click on "Apply..." link.
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      
      # Fill the Questions form.
      {"displayed" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => JobBoardJobDetail::FIRST_NAME_TEXT_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::LAST_NAME_TEXT_XPATH, "text" => "s"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_HEAR_ABOUT_US_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardJobDetail::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
      
      {"change_window" => ""},
    ]
    Common.main(test)
    
  end

  
  
  def test_sources_tc943 #7 
    # Applying to the Job, New Candidate, Hide Source Question = true, Blank tSource, non-authenticated
    # Preconditions:
    # Job Board Setup -> Hide Source Question = true
    
    # Steps:
    # 1 - Go to "Job Board"
    # 2 - Click on a job
    # 3 - Delete tSource cookie, URL should contain empty tSource parameter
    # 4 - Start application process with registering new user
    # 5 - Complete process
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.logout_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [
      {"delete_cookie" => ""},
      
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
  
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
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
  


  def test_sources_tc944 #8 
    # Applying to the Job, New Candidate, Authenticated
    # Preconditions:
    # Must have link to job board with source prepopulated (click on a Search URL from Notes & Attachments list on Board Setup tab)
    
    # Steps:
    #  1 - Go to "Job Board"
    #  2 - Click on a job
    #  3 - Log in and start application process
    #  4 - Complete process
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.login_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => Users::PASSWORD_SOURCES},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      #
      {"check_apply" => ""},
      #
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
  


  def test_sources_tc945 #9 
    # Applying to the Job, New Candidate, Hide Source Question = false, Authenticated, deleted tSource
    # Preconditions:
    # Job Board Setup -> Hide Source Question = false
    
    # Steps:
    #  1 - Create and Save a URL for a Source using Search URL Builder on Board Setup
    #  2 - Delete the Source associated with the URL
    #  3 - Click on the Saved URL in Notes & Attachments section on Board Setup
    #  4 - Click on a job order to go to detail page
    #  5 - Click Apply
    #  6 - Login and complete Application process and select a Source
    
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.login_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    source_name = 'source_test21'
    url_name = 'url_name' + source_name
    
    Common.create_sources(source_name)
    
    Common.delete_sources(source_name)
    
    #Common.CreateUserJobBoard(Users::USER_SOURCES, Users::PASSWORD_SOURCES)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    Common.click(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    test = [
      # Click on the Saved URL in Notes & Attachments section on Board Setup
      {"displayed" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      {"click" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      
      {"displayed" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      {"click" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      
      {"change_window" => ""},
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => Users::PASSWORD_SOURCES},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      #
      {"check_apply" => ""},
      #
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
  

  
  def test_sources_tc946 #10 
    # Applying to the Job, New Candidate, Hide Source Question = false, Blank tSource, Authenticated
    # Preconditions:
    # Job Board Setup -> Hide Source Question = false
    
    # Steps:
    #  1 - Go to "Job Board"
    #  2 - Click on a job
    #  3 - Delete tSource cookie, URL should contain empty tSource parameter
    #  4 - Register and start application process
    #  5 - Complete process
    
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.login_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => Users::PASSWORD_SOURCES},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      #
      {"delete_cookie" => ""},
      
      {"check_apply" => ""},
      #
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
  

  
  def test_sources_tc947 #11 
    # Applying to the Job, New Candidate, Hide Source Question = true, Authenticated, deleted tSource
    # Preconditions:
    # Job Board Setup -> Hide Source Question = true
    
    # Steps:
    #  1 - Create and Save a URL for a Source using Search URL Builder on Board Setup
    #  2 - Delete the Source associated with the URL
    #  3 - Click on the Saved URL in Notes & Attachments section on Board Setup
    #  4 - Click on a job
    #  5 - Register/login and start application process
    #  6 - Complete process
    
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.login_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    source_name = 'source_test21'
    url_name = 'url_name' + source_name
    
    Common.create_sources(source_name)
    
    Common.delete_sources(source_name)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
      # Click on the Saved URL in Notes & Attachments section on Board Setup
      {"displayed" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      {"click" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      
      {"displayed" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      {"click" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      
      {"change_window" => ""},
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => Users::PASSWORD_SOURCES},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      #
      {"check_apply" => ""},
      #
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
  


  def test_sources_tc948 #12 
    # Applying to the Job, New Candidate, Hide Source Question = true, Blank tSource, Authenticated
    # Preconditions:
    # Job Board Setup -> Hide Source Question = true
    
    # Steps:
    #  1 - Go to "Job Board"
    #  2 - Click on a job
    #  3 - Delete tSource cookie, URL should contain empty tSource parameter
    #  4 - Log in and start application process
    #  5 - Complete process
    
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.login_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => Users::PASSWORD_SOURCES},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      #
      {"delete_cookie" => ""},
      
      {"check_apply" => ""},
      #
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
  

  def test_sources_tc949 #13 
    # Applying to the Job, Existing Candidate, Non-authenticated 
    # Preconditions:
    # Must have link to job board with source prepopulated (click on a Search URL from Notes & Attachments list on Board Setup tab)
    
    # Steps:
    #  1 - Go to "Job Board"
    #  2 - Click on a job
    #  3 - Start application process using email address of existing candidate
    #  4 - Complete process
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.logout_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [ 
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
  
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
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




  def test_sources_tc950 #14 
    # Applying to the Job, Existing Candidate, tSource incorrect, Non-authenticated 
    
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.logout_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    source_name = 'source_test21'
    url_name = 'url_name' + source_name
    
    Common.create_sources(source_name)
    
    Common.delete_sources(source_name)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
      # Click on the Saved URL in Notes & Attachments section on Board Setup
      {"displayed" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      {"click" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      
      {"displayed" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      {"click" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      
      {"change_window" => ""},
      #
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      #
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 9. Fill the field...
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]"},
      
      {"change_window" => ""},
    ]
    Common.main(test)
    
  end
  
  



  def test_sources_tc951 #15 
    # Applying to the Job, Existing Candidate, tSource deleted, Non-authenticated 
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.logout_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [ 
      {"delete_cookie" => ""},
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
  
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
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
  


  def test_sources_tc952 #16 
    # Applying to the Job, Existing Candidate, tSource deleted, Non-authenticated 
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.login_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => Users::PASSWORD_SOURCES},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      #
      {"check_apply" => ""},
      #
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
  

  def test_sources_tc953 #17 
    # Applying to the Job, Existing Candidate, tSource incorrect, Authenticated 
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.login_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    source_name = 'source_test21'
    url_name = 'url_name' + source_name
    
    Common.create_sources(source_name)
    
    Common.delete_sources(source_name)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
      # Click on the Saved URL in Notes & Attachments section on Board Setup
      {"displayed" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      {"click" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      
      {"displayed" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      {"click" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      
      {"change_window" => ""},
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => Users::PASSWORD_SOURCES},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      #
      {"check_apply" => ""},
      #
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
  

  
  
  def test_sources_tc954 #18 
    # Applying to the Job, Existing Candidate, tSource incorrect, Authenticated 
    
    
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.login_job_board
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH
    test = [
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_RESUME_REQUIRED_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => Users::PASSWORD_SOURCES},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      #
      {"delete_cookie" => ""},
      {"check_apply" => ""},
      #
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
  


  def test_sources_tc955   NO AUTOMATABLE
    #  Assign Source to Candidate via Email-to-Parse
  end 
  

  def test_sources_tc956 #19
    #  Assign Source to Candidate via Email-to-Parse
    # Preconditions:
    # Job Board Setup -> Job Board Type = Internal
    # ->Apply Referral Immediately = true
    # Set any valid source in Source Tracking for Internal Referrals on Board Setup
    
    # Steps:
    #  1 - Go to "Job Board"
    #  2 - Go to a job detail page
    #  3 - Click on "Refer Candidate"
    #  4 - Enter internal user email address
    #  5 - Fill in the form for Prospect, use an email address which is not present in the system
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions
    $browser.get BoardSetupHomePage::INTERNAL_URL
    test = [
      {"displayed" => ".//*[@name='edit']"},
      {"click" => ".//*[@name='edit']"},
      
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_APPLY_REFERRAL_IMMEDIATELY_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_APPLY_REFERRAL_IMMEDIATELY_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SOURCE_TRACKING_FOR_INTERNAL_REFERRAL_XPATH, "text" => "Change Jobs"},
      
      {"click" => ".//*[@value='Save']"},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"check_apply" => ""},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      
      {"displayed" => ".//*[@id='j_id0:j_id1:j_id28:r2_email']"},
      {"set_text" => ".//*[@id='j_id0:j_id1:j_id28:r2_email']", "text" => "matiast@oktana.io"},
      {"click" => ".//*[@value='Continue']"},
      
      {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "b"},
      {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL_XPATH, "text" => "matiast@oktana.io"},
      {"click" => ".//*[@value='Submit']"},
    ]
    Common.main(test)
    
    
  end 
  


  #TC957 - Refering candidate with tracking source, existing candidate  NOT AUTOMATABLE
  
  def test_sources_tc958 #20  
    # Refering candidate with tracking source, new candidate, Clear Source Tracking for Internal Referrals
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions
    $browser.get BoardSetupHomePage::INTERNAL_URL
    test = [
      {"displayed" => ".//*[@name='edit']"},
      {"click" => ".//*[@name='edit']"},
      
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_APPLY_REFERRAL_IMMEDIATELY_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_APPLY_REFERRAL_IMMEDIATELY_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SOURCE_TRACKING_FOR_INTERNAL_REFERRAL_XPATH, "text" => " "},
      
      {"click" => ".//*[@value='Save']"},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"check_apply" => ""},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      
      {"displayed" => ".//*[@id='j_id0:j_id1:j_id28:r2_email']"},
      {"set_text" => ".//*[@id='j_id0:j_id1:j_id28:r2_email']", "text" => "matiast@oktana.io"},
      {"click" => ".//*[@value='Continue']"},
      
      {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "b"},
      {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL_XPATH, "text" => "matiast@oktana.io"},
      {"click" => ".//*[@value='Submit']"},
    ]
    Common.main(test)
  end 
  
  
  def test_sources_tc959 #21 
    # Refering candidate with tracking source, existing candidate, Clear Source Tracking for Internal Referrals 
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Preconditions
    $browser.get BoardSetupHomePage::INTERNAL_URL
    test = [
      {"displayed" => ".//*[@name='edit']"},
      {"click" => ".//*[@name='edit']"},
      
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_APPLY_REFERRAL_IMMEDIATELY_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_APPLY_REFERRAL_IMMEDIATELY_XPATH},
      {"set_text" => BoardSetupEditPage::BOARD_EDIT_SOURCE_TRACKING_FOR_INTERNAL_REFERRAL_XPATH, "text" => " "},
      
      {"click" => ".//*[@value='Save']"},
    ]
    Common.main(test)
    
    $browser.get HomePage::JOB_BOARD_INTERNAL_URL
    test = [
      {"check_apply" => ""},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
      
      {"displayed" => ".//*[@id='j_id0:j_id1:j_id28:r2_email']"},
      {"set_text" => ".//*[@id='j_id0:j_id1:j_id28:r2_email']", "text" => "matiast@oktana.io"},
      {"click" => ".//*[@value='Continue']"},
      
      {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
      {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "a"},
      {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "b"},
      {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL_XPATH, "text" => "matiast@oktana.io"},
      {"click" => ".//*[@value='Submit']"},
    ]
    Common.main(test)
  end 
  


  def test_sources_tc962 #22 
    # Chatter Source Tracking
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.goToTab(HomePage::REQUISITION_TAB_LINK_XPATH)
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH},
      {"click" => RequisitionsHomePage::REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH},
      
      {"displayed" => RequisitionsDetail::RE_CHAR_BUTTON_XPATH},
      {"click" => RequisitionsDetail::RE_CHAR_BUTTON_XPATH},
    ]
    Common.main(test)
    
    Common.goToTab(HomePage::CHATTER_TAB_XPATH)
    test = [
      {"displayed" => ".//*[text()[contains(.,'View Job Posting')]]"},
      {"click" => ".//*[text()[contains(.,'View Job Posting')]]"},
      
      {"change_window" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
  
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => Users::USER_SOURCES},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 9. Fill the field...
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]"},
      
      {"change_window" => ""},
      {"change_window" => ""},
    ]
    Common.main(test)
    
    
    
    
    
  end
  
  
=end  
 
end    









