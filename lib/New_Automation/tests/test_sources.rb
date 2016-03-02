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

require './New_Automation/pages/custom_settings.rb'

require './New_Automation/pages/sources/source_home_page.rb'
require './New_Automation/pages/sources/source_new_edit_page.rb'



class TestSources < TestBasic
  #
  $USER_JOB_BOARD = "ETess@fromthesky.up"
  $PASSWORD_JOB_BOARD = "otherworld666"
  
=begin
  def test_sources_tc937 #1
    # New Source, Successfully Created
    # Preconditions:
    # Must be logged in.
    
    # Steps:
    # 1 - Click on "Sources" Tab
    # 2 - Click on "New"
    # 3 - Fill all the fields correctly
    # 4 - Click on "Save"
    
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Steps
    $browser.get HomePage::SOURCE_LINK_URL
    test = [
      {"displayed" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      {"click" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      
      {"displayed" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH, "text" => "MATIAS TEST2"},
      {"set_text" => SourceNewEdit::GENERAL_SOURCE_TYPE_XPATH, "text" => "Other"},
      {"set_text" => SourceNewEdit::TYPE_SELECT_XPATH, "text" => "s"},
      {"click" => SourceNewEdit::SOURCE_EDIT_BTN_SAVE_XPATH},
      
      {"displayed" => SourceNewEdit::SOURCE_EDIT_BTN_EDIT_XPATH},
    ]
    Common.main(test)
    
  end
  


  def test_sources_tc938 #2
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    # Steps
    $browser.get HomePage::SOURCE_LINK_URL
    test = [
      # 2
      {"displayed" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      {"click" => SourceHomePage::SOURCE_HOME_PAGE_BTN_NEW_XPATH},
      # 4
      {"click" => SourceNewEdit::SOURCE_EDIT_BTN_SAVE_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must enter a value')]]"},
      
      # 5
      {"displayed" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_SOURCE_NAME_XPATH, "text" => "MATIAS TEST2"},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_START_DATE, "text" => "90/26/2015"},
      {"set_text" => SourceNewEdit::SOURCE_EDIT_END_DATE, "text" => "90/26/2015"},
      {"click" => SourceNewEdit::SOURCE_EDIT_BTN_SAVE_XPATH},
      
      {"displayed" => ".//*[text()[contains(.,'Invalid Date')]]"},
    ]
    Common.main(test)
    
  end
  

  
  def test_sources_tc939 #3
    # Applying to the Job, New Candidate, non-authenticated
    # Preconditions:
    # Must have link to job board with source prepopulated (click on a Search URL from Notes & Attachments list on Board Setup tab)
    
    # Steps:
    #  1 - Go to "Job Board"
    #  2 - Click on a job
    #  3 - Start application process with registering new user
    #  4 - Complete process
    
    # Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # Precondition
    Common.logout_job_board
    
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
    # Steps
    $browser.get "http://js-recruiting-148857d918a-14910044900.force.com/openings?nostate=1&tSource=a0eo00000036CYQAA2"
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOCATION_SELECT_XPATH},
      # 6. Click on a job title.
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text_exist" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text_exist" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text_exist" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 9. Click on "Continue".
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 10. In the additional attachments step, Attach the required number of documents with proper filetype.
      #{"displayed" => JobBoardHomePage::ATTACH_ADDITIONAL_DOC_XPATH},
      #{"upload" => JobBoardHomePage::ATTACH_ADDITIONAL_DOC_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # 11. Click on "Continue".
      #{"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
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
    
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.logout_job_board
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
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
    
    #Common.CreateUserJobBoard($USER_JOB_BOARD, $PASSWORD_JOB_BOARD)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
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
      {"set_text" => JobBoardJobDetail::EMAIL_ADDRESS_XPATH, "text" => $USER_JOB_BOARD},
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # Precondition
    Common.logout_job_board
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"unchecked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
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
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
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
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.create_sources("source_test")
    
    # Precondition
    Common.logout_job_board
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
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
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
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

  
  def test_sources_tc942 #7 
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
    
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.login_job_board
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    source_name = 'source_test21'
    url_name = 'url_name' + source_name
    
    #Common.create_sources(source_name)
    
    #Common.delete_sources(source_name)
    
    #Common.CreateUserJobBoard($USER_JOB_BOARD, $PASSWORD_JOB_BOARD)
    
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
      # Click on the Saved URL in Notes & Attachments section on Board Setup
      {"displayed" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      {"click" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      
      {"displayed" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      {"click" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      
      {"change_window" => ""},
      
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      
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
      
      # Click on "Apply..." link.
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      # Upload resume.
      #{"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      #{"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # Add text to cover letter field.
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_COVER_LETTER_XPATH, "text" => "THIS IS A LETTER"},
      # 11. Click on "Continue" button.
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # Fill the Questions form.
      #{"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      # Click on "Submit".
      #{"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
      # Click on a job order to go to detail page
      # (((.//*[@class='data2Col'])[5])/child::a)[1]
    ]
    Common.main(test)
    
    # .//a[text()[contains(., source_name)]]
    # value="Delete"s
    # SourceNewEdit::SOURCE_EDIT_BTN_DELETE_XPATH
    # accept_alert
    # (.//*[@class='list']/child::tbody/child::tr)//a[text()[contains(., "source_test7")]]
    # Search Url: url_namesource_test9
    # .//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: url_namesource_test9')]]
    
    # (.//*[@class='detailList']/child::tbody/child::tr/child::td)[2]/child::a
  end
  
=begin

  def test_sources_tc943 #8
    # Applying to the Job, New Candidate, Hide Source Question = true, Blank tSource, non-authenticated
    # Preconditions
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.logout_job_board
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
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
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "et"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "extra"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 9. Click on button "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 11. Click on "Continue"
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You have successfully registered')]]"},
      
      {"click" => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH},
      
      {"check_apply" => ""},
      
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH},
      {"set_text" => JobBoardHomePage::EMAIL_ADRESS_TEXT_XPATH, "text" => $USER_JOB_BOARD},
      {"set_text" => JobBoardHomePage::FIRST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text" => JobBoardHomePage::LAST_NAME_TEXT_XPATH, "text" => "test"},
      {"set_text_exist" => JobBoardRegisterPage::JOB_BOARD_REGISTER_QUESTION_XPATH, "text" => "c"},
      # 8. Click on "Continue".
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      # 9. Click on "Continue".
      {"displayed" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
    ]
    Common.main(test)
  end
  



  def test_sources_tc944 #9
    # Applying to the Job, New Candidate, Authenticated
    # Preconditions
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.login_job_board
    
    $browser.get HomePage::BOARD_SETUP_TAB_LINK_URL
    test = [
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_FIRSTRECORD_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH},
      {"displayed" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"checked" => BoardSetupEditPage::BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    $browser.get BoardSetupHomePage::CAREERS_URL_XPATH
    test = [
      # Click on the Saved URL in Notes & Attachments section on Board Setup
      {"displayed" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      {"click" => ".//*[@id='a0Go00000080Tcp_RelatedNoteList_body']//a[text()[contains(., 'Search Url: #{url_name}')]]"},
      
      {"displayed" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      {"click" => ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"},
      
      {"change_window" => ""},
      
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      
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
      
      # Click on "Apply..." link.
      {"check_apply" => ""},
      
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      # Upload resume.
      #{"displayed" => JobBoardHomePage::BROWSE_BUTTON_XPATH},
      #{"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
      # Add text to cover letter field.
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_COVER_LETTER_XPATH, "text" => "THIS IS A LETTER"},
      # 11. Click on "Continue" button.
      {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      # Fill the Questions form.
      #{"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CURRENT_SALARY_XPATH, "text" => "1"},
      # Click on "Submit".
      #{"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH},
      {"displayed" => ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for the')]]"},
      # Click on a job order to go to detail page
      # (((.//*[@class='data2Col'])[5])/child::a)[1]
    ]
    Common.main(test)
    
    
  end
=end
end    









