require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'
require './New_Automation/pages/applications/applications_home_page.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/job_board/job_board_login_page.rb'
require './New_Automation/pages/job_board/job_board_register_page.rb'

require_relative 'users.rb'


class TestApplications < TestBasic

  #TC1058 - Application / Create PDF
  def test_applicationCreationPdf
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.goToTab(HomePage::APPLICATIONS_TAB_LINK_XPATH)
    $wait.until{
      $browser.find_element(:xpath, ApplicationsHomePage::APPLICATION_OPTION_BAR_XPATH).displayed?
       $browser.find_element(:xpath, ApplicationsHomePage::FIRST_APPLICATION_ON_TABLE_XPATH).displayed?
    }
    $browser.find_element(:xpath, ApplicationsHomePage::FIRST_APPLICATION_ON_TABLE_XPATH).click
    $wait.until {
      $browser.find_element(:xpath, ApplicationsDetailPage::CREATE_PDF_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath, ApplicationsDetailPage::CREATE_PDF_BUTTON_XPATH).click
    newWindow= $browser.window_handles[1]
    $browser.switch_to.window(newWindow)
    assert $wait.until{
      $browser.find_element(:xpath, ApplicationsDetailPage::PDF_POP_UP_WINDOWS_ELEMENT_XPATH).displayed?
    }
  end 
  
  #TC105 - Allow Duplicate Applications
  def test_AllowDuplicateApp
    randomName = SecureRandom.hex(4)

    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    # Mark the field Allow Duplicate Apps = TRUE
    # In Allow Duplicate Application Days enter: 0
    CustomSettings.AllowDuplicateApplcation(true)
    
    CustomSettings.BoardSetupInit
    CustomSettings.JobBoardLogin(true)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    CustomSettings.MaxNumberOfAttachments(0)    
    Common.CreateRequisitionPostJob(randomName, true)
        
    # 1. Go to Board Setup tab
    Common.goToTab(HomePage::JOB_BOARD_URL)
     
    # 6. Click Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => Users::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => Users::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH}  
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH}
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH}
    ]
    Common.main(test)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + Users::JOB_BOARD_USER_NAME_TEXT + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_SECOND_XPATH}
    ]
    Common.main(test)
    
    assert_equal(randomName, $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_XPATH).text)
    assert_equal(randomName, $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_APP_LIST_SECOND_XPATH).text)
    
    
  end
  
  #TC110 - Revert button on record in Job Orders
  def test_RevertButtonOnJobOrders
    randomName = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
  
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
     # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2. Select (doing click on checkbox) one or more contacts
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
    # 3. Click on "Apply to jobs"
    Common.click(ContactsHomePage::CONTACT_HOME_APPLY_TO_JOB_XPATH)
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(4)
    
    test = [
    # 5. Select the posted Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomName},
    # 6. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 7. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 8. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # 9. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_APP_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH},
    ]
    Common.main(test)
    sleep(3)
    
    currentUrl = $browser.current_url
    
    $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH).click
    
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)   
    sleep(6)
    
    test = [
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
    ]
    Common.main(test) 
    sleep(2)
    
    newWindow4= $browser.window_handles.first
    $browser.switch_to.window(newWindow4)
    
    sleep(6)
    $browser.get(currentUrl)
    
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    ]
    Common.main(test) 
    
    newWindow5= $browser.window_handles.last
    $browser.switch_to.window(newWindow5)
    
    sleep(3)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_RADIO_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_SEND_EMAIL_BOX_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH}
    ]
    Common.main(test)
    
    $browser.switch_to.alert.accept
    sleep(5)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow6= $browser.window_handles.first
    $browser.switch_to.window(newWindow6)
    sleep(3)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
          ]
    Common.main(test) 
    
    assert_equal("Application", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
  end
  
  #TC858 - Revert Stage
  def test_RevertStage
    randomName = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
     
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_APP_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH},
    ]
    Common.main(test)
    sleep(3)
    
    currentUrl = $browser.current_url
    
    $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH).click
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)   
    sleep(4)
    
    test = [
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
    ]
    Common.main(test) 
    sleep(2)
    
    newWindow4= $browser.window_handles.first
    $browser.switch_to.window(newWindow4)
    
    sleep(6)
    $browser.get(currentUrl)
    
    #
    $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH).click
    sleep(3)
    newWindow5= $browser.window_handles.last
    $browser.switch_to.window(newWindow5)   
    sleep(6)
    
    test = [
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_CS1_STAGE_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_CS1_STAGE_XPATH},
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CLOSE_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test) 
    sleep(2)
    
    newWindow6= $browser.window_handles.first
    $browser.switch_to.window(newWindow6)
    
    sleep(6)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    # 4 - Click on "Revert Stage'  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    ]
    Common.main(test) 
    sleep(1)
    
    newWindow7= $browser.window_handles.last
    $browser.switch_to.window(newWindow7)
    
    sleep(3)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH},
    # 5 - Select any previous stage (except Application)   
      {"click" => ApplicationsDetailPage::REVERT_STAGE_RADIO_2_XPATH},
    # 6 - Click on "Next"  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH}
    ]
    Common.main(test)
    
    # 7 - Click on "OK"
    $browser.switch_to.alert.accept
    sleep(5)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH},
    ]
    Common.main(test)
    
    # RESULT
    # Success message will be displayed.
    assert_equal(ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_TEXT, $browser.find_element(:xpath, ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH).text)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow8= $browser.window_handles.last
    $browser.switch_to.window(newWindow8)
    $browser.close
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    sleep(3)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
          ]
    Common.main(test) 
    
    # RESULT 
    # Further stages will be deleted, and application will have Overall Stage = selected stage. 
    assert_equal("Submittal", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
  end

  #TC859 - Revert Stage, Send Email
  def test_RevertStageSendMail
    randomName = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    
    
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
     
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_APP_XPATH},
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH},
    ]
    Common.main(test)
    sleep(3)
    
    currentUrl = $browser.current_url
    
    $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH).click
    
    sleep(2)
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)   
    sleep(4)
    
    test = [
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"displayed" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
    ]
    Common.main(test) 
    sleep(2)
    
    newWindow4= $browser.window_handles.first
    $browser.switch_to.window(newWindow4)
    
    sleep(6)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    # 4 - Click on "Revert Stage'  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    ]
    Common.main(test) 
    sleep(1)
    
    newWindow7= $browser.window_handles.last
    $browser.switch_to.window(newWindow7)
    
    sleep(3)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_SEND_EMAIL_BOX_XPATH},
    # 5 - Check "Send Email" box  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_SEND_EMAIL_BOX_XPATH},
    # 6 - Select "Aplication" stage  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_RADIO_XPATH},
    # 7 - Click on "Next"  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH}
    ]
    Common.main(test)
    
    # 8 - Click on "OK"
    $browser.switch_to.alert.accept
    sleep(5)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH},
    ]
    Common.main(test)
    
    # RESULT
    # Success message will be displayed.
    assert_equal(ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_TEXT, $browser.find_element(:xpath, ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH).text)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
        
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    sleep(3)
    $browser.get(currentUrl)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
          ]
    Common.main(test) 
    
    # RESULT 
    # Further stages will be deleted, and application will have Overall Stage = selected stage. Email with merged fields from template will be sent to candidate.
    assert_equal("Application", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
  end

  #TC860 - TC860 - Revert Stage, Can't revert
  def test_RevertStageCantRevert
    randomName = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    CustomSettings.EnableEnhancedApplyToJob(true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    # Application was moved to any further stage: Submittal, Interview, Offer or Placement.
     
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "CRM Contacts - All"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../../../..//td[1]//input").click
    
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
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OPTION_3_XPATH},
    # Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 1 - Click on "Contacts" Tab
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH, "text" => "Candidates - New Today"},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH}
    ]
    Common.main(test)
    
    # 2 - Select a Candidate
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_CONTACT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
        }
     
    test = [
    # 3 - Click on a Candidate's application that fits the preconditions => Application is in Application Stage. 
      {"click" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_APP_XPATH},
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    # 4 - Click on "Revert Stage'  
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH}
    ]
    Common.main(test)
    sleep(3)
    # RESULT
    # Pop-up window will be opened.
    newWindow7= $browser.window_handles.last
    $browser.switch_to.window(newWindow7)
    
    sleep(3)
    
    test = [
      {"displayed" => ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH}
    ]
    Common.main(test) 
    
    # RESULT 
    # The message "The Application selected cannot be Reverted as it is in the Application Stage. There is no stage it can be reverted to" will be displayed.
    assert_equal(ApplicationsDetailPage::REVERT_STAGE_CANNOT_REVERT_MSG_TEXT, $browser.find_element(:xpath, ApplicationsDetailPage::REVERT_STAGE_SUCCESS_MSG_XPATH).text)
    
    $browser.close
    
    newWindow9= $browser.window_handles.first
    $browser.switch_to.window(newWindow9)
    sleep(1)
    
  end
  
end