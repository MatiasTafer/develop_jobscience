require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'
require_relative './pages/home_page.rb'
require_relative './pages/requisitions_detail_page.rb'
require_relative './pages/setup_page.rb'
require_relative './pages/rss_customization_page.rb'
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/job_board_login_page.rb'
require_relative './pages/contacts_detail_page.rb'
require_relative './pages/applications_detail_page.rb'
require_relative './pages/applications_new_page.rb'
require_relative './pages/requisitions_home_page.rb'
require_relative './pages/requisitions_new_and_edit.rb'
require_relative './pages/requisitions_detail_page.rb'


class TestCandidatesMisc < TestBasic
  @@job_path = "/Users/admin/Desktop/testing job order.pdf"
=begin  
  #TC103 - Add Job Order from Uploading File
  def test_AddJobOrderFromUploading
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #Go to HomePage
    $browser.get(HomePage::HOME_TAB_LINK_URL)
    
    # 1 - Click on "Job Order Tools" on sidebar sections
    test = [
      {"displayed" => HomePage::ADD_JOB_ORDERS_XPATH},
    # 2 - Click on "Add Job Order"  
      {"click" => HomePage::ADD_JOB_ORDERS_XPATH}
    ]
    Common.main(test)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => HomePage::UPLOAD_BTN_BROWSE_XPATH},
      {"upload" => HomePage::UPLOAD_BTN_BROWSE_XPATH, "file" => @@job_path},
      {"click" => HomePage::UPLOAD_BTN_ADD_JOB_XPATH}
    ]
    Common.main(test)
    
    newWindow= $browser.window_handles.first
    $browser.switch_to.window(newWindow)
    
    assert $wait.until{
      $browser.find_element(:xpath => RequisitionsDetail::REQUISITIONS_DETAIL_NAME_XPATH).displayed?
    }
  end
 
   #TC104 - RSS feed customizable fields
  def test_RSSFeddCustomizableFields
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get(SetupEditPage::RSS_FEED_CUSTOMIZATION_URL)
    
    test = [
      {"displayed" => RSSCustomizationPage::RSS_CUSTOM_QUICK_FIND_XPATH},
      {"set_text" => RSSCustomizationPage::RSS_CUSTOM_QUICK_FIND_XPATH, "text" => RSSCustomizationPage::RSS_CUSTOM_QUICK_FIND_TEXT}
      ]
    Common.main(test)
    sleep(1)
    # Add or remove fields drag and drop fields into the "In the Field Set" section.
    element = $browser.find_element(:xpath => RSSCustomizationPage::RSS_CUSTOM_FIRST_ITEM_XPATH)
    target = $browser.find_element(:xpath => RSSCustomizationPage::RSS_CUSTOM_LAST_ITEM_USED_XPATH)

    $browser.action.drag_and_drop(element, target).perform
    
    # Click on "Save"
    $browser.find_element(:xpath => RSSCustomizationPage::RSS_CUSTOM_BTN_SAVE_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => RSSCustomizationPage::RSS_CUSTOM_DETAIL_BTN_NEW_XPATH).displayed?
    }
    
    ###### TERMINAR TERMINAR TERMINAR TERMINAR TERMINAR ######
   
   end  

  
  #TC105 - Allow Duplicate Applications
  def test_AllowDuplicateApp
    randomName = SecureRandom.hex(4)

    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    # Mark the field Allow Duplicate Apps = TRUE
    # In Allow Duplicate Application Days enter: 0
    CustomSettings.AllowDuplicateApplcation(true)
    
    CustomSettings.BoardSetupInit
    CustomSettings.JobBoardLogin(true)
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    CustomSettings.MaxNumberOfAttachments(0)    
    Common.CreateRequisitionPostJob(randomName, true)
        
    # 1. Go to Board Setup tab
    $browser.get(HomePage::JOB_BOARD_URL)
     
    # 6. Click Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
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
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + JobBoardLoginPage::JOB_BOARD_USER_NAME_TEXT + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_SECOND_XPATH}
    ]
    Common.main(test)
    
    assert_equal(randomName, $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_APP_LIST_FIRST_XPATH).text)
    assert_equal(randomName, $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_APP_LIST_SECOND_XPATH).text)
    
    Common.DeleteRequisition(randomName)

  end
   
  #TC106 - Enable Resume Attached to contact record
  def test_EnableResumeAttachContactRecord
    randomName = SecureRandom.hex(4)
  
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    # Mark the field "Attach to Applications" = TRUE
    CustomSettings.AttachToApplications(true)
    
    CustomSettings.BoardSetupInit
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    
    # 1. Go to Board Setup tab
    $browser.get(HomePage::JOB_BOARD_URL)
     
    # Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH}  
    ]
    Common.main(test)
    # 8. Select a Job title
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
    # 9. Click Apply for [job title] position    
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
    # 10. Click Continue
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH}
    ]
    Common.main(test)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
    ]
    Common.main(test)
    
    # 13. Go to Contact record
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + JobBoardLoginPage::JOB_BOARD_USER_NAME_TEXT + "')]]").click
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test) 
    
    # 14. Click on record ID of newly created Application
    $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]//..//..//..//td[7]//a").click
    test = [
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_RESUME_UPLOADED_XPATH}
    ]
    Common.main(test) 
    
    # Resume should be attached to contact record as well as application record
    assert_equal("true", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_RESUME_UPLOADED_XPATH).text)
 
    Common.DeleteRequisition(randomName)
    
  end
  
  #TC107 - Enable contact jcard view
  def test_EnableContactJCardView 
   
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
   
    CustomSettings.EnableJCardForContact(true)
   
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_FIRST_ENTRY_GO_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_FIRST_ENTRY_GO_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH}
    ]
    Common.main(test)
    sleep(3)
    
    $browser.switch_to.frame(ContactDetailPage::CONTACT_DETAIL_RESUME_IFRAME_ID)
    assert $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_JCARD_XPATH).displayed?
    }
   CustomSettings.EnableJCardForContact(false)
  end
 
  #TC108 - Able Read Hiring Manager Job Orders
  def test_ReadHiringManagerJobOrders
    randomName = SecureRandom.hex(4)
    randomUserName = SecureRandom.hex(4)
  
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    Common.CreateAccount(randomUserName)
    Common.CreateContact(randomUserName, randomUserName)
    
    CustomSettings.AutoShareMode("Read")
    
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    
    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_NEW_APP_XPATH},
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_NEW_APP_XPATH},
      {"displayed" => ApplicationsNewPage::APP_NEW_CANDIDATE_XPATH},
      {"set_text" => ApplicationsNewPage::APP_NEW_CANDIDATE_XPATH, "text" => randomUserName},
      {"click" => ApplicationsNewPage::APP_NEW_BTN_SAVE_XPATH},
      {"displayed" => ApplicationsDetailPage::CREATE_PDF_BUTTON_XPATH}
    ]
    Common.main(test)
    
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    
    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH},
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH}
    ]
    Common.main(test)
    sleep(2)
    test=[   
      {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_HIRING_MANAGER_XPATH},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_HIRING_MANAGER_XPATH, "text" => "Manager User"},
      {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_EDIT_XPATH},
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH}
    ]
    Common.main(test)
    
    $browser.get(HomePage::LOGIN_URL)
    $wait.until {
     $browser.find_element(:id => "username").displayed?
    }
    $browser.find_element(:id, "username").send_keys Common::USER_EMAIL3
    $browser.find_element(:id, "password").send_keys Common::PASSWORD
    $browser.find_element(:id, "Login").click
    $wait.until {
     $browser.find_element(:xpath => HomePage::SEARCH_BUTTON_XPATH).displayed?
    }
    
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH},
    ]
    Common.main(test) 
    
    assert $wait.until{
      $browser.find_element(:xpath => ".//*[text()[contains(.,'" + randomUserName +"')]]").displayed?
    }
  
  end
  
  #TC109 - Able Read Hiring Manager Job Orders
  def test_ReadWriteHiringManagerJobOrders
    randomName = SecureRandom.hex(4)
    randomUserName = SecureRandom.hex(4)
  
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    Common.CreateAccount(randomUserName)
    Common.CreateContact(randomUserName, randomUserName)
    CustomSettings.AllowDuplicateApplcation(true)
    
    CustomSettings.AutoShareMode("Read/Write")
    
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    
    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_NEW_APP_XPATH},
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_NEW_APP_XPATH},
      {"displayed" => ApplicationsNewPage::APP_NEW_CANDIDATE_XPATH},
      {"set_text" => ApplicationsNewPage::APP_NEW_CANDIDATE_XPATH, "text" => randomUserName},
      {"click" => ApplicationsNewPage::APP_NEW_BTN_SAVE_XPATH},
      {"displayed" => ApplicationsDetailPage::CREATE_PDF_BUTTON_XPATH}
    ]
    Common.main(test)
    
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    
    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH},
      {"click" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH}
    ]
    Common.main(test)
    sleep(2)
    test=[   
      {"displayed" => RequisitionsNewAndEdit::REQUISITIONS_HIRING_MANAGER_XPATH},
      {"set_text" => RequisitionsNewAndEdit::REQUISITIONS_HIRING_MANAGER_XPATH, "text" => "Manager User"},
      {"click" => RequisitionsNewAndEdit::REQUISITIONS_NEW_BTN_SAVE_EDIT_XPATH},
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH}
    ]
    Common.main(test)
    
    $browser.get(HomePage::LOGIN_URL)
    $wait.until {
     $browser.find_element(:id => "username").displayed?
    }
    $browser.find_element(:id, "username").send_keys Common::USER_EMAIL3
    $browser.find_element(:id, "password").send_keys Common::PASSWORD
    $browser.find_element(:id, "Login").click
    $wait.until {
     $browser.find_element(:xpath => HomePage::SEARCH_BUTTON_XPATH).displayed?
    }
    
    $browser.get(HomePage::REQUISITIONS_LINK_URL)
    
    test = [
      {"displayed" => RequisitionsHomePage::REQUISITIONS_PAGE_BTN_NEW_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => RequisitionsHomePage::REQUISITIONS_PAGE_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    test = [
      {"displayed" => RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH},
    ]
    Common.main(test) 
    
    assert $wait.until{
      $browser.find_element(:xpath => ".//*[text()[contains(.,'" + randomUserName +"')]]").displayed?
    }
    sleep(10)
  
  end

  #TC111 - Custom text EEO message on Job Board
  def test_CustomTextEEOMessage
    randomJob = SecureRandom.hex(4)
    randomName = SecureRandom.hex(4)
    randomEmail = SecureRandom.hex(4) 
    randomLastName = SecureRandom.hex(4) 
  
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    CustomSettings.EEOTextAndDisclaimer("This is EEO Text", true)
    
    CustomSettings.JobBoardLogin(true)
    CustomSettings.BoardSetupInit
    CustomSettings.DefineEEOQuestions(true, false, false, false, false)
    
    
    
    # Go to Board Setup tab
    $browser.get(HomePage::JOB_BOARD_URL)
     
    # Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH}, 
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH} 
    ]
    Common.main(test)
    
  end
  
  #TC113 - Add Custom Privacy Policy message on registration page
  def test_AddCustomPrivacyPolicy
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    CustomSettings.PrivacyPolicyTextAndDisplay("This is a privacy policy statement. Thank you!", true)
    
    CustomSettings.JobBoardLogin(true)
    CustomSettings.BoardSetupInit
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    CustomSettings.AllowDuplicateApplcation(true)
    
    
    # Go to Board Setup tab
    $browser.get(HomePage::JOB_BOARD_URL)
     
    # Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH}, 
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH} 
    ]
    Common.main(test)
    # FALTA VER EL MENSAJE PRIVACY POLICY
  end
=end  
  #TC110 - Revert button on record in Job Orders
  def test_RevertButtonOnJobOrders
    randomName = SecureRandom.hex(4)
    randomContact = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
          
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
     # 1. Click on "Contacts". 
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    
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
    sleep(2)
    
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
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
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
      {"display" => ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH},
    ]
    Common.main(test)
    sleep(2)
    
    currentUrl = $browser.current_url
    
    $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_MOVE_LINK_XPATH).click
    
    newWindow3= $browser.window_handles.last
    $browser.switch_to.window(newWindow3)   
    sleep(5)
    
    test = [
      {"display" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
      {"click" => ApplicationsDetailPage::MOVE_POPUP_SUBMITTAL_STAGE_XPATH},
      {"display" => ApplicationsDetailPage::MOVE_POPUP_BTN_CANCEL_XPATH},
    ]
    Common.main(test) 
    sleep(1)
    
    newWindow4= $browser.window_handles.first
    $browser.switch_to.window(newWindow4)
    
    sleep(5)
    $browser.get(currentUrl)
    
    
    test = [
      {"display" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
    ]
    Common.main(test) 
    
    newWindow5= $browser.window_handles.last
    $browser.switch_to.window(newWindow5)
    
    sleep(2)
    
    test = [
      {"display" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_RADIO_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_SEND_EMAIL_BOX_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_NEXT_XPATH}
    ]
    Common.main(test)
    
    $browser.switch_to.alert.accept
    sleep(4)
    
    test = [
      {"display" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH},
      {"click" => ApplicationsDetailPage::REVERT_STAGE_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow6= $browser.window_handles.first
    $browser.switch_to.window(newWindow6)
    sleep(2)
    $browser.get(currentUrl)
    
    test = [
      {"display" => ApplicationsDetailPage::REVERT_STAGE_BTN_XPATH},
          ]
    Common.main(test) 
    
    assert_equal("Application", $browser.find_element(:xpath, ApplicationsDetailPage::APP_DETAIL_OVERALL_STAGE_XPATH).text)
    
  end
       
end