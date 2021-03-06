require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'
require './New_Automation/pages/offers/offers_home_page.rb'
require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'
require './New_Automation/tests/custom_settings.rb'
require './New_Automation/pages/accounts/accounts_home_page.rb'
require './New_Automation/pages/accounts/accounts_new_edit_page.rb'
require './New_Automation/pages/accounts/accounts_detail_page.rb'
require './New_Automation/pages/search/skill_detail_page.rb'
require './New_Automation/pages/short_lists/short_list_home_page.rb'
require './New_Automation/pages/short_lists/short_list_new_edit_page.rb'
require './New_Automation/pages/short_lists/short_list_detail_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/search/search_results_page.rb'
require './New_Automation/pages/search/education_history_new_page.rb'
require './New_Automation/pages/search/employment_history_new_page.rb'
require './New_Automation/pages/resume/add_resume_popup_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_login_page.rb'
require './New_Automation/pages/board_setup/board_setup_home_page.rb'
require './New_Automation/pages/board_setup/board_setup_detail_page.rb' 
require './New_Automation/pages/board_setup/board_setup_edit_page.rb'
require_relative 'users.rb'


class TestParsingCandidatesFileType < TestBasic
  @@resume_path = "/New_Automation/files/Daxtra/DaxtraResume01.pdf"

  # TC127 - Resume uploader with incorrect file type
  def test_AddResumeResumeToolsIncorrectFileType
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_parser_settings()
    CustomSettings.DefineResumeAllowedTypes("txt")
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    # 1. Click on "Add Resume" om "Resume Tools" in the sidebar
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},
      {"click" => HomePage::ADD_RESUMES_XPATH},
    ]
    Common.main(test)
    
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@resume_path)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # 2. Click on "Browse ..." to upload a file with type added in preconditions
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file}
    ]
    Common.main(test) 
   
    # 3. Click on "Add Resume" 
    begin
      button = $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH).displayed?
    rescue 
      button = false 
    end
    if button
      $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH).click
    else
      $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUME_2_XPATH).click
    end
    
    Common.displayed(AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH)
    
    #Result
    assert_equal("Error:\nWrong file type. The following file types are allowed: txt", $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_ERROR_MESSAGE_XPATH).text)
    
    # For closing all popups
    $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_CANCEL_XPATH).click
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
  end  

  # TC128 - Resume uploader with correct file type
  def test_AddResumeResumeToolsCorrectFileType
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_parser_settings()
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    # 1. Click on "Add Resume" om "Resume Tools" in the sidebar
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},
      {"click" => HomePage::ADD_RESUMES_XPATH},
    ]
    Common.main(test)
    
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@resume_path)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # 2. Click on "Browse ..." to upload a file with type added in preconditions
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file}
    ]
    Common.main(test) 
    
    # 3. Click on "Add Resume"  
    begin
      button = $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH).displayed?
    rescue 
      button = false 
    end
    if button
      $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH).click
    else
      $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUME_2_XPATH).click
    end
    
    sleep(5)
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH).displayed?
    }
    
    
  end 

  # TC131 - Apply to a job with linkedin
  def test_ApplyToAJobWithLinkedInEEOQuestionsEnable
    randomName = "0" + SecureRandom.hex(4)
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_social_settings()
    CustomSettings.ApplyToLinkedIn(true)
    
    Common.go_to_parser_settings()
    CustomSettings.DefineResumeAllowedTypesJobBoard("pdf")
    
    CustomSettings.JobBoardLogin(false)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.DefineEEOQuestions(true, true, true, true, false)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    # 1 - Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    # 2 - Apply to a job from the job board site
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH}
    ]
    Common.main(test)
    sleep(5)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH, "text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_DATA_EMAIL_TEXT},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_PASSWORD_XPATH, "text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_DATA_PASSWORD_TEXT},
      {"click" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_BTN_ALLOW_XPATH}
    ]
    Common.main(test)
    $browser.switch_to.window($browser.window_handles.first)
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_GENDER_XPATH).displayed?
    }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_EEO_QUESTIONS_BTN_SUBMIT_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_LINKEDIN_SUCCESS_MSG_XPATH).displayed?
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_LINKEDIN_SUCCESS_MSG_XPATH).text == "Your application for the "+ randomName +" position was submitted successfully."
      }
  end 
    
 
  # TC1224 - Apply To A Job With LinkedIn EEO Questions Disable
  def test_ApplyToAJobWithLinkedInEEOQuestionsDisable
    randomName = SecureRandom.hex(4)
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_social_settings()
    CustomSettings.ApplyToLinkedIn(true)
    
    Common.go_to_parser_settings()
    CustomSettings.DefineResumeAllowedTypesJobBoard("pdf")
    
    CustomSettings.JobBoardLogin(false)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    CustomSettings.BoardSetupInit
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    # 1 - Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    # 2 - Apply to a job from the job board site
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_WITH_LINKEDIN_XPATH}
    ]
    Common.main(test)
    sleep(5)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_EMAIL_XPATH, "text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_DATA_EMAIL_TEXT},
      {"set_text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_PASSWORD_XPATH, "text" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_DATA_PASSWORD_TEXT},
      {"click" => JobBoardJobDetail::JOB_BOARD_LINKEDIN_BTN_ALLOW_XPATH}
    ]
    Common.main(test)
    $browser.switch_to.window($browser.window_handles.first)
    
    assert $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_LINKEDIN_SUCCESS_DIALOG_XPATH).displayed?
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_LINKEDIN_SUCCESS_DIALOG_XPATH).text == "Your application for the "+ randomName +" position was submitted successfully."
      }
  end 
    
 
  # TC132 - Resume update with incorrect file type
  def test_ResumeUpdateIncorrectFileType
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_parser_settings()
    CustomSettings.DefineResumeAllowedTypes("txt")
    
    # 1. Click on "Contacts"
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Click on one record
    test =[
      {"displayed" => ContactsHomePage::CONTACT_HOME_LIST_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_FIRST_VIEW_OPTION_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_FIRST_ENTRY_GO_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
    # 3. Click on "Resume Update" button  
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test) 

    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@resume_path)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # 4. Click on "Browse ..." to upload a file with type added in preconditions
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file}
    ]
    Common.main(test) 
    
    # 5. Click on "Add Resume" 
    begin
      button = $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH).displayed?
    rescue 
      button = false 
    end
    if button
      $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH).click
    else
      $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUME_2_XPATH).click
    end
    
    Common.displayed(AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH)
    
    #Result
    assert_equal("Error:\nWrong file type. The following file types are allowed: txt", $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_ERROR_MESSAGE_XPATH).text)
    
    # For closing all popups
    $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_CANCEL_XPATH).click
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
  end
 
  # TC133 - Resume update with correct file type
  def test_ResumeUpdateCorrectFileType
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_parser_settings()
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    # 1. Click on "Contacts"
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    # 2. Click on one record
    test =[
      {"displayed" => ContactsHomePage::CONTACT_HOME_FIRST_VIEW_OPTION_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_FIRST_VIEW_OPTION_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_FIRST_ENTRY_GO_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
    # 3. Click on "Resume Update" button  
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test) 

    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@resume_path)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # 4. Click on "Browse ..." to upload a file with type added in preconditions
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file}
      ]
    Common.main(test) 
    
    # 5. Click on "Add Resume" 
    begin
      button = $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH).displayed?
    rescue 
      button = false 
    end
    if button
      $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH).click
    else
      $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUME_2_XPATH).click
    end
    
    sleep(5)
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH).displayed?
    }
    
  end
 
  # TC134 - Apply to a job from job board with incorrect file type    
  def test_ApplyJobIncorrectFileType
    
    
    randomName = SecureRandom.hex(4)
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4) 
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    CustomSettings.BoardSetupInit
    
    Common.go_to_parser_settings()
    CustomSettings.DefineResumeAllowedTypesJobBoard("txt")
    
    CustomSettings.JobBoardLogin(false)
    
    # 1 - Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    # 2 - Apply to a job from the job board site
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).click
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
       
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    
    file = File.join(Dir.pwd, @@resume_path)

    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_RADIO_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_RADIO_XPATH},
      {"upload" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_BROWSE_XPATH, "file" => file},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("Wrong file type. The following file types are allowed: txt", $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_ERROR_MESSAGE_2_XPATH).text)
    
  end 
  
  # TC135 - Apply to a job from job board with correct file type
  def test_ApplyJobCorrectFileType
    
    randomJob = SecureRandom.hex(4)
    randomName = SecureRandom.hex(4)
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4) 
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    home_url = $browser.current_url
    
    Common.go_to_parser_settings()
    CustomSettings.DefineResumeAllowedTypesJobBoard("pdf")
    
    CustomSettings.JobBoardLogin(false)
    
    Common.goToTab(HomePage::BOARD_SETUP_TAB_LINK_XPATH)
    Common.displayed(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.click_and_load(BoardSetupHomePage::CAREERS_LINK_LIST_XPATH)
    Common.displayed(BoardSetupDetailPage::BOARD_DETAIL_EDIT_BUTTON_XPATH)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    CustomSettings.BoardSetupInit
    
    Common.CreateRequisitionPostJob(randomJob, true)
    
    # 1 - Go to Job Board
    $browser.get(HomePage::JOB_BOARD_URL)
    
    # 2 - Apply to a job from the job board site
    $browser.get(HomePage::JOB_BOARD_URL)
    $wait.until{
      $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_RETURN_TO_SEARCH_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomJob + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).displayed?
      }
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH).click
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
       
    $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH).displayed?
      }
    
    file = File.join(Dir.pwd, @@resume_path)
    
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_RADIO_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_RADIO_XPATH},
      {"upload" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_BROWSE_XPATH, "file" => file},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
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
    
    Common.displayed(JobBoardJobDetail::JOB_BOARD_LINKEDIN_SUCCESS_MSG_XPATH)
    assert_equal("Your application for the "+ randomJob +" position was submitted successfully." , $browser.find_element(:xpath => JobBoardJobDetail::JOB_BOARD_LINKEDIN_SUCCESS_MSG_XPATH).text)
    
    $browser.get(home_url)
    DeleteRequisition(randomJob)
    
  end 
 
  def DeleteRequisition(name)
    # 1 - Go to "Requisition" Tab
    Common.goToTab(HomePage::REQUISITIONS_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH).displayed?  
      }
    sleep(5)  
    # 2 - Click on the Requisition
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + name + "')]]").click
    $wait.until{
      $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
     # 3 - Click on Delete 
    $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_DELETE_XPATH).click
     sleep(3)
    # 4 - Confirm
    $browser.switch_to.alert.accept
  end
   
end